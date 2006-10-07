From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: RE: Can't Boot - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Sat, 7 Oct 2006 11:09:33 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A8543873739@EXCHDB.admin.wpi.edu>
References: <CC7B089C59ED6841BAE28F1EA69A8543873738@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A8543873738@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Sideleau, Scott R [srs@WPI.EDU] wrote...
> It seems to make sense to me, then, that I could drop the rootfs at
> 0x0022c341 since it is supposed to start at 0x00240000 anyway.

I'm sorry, I meant 0x0026c341.  Please note the 6.

0x0022c341 was the size of the kernel, plus 0x00040000 yields 0x0026c341 =
-- a
memory location already beyond 0x00240000, the listed start location for =
the
rootfs.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
=20
