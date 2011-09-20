From: <hvaibhav@ti.com>
Subject: [PATCH-V3 1/4] arm:omap:am33xx: Update common omap platform files
Date: Tue, 20 Sep 2011 20:02:19 +0530
Message-ID: <1316529142-27564-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56635 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab1ITOct (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 10:32:49 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Hemant Pedanekar <hemantp@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch updates the common platform files with AM335X device
support (AM33XX family).

The approach taken in this patch is,
AM33XX device will be considered as OMAP3 variant, and a separate
SoC class created for AM33XX family of devices with a subclass type
for AM335X device, which is newly added device in the family.

This means, cpu_is_omap34xx(), cpu_is_am33xx() and cpu_is_am335x()
checks will return success on AM335X device.
A kernel config option CONFIG_SOC_OMAPAM33XX is added under OMAP3
to include support for AM33XX build.

Also, cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence
struct clksel_rate.flags, struct prcm_config.flags and cpu_mask
are changed to u16 from u8.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig                   |    5 +++++
 arch/arm/mach-omap2/clock.c                   |    2 +-
 arch/arm/mach-omap2/clock.h                   |    2 +-
 arch/arm/mach-omap2/opp2xxx.h                 |    2 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/include/plat/clock.h       |    3 ++-
 arch/arm/plat-omap/include/plat/cpu.h         |   25 +++++++++++++++++++++++++
 7 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..12ab835 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -78,6 +78,11 @@ config SOC_OMAPTI816X
 	depends on ARCH_OMAP3
 	default y

+config SOC_OMAPAM33XX
+	bool "AM33XX support"
+	depends on ARCH_OMAP3
+	default y
+
 config OMAP_PACKAGE_ZAF
        bool

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
index 387a963..6d84c0c 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -40,6 +40,7 @@ struct omap_clk {
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
 #define CK_446X		(1 << 13)
+#define CK_AM33XX	(1 << 14)	/* AM33xx specific clocks */


 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 197ca03..168c54e 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -59,6 +59,7 @@ struct clkops {
 #define RATE_IN_4430		(1 << 5)
 #define RATE_IN_TI816X		(1 << 6)
 #define RATE_IN_4460		(1 << 7)
+#define RATE_IN_AM33XX		(1 << 8)

 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
@@ -84,7 +85,7 @@ struct clkops {
 struct clksel_rate {
 	u32			val;
 	u8			div;
-	u8			flags;
+	u16			flags;
 };

 /**
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2f90269..9f4d5c3 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -78,6 +78,14 @@ static inline int is_omap ##class (void)		\
 	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
 }

+#define GET_AM_CLASS	((omap_rev() >> 24) & 0xff)
+
+#define IS_AM_CLASS(class, id)			\
+static inline int is_am ##class (void)		\
+{							\
+	return (GET_AM_CLASS == (id)) ? 1 : 0;	\
+}
+
 #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)

 #define IS_OMAP_SUBCLASS(subclass, id)			\
@@ -92,12 +100,19 @@ static inline int is_ti ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }

+#define IS_AM_SUBCLASS(subclass, id)			\
+static inline int is_am ##subclass (void)		\
+{							\
+	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(7xx, 0x07)
 IS_OMAP_CLASS(15xx, 0x15)
 IS_OMAP_CLASS(16xx, 0x16)
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
+IS_AM_CLASS(33xx, 0x33)

 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
@@ -107,6 +122,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 IS_OMAP_SUBCLASS(446x, 0x446)

 IS_TI_SUBCLASS(816x, 0x816)
+IS_AM_SUBCLASS(335x, 0x335)

 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -117,6 +133,8 @@ IS_TI_SUBCLASS(816x, 0x816)
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
 #define cpu_is_ti816x()			0
+#define cpu_is_am33xx()			0
+#define cpu_is_am335x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -323,6 +341,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3505
 # undef cpu_is_omap3517
 # undef cpu_is_ti816x
+# undef cpu_is_am33xx
+# undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -340,6 +360,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti816x()		is_ti816x()
+# define cpu_is_am33xx()		is_am33xx()
+# define cpu_is_am335x()		is_am335x()
 #endif

 # if defined(CONFIG_ARCH_OMAP4)
@@ -386,6 +408,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define TI8168_REV_ES1_0	TI816X_CLASS
 #define TI8168_REV_ES1_1	(TI816X_CLASS | (0x1 << 8))

+#define AM335X_CLASS		0x33500034
+#define AM335X_REV_ES1_0	AM335X_CLASS
+
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
 #define OMAP4430_REV_ES2_0	(OMAP443X_CLASS | (0x20 << 8))
--
1.7.0.4

