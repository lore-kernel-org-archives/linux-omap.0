From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: RE: Can't Boot - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Fri, 6 Oct 2006 15:05:37 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A8543873730@EXCHDB.admin.wpi.edu>
References: <CC7B089C59ED6841BAE28F1EA69A854387372D@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A854387372D@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

I was finally able to get a successful compile of the 2.6.18-omap1 =
kernel
with the help of Dirk Behme's config file (thanks again, Dirk).  Now, =
though,
the OSK is unable to boot the new kernel, but instead just hangs.  From =
my
console (as it has been running for the last half-hour)...

=3D=3D=3D=3D=3D
U-Boot 1.1.4 (Aug 29 2006 - 17:05:48)

CPU:   OMAP162123 at 96.0 MHz (DPLL1=3D96.0 MHz)
Board: OSK5912
DRAM:  32 MB
Flash: 32 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
## Booting image at 00100000 ...
   Image Name:   OE
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1065210 Bytes =3D  1 MB
   Load Address: 10c08000
   Entry Point:  10c08000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...
=3D=3D=3D=3D=3D

This kernel build includes the two pushes earlier today by Tony =
Lindgren.

Any ideas?  Any and all help/direction is appreciated.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
=20
