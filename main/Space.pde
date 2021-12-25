/*
	A face on the icosphere.
*/
class Space {	
	PVector[] verts = new PVector[3];
	
	// Centroid
	PVector c;

	// Neighbors
	Space n1;
	Space n2;
	Space n3;
	PVector[] neighbors = new PVector[3];

	//children
	Space[] children = new Space[4];

	/*
		Creates a Space with 3 vertices.
	*/
	Space (PVector vert1, PVector vert2, PVector vert3) {
		verts[0] = vert1;
		verts[1] = vert2;
		verts[2] = vert3;
		setCentroid();
	}

	/*
		Create a Space from neighbors instead of vertices.
	*/
	Space (Space neighbor1, Space neighbor2, Space neighbor3) {
		n1 = neighbor1;
		n2 = neighbor2;
		n3 = neighbor3;
		makeVerts();
		setCentroid();
	}


	void display() {
		strokeWeight(1);
		stroke(0,0,255,50);
		// float theta = atan2(c.y, c.x);
		// float phi = atan2(c.y, c.z);
		// stroke((200*inc+(50*sin(inc)+100)*sin(phi+inc)*sin(theta+inc))%255, 120, 200, 30);
		
		line(verts[0].x, verts[0].y, verts[0].z, verts[1].x, verts[1].y, verts[1].z);
		line(verts[1].x, verts[1].y, verts[1].z, verts[2].x, verts[2].y, verts[2].z);
		line(verts[0].x, verts[0].y, verts[0].z, verts[2].x, verts[2].y, verts[2].z);

		// displayCentroid();
		// drawNeighborVectors();
	}
	/*

		(I literally do not remember how this function works but here is a comment I left):
		
	   "Returns which neighbor a is to b
		a.n[x] = b
		where x = a_offset"
	*/
	int findNeighbor(Space a, Space b, int a_offset){
		if(a == b.n1) return abs(a_offset-1);
		else if(a == b.n2) return abs(a_offset-2);
		else if(a == b.n3) return abs(a_offset-3);
		else return -1;
	}

	void displayCentroid() {
		fill(255);
		text(dw.spaces.indexOf(this), c.x, c.y, c.z);
		point(c.x, c.y, c.z);
	}

	/*
		Builds this Space's verts by matching up neighbors.
	*/
	void makeVerts() {
		verts[0] = getCommonVertex(n1, n3);
		verts[1] = getCommonVertex(n1, n2);
		verts[2] = getCommonVertex(n2, n3);
	}

	/*
		Return a common vertex between two triangles.
	*/
	PVector getCommonVertex(Space s1, Space s2) {
		if(s1.verts[0] == s2.verts[0]) return s1.verts[0];
		if(s1.verts[0] == s2.verts[1]) return s1.verts[0];
		if(s1.verts[0] == s2.verts[2]) return s1.verts[0];

		if(s1.verts[1] == s2.verts[0]) return s1.verts[1];
		if(s1.verts[1] == s2.verts[1]) return s1.verts[1];
		if(s1.verts[1] == s2.verts[2]) return s1.verts[1];

		if(s1.verts[2] == s2.verts[0]) return s1.verts[2];
		if(s1.verts[2] == s2.verts[1]) return s1.verts[2];
		if(s1.verts[2] == s2.verts[2]) return s1.verts[2];

		println("No common vertex.");
		return new PVector(-1, -1, -1);
	}

	/*
		Returns PVector of centroid:
		c(p1,p2,p3) = average of p1, p2, p3's components
	*/
	void setCentroid() {
		this.c = new PVector((verts[0].x+verts[1].x+verts[2].x)/3, (verts[0].y+verts[1].y+verts[2].y)/3, (verts[0].z+verts[1].z+verts[2].z)/3);
	}

	PVector getMidpoint(PVector vert1, PVector vert2) {
		return new PVector((vert1.x+vert2.x)/2, (vert1.y+vert2.y)/2, (vert1.z+vert2.z)/2);
	}

	//WIP
	// void setNeighbors(int s1, int s2, int s3) {
	// 	println(dw.spaces);
	// 	// n1 = dw.spaces.get(s1);
	// 	// n2 = dw.spaces.get(s2);
	// 	// n3 = dw.spaces.get(s3);
	// }

	/*
		Draws lines from centroid to edge to indicate direction of each neighbor.
		n1 = red line
		n2 = green line
		n3 = blue line
	*/
	void drawNeighborVectors() {
		//draw n1 line
		stroke(0, 255, 255, 200);
		PVector n1mid = getMidpoint(verts[0], verts[1]);
		line(c.x, c.y, c.z, n1mid.x, n1mid.y, n1mid.z);		

		//draw n2 line
		stroke(85, 255, 255, 200);
		PVector n2mid = getMidpoint(verts[1], verts[2]);
		line(c.x, c.y, c.z, n2mid.x, n2mid.y, n2mid.z);

		//draw n3 line
		stroke(170, 255, 255, 200);
		PVector n3mid = getMidpoint(verts[2], verts[0]);
		line(c.x, c.y, c.z, n3mid.x, n3mid.y, n3mid.z);

		// //draw n1 text
		// PVector c_n1_mid = getMidpoint(c, n1mid);
		// text("n1", c_n1_mid.x, c_n1_mid.y, c_n1_mid.z);
		// point(c_n1_mid.x, c_n1_mid.y, c_n1_mid.z);

		// //draw n2 text
		// PVector c_n2_mid = getMidpoint(c, n2mid);
		// text("n2", c_n2_mid.x, c_n2_mid.y, c_n2_mid.z);
		// point(c_n2_mid.x, c_n2_mid.y, c_n2_mid.z);

		// //draw n3 text
		// PVector c_n3_mid = getMidpoint(c, n3mid);
		// text("n3", c_n3_mid.x, c_n3_mid.y, c_n3_mid.z);
		// point(c_n3_mid.x, c_n3_mid.y, c_n3_mid.z);
	}
}
