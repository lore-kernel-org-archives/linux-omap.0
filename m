From: "Choraria, Rohit" <rohitkc@ti.com>
Subject: [PATCH] ARM: OMAP: Warm reset functionality for 34xx
Date: Wed, 7 Nov 2007 14:41:49 +0530
Message-ID: <AC2D475575504148943F5EB0938951C4011252AA@dbde01.ent.ti.com>
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

Hi,
This patch adds the implementation for warm reset functionality for =
OMAP3.

Regards,
Rohit

Signed-off-by: Rohit Choraria <rohitkc@ti.com>
---
 arch/arm/mach-omap2/prcm.c         |   11 +++++++++--
 include/asm-arm/arch-omap/system.h |    2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-omap-git-20071030/arch/arm/mach-omap2/prcm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-git-20071030.orig/arch/arm/mach-omap2/prcm.c	2007-10-30 =
12:38:14.000000000 -0400
+++ linux-omap-git-20071030/arch/arm/mach-omap2/prcm.c	2007-11-06 =
13:22:07.892612648 -0500
@@ -33,6 +33,13 @@
 {
 	u32 wkup;
 	omap2_clk_prepare_for_reboot();
-	wkup =3D prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | OMAP_RST_DPLL3;
-	prm_write_mod_reg(wkup, WKUP_MOD, RM_RSTCTRL);
+
+	if (cpu_is_omap24xx()) {
+		wkup =3D prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | OMAP_RST_DPLL3;
+		prm_write_mod_reg(wkup, WKUP_MOD, RM_RSTCTRL);
+	} else if (cpu_is_omap34xx()) {
+		wkup =3D prm_read_mod_reg(OMAP3430_GR_MOD, RM_RSTCTRL)
+							| OMAP_RST_DPLL3;
+		prm_write_mod_reg(wkup, OMAP3430_GR_MOD, RM_RSTCTRL);
+	}
 }
Index: linux-omap-git-20071030/include/asm-arm/arch-omap/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-git-20071030.orig/include/asm-arm/arch-omap/system.h	=
2007-10-30 12:42:49.000000000 -0400
+++ linux-omap-git-20071030/include/asm-arm/arch-omap/system.h	=
2007-11-06 13:21:57.893132800 -0500
@@ -40,7 +40,7 @@
=20
 static inline void arch_reset(char mode)
 {
-	if (!cpu_is_omap24xx())
+	if (!cpu_class_is_omap2())
 		omap1_arch_reset(mode);
 	else
 		omap_prcm_arch_reset(mode);
