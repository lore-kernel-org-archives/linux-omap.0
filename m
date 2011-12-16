From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2] arm:omap: cleanup & split omap2/3/4_check_revision function
Date: Fri, 16 Dec 2011 17:33:26 +0530
Message-ID: <1324037006-31984-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60541 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab1LPMEC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 07:04:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

This patch doesn't change functionality or behavior of the code
execution; it barely cleans up the code and splits into SoC
specific implementation for Rev ID and feature detection.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
Changes from V1:
	- Incorporated suggessions from Tony to split the function

The patch has been tested on AM/DM37x EVM.

 arch/arm/mach-omap2/id.c              |  283 +++++++++++++++------------------
 arch/arm/mach-omap2/io.c              |    9 +-
 arch/arm/plat-omap/include/plat/cpu.h |    7 +-
 3 files changed, 143 insertions(+), 156 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 6c58266..ce30a67 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -29,7 +29,7 @@
 #include "control.h"

 static unsigned int omap_revision;
-
+static const char *cpu_rev;
 u32 omap_features;

 unsigned int omap_rev(void)
@@ -112,58 +112,54 @@ void omap_get_die_id(struct omap_die_id *odi)
 	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
 }

-static void __init omap24xx_check_revision(void)
-{
-	int i, j;
-	u32 idcode, prod_id;
-	u16 hawkeye;
-	u8  dev_type, rev;
-	struct omap_die_id odi;
-
-	idcode = read_tap_reg(OMAP_TAP_IDCODE);
-	prod_id = read_tap_reg(tap_prod_id);
-	hawkeye = (idcode >> 12) & 0xffff;
-	rev = (idcode >> 28) & 0x0f;
-	dev_type = (prod_id >> 16) & 0x0f;
-	omap_get_die_id(&odi);
-
-	pr_debug("OMAP_TAP_IDCODE 0x%08x REV %i HAWKEYE 0x%04x MANF %03x\n",
-		 idcode, rev, hawkeye, (idcode >> 1) & 0x7ff);
-	pr_debug("OMAP_TAP_DIE_ID_0: 0x%08x\n", odi.id_0);
-	pr_debug("OMAP_TAP_DIE_ID_1: 0x%08x DEV_REV: %i\n",
-		 odi.id_1, (odi.id_1 >> 28) & 0xf);
-	pr_debug("OMAP_TAP_DIE_ID_2: 0x%08x\n", odi.id_2);
-	pr_debug("OMAP_TAP_DIE_ID_3: 0x%08x\n", odi.id_3);
-	pr_debug("OMAP_TAP_PROD_ID_0: 0x%08x DEV_TYPE: %i\n",
-		 prod_id, dev_type);
+#define OMAP3_SHOW_FEATURE(feat)		\
+	if (omap3_has_ ##feat())		\
+		printk(#feat" ");

-	/* Check hawkeye ids */
-	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
-		if (hawkeye == omap_ids[i].hawkeye)
-			break;
-	}
+static void __init omap3_cpuinfo(const char *cpu_rev)
+{
+	const char *cpu_name;

-	if (i == ARRAY_SIZE(omap_ids)) {
-		printk(KERN_ERR "Unknown OMAP CPU id\n");
-		return;
+	/*
+	 * OMAP3430 and OMAP3530 are assumed to be same.
+	 *
+	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
+	 * on available features. Upon detection, update the CPU id
+	 * and CPU class bits.
+	 */
+	if (cpu_is_omap3630()) {
+		cpu_name = "OMAP3630";
+	} else if (cpu_is_omap3517()) {
+		/* AM35xx devices */
+		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
+	} else if (cpu_is_ti816x()) {
+		cpu_name = "TI816X";
+	} else if (cpu_is_am335x()) {
+		cpu_name =  "AM335X";
+	} else if (cpu_is_ti814x()) {
+		cpu_name = "TI814X";
+	} else if (omap3_has_iva() && omap3_has_sgx()) {
+		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
+		cpu_name = "OMAP3430/3530";
+	} else if (omap3_has_iva()) {
+		cpu_name = "OMAP3525";
+	} else if (omap3_has_sgx()) {
+		cpu_name = "OMAP3515";
+	} else {
+		cpu_name = "OMAP3503";
 	}

-	for (j = i; j < ARRAY_SIZE(omap_ids); j++) {
-		if (dev_type == omap_ids[j].dev)
-			break;
-	}
+	/* Print verbose information */
+	pr_info("%s ES%s (", cpu_name, cpu_rev);

-	if (j == ARRAY_SIZE(omap_ids)) {
-		printk(KERN_ERR "Unknown OMAP device type. "
-				"Handling it as OMAP%04x\n",
-				omap_ids[i].type >> 16);
-		j = i;
-	}
+	OMAP3_SHOW_FEATURE(l2cache);
+	OMAP3_SHOW_FEATURE(iva);
+	OMAP3_SHOW_FEATURE(sgx);
+	OMAP3_SHOW_FEATURE(neon);
+	OMAP3_SHOW_FEATURE(isp);
+	OMAP3_SHOW_FEATURE(192mhz_clk);

-	pr_info("OMAP%04x", omap_rev() >> 16);
-	if ((omap_rev() >> 8) & 0x0f)
-		pr_info("ES%x", (omap_rev() >> 12) & 0xf);
-	pr_info("\n");
+	printk(")\n");
 }

 #define OMAP3_CHECK_FEATURE(status,feat)				\
@@ -172,7 +168,7 @@ static void __init omap24xx_check_revision(void)
 		omap_features |= OMAP3_HAS_ ##feat;			\
 	}

-static void __init omap3_check_features(void)
+void __init omap3xxx_check_features(void)
 {
 	u32 status;

@@ -199,9 +195,22 @@ static void __init omap3_check_features(void)
 	 * TODO: Get additional info (where applicable)
 	 *       e.g. Size of L2 cache.
 	 */
+
+	omap3_cpuinfo(cpu_rev);
+}
+
+void __init ti81xx_check_features(void)
+{
+	/*
+	 * We do not have feature register here, so hardcoding
+	 * default features.
+	 */
+	omap_features = OMAP3_HAS_NEON | OMAP3_HAS_L2CACHE;
+
+	omap3_cpuinfo(cpu_rev);
 }

-static void __init omap4_check_features(void)
+void __init omap4xxx_check_features(void)
 {
 	u32 si_type;

@@ -226,12 +235,61 @@ static void __init omap4_check_features(void)
 	}
 }

-static void __init ti81xx_check_features(void)
+void __init omap2xxx_check_revision(void)
 {
-	omap_features = OMAP3_HAS_NEON;
+	int i, j;
+	u32 idcode, prod_id;
+	u16 hawkeye;
+	u8  dev_type, rev;
+	struct omap_die_id odi;
+
+	idcode = read_tap_reg(OMAP_TAP_IDCODE);
+	prod_id = read_tap_reg(tap_prod_id);
+	hawkeye = (idcode >> 12) & 0xffff;
+	rev = (idcode >> 28) & 0x0f;
+	dev_type = (prod_id >> 16) & 0x0f;
+	omap_get_die_id(&odi);
+
+	pr_debug("OMAP_TAP_IDCODE 0x%08x REV %i HAWKEYE 0x%04x MANF %03x\n",
+		 idcode, rev, hawkeye, (idcode >> 1) & 0x7ff);
+	pr_debug("OMAP_TAP_DIE_ID_0: 0x%08x\n", odi.id_0);
+	pr_debug("OMAP_TAP_DIE_ID_1: 0x%08x DEV_REV: %i\n",
+		 odi.id_1, (odi.id_1 >> 28) & 0xf);
+	pr_debug("OMAP_TAP_DIE_ID_2: 0x%08x\n", odi.id_2);
+	pr_debug("OMAP_TAP_DIE_ID_3: 0x%08x\n", odi.id_3);
+	pr_debug("OMAP_TAP_PROD_ID_0: 0x%08x DEV_TYPE: %i\n",
+		 prod_id, dev_type);
+
+	/* Check hawkeye ids */
+	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
+		if (hawkeye == omap_ids[i].hawkeye)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(omap_ids)) {
+		printk(KERN_ERR "Unknown OMAP CPU id\n");
+		return;
+	}
+
+	for (j = i; j < ARRAY_SIZE(omap_ids); j++) {
+		if (dev_type == omap_ids[j].dev)
+			break;
+	}
+
+	if (j == ARRAY_SIZE(omap_ids)) {
+		printk(KERN_ERR "Unknown OMAP device type. "
+				"Handling it as OMAP%04x\n",
+				omap_ids[i].type >> 16);
+		j = i;
+	}
+
+	pr_info("OMAP%04x", omap_rev() >> 16);
+	if ((omap_rev() >> 8) & 0x0f)
+		pr_info("ES%x", (omap_rev() >> 12) & 0xf);
+	pr_info("\n");
 }

