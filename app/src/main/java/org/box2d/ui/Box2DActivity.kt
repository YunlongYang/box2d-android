package org.box2d.ui

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import box2d.World
import org.box2d.R
import org.box2d.android.Box2dNdk
import org.box2d.ui.box2d.ActivityWorld
import org.box2d.ui.box2d.ActivityWorldEngine
import org.box2d.ui.box2d.ActivityWorldView

class Box2DActivity : AppCompatActivity() {

    private lateinit var mActivityWorld : ActivityWorld
    private lateinit var mActivityWorldView : ActivityWorldView
    private lateinit var mActivityWorldEngine: ActivityWorldEngine
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_box2d)
        Box2dNdk.load()

        mActivityWorld = ActivityWorld()
        mActivityWorld.onCreate()

        mActivityWorldView = findViewById(R.id.activity_world_view)


        mActivityWorldEngine = ActivityWorldEngine()
        mActivityWorldEngine.bindWorld(mActivityWorld)

        mActivityWorldView.bindWorld(mActivityWorld,mActivityWorldEngine)


    }

    override fun onDestroy() {
        super.onDestroy()
        mActivityWorld.onDestroy()
    }
}