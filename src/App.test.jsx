import { render, screen, fireEvent } from '@testing-library/react'
import App from './App'

describe('App', () => {
  it('starts the counter at 0', () => {
    render(<App />)
    expect(screen.getByRole('button')).toHaveTextContent('Count is 0')
  })

  it('increments the counter when clicked', () => {
    render(<App />)
    const button = screen.getByRole('button')

    fireEvent.click(button)

    expect(button).toHaveTextContent('Count is 1')
  })
})