-static void __init omap3_check_revision(const char **cpu_rev)
+void __init omap3xxx_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -245,7 +303,7 @@ static void __init omap3_check_revision(const char **cpu_rev)
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		omap_revision = OMAP3430_REV_ES1_0;
-		*cpu_rev = "1.0";
+		cpu_rev = "1.0";
 		return;
 	}

@@ -266,26 +324,26 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		case 0: /* Take care of early samples */
 		case 1:
 			omap_revision = OMAP3430_REV_ES2_0;
-			*cpu_rev = "2.0";
+			cpu_rev = "2.0";
 			break;
 		case 2:
 			omap_revision = OMAP3430_REV_ES2_1;
-			*cpu_rev = "2.1";
+			cpu_rev = "2.1";
 			break;
 		case 3:
 			omap_revision = OMAP3430_REV_ES3_0;
-			*cpu_rev = "3.0";
+			cpu_rev = "3.0";
 			break;
 		case 4:
 			omap_revision = OMAP3430_REV_ES3_1;
-			*cpu_rev = "3.1";
+			cpu_rev = "3.1";
 			break;
 		case 7:
 		/* FALLTHROUGH */
 		default:
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1_2;
-			*cpu_rev = "3.1.2";
+			cpu_rev = "3.1.2";
 		}
 		break;
 	case 0xb868:
