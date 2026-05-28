import { useEffect, useRef, useState } from 'react'
import type { FormEvent, KeyboardEvent } from 'react'
import './App.css'

type Role = 'user' | 'ai'
type MessageStatus = 'pending' | 'error'

interface ChatMessage {
  id: string
  role: Role
  content: string
  status?: MessageStatus
  type?: 'text' | 'estimate'
}

const API_BASE = import.meta.env.VITE_API_BASE_URL ?? ''
const API_PATH = '/api/v1/estimator/estimate'

const buildUrl = (description: string) => {
  const endpoint = API_BASE ? `${API_BASE}${API_PATH}` : API_PATH
  const url = new URL(endpoint, window.location.origin)
  url.searchParams.set('description', description)
  return url.toString()
}

const createId = () => `${Date.now()}-${Math.random().toString(16).slice(2)}`

function EstimateDisplay({ content }: { content: string }) {
  try {
    const data = JSON.parse(content)
    return (
      <div className="estimate-result">
        <div className="estimate-summary">
          <div className="estimate-value">
            <strong>{data.estimatedHoursToCompleteTheTask}h</strong>
            <span>Estimativa</span>
          </div>
          <div className="estimate-confidence">
            <strong>{data.confidenceRateInTheEstimatedHours}/10</strong>
            <span>Confiança</span>
          </div>
        </div>
        
        <div className="estimate-justification">
          <h4>Justificativa</h4>
          <p>{data.justification}</p>
        </div>

        {data.riskFactorsThatMayAffectTheTimeToCompleteTheTask?.length > 0 && (
          <div className="estimate-risks">
            <h4>Fatores de Risco</h4>
            <ul>
              {data.riskFactorsThatMayAffectTheTimeToCompleteTheTask.map((risk: string, i: number) => (
                <li key={i}>{risk}</li>
              ))}
            </ul>
          </div>
        )}
      </div>
    )
  } catch {
    return <p>{content}</p>
  }
}

function App() {
  const [messages, setMessages] = useState<ChatMessage[]>([
    {
      id: 'welcome',
      role: 'ai',
      content: 'Descreva a task e eu retorno uma estimativa em horas.',
    },
  ])
  const [input, setInput] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [lastError, setLastError] = useState<string | null>(null)
  const listRef = useRef<HTMLDivElement | null>(null)

  useEffect(() => {
    const list = listRef.current
    if (!list) return
    list.scrollTo({ top: list.scrollHeight, behavior: 'smooth' })
  }, [messages, isLoading])

  const handleSubmit = async (event?: FormEvent<HTMLFormElement>) => {
    event?.preventDefault()

    const description = input.trim()
    if (!description || isLoading) return

    const userId = createId()
    const pendingId = createId()

    setMessages((prev) => [
      ...prev,
      { id: userId, role: 'user', content: description },
      {
        id: pendingId,
        role: 'ai',
        content: 'Aguardando resposta...',
        status: 'pending',
      },
    ])
    setInput('')
    setIsLoading(true)
    setLastError(null)

    try {
      const response = await fetch(buildUrl(description), {
        method: 'GET',
      })
      const text = (await response.text()).trim()

      if (!response.ok) {
        throw new Error(text || 'Falha ao consultar a API.')
      }

      let isEstimate = false
      try {
        const parsed = JSON.parse(text)
        if (parsed.estimatedHoursToCompleteTheTask !== undefined) {
          isEstimate = true
        }
      } catch {
        // Not a JSON estimate, treat as regular text
      }

      setMessages((prev) =>
        prev.map((message) =>
          message.id === pendingId
            ? {
                ...message,
                content: text || 'Resposta vazia.',
                status: undefined,
                type: isEstimate ? 'estimate' : 'text',
              }
            : message,
        ),
      )
    } catch (error) {
      const message =
        error instanceof Error ? error.message : 'Erro inesperado.'
      setMessages((prev) =>
        prev.map((item) =>
          item.id === pendingId
            ? { ...item, content: message, status: 'error' }
            : item,
        ),
      )
      setLastError(message)
    } finally {
      setIsLoading(false)
    }
  }

  const handleKeyDown = (event: KeyboardEvent<HTMLTextAreaElement>) => {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault()
      void handleSubmit()
    }
  }

  return (
    <div className="app">
      <header className="app-header">
        <span className="eyebrow">Estimator IA</span>
        <h1>Estimativa rapida para tarefas complexas.</h1>
        <p className="lead">
          Descreva o escopo da task, tecnologias e riscos. Eu retorno uma
          estimativa de horas baseada na sua descricao.
        </p>
        <div className="chips">
          <span>Escopo</span>
          <span>Tecnologias</span>
          <span>Riscos</span>
        </div>
        <div className="status-bar" role="status" aria-live="polite">
          <span className={isLoading ? 'pulse' : ''}>
            {isLoading ? 'Aguardando resposta da IA...' : 'Pronto para estimar.'}
          </span>
          {lastError ? <span className="error-text">{lastError}</span> : null}
        </div>
      </header>

      <section className="chat-card" aria-label="Chat com IA">
        <div className="chat-header">
          <div>
            <h2>Chat</h2>
            <p>Envie uma descricao detalhada da task.</p>
          </div>
          <div className="status-pill">
            {isLoading ? 'Em analise' : 'Online'}
          </div>
        </div>

        <div className="chat-window" ref={listRef}>
          {messages.map((message) => (
            <article
              key={message.id}
              className={`message ${message.role} ${
                message.status ? message.status : ''
              }`}
            >
              <div className="meta">
                <span className="role">
                  {message.role === 'user' ? 'Voce' : 'IA'}
                </span>
                {message.status === 'error' ? (
                  <span className="tag error">Erro</span>
                ) : null}
                {message.status === 'pending' ? (
                  <span className="tag pending">Processando</span>
                ) : null}
              </div>
              <div className="bubble">
                {message.status === 'pending' ? (
                  <div className="typing" aria-hidden="true">
                    <span />
                    <span />
                    <span />
                  </div>
                ) : null}
                {message.type === 'estimate' ? (
                  <EstimateDisplay content={message.content} />
                ) : (
                  <p>{message.content}</p>
                )}
              </div>
            </article>
          ))}
        </div>

        <form className="composer" onSubmit={(event) => void handleSubmit(event)}>
          <label className="sr-only" htmlFor="task-input">
            Descricao da task
          </label>
          <textarea
            id="task-input"
            placeholder="Ex: Criar endpoint para exportar relatorios em PDF com filtro por data."
            value={input}
            onChange={(event) => setInput(event.target.value)}
            onKeyDown={handleKeyDown}
            rows={3}
            disabled={isLoading}
          />
          <div className="composer-actions">
            <span className="hint">
              Enter para enviar, Shift+Enter para quebrar linha.
            </span>
            <button type="submit" disabled={isLoading || !input.trim()}>
              {isLoading ? 'Enviando...' : 'Enviar'}
            </button>
          </div>
        </form>
      </section>
    </div>
  )
}

export default App
