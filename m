From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/07] ARM: OMAP2: Use omap_globals for CPU detection for multi-omap
Date: Fri,  3 Oct 2008 14:56:45 +0300
Message-ID: <1223035009-23866-4-git-send-email-tony@atomide.com>
References: <1223035009-23866-1-git-send-email-tony@atomide.com>
 <1223035009-23866-2-git-send-email-tony@atomide.com>
 <1223035009-23866-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62881 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbYJCLyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 07:54:08 -0400
In-Reply-To: <1223035009-23866-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This allows to get rid of the ifdefs and will allow simpler
CPU detection in the future.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 7342128..bf45ff3 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -18,24 +18,15 @@
 
 #include <asm/cputype.h>
 
+#include <mach/common.h>
 #include <mach/control.h>
 #include <mach/cpu.h>
 
-#if defined(CONFIG_ARCH_OMAP2420)
-#define TAP_BASE	IO_ADDRESS(0x48014000)
-#elif defined(CONFIG_ARCH_OMAP2430)
-#define TAP_BASE	IO_ADDRESS(0x4900A000)
-#elif defined(CONFIG_ARCH_OMAP34XX)
-#define TAP_BASE	IO_ADDRESS(0x4830A000)
-#endif
+static u32 class;
+static void __iomem *tap_base;
+static u16 tap_prod_id;
 
 #define OMAP_TAP_IDCODE		0x0204
-#if defined(CONFIG_ARCH_OMAP34XX)
-#define OMAP_TAP_PROD_ID	0x0210
-#else
-#define OMAP_TAP_PROD_ID	0x0208
-#endif
-
 #define OMAP_TAP_DIE_ID_0	0x0218
 #define OMAP_TAP_DIE_ID_1	0x021C
 #define OMAP_TAP_DIE_ID_2	0x0220
@@ -94,18 +85,24 @@ static u32 __init read_tap_reg(int reg)
 	 * it means its Cortex r0p0 which is 3430 ES1
 	 */
 	if ((((cpuid >> 4) & 0xFFF) == 0xC08) && ((cpuid & 0xF) == 0x0)) {
+
+		if (reg == tap_prod_id) {
+			regval = 0x000F00F0;
+			goto out;
+		}
+
 		switch (reg) {
 		case OMAP_TAP_IDCODE  : regval = 0x0B7AE02F; break;
 		/* Making DevType as 0xF in ES1 to differ from ES2 */
-		case OMAP_TAP_PROD_ID : regval = 0x000F00F0; break;
 		case OMAP_TAP_DIE_ID_0: regval = 0x01000000; break;
 		case OMAP_TAP_DIE_ID_1: regval = 0x1012d687; break;
 		case OMAP_TAP_DIE_ID_2:	regval = 0x00000000; break;
 		case OMAP_TAP_DIE_ID_3:	regval = 0x2d2c0000; break;
 		}
 	} else
-		regval = __raw_readl(TAP_BASE + reg);
+		regval = __raw_readl(tap_base + reg);
 
+out:
 	return regval;
 
 }
@@ -204,7 +201,7 @@ void __init omap2_check_revision(void)
 	u8  rev;
 
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
-	prod_id = read_tap_reg(OMAP_TAP_PROD_ID);
+	prod_id = read_tap_reg(tap_prod_id);
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0x0f;
 	dev_type = (prod_id >> 16) & 0x0f;
@@ -269,3 +266,13 @@ void __init omap2_check_revision(void)
 
 }
 
+void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
+{
+	class = omap2_globals->class;
+	tap_base = omap2_globals->tap;
+
+	if (class == 0x3430)
+		tap_prod_id = 0x0210;
+	else
+		tap_prod_id = 0x0208;
+}
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 434beae..0843b88 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -248,6 +248,7 @@ static struct omap_globals *omap2_globals;
 
 static void __init __omap2_set_globals(void)
 {
+	omap2_set_globals_tap(omap2_globals);
 	omap2_set_globals_memory(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
@@ -258,6 +259,7 @@ static void __init __omap2_set_globals(void)
 #if defined(CONFIG_ARCH_OMAP2420)
 
 static struct omap_globals omap242x_globals = {
+	.class	= OMAP242X_CLASS,
 	.tap	= OMAP2_IO_ADDRESS(0x48014000),
 	.sdrc	= OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE),
 	.sms	= OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE),
@@ -276,6 +278,7 @@ void __init omap2_set_globals_242x(void)
 #if defined(CONFIG_ARCH_OMAP2430)
 
 static struct omap_globals omap243x_globals = {
+	.class	= OMAP243X_CLASS,
 	.tap	= OMAP2_IO_ADDRESS(0x4900a000),
 	.sdrc	= OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE),
 	.sms	= OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE),
@@ -294,6 +297,7 @@ void __init omap2_set_globals_243x(void)
 #if defined(CONFIG_ARCH_OMAP3430)
 
 static struct omap_globals omap343x_globals = {
+	.class	= OMAP343X_CLASS,
 	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
 	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
 	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 515c628..ef70e2b 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -50,6 +50,7 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 
 /* IO bases for various OMAP processors */
 struct omap_globals {
+	u32		class;		/* OMAP class to detect */
 	void __iomem	*tap;		/* Control module ID code */
 	void __iomem	*sdrc;		/* SDRAM Controller */
 	void __iomem	*sms;		/* SDRAM Memory Scheduler */
@@ -63,6 +64,7 @@ void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
+void omap2_set_globals_tap(struct omap_globals *);
 void omap2_set_globals_memory(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 05aee0e..e046418 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -346,9 +346,14 @@ IS_OMAP_TYPE(3430, 0x3430)
 		get_sil_revision(system_rev)
 
 /* Various silicon macros defined here */
+#define OMAP242X_CLASS		0x24200000
 #define OMAP2420_REV_ES1_0	0x24200000
 #define OMAP2420_REV_ES2_0	0x24201000
+
+#define OMAP243X_CLASS		0x24300000
 #define OMAP2430_REV_ES1_0	0x24300000
+
+#define OMAP343X_CLASS		0x34300000
 #define OMAP3430_REV_ES1_0	0x34300000
 #define OMAP3430_REV_ES2_0	0x34301000
 #define OMAP3430_REV_ES2_1	0x34302000
