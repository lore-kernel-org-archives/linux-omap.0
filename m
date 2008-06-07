From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 21/21] ARM: OMAP: Add OMAP chip type structure; clean up mach-omap2/id.c
Date: Fri,  6 Jun 2008 18:30:53 -0700
Message-ID: <1212802253-17797-22-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
 <1212802253-17797-8-git-send-email-tony@atomide.com>
 <1212802253-17797-9-git-send-email-tony@atomide.com>
 <1212802253-17797-10-git-send-email-tony@atomide.com>
 <1212802253-17797-11-git-send-email-tony@atomide.com>
 <1212802253-17797-12-git-send-email-tony@atomide.com>
 <1212802253-17797-13-git-send-email-tony@atomide.com>
 <1212802253-17797-14-git-send-email-tony@atomide.com>
 <1212802253-17797-15-git-send-email-tony@atomide.com>
 <1212802253-17797-16-git-send-email-tony@atomide.com>
 <1212802253-17797-17-git-send-email-tony@atomide.com>
 <1212802253-17797-18-git-send-email-tony@atomide.com>
 <1212802253-17797-19-git-send-email-tony@atomide.com>
 <1212802253-17797-20-git-send-email-tony@atomide.com>
 <1212802253-17797-21-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53582 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933781AbYFGBbn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:43 -0400
In-Reply-To: <1212802253-17797-21-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Add a new OMAP chip identification interface, omap_chip_id.
omap_chip_id is a structure which contains one bit for each OMAP2/3
CPU type, and on 3430, ES level.  For example, the CHIP_IS_OMAP2420
bit is set in omap_chip at boot on an OMAP2420.  On OMAP3430ES2, both
CHIP_IS_OMAP3430 and CHIP_IS_OMAP3430ES2 bits are set.

omap_chip is set in mach-omap2/id.c by _set_omap_chip(). Other
code should use the omap_chip_is() function to test against omap_chip.

Also, clean up id.c by splitting some code out of
omap_check_revision() into its own function, _set_system_rev(); and
converting some debug printk()s into pr_debug().

Second revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 4dfd878..dff4b16 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -17,16 +17,23 @@
 
 #include <asm/io.h>
 
-#if defined(CONFIG_ARCH_OMAP2420)
-#define OMAP24XX_TAP_BASE	io_p2v(0x48014000)
-#endif
+#include <asm/arch/control.h>
+#include <asm/arch/cpu.h>
 
-#if defined(CONFIG_ARCH_OMAP2430)
-#define OMAP24XX_TAP_BASE	io_p2v(0x4900A000)
+#if defined(CONFIG_ARCH_OMAP2420)
+#define TAP_BASE	io_p2v(0x48014000)
+#elif defined(CONFIG_ARCH_OMAP2430)
+#define TAP_BASE	io_p2v(0x4900A000)
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define TAP_BASE	io_p2v(0x4830A000)
 #endif
 
 #define OMAP_TAP_IDCODE		0x0204
+#if defined(CONFIG_ARCH_OMAP34XX)
+#define OMAP_TAP_PROD_ID	0x0210
+#else
 #define OMAP_TAP_PROD_ID	0x0208
+#endif
 
 #define OMAP_TAP_DIE_ID_0	0x0218
 #define OMAP_TAP_DIE_ID_1	0x021C
@@ -56,9 +63,134 @@ static struct omap_id omap_ids[] __initdata = {
 	{ .hawkeye = 0xb68a, .dev = 0x0, .type = 0x24300000 },
 };
 
