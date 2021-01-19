module ecs

import rand

pub struct Component {
pub mut:
        component_type          int
        data                    map[string]f64
        metadata                map[string]string
}

pub fn (mut c Component) create_component(component_type int, data map[string]f64, metadata map[string]string) Component {
        mut component := Component{component_type, data, metadata}
        return component
}

pub struct Entity {
mut:
        id               string
        component_bucket []Component
}

pub fn (mut e Entity) create_entity() Entity {
        mut new_id := e.generate_id()
        mut entity := Entity{new_id, []}
        return entity
}

pub fn (mut e Entity) add_components_to_entity(components []Component) bool {
        for c in components {
                e.component_bucket << c
        }
        return true
}

pub fn (mut e Entity) remove_components_from_entity(components []Component) bool {
        for k, beacon in e.component_bucket {
                for _, component in components {
                        if component.component_type == beacon.component_type {
                                e.component_bucket.delete(k)
                        }
                }
        }
        return true
}

fn (mut e Entity) generate_id() string {
        mut id := rand.uuid_v4()
        return id
}

pub fn (mut e Entity) get_component(component Component) Component {
        if component in e.component_bucket {
                return component
        }
        return {}
}

pub struct System {
mut:
        name       string
        function   fn()
        components []Component
        data       map[string]f64
        metadata   map[string]string
}

pub fn (mut s System) run(name string, function fn(), components []Component, data map[string]f64, metadata map[string]string) {

        /* Systems are substantially side-effects functions. Query for all the entities sharing the array of components */
        
        /* System actions on the world context given the function */ 
        /* Note: should be channeled <- or should be always in concurrency */
        function()
}