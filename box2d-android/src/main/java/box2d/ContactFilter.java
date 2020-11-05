//
// This file has been modified by Christof Krüger <jniBox2d@christof-krueger.de>.
//

/*******************************************************************************
 * Copyright 2011 See AUTHORS file.
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
 ******************************************************************************/
package box2d;

/**
 * Implement this class to provide collision filtering. In other words, you can implement this class if you want finer control
 * over contact creation.
 * @author mzechner
 * 
 */
public interface ContactFilter {
	boolean shouldCollide(Fixture fixtureA, Fixture fixtureB);
}