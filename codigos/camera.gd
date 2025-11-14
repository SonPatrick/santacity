extends Camera2D

var alvo: Node2D # variável que recebe o nó do nosso Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buscar_alvo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = alvo.position # camera recebe a posição do alvo(Player)

func buscar_alvo():
	var nodes = get_tree().get_nodes_in_group("Player")

	if nodes.size() == 0: # Se o total de nós do grupo Player for igual a zero
		push_error("Nó Player não foi encontrado") # Exibe uma mensagem no console/terminal
		return # encerra a execução do método após o erro

	alvo = nodes[0]
