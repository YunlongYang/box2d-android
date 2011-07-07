//
// This file has been modified by Christof Krüger <jniBox2d@christof-krueger.de>.
//

/*
 * Copyright 2010 Mario Zechner (contact@badlogicgames.com), Nathan Sweet (admin@esotericsoftware.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
 * License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS"
 * BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */
#include "Box2D.h"
#include "DistanceJoint.h"

/*
 * Class:     box2d_joints_DistanceJoint
 * Method:    jniSetLength
 * Signature: (JF)V
 */
JNIEXPORT void JNICALL Java_box2d_joints_DistanceJoint_jniSetLength
  (JNIEnv *, jobject, jlong addr, jfloat len)
{
	b2DistanceJoint* joint = (b2DistanceJoint*)addr;
	joint->SetLength( len );
}

/*
 * Class:     box2d_joints_DistanceJoint
 * Method:    jniGetLength
 * Signature: (J)F
 */
JNIEXPORT jfloat JNICALL Java_box2d_joints_DistanceJoint_jniGetLength
  (JNIEnv *, jobject, jlong addr)
{
	b2DistanceJoint* joint = (b2DistanceJoint*)addr;
	return joint->GetLength();
}

/*
 * Class:     box2d_joints_DistanceJoint
 * Method:    jniSetFrequency
 * Signature: (JF)V
 */
JNIEXPORT void JNICALL Java_box2d_joints_DistanceJoint_jniSetFrequency
  (JNIEnv *, jobject, jlong addr, jfloat hz)
{
	b2DistanceJoint* joint = (b2DistanceJoint*)addr;
	joint->SetFrequency( hz );
}

/*
 * Class:     box2d_joints_DistanceJoint
 * Method:    jniGetFrequency
 * Signature: (J)F
 */
JNIEXPORT jfloat JNICALL Java_box2d_joints_DistanceJoint_jniGetFrequency
  (JNIEnv *, jobject, jlong addr )
{
	b2DistanceJoint* joint = (b2DistanceJoint*)addr;
	return joint->GetFrequency();
}

/*
 * Class:     box2d_joints_DistanceJoint
 * Method:    jniSetDampingRatio
 * Signature: (JF)V
 */
JNIEXPORT void JNICALL Java_box2d_joints_DistanceJoint_jniSetDampingRatio
  (JNIEnv *, jobject, jlong addr, jfloat dampingRatio)
{
	b2DistanceJoint* joint = (b2DistanceJoint*)addr;
	joint->SetDampingRatio( dampingRatio );
}

/*
 * Class:     box2d_joints_DistanceJoint
 * Method:    jniGetDampingRatio
 * Signature: (J)F
 */
JNIEXPORT jfloat JNICALL Java_box2d_joints_DistanceJoint_jniGetDampingRatio
  (JNIEnv *, jobject, jlong addr )
{
	b2DistanceJoint* joint = (b2DistanceJoint*)addr;
	return joint->GetDampingRatio();
}
