package main

import (
	"carotovt/config"

	g "github.com/AllenDang/giu"
)

func loop() {
	g.SingleWindow("Overview").Layout(g.Layout{
		g.TabBar("Tabbar Input").Layout(g.Layout{
			g.TabItem("Search").Layout(g.Layout{}),
			g.TabItem("About").Layout(g.Layout{
				g.Line(
					g.Group().Layout(g.Layout{
						g.Label("Carot Onvif Tool Ver." + config.Version),
					}),
				),
			}),
		}),
	})
}

func main() {
	g.NewMasterWindow("Carot Onvif Tool", 900, 600, 0, nil).Run(loop)
}
