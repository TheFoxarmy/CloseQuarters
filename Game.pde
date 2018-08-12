public class Game {
    public Game() {
        currentRoom = new Room("room1");
        newRoom = new Room("room1");
        player = new Player(100, 100);
        drawables.add(player);
        currentRoom.roomDrawables.add(new Door(0, (720/2)-100, newRoom));
        // drawables.add(new LightMask()); <- REMOVED FOR NOW
        drawablesUpdated();
    }
    public void draw() {   
      currentRoom.draw();
      for(Drawable t : drawables)
        t.draw();
    }
    public void tick() {
        boolean drawablesChanged = false;
        for(Drawable t : drawables) {
            if (t instanceof Sprite) {
                Sprite sprite = (Sprite) t;
                for(Drawable j : drawables) {
                    if(j instanceof Sprite) {
                        Sprite sprite2 = (Sprite) j;
                        if (intersects(sprite, sprite2)) {
                            if (sprite.onCollision(sprite2)) {
                                drawablesChanged = true;
                            }
                        }
                    }
                }
                sprite.tick();
            }
            currentRoom.tick();
            if(drawablesChanged) drawablesUpdated();
        }
    }
    public void keyPressed() {
        player.keyPressed();
        if(key == ESC)
            key = 0;
    }
    public void keyReleased() {
        player.keyReleased();
        if(key == ESC) {
            key = 0;
            drawables.clear();
            playstate = PlayState.MENU;
        }
    }
    
}