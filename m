From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v4 2/3] ARM: OMAP: TI814X: Add cpu type macros and detection support
Date: Mon, 10 Oct 2011 07:10:04 +0530
Message-ID: <1318210804-2447-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41368 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab1JJBkN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 9 Oct 2011 21:40:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch adds cpu type, macros for identification of TI814X device.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c          |    3 +++
 arch/arm/mach-omap2/id.c                      |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/include/plat/clock.h       |    1 +
 arch/arm/plat-omap/include/plat/cpu.h         |    9 +++++++++
 5 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 96622b6..4d8e908 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3517,6 +3517,9 @@ int __init omap3xxx_clk_init(void)
 	} else if (cpu_is_ti816x()) {
 		cpu_mask = RATE_IN_TI816X;
 		cpu_clkflg = CK_TI816X;
+	} else if (cpu_is_ti814x()) {
+		cpu_mask = RATE_IN_TI814X;
+		cpu_clkflg = CK_TI814X;
 	} else if (cpu_is_omap34xx()) {
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			cpu_mask = RATE_IN_3430ES1;
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index ab2f417..f07faa9 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -337,6 +337,26 @@ static void __init omap3_check_revision(const char **cpu_rev)
 			break;
 		}
 		break;
+	case 0xb8f2:
+		switch (rev) {
+		case 0:
+		/* FALLTHROUGH */
+		case 1:
+			omap_revision = TI8148_REV_ES1_0;
+			*cpu_rev = "1.0";
+			break;
+		case 2:
+			omap_revision = TI8148_REV_ES2_0;
+			*cpu_rev = "2.0";
+			break;
+		case 3:
+		/* FALLTHROUGH */
+		default:
+			omap_revision = TI8148_REV_ES2_1;
+			*cpu_rev = "2.1";
+			break;
+		}
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP3630_REV_ES1_2;
@@ -429,6 +449,8 @@ static void __init omap3_cpuinfo(const char *cpu_rev)
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
 		cpu_name = "TI816X";
+	} else if (cpu_is_ti814x()) {
+		cpu_name = "TI814X";
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		cpu_name = "OMAP3430/3530";
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 6d84c0c..ea61ea2 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -41,6 +41,7 @@ struct omap_clk {
 #define CK_TI816X	(1 << 12)
 #define CK_446X		(1 << 13)
 #define CK_AM33XX	(1 << 14)	/* AM33xx specific clocks */
+#define CK_TI814X	(1 << 15)
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 168c54e..739ba23 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -60,6 +60,7 @@ struct clkops {
 #define RATE_IN_TI816X		(1 << 6)
 #define RATE_IN_4460		(1 << 7)
 #define RATE_IN_AM33XX		(1 << 8)
+#define RATE_IN_TI814X		(1 << 9)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 03ab390..6bc662e 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -132,6 +132,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 IS_OMAP_SUBCLASS(446x, 0x446)
 
 IS_TI_SUBCLASS(816x, 0x816)
+IS_TI_SUBCLASS(814x, 0x814)
 IS_AM_SUBCLASS(335x, 0x335)
 
 #define cpu_is_omap7xx()		0
@@ -144,6 +145,7 @@ IS_AM_SUBCLASS(335x, 0x335)
 #define cpu_is_omap343x()		0
 #define cpu_is_ti81xx()			0
 #define cpu_is_ti816x()			0
+#define cpu_is_ti814x()			0
 #define cpu_is_am33xx()			0
 #define cpu_is_am335x()			0
 #define cpu_is_omap44xx()		0
@@ -353,6 +355,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3517
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
+# undef cpu_is_ti814x
 # undef cpu_is_am33xx
 # undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
@@ -373,6 +376,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
+# define cpu_is_ti814x()		is_ti814x()
 # define cpu_is_am33xx()		is_am33xx()
 # define cpu_is_am335x()		is_am335x()
 #endif
@@ -421,6 +425,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define TI8168_REV_ES1_0	TI816X_CLASS
 #define TI8168_REV_ES1_1	(TI816X_CLASS | (0x1 << 8))
 
+#define TI814X_CLASS		0x81400034
+#define TI8148_REV_ES1_0	TI814X_CLASS
+#define TI8148_REV_ES2_0	(TI814X_CLASS | (0x1 << 8))
+#define TI8148_REV_ES2_1	(TI814X_CLASS | (0x2 << 8))
+
 #define AM335X_CLASS		0x33500034
 #define AM335X_REV_ES1_0	AM335X_CLASS
 
-- 
1.7.3.5

