package org.box2d.ui.box2d

import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint

class ActivityWorldBodyRender {
    private var mActivityWorld: ActivityWorld? = null

    private val paint = Paint()

    init {
        paint.color = Color.RED
    }

    fun bindWorld(activityWorld: ActivityWorld){
        mActivityWorld = activityWorld
    }

    fun render(canvas: Canvas){
        mActivityWorld?.let {
            val body = it.getBody()
            canvas.drawCircle(
                body.position.x + 100,
                -body.position.y,
                50f,
                paint
            )
        }
    }
}