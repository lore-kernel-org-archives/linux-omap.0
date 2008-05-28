From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/14] ARM: OMAP: Use omap_globals for CPU detection for multi-omap
Date: Tue, 27 May 2008 21:20:18 -0700
Message-ID: <1211948418-16455-15-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
 <1211948418-16455-3-git-send-email-tony@atomide.com>
 <1211948418-16455-4-git-send-email-tony@atomide.com>
 <1211948418-16455-5-git-send-email-tony@atomide.com>
 <1211948418-16455-6-git-send-email-tony@atomide.com>
 <1211948418-16455-7-git-send-email-tony@atomide.com>
 <1211948418-16455-8-git-send-email-tony@atomide.com>
 <1211948418-16455-9-git-send-email-tony@atomide.com>
 <1211948418-16455-10-git-send-email-tony@atomide.com>
 <1211948418-16455-11-git-send-email-tony@atomide.com>
 <1211948418-16455-12-git-send-email-tony@atomide.com>
 <1211948418-16455-13-git-send-email-tony@atomide.com>
 <1211948418-16455-14-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:49796 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbYE1EUn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:43 -0400
In-Reply-To: <1211948418-16455-14-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This allows to get rid of the ifdefs and will allow simpler
CPU detection in the future.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c           |   43 ++++++++++++++++++++++-------------
 arch/arm/plat-omap/common.c        |    4 +++
 include/asm-arm/arch-omap/common.h |    2 +
 include/asm-arm/arch-omap/cpu.h    |    5 ++++
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 0db34ba..27dfdca 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -16,24 +16,15 @@
 #include <linux/init.h>
 #include <linux/io.h>
 
+#include <asm/arch/common.h>
 #include <asm/arch/control.h>
 #include <asm/arch/cpu.h>
 
-#if defined(CONFIG_ARCH_OMAP2420)
-#define TAP_BASE	(__force void __iomem *)io_p2v(0x48014000)
-#elif defined(CONFIG_ARCH_OMAP2430)
-#define TAP_BASE	(__force void __iomem *)io_p2v(0x4900A000)
-#elif defined(CONFIG_ARCH_OMAP34XX)
-#define TAP_BASE	(__force void __iomem *)io_p2v(0x4830A000)
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
@@ -92,18 +83,24 @@ static u32 __init read_tap_reg(int reg)
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
@@ -202,7 +199,7 @@ void __init omap2_check_revision(void)
 	u8  rev;
 
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
-	prod_id = read_tap_reg(OMAP_TAP_PROD_ID);
+	prod_id = read_tap_reg(tap_prod_id);
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0x0f;
 	dev_type = (prod_id >> 16) & 0x0f;
@@ -275,6 +272,9 @@ static int __init omap3_check_l2cache(void)
 {
 	u32 val;
 
+	if (class < OMAP3430_REV_ES1_0)
+		return -ENODEV;
+
 	/* Get CP15 AUX register, bit 1 enabled indicates L2 cache is on */
 	asm volatile("mrc p15, 0, %0, c1, c0, 1":"=r" (val));
 
@@ -289,3 +289,14 @@ static int __init omap3_check_l2cache(void)
 
 arch_initcall(omap3_check_l2cache);
 #endif /* CONFIG_ARCH_OMAP3 */
+
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
index 8a718ff..132a758 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -268,6 +268,7 @@ static struct omap_globals *omap2_globals;
 
 static void __init __omap2_set_globals(void)
 {
+	omap2_set_globals_tap(omap2_globals);
 	omap2_set_globals_memory(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
@@ -279,6 +280,7 @@ static void __init __omap2_set_globals(void)
 #if defined(CONFIG_ARCH_OMAP2420)
 
 static struct omap_globals omap242x_globals = {
+	.class	= OMAP242X_CLASS,
 	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x48014000),
 	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE),
 	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE),
@@ -297,6 +299,7 @@ void __init omap2_set_globals_242x(void)
 #if defined(CONFIG_ARCH_OMAP2430)
 
 static struct omap_globals omap243x_globals = {
+	.class	= OMAP243X_CLASS,
 	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4900a000),
 	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE),
 	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE),
@@ -315,6 +318,7 @@ void __init omap2_set_globals_243x(void)
 #if defined(CONFIG_ARCH_OMAP3430)
 
 static struct omap_globals omap343x_globals = {
+	.class	= OMAP343X_CLASS,
 	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),
 	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
 	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index e4cce2e..7a48fc9 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
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
diff --git a/include/asm-arm/arch-omap/cpu.h b/include/asm-arm/arch-omap/cpu.h
index 0f1cf78..fd1155e 100644
--- a/include/asm-arm/arch-omap/cpu.h
+++ b/include/asm-arm/arch-omap/cpu.h
@@ -348,9 +348,14 @@ IS_OMAP_TYPE(3430, 0x3430)
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
-- 
1.5.3.6

