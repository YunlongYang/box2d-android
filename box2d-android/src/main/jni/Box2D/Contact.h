//
// This file has been modified by Christof Krüger <jniBox2d@christof-krueger.de>.
//

/**
* Copyright 2010 Mario Zechner (contact@badlogicgames.com)
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*   http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class box2d_Contact */

#ifndef _Included_box2d_Contact
#define _Included_box2d_Contact
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     box2d_Contact
 * Method:    jniGetWorldManifold
 * Signature: (J[F)I
 */
JNIEXPORT jint JNICALL Java_box2d_Contact_jniGetWorldManifold
  (JNIEnv *, jobject, jlong, jfloatArray);

/*
 * Class:     box2d_Contact
 * Method:    jniIsTouching
 * Signature: (J)Z
 */
JNIEXPORT jboolean JNICALL Java_box2d_Contact_jniIsTouching
  (JNIEnv *, jobject, jlong);

/*
 * Class:     box2d_Contact
 * Method:    jniSetEnabled
 * Signature: (JZ)V
 */
JNIEXPORT void JNICALL Java_box2d_Contact_jniSetEnabled
  (JNIEnv *, jobject, jlong, jboolean);

/*
 * Class:     box2d_Contact
 * Method:    jniIsEnabled
 * Signature: (J)Z
 */
JNIEXPORT jboolean JNICALL Java_box2d_Contact_jniIsEnabled
  (JNIEnv *, jobject, jlong);

/*
 * Class:     box2d_Contact
 * Method:    jniGetFixtureA
 * Signature: (J)J
 */
JNIEXPORT jlong JNICALL Java_box2d_Contact_jniGetFixtureA
  (JNIEnv *, jobject, jlong);

/*
 * Class:     box2d_Contact
 * Method:    jniGetFixtureB
 * Signature: (J)J
 */
JNIEXPORT jlong JNICALL Java_box2d_Contact_jniGetFixtureB
  (JNIEnv *, jobject, jlong);

#ifdef __cplusplus
}
#endif
#endif
