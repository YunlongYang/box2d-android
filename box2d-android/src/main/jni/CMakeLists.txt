# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.10.2)

# Declares and names the project.

project("box2d")

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.

include_directories(./)

add_library( # Sets the name of the library.
             box2d
             # Sets the library as a shared library.
             SHARED
             # Provides a relative path to your source file(s).
Box2D/ContactImpulse.cpp
Box2D/LineJoint.cpp
Box2D/Contact.cpp
Box2D/RevoluteJoint.cpp
Box2D/Fixture.cpp
Box2D/Shape.cpp
Box2D/PulleyJoint.cpp
Box2D/FrictionJoint.cpp
Box2D/DistanceJoint.cpp
Box2D/Joint.cpp
Box2D/World.cpp
Box2D/MouseJoint.cpp
Box2D/PolygonShape.cpp
Box2D/PrismaticJoint.cpp
Box2D/GearJoint.cpp
Box2D/Body.cpp
Box2D/CircleShape.cpp
Box2D/Manifold.cpp
Box2D/Common/b2Math.cpp
Box2D/Common/b2StackAllocator.cpp
Box2D/Common/b2BlockAllocator.cpp
Box2D/Common/b2Settings.cpp
Box2D/Collision/b2DynamicTree.cpp
Box2D/Collision/b2TimeOfImpact.cpp
Box2D/Collision/b2Collision.cpp
Box2D/Collision/b2CollidePolygon.cpp
Box2D/Collision/b2Distance.cpp
Box2D/Collision/b2CollideCircle.cpp
Box2D/Collision/b2BroadPhase.cpp
Box2D/Collision/Shapes/b2PolygonShape.cpp
Box2D/Collision/Shapes/b2CircleShape.cpp
Box2D/Dynamics/b2WorldCallbacks.cpp
Box2D/Dynamics/b2World.cpp
Box2D/Dynamics/b2ContactManager.cpp
Box2D/Dynamics/b2Island.cpp
Box2D/Dynamics/b2Body.cpp
Box2D/Dynamics/b2Fixture.cpp
Box2D/Dynamics/Joints/b2LineJoint.cpp
Box2D/Dynamics/Joints/b2PulleyJoint.cpp
Box2D/Dynamics/Joints/b2PrismaticJoint.cpp
Box2D/Dynamics/Joints/b2DistanceJoint.cpp
Box2D/Dynamics/Joints/b2WeldJoint.cpp
Box2D/Dynamics/Joints/b2RevoluteJoint.cpp
Box2D/Dynamics/Joints/b2MouseJoint.cpp
Box2D/Dynamics/Joints/b2Joint.cpp
Box2D/Dynamics/Joints/b2FrictionJoint.cpp
Box2D/Dynamics/Joints/b2GearJoint.cpp
Box2D/Dynamics/Contacts/b2Contact.cpp
Box2D/Dynamics/Contacts/b2PolygonAndCircleContact.cpp
Box2D/Dynamics/Contacts/b2TOISolver.cpp
Box2D/Dynamics/Contacts/b2CircleContact.cpp
Box2D/Dynamics/Contacts/b2ContactSolver.cpp
Box2D/Dynamics/Contacts/b2PolygonContact.cpp)

# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

find_library( # Sets the name of the path variable.
              log-lib
              # Specifies the name of the NDK library that
              # you want CMake to locate.
              log )

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

target_link_libraries( # Specifies the target library.
                       box2d
                       # Links the target library to the log library
                       # included in the NDK.
                       ${log-lib} )