+static struct omap_chip_id omap_chip;
+
+/**
+ * omap_chip_is - test whether currently running OMAP matches a chip type
+ * @oc: omap_chip_t to test against
+ *
+ * Test whether the currently-running OMAP chip matches the supplied
+ * chip type 'oc'.  Returns 1 upon a match; 0 upon failure.
+ */
+int omap_chip_is(struct omap_chip_id oci)
+{
+	return (oci.oc & omap_chip.oc) ? 1 : 0;
+}
+EXPORT_SYMBOL(omap_chip_is);
+
 static u32 __init read_tap_reg(int reg)
 {
-	return __raw_readl(OMAP24XX_TAP_BASE + reg);
+	unsigned int regval = 0;
+	u32 cpuid;
+
+	/* Reading the IDCODE register on 3430 ES1 results in a
+	 * data abort as the register is not exposed on the OCP
+	 * Hence reading the Cortex Rev
+	 */
+	cpuid = read_cpuid(CPUID_ID);
+
+	/* If the processor type is Cortex-A8 and the revision is 0x0
+	 * it means its Cortex r0p0 which is 3430 ES1
+	 */
+	if ((((cpuid >> 4) & 0xFFF) == 0xC08) && ((cpuid & 0xF) == 0x0)) {
+		switch (reg) {
+		case OMAP_TAP_IDCODE  : regval = 0x0B7AE02F; break;
+		/* Making DevType as 0xF in ES1 to differ from ES2 */
+		case OMAP_TAP_PROD_ID : regval = 0x000F00F0; break;
+		case OMAP_TAP_DIE_ID_0: regval = 0x01000000; break;
+		case OMAP_TAP_DIE_ID_1: regval = 0x1012d687; break;
+		case OMAP_TAP_DIE_ID_2:	regval = 0x00000000; break;
+		case OMAP_TAP_DIE_ID_3:	regval = 0x2d2c0000; break;
+		}
+	} else
+		regval = __raw_readl(TAP_BASE + reg);
+
+	return regval;
+
+}
+
+/*
+ * _set_system_rev - set the system_rev global based on current OMAP chip type
+ *
+ * Set the system_rev global.  This is primarily used by the cpu_is_omapxxxx()
+ * macros.
+ */
+static void __init _set_system_rev(u32 type, u8 rev)
+{
+	u32 i, ctrl_status;
+
+	/*
+	 * system_rev encoding is as follows
+	 * system_rev & 0xff000000 -> Omap Class (24xx/34xx)
+	 * system_rev & 0xfff00000 -> Omap Sub Class (242x/343x)
+	 * system_rev & 0xffff0000 -> Omap type (2420/2422/2423/2430/3430)
+	 * system_rev & 0x0000f000 -> Silicon revision (ES1, ES2 )
+	 * system_rev & 0x00000700 -> Device Type ( EMU/HS/GP/BAD )
+	 * system_rev & 0x000000c0 -> IDCODE revision[6:7]
+	 * system_rev & 0x0000003f -> sys_boot[0:5]
+	 */
+	/* Embedding the ES revision info in type field */
+	system_rev = type;
+	/* Also add IDCODE revision info only two lower bits */
+	system_rev |= ((rev & 0x3) << 6);
+
+	/* Add in the device type and sys_boot fields (see above) */
+	if (cpu_is_omap24xx()) {
+		i = OMAP24XX_CONTROL_STATUS;
+	} else if (cpu_is_omap343x()) {
+		i = OMAP343X_CONTROL_STATUS;
+	} else {
+		printk(KERN_ERR "id: unknown CPU type\n");
+		BUG();
+	}
+	ctrl_status = omap_ctrl_readl(i);
+	system_rev |= (ctrl_status & (OMAP2_SYSBOOT_5_MASK |
+				      OMAP2_SYSBOOT_4_MASK |
+				      OMAP2_SYSBOOT_3_MASK |
+				      OMAP2_SYSBOOT_2_MASK |
+				      OMAP2_SYSBOOT_1_MASK |
+				      OMAP2_SYSBOOT_0_MASK));
+	system_rev |= (ctrl_status & OMAP2_DEVICETYPE_MASK);
+}
+
+
+/*
+ * _set_omap_chip - set the omap_chip global based on OMAP chip type
+ *
+ * Build the omap_chip bits.  This variable is used by powerdomain and
+ * clockdomain code to indicate whether structures are applicable for
+ * the current OMAP chip type by ANDing it against a 'platform' bitfield
+ * in the structure.
+ */
+static void __init _set_omap_chip(void)
+{
+	if (cpu_is_omap343x()) {
+
+		omap_chip.oc = CHIP_IS_OMAP3430;
+		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
+		else if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
+			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
+
+	} else if (cpu_is_omap243x()) {
+
+		/* Currently only supports 2430ES2.1 and 2430-all */
+		omap_chip.oc |= CHIP_IS_OMAP2430;
+
+	} else if (cpu_is_omap242x()) {
+
+		/* Currently only supports 2420ES2.1.1 and 2420-all */
+		omap_chip.oc |= CHIP_IS_OMAP2420;
+
+	} else {
+
+		/* Current CPU not supported by this code. */
+		printk(KERN_WARNING "OMAP chip type code does not yet support "
+		       "this CPU type.\n");
+		WARN_ON(1);
+
+	}
+
 }
 
 void __init omap2_check_revision(void)
@@ -76,21 +208,31 @@ void __init omap2_check_revision(void)
 	rev = (idcode >> 28) & 0x0f;
 	dev_type = (prod_id >> 16) & 0x0f;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "OMAP_TAP_IDCODE 0x%08x REV %i HAWKEYE 0x%04x MANF %03x\n",
