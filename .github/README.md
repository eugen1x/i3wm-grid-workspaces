# iwm3-grid-workspaces
Script that implements a pseudo 2d grid(10x10) of workspaces.

To enable it add this string: 

    bindsym <keys> exec <path>/grid-ws.sh <direction> <mode>
    
to your "~/.config/i3/config" and make file "grid-ws.sh" executable:

    chmod +x grid-ws.sh
  
  
  
Example for move:
    
    bindsym Control+Mod1+Right exec ~/grid-ws.sh right move
  
Example for switch:
    
    bindsym Control+Mod1+Left exec ~/grid-ws.sh left switch
  
Example for move-and-switch
    
    bindsym Control+Mod1+Up exec ~/grid-ws.sh up move-and-switch
  

Left or right directions moves the current container or switches the view to 10 workspaces in the selected direction.

Up or down directions moves the current container or switches the view to 1 workspaces in the selected direction.

The minimum number of workspace is 10

The maximum number of workspace is 109, when going beyond the border, 
the countdown will start from the minimum workspace
