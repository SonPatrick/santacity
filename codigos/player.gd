extends CharacterBody2D

@onready var animacao: AnimatedSprite2D = $AnimacaoPlayer

#Enumerador dos estados disponíveis do Player
enum EstadosPlayer {
	correndo,
	dano,
	morrendo,
	parado,
	rolando
}

var estado_atual_player: EstadosPlayer # Variável que recebe o estado atual e disponibiliza para outros métodos que chamarem ela
var direcao = 0

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	animacao.play("correndo")
	estado_atual_player = EstadosPlayer.correndo

	if not is_on_floor(): # se não estiver no chão
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	mover(delta)

	move_and_slide()

#Funcao que atualiza a animacao da direcao do Player
func atualizar_direcao_animacao():
	direcao = Input.get_axis("ui_left", "ui_right")

	if direcao < 0:
		animacao.flip_h = true
	elif direcao > 0:
		animacao.flip_h = false

# Funcao Responsavel pelo movimento do Player
func mover(delta):
	atualizar_direcao_animacao()

	if direcao:
		velocity.x = move_toward(velocity.x, direcao * 80, 400 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, 400 * delta)