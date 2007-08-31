From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] To fix OMAP3430 boot for new mach-types
Date: Thu, 30 Aug 2007 19:04:29 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701A9127E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


This patch is to fix OMAP 3430 boot/compilation for updated mach-types.

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>

File:
 arch/arm/mach-omap2/board-3430sdp.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-07-11 =
09:55:16.000000000 -0500
+++ my_linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-08-30 =
18:54:44.000000000 -0500
@@ -181,7 +181,7 @@ static void __init omap_3430sdp_map_io(v
 	omap2_map_common_io();
 }
=20
-MACHINE_START(OMAP_SDP3430, "OMAP3430 sdp3430 board")
+MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	=3D 0x48000000,
 	.io_pg_offst	=3D ((0xd8000000) >> 18) & 0xfffc,
