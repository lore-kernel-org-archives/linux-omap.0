From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] ARM: OMAP: Change all cpu_is_* occurences to soc_is_*
Date: Wed, 26 Aug 2015 09:29:35 +0530
Message-ID: <1440561575-3740-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Currently apart from dra7, omap5 and amx3 all the other SoCs
are identified using cpu_is_* functions which is not right since
they are all SoCs(System on Chips). Hence changing the SoC
identification code to use soc_is instead of cpu_is and keeping
defines for cpu_is where needed. This allows us to replace the
rest of cpu_is usage along with other fixes as needed.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk> 
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Corrected a typo in the commit log.

 arch/arm/mach-omap2/id.c  |  30 +++----
 arch/arm/mach-omap2/soc.h | 193 ++++++++++++++++++++++++++--------------------
 2 files changed, 123 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e3f713f..24f24d4 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -57,15 +57,15 @@ int omap_type(void)
 	if (val < OMAP2_DEVICETYPE_MASK)
 		return val;
 
-	if (cpu_is_omap24xx()) {
+	if (soc_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
-	} else if (cpu_is_ti81xx()) {
+	} else if (soc_is_ti81xx()) {
 		val = omap_ctrl_readl(TI81XX_CONTROL_STATUS);
 	} else if (soc_is_am33xx() || soc_is_am43xx()) {
 		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
-	} else if (cpu_is_omap34xx()) {
+	} else if (soc_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
-	} else if (cpu_is_omap44xx()) {
+	} else if (soc_is_omap44xx()) {
 		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
 	} else if (soc_is_omap54xx() || soc_is_dra7xx()) {
 		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
@@ -122,7 +122,7 @@ static u16 tap_prod_id;
 
 void omap_get_die_id(struct omap_die_id *odi)
 {
-	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
+	if (soc_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
 		odi->id_0 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_0);
 		odi->id_1 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_1);
 		odi->id_2 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_2);
@@ -218,17 +218,17 @@ static void __init omap3_cpuinfo(void)
 	 * on available features. Upon detection, update the CPU id
 	 * and CPU class bits.
 	 */
-	if (cpu_is_omap3630()) {
+	if (soc_is_omap3630()) {
 		cpu_name = "OMAP3630";
 	} else if (soc_is_am35xx()) {
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
-	} else if (cpu_is_ti816x()) {
+	} else if (soc_is_ti816x()) {
 		cpu_name = "TI816X";
 	} else if (soc_is_am335x()) {
 		cpu_name =  "AM335X";
 	} else if (soc_is_am437x()) {
 		cpu_name =  "AM437x";
-	} else if (cpu_is_ti814x()) {
+	} else if (soc_is_ti814x()) {
 		cpu_name = "TI814X";
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
@@ -275,11 +275,11 @@ void __init omap3xxx_check_features(void)
 	OMAP3_CHECK_FEATURE(status, SGX);
 	OMAP3_CHECK_FEATURE(status, NEON);
 	OMAP3_CHECK_FEATURE(status, ISP);
-	if (cpu_is_omap3630())
+	if (soc_is_omap3630())
 		omap_features |= OMAP3_HAS_192MHZ_CLK;
-	if (cpu_is_omap3430() || cpu_is_omap3630())
+	if (soc_is_omap3430() || soc_is_omap3630())
 		omap_features |= OMAP3_HAS_IO_WAKEUP;
-	if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
+	if (soc_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
 	    omap_rev() == OMAP3430_REV_ES3_1_2)
 		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
 
@@ -697,7 +697,7 @@ void __init omap2_set_globals_tap(u32 class, void __iomem *tap)
 	tap_base = tap;
 
 	/* XXX What is this intended to do? */
-	if (cpu_is_omap34xx())
+	if (soc_is_omap34xx())
 		tap_prod_id = 0x0210;
 	else
 		tap_prod_id = 0x0208;
@@ -715,11 +715,11 @@ static const char * const omap_types[] = {
 
 static const char * __init omap_get_family(void)
 {
-	if (cpu_is_omap24xx())
+	if (soc_is_omap24xx())
 		return kasprintf(GFP_KERNEL, "OMAP2");
-	else if (cpu_is_omap34xx())
+	else if (soc_is_omap34xx())
 		return kasprintf(GFP_KERNEL, "OMAP3");
-	else if (cpu_is_omap44xx())
+	else if (soc_is_omap44xx())
 		return kasprintf(GFP_KERNEL, "OMAP4");
 	else if (soc_is_omap54xx())
 		return kasprintf(GFP_KERNEL, "OMAP5");
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index f97654d..bb824ae 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -148,13 +148,13 @@ static inline int soc_is_omap(void)
 /*
  * Macros to group OMAP into cpu classes.
  * These can be used in most places.
- * cpu_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
- * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
- * cpu_is_omap243x():	True for OMAP2430
- * cpu_is_omap343x():	True for OMAP3430
- * cpu_is_omap443x():	True for OMAP4430
- * cpu_is_omap446x():	True for OMAP4460
- * cpu_is_omap447x():	True for OMAP4470
+ * soc_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
+ * soc_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
+ * soc_is_omap243x():	True for OMAP2430
+ * soc_is_omap343x():	True for OMAP3430
+ * soc_is_omap443x():	True for OMAP4430
+ * soc_is_omap446x():	True for OMAP4460
+ * soc_is_omap447x():	True for OMAP4470
  * soc_is_omap543x():	True for OMAP5430, OMAP5432
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
@@ -225,23 +225,23 @@ IS_TI_SUBCLASS(814x, 0x814)
 IS_AM_SUBCLASS(335x, 0x335)
 IS_AM_SUBCLASS(437x, 0x437)
 
-#define cpu_is_omap24xx()		0
-#define cpu_is_omap242x()		0
-#define cpu_is_omap243x()		0
-#define cpu_is_omap34xx()		0
-#define cpu_is_omap343x()		0
-#define cpu_is_ti81xx()			0
-#define cpu_is_ti816x()			0
-#define cpu_is_ti814x()			0
+#define soc_is_omap24xx()		0
+#define soc_is_omap242x()		0
+#define soc_is_omap243x()		0
+#define soc_is_omap34xx()		0
+#define soc_is_omap343x()		0
+#define soc_is_ti81xx()			0
+#define soc_is_ti816x()			0
+#define soc_is_ti814x()			0
 #define soc_is_am35xx()			0
 #define soc_is_am33xx()			0
 #define soc_is_am335x()			0
 #define soc_is_am43xx()			0
 #define soc_is_am437x()			0
-#define cpu_is_omap44xx()		0
-#define cpu_is_omap443x()		0
-#define cpu_is_omap446x()		0
-#define cpu_is_omap447x()		0
+#define soc_is_omap44xx()		0
+#define soc_is_omap443x()		0
+#define soc_is_omap446x()		0
+#define soc_is_omap447x()		0
 #define soc_is_omap54xx()		0
 #define soc_is_omap543x()		0
 #define soc_is_dra7xx()			0
@@ -250,54 +250,64 @@ IS_AM_SUBCLASS(437x, 0x437)
 
 #if defined(MULTI_OMAP2)
 # if defined(CONFIG_ARCH_OMAP2)
-#  undef  cpu_is_omap24xx
-#  define cpu_is_omap24xx()		is_omap24xx()
+#  undef  soc_is_omap24xx
+#  define soc_is_omap24xx()		is_omap24xx()
+#  define cpu_is_omap24xx		soc_is_omap24xx
 # endif
 # if defined (CONFIG_SOC_OMAP2420)
-#  undef  cpu_is_omap242x
-#  define cpu_is_omap242x()		is_omap242x()
+#  undef  soc_is_omap242x
+#  define soc_is_omap242x()		is_omap242x()
+#  define cpu_is_omap242x		soc_is_omap242x
 # endif
 # if defined (CONFIG_SOC_OMAP2430)
-#  undef  cpu_is_omap243x
-#  define cpu_is_omap243x()		is_omap243x()
+#  undef  soc_is_omap243x
+#  define soc_is_omap243x()		is_omap243x()
+#  define cpu_is_omap243x		soc_is_omap243x
 # endif
 # if defined(CONFIG_ARCH_OMAP3)
-#  undef  cpu_is_omap34xx
-#  undef  cpu_is_omap343x
-#  define cpu_is_omap34xx()		is_omap34xx()
-#  define cpu_is_omap343x()		is_omap343x()
+#  undef  soc_is_omap34xx
+#  undef  soc_is_omap343x
+#  define soc_is_omap34xx()		is_omap34xx()
+#  define cpu_is_omap34xx		soc_is_omap34xx
+#  define soc_is_omap343x()		is_omap343x()
+#  define cpu_is_omap343x		soc_is_omap343x
 # endif
 #else
 # if defined(CONFIG_ARCH_OMAP2)
-#  undef  cpu_is_omap24xx
-#  define cpu_is_omap24xx()		1
+#  undef  soc_is_omap24xx
+#  define soc_is_omap24xx()		1
+#  define cpu_is_omap24xx		soc_is_omap24xx
 # endif
 # if defined(CONFIG_SOC_OMAP2420)
-#  undef  cpu_is_omap242x
-#  define cpu_is_omap242x()		1
+#  undef  soc_is_omap242x
+#  define soc_is_omap242x()		1
+#  define cpu_is_omap242x		soc_is_omap242x
 # endif
 # if defined(CONFIG_SOC_OMAP2430)
-#  undef  cpu_is_omap243x
-#  define cpu_is_omap243x()		1
+#  undef  soc_is_omap243x
+#  define soc_is_omap243x()		1
+#  define cpu_is_omap243x		soc_is_omap243x
 # endif
 # if defined(CONFIG_ARCH_OMAP3)
-#  undef  cpu_is_omap34xx
-#  define cpu_is_omap34xx()		1
+#  undef  soc_is_omap34xx
+#  define soc_is_omap34xx()		1
+#  define cpu_is_omap34xx		soc_is_omap34xx
 # endif
 # if defined(CONFIG_SOC_OMAP3430)
-#  undef  cpu_is_omap343x
-#  define cpu_is_omap343x()		1
+#  undef  soc_is_omap343x
+#  define soc_is_omap343x()		1
+#  define cpu_is_omap343x		soc_is_omap343x
 # endif
 #endif
 
 /*
- * Macros to detect individual cpu types.
+ * Macros to detect individual soc types.
  * These are only rarely needed.
- * cpu_is_omap2420():	True for OMAP2420
- * cpu_is_omap2422():	True for OMAP2422
- * cpu_is_omap2423():	True for OMAP2423
- * cpu_is_omap2430():	True for OMAP2430
- * cpu_is_omap3430():	True for OMAP3430
+ * soc_is_omap2420():	True for OMAP2420
+ * soc_is_omap2422():	True for OMAP2422
+ * soc_is_omap2423():	True for OMAP2423
+ * soc_is_omap2430():	True for OMAP2430
+ * soc_is_omap3430():	True for OMAP3430
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -313,51 +323,60 @@ IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
 
-#define cpu_is_omap2420()		0
-#define cpu_is_omap2422()		0
-#define cpu_is_omap2423()		0
-#define cpu_is_omap2430()		0
-#define cpu_is_omap3430()		0
-#define cpu_is_omap3630()		0
+#define soc_is_omap2420()		0
+#define soc_is_omap2422()		0
+#define soc_is_omap2423()		0
+#define soc_is_omap2430()		0
+#define soc_is_omap3430()		0
+#define soc_is_omap3630()		0
 #define soc_is_omap5430()		0
 
 /* These are needed for the common code */
 #ifdef CONFIG_ARCH_OMAP2PLUS
-#define cpu_is_omap7xx()		0
-#define cpu_is_omap15xx()		0
-#define cpu_is_omap16xx()		0
-#define cpu_is_omap1510()		0
-#define cpu_is_omap1610()		0
-#define cpu_is_omap1611()		0
-#define cpu_is_omap1621()		0
-#define cpu_is_omap1710()		0
+#define soc_is_omap7xx()		0
+#define soc_is_omap15xx()		0
+#define soc_is_omap16xx()		0
+#define soc_is_omap1510()		0
+#define soc_is_omap1610()		0
+#define soc_is_omap1611()		0
+#define soc_is_omap1621()		0
+#define soc_is_omap1710()		0
 #define cpu_class_is_omap1()		0
 #define cpu_class_is_omap2()		1
 #endif
 
 #if defined(CONFIG_ARCH_OMAP2)
-# undef  cpu_is_omap2420
-# undef  cpu_is_omap2422
-# undef  cpu_is_omap2423
-# undef  cpu_is_omap2430
-# define cpu_is_omap2420()		is_omap2420()
-# define cpu_is_omap2422()		is_omap2422()
-# define cpu_is_omap2423()		is_omap2423()
-# define cpu_is_omap2430()		is_omap2430()
+# undef  soc_is_omap2420
+# undef  soc_is_omap2422
+# undef  soc_is_omap2423
+# undef  soc_is_omap2430
+# define soc_is_omap2420()		is_omap2420()
+# define cpu_is_omap2420		soc_is_omap2420
+# define soc_is_omap2422()		is_omap2422()
+# define cpu_is_omap2422		soc_is_omap2422
+# define soc_is_omap2423()		is_omap2423()
+# define cpu_is_omap2423		soc_is_omap2423
+# define soc_is_omap2430()		is_omap2430()
+# define cpu_is_omap2430		soc_is_omap2430
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3)
-# undef cpu_is_omap3430
-# undef cpu_is_ti81xx
-# undef cpu_is_ti816x
-# undef cpu_is_ti814x
+# undef soc_is_omap3430
+# undef soc_is_ti81xx
+# undef soc_is_ti816x
+# undef soc_is_ti814x
 # undef soc_is_am35xx
-# define cpu_is_omap3430()		is_omap3430()
-# undef cpu_is_omap3630
-# define cpu_is_omap3630()		is_omap363x()
-# define cpu_is_ti81xx()		is_ti81xx()
-# define cpu_is_ti816x()		is_ti816x()
-# define cpu_is_ti814x()		is_ti814x()
+# define soc_is_omap3430()		is_omap3430()
+# define cpu_is_omap3430		soc_is_omap3430
+# undef soc_is_omap3630
+# define soc_is_omap3630()		is_omap363x()
+# define cpu_is_omap3630		soc_is_omap3630
+# define soc_is_ti81xx()		is_ti81xx()
+# define cpu_is_ti81xx			soc_is_ti81xx
+# define soc_is_ti816x()		is_ti816x()
+# define cpu_is_ti816x			soc_is_ti816x
+# define soc_is_ti814x()		is_ti814x()
+# define cpu_is_ti814x			soc_is_ti814x
 # define soc_is_am35xx()		is_am35xx()
 #endif
 
@@ -376,14 +395,18 @@ IS_OMAP_TYPE(3430, 0x3430)
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
-# undef cpu_is_omap44xx
-# undef cpu_is_omap443x
-# undef cpu_is_omap446x
-# undef cpu_is_omap447x
-# define cpu_is_omap44xx()		is_omap44xx()
-# define cpu_is_omap443x()		is_omap443x()
-# define cpu_is_omap446x()		is_omap446x()
-# define cpu_is_omap447x()		is_omap447x()
+# undef soc_is_omap44xx
+# undef soc_is_omap443x
+# undef soc_is_omap446x
+# undef soc_is_omap447x
+# define soc_is_omap44xx()		is_omap44xx()
+# define cpu_is_omap44xx()		soc_is_omap44xx()
+# define soc_is_omap443x()		is_omap443x()
+# define cpu_is_omap443x()		soc_is_omap443x()
+# define soc_is_omap446x()		is_omap446x()
+# define cpu_is_omap446x()		soc_is_omap446x()
+# define soc_is_omap447x()		is_omap447x()
+# define cpu_is_omap447x()		soc_is_omap447x()
 # endif
 
 # if defined(CONFIG_SOC_OMAP5)
-- 
1.9.1
