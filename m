From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for DRA7xx based SoCs'
Date: Tue, 30 Jul 2013 16:55:39 +0530
Message-ID: <1375183546-12758-2-git-send-email-rnayak@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36406 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab3G3L01 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 07:26:27 -0400
In-Reply-To: <1375183546-12758-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

The DRA7xx is a high-performance, infotainment application device,
based on enhanced OMAP architecture integrated on a 28-nm technology.

DRA7xx family is composed of DRA75x and DRA74x devices.

Adding the DRA752 ES1.0 cpu revision detection support.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/include/mach/soc.h |    1 +
 arch/arm/mach-omap2/id.c               |   30 ++++++++++++++++++++++--
 arch/arm/mach-omap2/soc.h              |   39 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/soc.h b/arch/arm/mach-omap1/include/mach/soc.h
index 6cf9c1c..612bd1c 100644
--- a/arch/arm/mach-omap1/include/mach/soc.h
+++ b/arch/arm/mach-omap1/include/mach/soc.h
@@ -195,6 +195,7 @@ IS_OMAP_TYPE(1710, 0x1710)
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap44xx()		0
 #define soc_is_omap54xx()		0
+#define soc_is_dra7xx()			0
 #define soc_is_am33xx()			0
 #define cpu_class_is_omap1()		1
 #define cpu_class_is_omap2()		0
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2dc62a2..332ae95 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -61,7 +61,7 @@ int omap_type(void)
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
 		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
-	} else if (soc_is_omap54xx()) {
+	} else if (soc_is_omap54xx() || soc_is_dra7xx()) {
 		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
 		val &= OMAP5_DEVICETYPE_MASK;
 		val >>= 6;
@@ -116,7 +116,7 @@ static u16 tap_prod_id;
 
 void omap_get_die_id(struct omap_die_id *odi)
 {
-	if (cpu_is_omap44xx() || soc_is_omap54xx()) {
+	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
 		odi->id_0 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_0);
 		odi->id_1 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_1);
 		odi->id_2 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_2);
@@ -606,6 +606,32 @@ void __init omap5xxx_check_revision(void)
 	pr_info("%s %s\n", soc_name, soc_rev);
 }
 
+void __init dra7xx_check_revision(void)
+{
+	u32 idcode;
+	u16 hawkeye;
+	u8 rev;
+
+	idcode = read_tap_reg(OMAP_TAP_IDCODE);
+	hawkeye = (idcode >> 12) & 0xffff;
+	rev = (idcode >> 28) & 0xff;
+	switch (hawkeye) {
+	case 0xb990:
+		switch (rev) {
+		case 0:
+		default:
+			omap_revision = DRA752_REV_ES1_0;
+		}
+		break;
+	default:
+		/* Unknown. Default to latest silicon revision */
+		omap_revision = DRA752_REV_ES1_0;
+	}
+
+	pr_info("DRA%03x ES%d.%d\n", omap_rev() >> 16,
+		((omap_rev() >> 12) & 0xf), ((omap_rev() >> 8) & 0xf));
+}
+
 /*
  * Set up things for map_io and processor detection later on. Gets called
  * pretty much first thing from board init. For multi-omap, this gets
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 8c616e4..0d242f1 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -8,6 +8,7 @@
  * Written by Tony Lindgren <tony.lindgren@nokia.com>
  *
  * Added OMAP4/5 specific defines - Santosh Shilimkar<santosh.shilimkar@ti.com>
+ * Added DRA7xxx specific defines - Sricharan R<r.sricharan@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -105,6 +106,15 @@
 # endif
 #endif
 
+#ifdef CONFIG_SOC_DRA7XX
+# ifdef OMAP_NAME
+#  undef MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME DRA7XX
+# endif
+#endif
+
 /*
  * Omap device type i.e. EMU/HS/TST/GP/BAD
  */
@@ -145,6 +155,7 @@ static inline int soc_is_omap(void)
  * cpu_is_omap446x():	True for OMAP4460
  * cpu_is_omap447x():	True for OMAP4470
  * soc_is_omap543x():	True for OMAP5430, OMAP5432
+ * soc_is_dra75x():	True for DRA752, DRA754, DRA756
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -170,6 +181,12 @@ static inline int is_ti ##class (void)		\
 	return (GET_TI_CLASS == (id)) ? 1 : 0;	\
 }
 
+#define IS_DRA_CLASS(class, id)				\
+static inline int is_dra ##class(void)			\
+{							\
+	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
+}
+
 #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
 
 #define IS_OMAP_SUBCLASS(subclass, id)			\
@@ -190,6 +207,12 @@ static inline int is_am ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }
 
+#define IS_DRA_SUBCLASS(subclass, id)			\
+static inline int is_dra ##subclass(void)		\
+{							\
+	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
@@ -197,6 +220,7 @@ IS_AM_CLASS(35xx, 0x35)
 IS_OMAP_CLASS(54xx, 0x54)
 IS_AM_CLASS(33xx, 0x33)
 IS_AM_CLASS(43xx, 0x43)
+IS_DRA_CLASS(7xx, 0x7)
 
 IS_TI_CLASS(81xx, 0x81)
 
@@ -213,6 +237,8 @@ IS_TI_SUBCLASS(816x, 0x816)
 IS_TI_SUBCLASS(814x, 0x814)
 IS_AM_SUBCLASS(335x, 0x335)
 IS_AM_SUBCLASS(437x, 0x437)
+IS_DRA_SUBCLASS(75x, 0x75)
+IS_DRA_SUBCLASS(74x, 0x74)
 
 #define cpu_is_omap24xx()		0
 #define cpu_is_omap242x()		0
@@ -233,6 +259,8 @@ IS_AM_SUBCLASS(437x, 0x437)
 #define cpu_is_omap447x()		0
 #define soc_is_omap54xx()		0
 #define soc_is_omap543x()		0
+#define soc_is_dra7xx()			0
+#define soc_is_dra75x()			0
 
 #if defined(MULTI_OMAP2)
 # if defined(CONFIG_ARCH_OMAP2)
@@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
 # define soc_is_omap543x()		is_omap543x()
 #endif
 
+# if defined(CONFIG_SOC_DRA7XX)
+# undef soc_is_dra7xx
+# undef soc_is_dra75x
+# define soc_is_dra7xx()		is_dra7xx()
+# define soc_is_dra75x()		is_dra75x()
+#endif
+
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
 #define OMAP2420_REV_ES1_0	OMAP242X_CLASS
@@ -443,6 +478,9 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP5432_REV_ES1_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x10 << 8))
 #define OMAP5432_REV_ES2_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x20 << 8))
 
+#define DRA7XX_CLASS		0x07000007
+#define DRA752_REV_ES1_0	(DRA7XX_CLASS | (0x52 << 16) | (0x10 << 8))
+
 void omap2xxx_check_revision(void);
 void omap3xxx_check_revision(void);
 void omap4xxx_check_revision(void);
@@ -451,6 +489,7 @@ void omap3xxx_check_features(void);
 void ti81xx_check_features(void);
 void am33xx_check_features(void);
 void omap4xxx_check_features(void);
+void dra7xx_check_revision(void);
 
 /*
  * Runtime detection of OMAP3 features
-- 
1.7.9.5