@@ -298,13 +356,13 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		switch (rev) {
 		case 0:
 			omap_revision = OMAP3517_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 1:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = OMAP3517_REV_ES1_1;
-			*cpu_rev = "1.1";
+			cpu_rev = "1.1";
 		}
 		break;
 	case 0xb891:
@@ -313,65 +371,65 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		switch(rev) {
 		case 0: /* Take care of early samples */
 			omap_revision = OMAP3630_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 1:
 			omap_revision = OMAP3630_REV_ES1_1;
-			*cpu_rev = "1.1";
+			cpu_rev = "1.1";
 			break;
 		case 2:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = OMAP3630_REV_ES1_2;
-			*cpu_rev = "1.2";
+			cpu_rev = "1.2";
 		}
 		break;
 	case 0xb81e:
 		switch (rev) {
 		case 0:
 			omap_revision = TI8168_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 1:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = TI8168_REV_ES1_1;
-			*cpu_rev = "1.1";
+			cpu_rev = "1.1";
 			break;
 		}
 		break;
 	case 0xb944:
 		omap_revision = AM335X_REV_ES1_0;
-		*cpu_rev = "1.0";
+		cpu_rev = "1.0";
 	case 0xb8f2:
 		switch (rev) {
 		case 0:
 		/* FALLTHROUGH */
 		case 1:
 			omap_revision = TI8148_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 2:
 			omap_revision = TI8148_REV_ES2_0;
-			*cpu_rev = "2.0";
+			cpu_rev = "2.0";
 			break;
 		case 3:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = TI8148_REV_ES2_1;
-			*cpu_rev = "2.1";
+			cpu_rev = "2.1";
 			break;
 		}
 		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP3630_REV_ES1_2;
-		*cpu_rev = "1.2";
+		cpu_rev = "1.2";
 		pr_warn("Warning: unknown chip type; assuming OMAP3630ES1.2\n");
 	}
 }

-static void __init omap4_check_revision(void)
+void __init omap4xxx_check_revision(void)
 {
 	u32 idcode;
 	u16 hawkeye;
@@ -444,89 +502,6 @@ static void __init omap4_check_revision(void)
 		((omap_rev() >> 12) & 0xf), ((omap_rev() >> 8) & 0xf));
 }

