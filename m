From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Cleanup 24xx definitions common to both 24xx / 3430
Date: Wed, 20 Jun 2007 22:16:20 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012A5136@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Cleanup 24xx.h definitions common to both 24xx / 3430

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 include/asm-arm/arch-omap/omap24xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-06-12 =
15:08:51.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/omap24xx.h	2007-06-20 =
14:37:23.000000000 -0500
@@ -35,7 +35,6 @@
 #define L4_24XX_BASE		0x48000000
 #define L4_WK_243X_BASE		0x49000000
 #define L3_24XX_BASE		0x68000000
-#define L4_OMAP_BASE		L4_24XX_BASE
=20
 /* interrupt controller */
 #define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)
