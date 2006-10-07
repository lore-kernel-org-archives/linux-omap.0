From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: RE: Can't Boot - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Sat, 7 Oct 2006 13:02:30 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A854387373A@EXCHDB.admin.wpi.edu>
References: <CC7B089C59ED6841BAE28F1EA69A8543873739@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A8543873739@EXCHDB.admin.wpi.edu>
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

I re-compiled the kernel again with low-level debugging enabled and =
patched,
as Dirk Behme previously requested of me.

I game up trying to put the rootfs near the kernel in flash, so I moved =
it
back to 0x1000000, far away from everything.

The board will boot and appears to successfully mount the rootfs, but =
still
hangs awkwardly.  The output is quite large, so I put it in a =
pastebin...

http://rafb.net/paste/results/Z0L4A080.html

Any ideas?
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
=20
