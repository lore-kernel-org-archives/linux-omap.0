From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] ARM: OMAP2: Use omap_rev() instead of system_rev
Date: Thu, 04 Dec 2008 18:40:17 -0800
Message-ID: <20081205024017.3868.98654.stgit@localhost>
References: <20081205023737.3868.78857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51063 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbYLECkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:40:20 -0500
In-Reply-To: <20081205023737.3868.78857.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Lauri Leukkunen <lauri.leukkunen@nokia.com>

From: Lauri Leukkunen <lauri.leukkunen@nokia.com>

system_rev is meant for board revision, this patch changes
all relevant instances to use the new omap_rev() function
liberating system_rev to be used with ATAG_REVISION as it
has been designed.

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/id.c                        |   50 ++++++++++++++---------
 arch/arm/mach-omap1/pm.c                        |    6 ++-
 arch/arm/mach-omap2/clock34xx.c                 |    2 -
 arch/arm/mach-omap2/id.c                        |   34 ++++++++++------
 arch/arm/plat-omap/include/mach/board-apollon.h |    4 +-
 arch/arm/plat-omap/include/mach/cpu.h           |   10 ++---
 arch/arm/plat-omap/sram.c                       |    3 +
 7 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index d6110fe..89bb875 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <mach/cpu.h>
 
 #define OMAP_DIE_ID_0		0xfffe1800
 #define OMAP_DIE_ID_1		0xfffe1804
@@ -30,6 +31,8 @@ struct omap_id {
 	u32	type;		/* Cpu id bits [31:08], cpu class bits [07:00] */
 };
 
+static unsigned int omap_revision;
+
 /* Register values to detect the OMAP version */
 static struct omap_id omap_ids[] __initdata = {
 	{ .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type = 0x03100000},
@@ -53,6 +56,12 @@ static struct omap_id omap_ids[] __initdata = {
 	{ .jtag_id = 0xb5f7, .die_rev = 0x2, .omap_id = 0x03330100, .type = 0x17100000},
 };
 
+unsigned int omap_rev(void)
+{
+	return omap_revision;
+}
+EXPORT_SYMBOL(omap_rev);
+
 /*
  * Get OMAP type from PROD_ID.
  * 1710 has the PROD_ID in bits 15:00, not in 16:01 as documented in TRM.
@@ -121,17 +130,18 @@ void __init omap_check_revision(void)
 	omap_id = omap_readl(OMAP32_ID_0);
 
 #ifdef DEBUG
-	printk("OMAP_DIE_ID_0: 0x%08x\n", omap_readl(OMAP_DIE_ID_0));
-	printk("OMAP_DIE_ID_1: 0x%08x DIE_REV: %i\n",
+	printk(KERN_DEBUG "OMAP_DIE_ID_0: 0x%08x\n", omap_readl(OMAP_DIE_ID_0));
+	printk(KERN_DEBUG "OMAP_DIE_ID_1: 0x%08x DIE_REV: %i\n",
 		omap_readl(OMAP_DIE_ID_1),
 	       (omap_readl(OMAP_DIE_ID_1) >> 17) & 0xf);
-	printk("OMAP_PRODUCTION_ID_0: 0x%08x\n", omap_readl(OMAP_PRODUCTION_ID_0));
-	printk("OMAP_PRODUCTION_ID_1: 0x%08x JTAG_ID: 0x%04x\n",
+	printk(KERN_DEBUG "OMAP_PRODUCTION_ID_0: 0x%08x\n",
+		omap_readl(OMAP_PRODUCTION_ID_0));
+	printk(KERN_DEBUG "OMAP_PRODUCTION_ID_1: 0x%08x JTAG_ID: 0x%04x\n",
 		omap_readl(OMAP_PRODUCTION_ID_1),
 		omap_readl(OMAP_PRODUCTION_ID_1) & 0xffff);
-	printk("OMAP32_ID_0: 0x%08x\n", omap_readl(OMAP32_ID_0));
-	printk("OMAP32_ID_1: 0x%08x\n", omap_readl(OMAP32_ID_1));
-	printk("JTAG_ID: 0x%04x DIE_REV: %i\n", jtag_id, die_rev);
+	printk(KERN_DEBUG "OMAP32_ID_0: 0x%08x\n", omap_readl(OMAP32_ID_0));
+	printk(KERN_DEBUG "OMAP32_ID_1: 0x%08x\n", omap_readl(OMAP32_ID_1));
+	printk(KERN_DEBUG "JTAG_ID: 0x%04x DIE_REV: %i\n", jtag_id, die_rev);
 #endif
 
 	system_serial_high = omap_readl(OMAP_DIE_ID_0);
@@ -140,7 +150,7 @@ void __init omap_check_revision(void)
 	/* First check only the major version in a safe way */
 	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
 		if (jtag_id == (omap_ids[i].jtag_id)) {
-			system_rev = omap_ids[i].type;
+			omap_revision = omap_ids[i].type;
 			break;
 		}
 	}
