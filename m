From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 2/3] TI814X: Add cpu type macros and detection support
Date: Thu, 4 Aug 2011 23:14:54 +0530
Message-ID: <1312479894-22824-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33260 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042Ab1HDRpG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 13:45:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch adds cpu type, macros for identification of TI814X device.

Note that following updates to common OMAP data structures are made:
1) struct omap_chip_id member 'oc' is updated to u32 from u16 as omap chip
bitfield has exhausted 16 bits for CHIP_IS_XXX.
2) cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence struct
clksel_rate.flags, struct prcm_config.flags and cpu_mask are changed to u16 from
u8.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/clock.c                   |    2 +-
 arch/arm/mach-omap2/clock.h                   |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c          |    3 +++
 arch/arm/mach-omap2/id.c                      |   18 ++++++++++++++++++
 arch/arm/mach-omap2/opp2xxx.h                 |    2 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/include/plat/clock.h       |    3 ++-
 arch/arm/plat-omap/include/plat/cpu.h         |   12 +++++++++++-
 8 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 1f3481f..f57ed5b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -35,7 +35,7 @@
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 
-u8 cpu_mask;
+u16 cpu_mask;
 
 /*
  * clkdm_control: if true, then when a clock is enabled in the
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 48ac568..687d3d3 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -130,7 +130,7 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
 
-extern u8 cpu_mask;
+extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_dummy;
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 10cf22f..af58741 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3482,6 +3482,9 @@ int __init omap3xxx_clk_init(void)
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
index 3d84fca..98f1922 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -346,6 +346,22 @@ static void __init omap3_check_revision(void)
 			omap_revision =  TI8168_REV_ES1_1;
 		}
 		break;
+	case 0xb8f2:
+		omap_chip.oc = CHIP_IS_TI814X;
+
+		switch (rev) {
+		case 0:
+		/* FALLTHROUGH */
+		case 1:
+			omap_revision = TI8148_REV_ES1_0;
+			break;
+		case 2:
+			omap_revision = TI8148_REV_ES2_0;
+			break;
+		default:
+			omap_revision = TI8148_REV_ES2_1;
+		}
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		omap_revision =  OMAP3630_REV_ES1_2;
@@ -451,6 +467,8 @@ static void __init omap3_cpuinfo(void)
 		}
 	} else if (cpu_is_ti816x()) {
 		strcpy(cpu_name, "TI816X");
+	} else if (cpu_is_ti814x()) {
+		strcpy(cpu_name, "TI814X");
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
diff --git a/arch/arm/mach-omap2/opp2xxx.h b/arch/arm/mach-omap2/opp2xxx.h
index 8affc66..8fae534 100644
--- a/arch/arm/mach-omap2/opp2xxx.h
+++ b/arch/arm/mach-omap2/opp2xxx.h
@@ -51,7 +51,7 @@ struct prcm_config {
 	unsigned long cm_clksel2_pll;	/* dpllx1 or x2 out */
 	unsigned long cm_clksel_mdm;	/* modem dividers 2430 only */
 	unsigned long base_sdrc_rfr;	/* base refresh timing for a set */
-	unsigned char flags;
+	unsigned short flags;
 };
 
 
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 387a963..3c50ec8 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -40,6 +40,7 @@ struct omap_clk {
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
 #define CK_446X		(1 << 13)
+#define CK_TI814X	(1 << 14)
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index df4b968..1c41292 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -59,6 +59,7 @@ struct clkops {
 #define RATE_IN_4430		(1 << 5)
 #define RATE_IN_TI816X		(1 << 6)
 #define RATE_IN_4460		(1 << 7)
+#define RATE_IN_TI814X		(1 << 8)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
@@ -86,7 +87,7 @@ struct clkops {
 struct clksel_rate {
 	u32			val;
 	u8			div;
-	u8			flags;
+	u16			flags;
 };
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 87dfc8b..f4ebbae 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -45,7 +45,7 @@
 int omap_type(void);
 
 struct omap_chip_id {
-	u16 oc;
+	u32 oc;
 	u8 type;
 };
 
@@ -137,6 +137,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 IS_OMAP_SUBCLASS(446x, 0x446)
 
 IS_TI_SUBCLASS(816x, 0x816)
+IS_TI_SUBCLASS(814x, 0x814)
 
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -148,6 +149,7 @@ IS_TI_SUBCLASS(816x, 0x816)
 #define cpu_is_omap343x()		0
 #define cpu_is_ti81xx()			0
 #define cpu_is_ti816x()			0
+#define cpu_is_ti814x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -355,6 +357,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3517
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
+# undef cpu_is_ti814x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -372,6 +375,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
+# define cpu_is_ti814x()		is_ti814x()
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
@@ -422,6 +426,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define TI8168_REV_ES1_0	TI816X_CLASS
 #define TI8168_REV_ES1_1	(TI816X_CLASS | (OMAP_REVBITS_01 << 8))
 
+#define TI814X_CLASS		0x81400034
+#define TI8148_REV_ES1_0	TI814X_CLASS
+#define TI8148_REV_ES2_0	(TI814X_CLASS | (OMAP_REVBITS_01 << 8))
+#define TI8148_REV_ES2_1	(TI814X_CLASS | (OMAP_REVBITS_02 << 8))
+
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
 #define OMAP4430_REV_ES2_0	(OMAP443X_CLASS | (0x20 << 8))
@@ -461,6 +470,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP4430ES2_2		(1 << 13)
 #define CHIP_IS_TI816X			(1 << 14)
 #define CHIP_IS_OMAP4460ES1_0		(1 << 15)
+#define CHIP_IS_TI814X			(1 << 16)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
-- 
1.7.3.5

