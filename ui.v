module vdesktop_ui

import vdirty_regions

pub enum NodeKind {
	box
	text
	icon
	input
	button
	tab
	drawer
	badge
	divider
	viewport
}

pub struct Node {
pub:
	id string
	kind NodeKind
	rect vdirty_regions.Rect
	text string
	classes []string
	interactive bool
	children []Node
}

pub struct RuntimeProfile {
pub:
	name string = 'vdesktop-ui-lowram'
	retained_tree bool = true
	continuous_frame_loop bool
	dirty_rects bool = true
	target_ws_mb int = 12
}

pub struct RenderPlan {
pub:
	nodes int
	interactive_nodes int
	dirty_regions []vdirty_regions.Rect
	dirty_area i64
	dirty_pressure string
	full_redraw bool
	profile RuntimeProfile
}

pub fn plan(nodes []Node, dirty []vdirty_regions.Rect, viewport vdirty_regions.Rect) RenderPlan {
	dirty_plan := vdirty_regions.plan_regions(dirty, 64, viewport.w, viewport.h)
	return RenderPlan{
		nodes: count_nodes(nodes)
		interactive_nodes: count_interactive(nodes)
		dirty_regions: dirty_plan.regions
		dirty_area: dirty_plan.dirty_area
		dirty_pressure: dirty_plan.pressure
		full_redraw: dirty_plan.full_redraw
		profile: RuntimeProfile{}
	}
}

pub fn count_nodes(nodes []Node) int {
	mut total := 0
	for node in nodes {
		total++
		total += count_nodes(node.children)
	}
	return total
}

pub fn count_interactive(nodes []Node) int {
	mut total := 0
	for node in nodes {
		if node.interactive {
			total++
		}
		total += count_interactive(node.children)
	}
	return total
}

pub fn find_node(nodes []Node, id string) ?Node {
	for node in nodes {
		if node.id == id {
			return node
		}
		found := find_node(node.children, id) or { continue }
		return found
	}
	return none
}

pub fn hit_test(nodes []Node, x int, y int) ?Node {
	for i := nodes.len - 1; i >= 0; i-- {
		node := nodes[i]
		if !node.rect.contains(x, y) {
			continue
		}
		child := hit_test(node.children, x, y) or {
			if node.interactive {
				return node
			}
			continue
		}
		return child
	}
	return none
}