@@ -148,7 +158,7 @@ void __init omap_check_revision(void)
 	/* Check if we can find the die revision */
 	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
 		if (jtag_id == omap_ids[i].jtag_id && die_rev == omap_ids[i].die_rev) {
-			system_rev = omap_ids[i].type;
+			omap_revision = omap_ids[i].type;
 			break;
 		}
 	}
@@ -158,35 +168,35 @@ void __init omap_check_revision(void)
 		if (jtag_id == omap_ids[i].jtag_id
 		    && die_rev == omap_ids[i].die_rev
 		    && omap_id == omap_ids[i].omap_id) {
-			system_rev = omap_ids[i].type;
+			omap_revision = omap_ids[i].type;
 			break;
 		}
 	}
 
 	/* Add the cpu class info (7xx, 15xx, 16xx, 24xx) */
-	cpu_type = system_rev >> 24;
+	cpu_type = omap_revision >> 24;
 
 	switch (cpu_type) {
 	case 0x07:
-		system_rev |= 0x07;
+		omap_revision |= 0x07;
 		break;
 	case 0x03:
 	case 0x15:
-		system_rev |= 0x15;
+		omap_revision |= 0x15;
 		break;
 	case 0x16:
 	case 0x17:
-		system_rev |= 0x16;
+		omap_revision |= 0x16;
 		break;
 	default:
-		printk("Unknown OMAP cpu type: 0x%02x\n", cpu_type);
+		printk(KERN_INFO "Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
 
-	printk("OMAP%04x", system_rev >> 16);
-	if ((system_rev >> 8) & 0xff)
-		printk("%x", (system_rev >> 8) & 0xff);
-	printk(" revision %i handled as %02xxx id: %08x%08x\n",
-	       die_rev, system_rev & 0xff, system_serial_low,
+	printk(KERN_INFO "OMAP%04x", omap_revision >> 16);
+	if ((omap_revision >> 8) & 0xff)
+		printk(KERN_INFO "%x", (omap_revision >> 8) & 0xff);
+	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
+	       die_rev, omap_revision & 0xff, system_serial_low,
 	       system_serial_high);
 }
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 770d256..9774c1f 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -226,7 +226,8 @@ void omap_pm_suspend(void)
 {
 	unsigned long arg0 = 0, arg1 = 0;
 
-	printk("PM: OMAP%x is trying to enter deep sleep...\n", system_rev);
+	printk(KERN_INFO "PM: OMAP%x is trying to enter deep sleep...\n",
+		omap_rev());
 
 	omap_serial_wake_trigger(1);
 
@@ -421,7 +422,8 @@ void omap_pm_suspend(void)
 
 	omap_serial_wake_trigger(0);
 
-	printk("PM: OMAP%x is re-starting from deep sleep...\n", system_rev);
+	printk(KERN_INFO "PM: OMAP%x is re-starting from deep sleep...\n",
+		omap_rev());
 }
 
 #if defined(DEBUG) && defined(CONFIG_PROC_FS)
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 3c2f665..31bb701 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -475,7 +475,7 @@ int __init omap2_clk_init(void)
 		 * Update this if there are further clock changes between ES2
 		 * and production parts
 		 */
-		if (system_rev == OMAP3430_REV_ES1_0) {
+		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
 			cpu_clkflg |= CLOCK_IN_OMAP3430ES1;
 		} else {
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d4e3a38..b0f8e7d 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -23,6 +23,14 @@
 #include <mach/cpu.h>
 
 static struct omap_chip_id omap_chip;
+static unsigned int omap_revision;
+
+
+unsigned int omap_rev(void)
+{
+	return omap_revision;
+}
+EXPORT_SYMBOL(omap_rev);
 
 /**
  * omap_chip_is - test whether currently running OMAP matches a chip type
@@ -50,7 +58,7 @@ EXPORT_SYMBOL(omap_chip_is);
 struct omap_id {
 	u16	hawkeye;	/* Silicon type (Hawkeye id) */
 	u8	dev;		/* Device type from production_id reg */
-	u32	type;		/* Combined type id copied to system_rev */
+	u32	type;		/* Combined type id copied to omap_revision */
 };
 
 /* Register values to detect the OMAP version */
@@ -116,9 +124,9 @@ void __init omap24xx_check_revision(void)
 		j = i;
 	}
 
-	pr_info("OMAP%04x", system_rev >> 16);
-	if ((system_rev >> 8) & 0x0f)
-		pr_info("ES%x", (system_rev >> 12) & 0xf);
+	pr_info("OMAP%04x", omap_rev() >> 16);
+	if ((omap_rev() >> 8) & 0x0f)
+		pr_info("ES%x", (omap_rev() >> 12) & 0xf);
 	pr_info("\n");
 }
 
@@ -136,7 +144,7 @@ void __init omap34xx_check_revision(void)
 	 */
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
-		system_rev = OMAP3430_REV_ES1_0;
+		omap_revision = OMAP3430_REV_ES1_0;
 		goto out;
 	}
 
