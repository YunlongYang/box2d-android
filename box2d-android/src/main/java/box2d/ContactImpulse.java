//
// This file has been modified by Christof Krüger <jniBox2d@christof-krueger.de>.
//

package box2d;

import box2d.Vector2;

public class ContactImpulse {
	final World world;
	long addr;
	float[] tmp = new float[2];
	final float[] normalImpulses = new float[2];
	final float[] tangentImpulses = new float[2];
	
	protected ContactImpulse(World world, long addr) {
		this.world = world;
		this.addr = addr;
	}
	
	public float[] getNormalImpulses() {
		jniGetNormalImpulses(addr, normalImpulses);		
		return normalImpulses;
	}
	
	private native void jniGetNormalImpulses(long addr, float[] values);
	
	public float[] getTangentImpulses() {
		jniGetTangentImpulses(addr, tangentImpulses);		
		return tangentImpulses;
	}
	
	private native void jniGetTangentImpulses(long addr, float[] values);
}
