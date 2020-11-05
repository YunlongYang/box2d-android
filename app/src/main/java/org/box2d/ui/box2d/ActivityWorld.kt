package org.box2d.ui.box2d

import box2d.*

class ActivityWorld {
    private lateinit var mWorld: World

    private lateinit var singleBody : Body

    private val singleBodyDef = BodyDef()
    private val fixtureDef = FixtureDef().also {
        val circleShape = CircleShape()
        circleShape.position.x = 100f
        circleShape.position.y = 100f
        circleShape.radius = 50f
        it.shape = circleShape
    }

    fun onCreate(){
        mWorld = World(Vector2(0f,-9.81f),true)
        singleBodyDef.type = BodyDef.BodyType.DynamicBody
        singleBody = mWorld.createBody(singleBodyDef)
        singleBody.createFixture(fixtureDef)
//        fixtureDef.shape.dispose()
    }

    fun getBody():Body{
        return singleBody
    }

    fun getWorld():World{
        return mWorld
    }

    fun onDestroy(){

    }
}