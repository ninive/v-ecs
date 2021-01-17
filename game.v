module main

// import time
import ecs

const (
	c_none 	  	= 0 // Component types (use Enum here?)
	rectangle	= 1
	circle		= 2
	position	= 3
	imagesrc	= 4
	identity	= 5
)

struct App {
mut:
	c				ecs.Component
	e				ecs.Entity
	s				ecs.System
	entities		[]ecs.Entity
	render			fn()
}

fn (mut app App) context() {
	app.c = ecs.Component{}
	app.e = ecs.Entity{}
	app.s = ecs.System{}

	// Todo: Move this in the struct to have the components name available 
	mut rr1 := app.c.create_component(rectangle, {'width':f64(64),'height':f64(32)}, {'':''})
	mut cc1 := app.c.create_component(circle, {'radius':f64(5)}, {'':''})
	mut pos1 := app.c.create_component(position, {'x':f64(64),'y':f64(32)}, {'':''})
	mut avatar := app.c.create_component(imagesrc, {'width':f64(64),'height':f64(64)}, {'src':'./avatar.png'})
	mut idy1 := app.c.create_component(identity, {'':f64(0)}, {'name': 'Ninive', 'type': 'player'})

	app.entities = []ecs.Entity{}

	for _ in 0 .. 3 {
		app.entities << app.e.create_entity()
	}

	app.entities[0].add_components_to_entity([cc1, pos1])
	app.entities[1].add_components_to_entity([rr1, pos1])
	app.entities[2].add_components_to_entity([rr1, pos1, avatar, idy1]) // Player Entity
	
	/* quick test */
	assert app.entities[2].get_component(rr1).data['width'] == 64

	/* Destroy an entity */
	// entities.delete(0)
	
	/* Get a live entity component */
	// println(app.entities[2].get_component(rr1))

	/* Get data from component */
	// println(entities[2].get_component(rr1).data['width'])

}

fn (mut app App) update() {
	app.s.run('renderer', app.render, [], {'':f64(0)}, {'':''})
	
	/* Physics for Velocity System Example */
	// app.s.run('movement', app.movement, [app.position], {'speed':f64(8),'angle':f64(54)}, {'':''})
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