-#define OMAP3_SHOW_FEATURE(feat)		\
-	if (omap3_has_ ##feat())		\
-		printk(#feat" ");
-
-static void __init omap3_cpuinfo(const char *cpu_rev)
-{
-	const char *cpu_name;
-
-	/*
-	 * OMAP3430 and OMAP3530 are assumed to be same.
-	 *
-	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
-	 * on available features. Upon detection, update the CPU id
-	 * and CPU class bits.
-	 */
-	if (cpu_is_omap3630()) {
-		cpu_name = "OMAP3630";
-	} else if (cpu_is_omap3517()) {
-		/* AM35xx devices */
-		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
-	} else if (cpu_is_ti816x()) {
-		cpu_name = "TI816X";
-	} else if (cpu_is_am335x()) {
-		cpu_name =  "AM335X";
-	} else if (cpu_is_ti814x()) {
-		cpu_name = "TI814X";
-	} else if (omap3_has_iva() && omap3_has_sgx()) {
-		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
-		cpu_name = "OMAP3430/3530";
-	} else if (omap3_has_iva()) {
-		cpu_name = "OMAP3525";
-	} else if (omap3_has_sgx()) {
-		cpu_name = "OMAP3515";
-	} else {
-		cpu_name = "OMAP3503";
-	}
-
-	/* Print verbose information */
-	pr_info("%s ES%s (", cpu_name, cpu_rev);
-
-	OMAP3_SHOW_FEATURE(l2cache);
-	OMAP3_SHOW_FEATURE(iva);
-	OMAP3_SHOW_FEATURE(sgx);
-	OMAP3_SHOW_FEATURE(neon);
-	OMAP3_SHOW_FEATURE(isp);
-	OMAP3_SHOW_FEATURE(192mhz_clk);
-
-	printk(")\n");
-}
-
-/*
- * Try to detect the exact revision of the omap we're running on
- */
-void __init omap2_check_revision(void)
-{
-	const char *cpu_rev;
-
-	/*
-	 * At this point we have an idea about the processor revision set
-	 * earlier with omap2_set_globals_tap().
-	 */
-	if (cpu_is_omap24xx()) {
-		omap24xx_check_revision();
-	} else if (cpu_is_omap34xx()) {
-		omap3_check_revision(&cpu_rev);
-
-		/* TI81XX doesn't have feature register */
-		if (!cpu_is_ti81xx())
-			omap3_check_features();
-		else
-			ti81xx_check_features();
-
-		omap3_cpuinfo(cpu_rev);
-		return;
-	} else if (cpu_is_omap44xx()) {
-		omap4_check_revision();
-		omap4_check_features();
-		return;
-	} else {
-		pr_err("OMAP revision unknown, please fix!\n");
-	}
-}
-
 /*
  * Set up things for map_io and processor detection later on. Gets called
  * pretty much first thing from board init. For multi-omap, this gets
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5652dda..a914925 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -351,7 +351,6 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)

 static void __init omap_common_init_early(void)
 {
-	omap2_check_revision();
 	omap_init_consistent_dma_size();
 }

@@ -392,6 +391,7 @@ static void __init omap_hwmod_init_postsetup(void)
 void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
+	omap2xxx_check_revision();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
@@ -404,6 +404,7 @@ void __init omap2420_init_early(void)
 void __init omap2430_init_early(void)
 {
 	omap2_set_globals_243x();
+	omap2xxx_check_revision();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
@@ -422,6 +423,8 @@ void __init omap2430_init_early(void)
 void __init omap3_init_early(void)
 {
 	omap2_set_globals_3xxx();
+	omap3xxx_check_revision();
+	omap3xxx_check_features();
 	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -454,6 +457,8 @@ void __init am35xx_init_early(void)
 void __init ti81xx_init_early(void)
 {
 	omap2_set_globals_ti81xx();
+	omap3xxx_check_revision();
+	ti81xx_check_features();
 	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -480,6 +485,8 @@ void __init am33xx_init_early(void)
 void __init omap4430_init_early(void)
 {
 	omap2_set_globals_443x();
+	omap4xxx_check_revision();
+	omap4xxx_check_features();
 	omap_common_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 6b51086..428ccb1 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -451,7 +451,12 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP447X_CLASS		0x44700044
 #define OMAP4470_REV_ES1_0	(OMAP447X_CLASS | (0x10 << 8))

-void omap2_check_revision(void);
+void omap2xxx_check_revision(void);
+void omap3xxx_check_revision(void);
+void omap4xxx_check_revision(void);
+void omap3xxx_check_features(void);
+void ti81xx_check_features(void);
+void omap4xxx_check_features(void);

 /*
  * Runtime detection of OMAP3 features
--
1.7.0.4

