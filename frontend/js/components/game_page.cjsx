Client = require('../Client.coffee')
StartedGameState = require('../../../shared/StartedGameState.coffee')
Lobby = require('./lobby.cjsx')
Gameplay = require('./gameplay.cjsx')

module.exports = React.createClass(
  displayName: 'GamePage'

  getInitialState: ->
    {}

  componentDidMount: ->
    @client = new Client(io(), @props.params.id, (data) =>
      @setState({data})
      # For debugging
      window.data = data
    )

  componentWillUnmount: ->
    @client.unsubscribe()

  pushMove: (move) ->
    @client.pushMove(move)

  render: ->
    if not @state.data?
      <div>Loading...</div> 
    else if @state.data.gameState instanceof StartedGameState
      <Gameplay data={@state.data} pushMove={@pushMove} />
    else
      <Lobby data={@state.data} pushMove={@pushMove} />
)