-		idcode, rev, hawkeye, (idcode >> 1) & 0x7ff);
-	printk(KERN_DEBUG "OMAP_TAP_DIE_ID_0: 0x%08x\n",
-		read_tap_reg(OMAP_TAP_DIE_ID_0));
-	printk(KERN_DEBUG "OMAP_TAP_DIE_ID_1: 0x%08x DEV_REV: %i\n",
-		read_tap_reg(OMAP_TAP_DIE_ID_1),
-	       (read_tap_reg(OMAP_TAP_DIE_ID_1) >> 28) & 0xf);
-	printk(KERN_DEBUG "OMAP_TAP_DIE_ID_2: 0x%08x\n",
-		read_tap_reg(OMAP_TAP_DIE_ID_2));
-	printk(KERN_DEBUG "OMAP_TAP_DIE_ID_3: 0x%08x\n",
-		read_tap_reg(OMAP_TAP_DIE_ID_3));
-	printk(KERN_DEBUG "OMAP_TAP_PROD_ID_0: 0x%08x DEV_TYPE: %i\n",
-		prod_id, dev_type);
-#endif
+	pr_debug("OMAP_TAP_IDCODE 0x%08x REV %i HAWKEYE 0x%04x MANF %03x\n",
+		 idcode, rev, hawkeye, (idcode >> 1) & 0x7ff);
+	pr_debug("OMAP_TAP_DIE_ID_0: 0x%08x\n",
+		 read_tap_reg(OMAP_TAP_DIE_ID_0));
+	pr_debug("OMAP_TAP_DIE_ID_1: 0x%08x DEV_REV: %i\n",
+		 read_tap_reg(OMAP_TAP_DIE_ID_1),
+		 (read_tap_reg(OMAP_TAP_DIE_ID_1) >> 28) & 0xf);
+	pr_debug("OMAP_TAP_DIE_ID_2: 0x%08x\n",
+		 read_tap_reg(OMAP_TAP_DIE_ID_2));
+	pr_debug("OMAP_TAP_DIE_ID_3: 0x%08x\n",
+		 read_tap_reg(OMAP_TAP_DIE_ID_3));
+	pr_debug("OMAP_TAP_PROD_ID_0: 0x%08x DEV_TYPE: %i\n",
+		 prod_id, dev_type);
+
+	/*
+	 * Detection for 34xx ES2.0 and above can be done with just
+	 * hawkeye and rev. See TRM 1.5.2 Device Identification.
+	 * Note that rev cannot be used directly as ES1.0 uses value 0.
+	 */
+	if (hawkeye == 0xb7ae) {
+		system_rev = 0x34300000 | ((1 + rev) << 12);
+		pr_info("OMAP%04x ES2.%i\n", system_rev >> 16, rev);
+		_set_omap_chip();
+		return;
+	}
 
 	/* Check hawkeye ids */
 	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
@@ -114,16 +256,15 @@ void __init omap2_check_revision(void)
 				omap_ids[i].type >> 16);
 		j = i;
 	}
-	system_rev = omap_ids[j].type;
 
-	system_rev |= rev << 8;
+	_set_system_rev(omap_ids[j].type, rev);
 
-	/* Add the cpu class info (24xx) */
-	system_rev |= 0x24;
+	_set_omap_chip();
 
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
-		printk("%x", (system_rev >> 8) & 0x0f);
-	printk("\n");
+		pr_info("ES%x", (system_rev >> 12) & 0xf);
+	pr_info("\n");
+
 }
 
diff --git a/include/asm-arm/arch-omap/cpu.h b/include/asm-arm/arch-omap/cpu.h
index e8a4cf5..52db09f 100644
--- a/include/asm-arm/arch-omap/cpu.h
+++ b/include/asm-arm/arch-omap/cpu.h
@@ -3,7 +3,7 @@
  *
  * OMAP cpu type detection
  *
- * Copyright (C) 2004 Nokia Corporation
+ * Copyright (C) 2004, 2008 Nokia Corporation
  *
  * Written by Tony Lindgren <tony.lindgren@nokia.com>
  *
@@ -26,6 +26,12 @@
 #ifndef __ASM_ARCH_OMAP_CPU_H
 #define __ASM_ARCH_OMAP_CPU_H
 
+struct omap_chip_id {
+	u8 oc;
+};
+
+#define OMAP_CHIP_INIT(x)	{ .oc = x }
+
 extern unsigned int system_rev;
 
 #define omap2_cpu_rev()		((system_rev >> 12) & 0x0f)
@@ -345,6 +351,33 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP2430_REV_ES1_0	0x24300000
 #define OMAP3430_REV_ES1_0	0x34300000
 #define OMAP3430_REV_ES2_0	0x34301000
+#define OMAP3430_REV_ES2_1	0x34302000
+#define OMAP3430_REV_ES2_2	0x34303000
+
+/*
+ * omap_chip bits
+ *
+ * CHIP_IS_OMAP{2420,2430,3430} indicate that a particular structure is
+ * valid on all chips of that type.  CHIP_IS_OMAP3430ES{1,2} indicates
+ * something that is only valid on that particular ES revision.
+ *
+ * These bits may be ORed together to indicate structures that are
+ * available on multiple chip types.
+ *
+ * To test whether a particular structure matches the current OMAP chip type,
+ * use omap_chip_is().
+ *
+ */
+#define CHIP_IS_OMAP2420       (1 << 0)
+#define CHIP_IS_OMAP2430       (1 << 1)
+#define CHIP_IS_OMAP3430       (1 << 2)
+#define CHIP_IS_OMAP3430ES1    (1 << 3)
+#define CHIP_IS_OMAP3430ES2    (1 << 4)
+
+#define CHIP_IS_OMAP24XX       (CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
+
+int omap_chip_is(struct omap_chip_id oci);
+
 
 /*
  * Macro to detect device type i.e. EMU/HS/TST/GP/BAD
@@ -362,6 +395,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define is_device_type_gp()	(get_device_type() == DEVICE_TYPE_GP)
 #define is_device_type_bad()	(get_device_type() == DEVICE_TYPE_BAD)
 
-#endif
+void omap2_check_revision(void);
+
+#endif    /* defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) */
 
 #endif
