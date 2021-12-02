extends Node

var high_score=load_data()
var current_score=0

func load_data():
	var file=File.new()
	file.open("user://save_game.data",File.READ)
	var data=file.get_16()
	file.close()
	return data

func save_data(data):
	var file=File.new()
	file.open("user://save_game.data",File.WRITE)
	file.store_16(data)
	file.close()
	high_score=data
