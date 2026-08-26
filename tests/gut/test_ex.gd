extends "res://addons/gut/test.gd"


func test_basic_math_works():
	var result = 2 + 2
	assert_eq(result, 4, "2 + 2 should equal 4")
