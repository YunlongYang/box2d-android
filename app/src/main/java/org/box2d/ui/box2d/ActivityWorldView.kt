package org.box2d.ui.box2d

import android.content.Context
import android.graphics.Canvas
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.View

class ActivityWorldView @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0
) : View(context, attrs, defStyleAttr), UiRefreshCaller {

    private val activityWorldBodyRender = ActivityWorldBodyRender()

    private var engine : ActivityWorldEngine? = null

    fun bindWorld(activityWorld: ActivityWorld,engine: ActivityWorldEngine) {
        activityWorldBodyRender.bindWorld(activityWorld)
        this.engine = engine
        engine.bindUiRefreshCaller(this)
    }

    override fun onTouchEvent(event: MotionEvent): Boolean {
        when(event.action){
            MotionEvent.ACTION_DOWN->{
                engine?.start()
            }
            MotionEvent.ACTION_UP->{
                engine?.stop()
            }
        }
        return true
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        activityWorldBodyRender.render(canvas)
    }

    override fun refresh() {
        post { invalidate() }
    }
}