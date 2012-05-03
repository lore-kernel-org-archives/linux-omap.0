From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 01/13] ARM: OMAP5: id: Add cpu id for ES versions
Date: Thu, 3 May 2012 12:56:10 +0530
Message-ID: <1336029982-31898-2-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39615 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab2ECH0s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:26:48 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

Adding the OMAP5 ES1.0, 2.0 and OMAP5432 cpu revision
detection support.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/control.h         |    4 +++
 arch/arm/mach-omap2/id.c              |   47 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/cpu.h |   23 ++++++++++++++-
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a406fd0..9daac6f 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -246,6 +246,10 @@
 /* TI81XX CONTROL_DEVCONF register offsets */
 #define TI81XX_CONTROL_DEVICE_ID	(TI81XX_CONTROL_DEVCONF + 0x000)
 
+/* OMAP54XX CONTROL STATUS register */
+#define OMAP5XXX_CONTROL_STATUS                0x134
+#define OMAP5_DEVICETYPE_MASK          (0x7 << 6)
+
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
  * that should be added.
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 0e79b7b..d2ec323 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -50,6 +50,11 @@ int omap_type(void)
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
 		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
+	} else if (cpu_is_omap54xx()) {
+		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
+		val &= OMAP5_DEVICETYPE_MASK;
+		val >>= 6;
+		goto out;
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
@@ -500,6 +505,48 @@ void __init omap4xxx_check_revision(void)
 		((omap_rev() >> 12) & 0xf), ((omap_rev() >> 8) & 0xf));
 }
 
+void __init omap5xxx_check_revision(void)
+{
+	u32 idcode;
+	u16 hawkeye;
+	u8 rev;
+
+	idcode = read_tap_reg(OMAP_TAP_IDCODE);
+	hawkeye = (idcode >> 12) & 0xffff;
+	rev = (idcode >> 28) & 0xff;
+	switch (hawkeye) {
+	case 0xb942:
+		switch (rev) {
+		case 0:
+			omap_revision = OMAP5430_REV_ES1_0;
+			break;
+		case 1:
+			omap_revision = OMAP5430_REV_ES2_0;
+			break;
+		default:
+			omap_revision = OMAP5430_REV_ES1_0;
+		}
+		break;
+
+	case 0xb998:
+		switch (rev) {
+		case 0:
+			omap_revision = OMAP5432_REV_ES1_0;
+			break;
+		default:
+			omap_revision = OMAP5432_REV_ES1_0;
+		}
+		break;
+
+	default:
+		/* Unknown default to latest silicon rev as default*/
+		omap_revision = OMAP5430_REV_ES2_0;
+	}
+
+	pr_info("OMAP%04x ES%d.0\n",
+			omap_rev() >> 16, ((omap_rev() >> 12) & 0xf));
+}
+
 /*
  * Set up things for map_io and processor detection later on. Gets called
  * pretty much first thing from board init. For multi-omap, this gets
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index dc6a86b..5e57732 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -9,7 +9,7 @@
  *
  * Written by Tony Lindgren <tony.lindgren@nokia.com>
  *
- * Added OMAP4 specific defines - Santosh Shilimkar<santosh.shilimkar@ti.com>
+ * Added OMAP4/5 specific defines - Santosh Shilimkar<santosh.shilimkar@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -70,6 +70,7 @@ unsigned int omap_rev(void);
  * cpu_is_omap443x():	True for OMAP4430
  * cpu_is_omap446x():	True for OMAP4460
  * cpu_is_omap447x():	True for OMAP4470
+ * cpu_is_omap543x():	True for OMAP5430, OMAP5432
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -121,6 +122,7 @@ IS_OMAP_CLASS(16xx, 0x16)
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
+IS_OMAP_CLASS(54xx, 0x54)
 IS_AM_CLASS(33xx, 0x33)
 
 IS_TI_CLASS(81xx, 0x81)
@@ -132,6 +134,7 @@ IS_OMAP_SUBCLASS(363x, 0x363)
 IS_OMAP_SUBCLASS(443x, 0x443)
 IS_OMAP_SUBCLASS(446x, 0x446)
 IS_OMAP_SUBCLASS(447x, 0x447)
+IS_OMAP_SUBCLASS(543x, 0x543)
 
 IS_TI_SUBCLASS(816x, 0x816)
 IS_TI_SUBCLASS(814x, 0x814)
@@ -154,6 +157,8 @@ IS_AM_SUBCLASS(335x, 0x335)
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
 #define cpu_is_omap447x()		0
+#define cpu_is_omap54xx()		0
+#define cpu_is_omap543x()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -299,6 +304,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
 #define cpu_is_omap3630()		0
+#define cpu_is_omap5430()		0
 
 /*
  * Whether we have MULTI_OMAP1 or not, we still need to distinguish
@@ -393,11 +399,18 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap447x()		is_omap447x()
 # endif
 
+# if defined(CONFIG_ARCH_OMAP5)
+# undef cpu_is_omap54xx
+# undef cpu_is_omap543x
+# define cpu_is_omap54xx()		is_omap54xx()
+# define cpu_is_omap543x()		is_omap543x()
+#endif
+
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
-				cpu_is_omap44xx())
+				cpu_is_omap44xx() || cpu_is_omap54xx())
 
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
@@ -449,9 +462,15 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP447X_CLASS		0x44700044
 #define OMAP4470_REV_ES1_0	(OMAP447X_CLASS | (0x10 << 8))
 
+#define OMAP54XX_CLASS		0x54000054
+#define OMAP5430_REV_ES1_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x10 << 8))
+#define OMAP5430_REV_ES2_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x20 << 8))
+#define OMAP5432_REV_ES1_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x10 << 8))
+
 void omap2xxx_check_revision(void);
 void omap3xxx_check_revision(void);
 void omap4xxx_check_revision(void);
+void omap5xxx_check_revision(void);
 void omap3xxx_check_features(void);
 void ti81xx_check_features(void);
 void omap4xxx_check_features(void);
-- 
1.7.1

