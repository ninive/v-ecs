module main

// import time
import ecs

enum Type {
  c_none
  rectangle
  circle
  position
  imagesrc
  identity
}

struct App {
mut:
	c				ecs.Component
	e				ecs.Entity
	s 				ecs.System
	entities		[]ecs.Entity
	render			fn()

	rect_s			ecs.Component
	circle_s		ecs.Component
	p_position		ecs.Component
	avatar			ecs.Component
	identity		ecs.Component
}

fn (mut app App) context() {
	app.c = ecs.Component{}
	app.e = ecs.Entity{}
	app.s = ecs.System{}

	app.rect_s = app.c.create_component(Type.rectangle, {'width':f64(64),'height':f64(32)}, {'':''})
	app.circle_s = app.c.create_component(Type.circle, {'radius':f64(5)}, {'':''})
	app.p_position = app.c.create_component(Type.position, {'x':f64(64),'y':f64(32)}, {'':''})
	app.avatar = app.c.create_component(Type.imagesrc, {'width':f64(64),'height':f64(64)}, {'src':'./avatar.png'})
	app.identity = app.c.create_component(Type.identity, {'':f64(0)}, {'name': 'Ninive', 'type': 'player'})

	app.entities = []ecs.Entity{}

	for _ in 0 .. 3 {
		app.entities << app.e.create_entity()
	}

	app.entities[0].add_components_to_entity([app.circle_s, app.p_position])
	app.entities[1].add_components_to_entity([app.rect_s, app.p_position])
	app.entities[2].add_components_to_entity([app.rect_s, app.p_position, app.avatar, app.identity]) // Player Entity

	app.entities[0].remove_components_from_entity([app.p_position])
	
	/* quick test */
	assert app.entities[2].get_component(app.rect_s).data['width'] == 64

	/* Destroy an entity */
	// entities.delete(0)
	
	/* Get a live entity component */
	// println(app.entities[2].get_component(rr1))

	/* Get data from component */
	// println(entities[2].get_component(rr1).data['width'])

}

fn (mut app App) update() {
	/* Note: This could be JSON templated and potentially NN automated */
	/* Default one frame testing app renderer, no components updates */
	app.s.run('renderer', app.render, [], {'':f64(0)}, {'':''})
	
	/* Physics for the velocity System example/milestone_reaching design */
	// app.s.run('movement', app.movement, [app.position, app.AI], {'speed':f64(8),'angle':f64(54)}, {'':''})
}

fn (mut app App) run() {
	// for {
		app.update()
		// time.sleep_ms(24)
	// }
}

fn (mut app App) render() {
	println(app.entities)
}

fn main() {
	mut app := &App{}
	app.context()
	app.render()
	go app.run()
}