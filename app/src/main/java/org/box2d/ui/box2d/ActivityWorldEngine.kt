package org.box2d.ui.box2d

import android.os.Handler
import android.os.HandlerThread

interface UiRefreshCaller{
    fun refresh()
}

class ActivityWorldEngine {
    private lateinit var mActivityWorld: ActivityWorld

    private lateinit var mHandler : Handler
    private lateinit var mHandlerThread : HandlerThread

    private var uiRefreshCaller : UiRefreshCaller? = null

    private var timeStep = 1.0f / 60.0f
    private var velocityIterations = 6
    private var positionIterations = 2

    fun bindWorld(activityWorld: ActivityWorld){
        mActivityWorld = activityWorld
        mHandlerThread = HandlerThread("ActivityWorldEngine")
        mHandlerThread.start()
        mHandler = Handler(mHandlerThread.looper)
    }

    fun bindUiRefreshCaller(uiRefreshCaller: UiRefreshCaller){
        this.uiRefreshCaller = uiRefreshCaller
    }

    fun start(){
        startLoop()
    }

    fun stop(){
        mHandler.removeCallbacks(loopTask)
    }

    private val loopTask = Runnable {
        mActivityWorld.getWorld().step(timeStep,velocityIterations,positionIterations)
        uiRefreshCaller?.refresh()
        loop()
    }

    private fun startLoop(){
        mHandler.post(loopTask)
    }

    private fun loop(){
        mHandler.postDelayed(loopTask,(timeStep*1000).toLong())
    }
}