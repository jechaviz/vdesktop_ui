module vdesktop_ui

import vdirty_regions

fn test_scene_count_and_hit_test() {
	nodes := [
		Node{
			id: 'root'
			kind: .box
			rect: vdirty_regions.Rect{0, 0, 500, 300}
			children: [
				Node{
					id: 'mission'
					kind: .input
					rect: vdirty_regions.Rect{20, 20, 300, 40}
					interactive: true
				},
			]
		},
	]
	assert count_nodes(nodes) == 2
	assert count_interactive(nodes) == 1
	hit := hit_test(nodes, 30, 30) or { panic('missing hit') }
	assert hit.id == 'mission'
}