@@ -153,26 +161,26 @@ void __init omap34xx_check_revision(void)
 	if (hawkeye == 0xb7ae) {
 		switch (rev) {
 		case 0:
-			system_rev = OMAP3430_REV_ES2_0;
+			omap_revision = OMAP3430_REV_ES2_0;
 			rev_name = "ES2.0";
 			break;
 		case 2:
-			system_rev = OMAP3430_REV_ES2_1;
+			omap_revision = OMAP3430_REV_ES2_1;
 			rev_name = "ES2.1";
 			break;
 		case 3:
-			system_rev = OMAP3430_REV_ES3_0;
+			omap_revision = OMAP3430_REV_ES3_0;
 			rev_name = "ES3.0";
 			break;
 		default:
 			/* Use the latest known revision as default */
-			system_rev = OMAP3430_REV_ES3_0;
+			omap_revision = OMAP3430_REV_ES3_0;
 			rev_name = "Unknown revision\n";
 		}
 	}
 
 out:
-	pr_info("OMAP%04x %s\n", system_rev >> 16, rev_name);
+	pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
 }
 
 /*
@@ -203,9 +211,9 @@ void __init omap2_check_revision(void)
 		omap_chip.oc |= CHIP_IS_OMAP2420;
 	} else if (cpu_is_omap343x()) {
 		omap_chip.oc = CHIP_IS_OMAP3430;
-		if (system_rev == OMAP3430_REV_ES1_0)
+		if (omap_rev() == OMAP3430_REV_ES1_0)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
-		else if (system_rev > OMAP3430_REV_ES1_0)
+		else if (omap_rev() > OMAP3430_REV_ES1_0)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
 	} else {
 		pr_err("Uninitialized omap_chip, please fix!\n");
@@ -221,7 +229,7 @@ void __init omap2_check_revision(void)
  */
 void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 {
-	system_rev = omap2_globals->class;
+	omap_revision = omap2_globals->class;
 	tap_base = omap2_globals->tap;
 
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/plat-omap/include/mach/board-apollon.h b/arch/arm/plat-omap/include/mach/board-apollon.h
index 731c858..61bd5e8 100644
--- a/arch/arm/plat-omap/include/mach/board-apollon.h
+++ b/arch/arm/plat-omap/include/mach/board-apollon.h
@@ -29,12 +29,14 @@
 #ifndef __ASM_ARCH_OMAP_APOLLON_H
 #define __ASM_ARCH_OMAP_APOLLON_H
 
+#include <mach/cpu.h>
+
 extern void apollon_mmc_init(void);
 
 static inline int apollon_plus(void)
 {
 	/* The apollon plus has IDCODE revision 5 */
-	return system_rev & 0xc0;
+	return omap_rev() & 0xc0;
 }
 
 /* Placeholder for APOLLON specific defines */
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 4325bbc..b2062f1 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -34,12 +34,12 @@ struct omap_chip_id {
 #define OMAP_CHIP_INIT(x)	{ .oc = x }
 
 /*
- * system_rev bits:
+ * omap_rev bits:
  * CPU id bits	(0730, 1510, 1710, 2422...)	[31:16]
  * CPU revision	(See _REV_ defined in cpu.h)	[15:08]
  * CPU class bits (15xx, 16xx, 24xx, 34xx...)	[07:00]
  */
-extern unsigned int system_rev;
+unsigned int omap_rev(void);
 
 /*
  * Test if multicore OMAP support is needed
@@ -113,7 +113,7 @@ extern unsigned int system_rev;
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
  */
-#define GET_OMAP_CLASS	(system_rev & 0xff)
+#define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
 #define IS_OMAP_CLASS(class, id)			\
 static inline int is_omap ##class (void)		\
@@ -121,7 +121,7 @@ static inline int is_omap ##class (void)		\
 	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
 }
 
-#define GET_OMAP_SUBCLASS	((system_rev >> 20) & 0x0fff)
+#define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
 
 #define IS_OMAP_SUBCLASS(subclass, id)			\
 static inline int is_omap ##subclass (void)		\
@@ -231,7 +231,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
  */
-#define GET_OMAP_TYPE	((system_rev >> 16) & 0xffff)
+#define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
 #define IS_OMAP_TYPE(type, id)				\
 static inline int is_omap ##type (void)			\
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 9f9a921..e1556f8 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -24,6 +24,7 @@
 
 #include <mach/sram.h>
 #include <mach/board.h>
+#include <mach/cpu.h>
 
 #include <mach/control.h>
 
@@ -87,7 +88,7 @@ static int is_sram_locked(void)
 	int type = 0;
 
 	if (cpu_is_omap242x())
-		type = system_rev & OMAP2_DEVICETYPE_MASK;
+		type = omap_rev() & OMAP2_DEVICETYPE_MASK;
 
 	if (type == GP_DEVICE) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */

