module vdesktop_ui

pub struct Color {
pub:
	r u8
	g u8
	b u8
	a u8 = 255
}

pub struct FontSpec {
pub:
	family string = 'Segoe UI'
	size int = 13
	weight int = 400
}

pub struct Theme {
pub:
	name string = 'neutral-dark'
	background Color = Color{r: 18, g: 20, b: 24}
	surface Color = Color{r: 28, g: 31, b: 36}
	surface_alt Color = Color{r: 36, g: 40, b: 47}
	text Color = Color{r: 235, g: 238, b: 244}
	muted Color = Color{r: 151, g: 158, b: 171}
	accent Color = Color{r: 113, g: 156, b: 255}
	danger Color = Color{r: 231, g: 91, b: 91}
	font FontSpec
	radius int = 10
	spacing int = 8
}

pub fn default_theme() Theme {
	return Theme{}
}
