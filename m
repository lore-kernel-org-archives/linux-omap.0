From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] ARM: OMAP2: Fix cpu detection
Date: Thu, 04 Dec 2008 18:39:45 -0800
Message-ID: <20081205023945.3868.32856.stgit@localhost>
References: <20081205023737.3868.78857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50852 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbYLECjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:39:48 -0500
In-Reply-To: <20081205023737.3868.78857.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

At some point omap2 changed the bits for GET_OMAP_CLASS, which
broke 15xx detection on 730 as noticed by Russell King.

This patch fixes omap2 cpu detection to respect the original
GET_OMAP_CLASS, and simplifies the detection for 34xx.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/id.c              |    3 
 arch/arm/mach-omap2/clock34xx.c       |    2 
 arch/arm/mach-omap2/id.c              |  290 ++++++++++++++-------------------
 arch/arm/plat-omap/include/mach/cpu.h |   76 +++------
 4 files changed, 145 insertions(+), 226 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 13083d7..d6110fe 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -178,9 +178,6 @@ void __init omap_check_revision(void)
 	case 0x17:
 		system_rev |= 0x16;
 		break;
-	case 0x24:
-		system_rev |= 0x24;
-		break;
 	default:
 		printk("Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 084e110..3c2f665 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -475,7 +475,7 @@ int __init omap2_clk_init(void)
 		 * Update this if there are further clock changes between ES2
 		 * and production parts
 		 */
-		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0)) {
+		if (system_rev == OMAP3430_REV_ES1_0) {
 			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
 			cpu_clkflg |= CLOCK_IN_OMAP3430ES1;
 		} else {
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index b6ee18c..d4e3a38 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -22,39 +22,6 @@
 #include <mach/control.h>
 #include <mach/cpu.h>
 
-static u32 class;
-static void __iomem *tap_base;
-static u16 tap_prod_id;
-
-#define OMAP_TAP_IDCODE		0x0204
-#define OMAP_TAP_DIE_ID_0	0x0218
-#define OMAP_TAP_DIE_ID_1	0x021C
-#define OMAP_TAP_DIE_ID_2	0x0220
-#define OMAP_TAP_DIE_ID_3	0x0224
-
-/* system_rev fields for OMAP2 processors:
- *   CPU id bits     [31:16],
- *   CPU device type [15:12], (unprg,normal,POP)
- *   CPU revision    [11:08]
- *   CPU class bits  [07:00]
- */
-
-struct omap_id {
-	u16	hawkeye;	/* Silicon type (Hawkeye id) */
-	u8	dev;		/* Device type from production_id reg */
-	u32	type;		/* combined type id copied to system_rev */
-};
-
-/* Register values to detect the OMAP version */
-static struct omap_id omap_ids[] __initdata = {
-	{ .hawkeye = 0xb5d9, .dev = 0x0, .type = 0x24200000 },
-	{ .hawkeye = 0xb5d9, .dev = 0x1, .type = 0x24201000 },
-	{ .hawkeye = 0xb5d9, .dev = 0x2, .type = 0x24202000 },
-	{ .hawkeye = 0xb5d9, .dev = 0x4, .type = 0x24220000 },
-	{ .hawkeye = 0xb5d9, .dev = 0x8, .type = 0x24230000 },
-	{ .hawkeye = 0xb68a, .dev = 0x0, .type = 0x24300000 },
-};
-
 static struct omap_chip_id omap_chip;
 
 /**
@@ -70,135 +37,41 @@ int omap_chip_is(struct omap_chip_id oci)
 }
 EXPORT_SYMBOL(omap_chip_is);
 
-static u32 __init read_tap_reg(int reg)
-{
-	unsigned int regval = 0;
-	u32 cpuid;
+/*----------------------------------------------------------------------------*/
 
-	/* Reading the IDCODE register on 3430 ES1 results in a
-	 * data abort as the register is not exposed on the OCP
-	 * Hence reading the Cortex Rev
-	 */
-	cpuid = read_cpuid(CPUID_ID);
-
-	/* If the processor type is Cortex-A8 and the revision is 0x0
-	 * it means its Cortex r0p0 which is 3430 ES1
-	 */
-	if ((((cpuid >> 4) & 0xFFF) == 0xC08) && ((cpuid & 0xF) == 0x0)) {
-
-		if (reg == tap_prod_id) {
-			regval = 0x000F00F0;
-			goto out;
-		}
-
-		switch (reg) {
-		case OMAP_TAP_IDCODE  : regval = 0x0B7AE02F; break;
-		/* Making DevType as 0xF in ES1 to differ from ES2 */
-		case OMAP_TAP_DIE_ID_0: regval = 0x01000000; break;
-		case OMAP_TAP_DIE_ID_1: regval = 0x1012d687; break;
-		case OMAP_TAP_DIE_ID_2:	regval = 0x00000000; break;
-		case OMAP_TAP_DIE_ID_3:	regval = 0x2d2c0000; break;
-		}
-	} else
-		regval = __raw_readl(tap_base + reg);
-
-out:
-	return regval;
-
-}
-
-/*
- * _set_system_rev - set the system_rev global based on current OMAP chip type
- *
- * Set the system_rev global.  This is primarily used by the cpu_is_omapxxxx()
- * macros.
- */
-static void __init _set_system_rev(u32 type, u8 rev)
-{
-	u32 i, ctrl_status;
-
-	/*
-	 * system_rev encoding is as follows
-	 * system_rev & 0xff000000 -> Omap Class (24xx/34xx)
-	 * system_rev & 0xfff00000 -> Omap Sub Class (242x/343x)
-	 * system_rev & 0xffff0000 -> Omap type (2420/2422/2423/2430/3430)
-	 * system_rev & 0x0000f000 -> Silicon revision (ES1, ES2 )
-	 * system_rev & 0x00000700 -> Device Type ( EMU/HS/GP/BAD )
-	 * system_rev & 0x000000c0 -> IDCODE revision[6:7]
-	 * system_rev & 0x0000003f -> sys_boot[0:5]
-	 */
-	/* Embedding the ES revision info in type field */
-	system_rev = type;
-	/* Also add IDCODE revision info only two lower bits */
-	system_rev |= ((rev & 0x3) << 6);
-
-	/* Add in the device type and sys_boot fields (see above) */
-	if (cpu_is_omap24xx()) {
-		i = OMAP24XX_CONTROL_STATUS;
-	} else if (cpu_is_omap343x()) {
-		i = OMAP343X_CONTROL_STATUS;
-	} else {
-		printk(KERN_ERR "id: unknown CPU type\n");
-		BUG();
-	}
-	ctrl_status = omap_ctrl_readl(i);
-	system_rev |= (ctrl_status & (OMAP2_SYSBOOT_5_MASK |
-				      OMAP2_SYSBOOT_4_MASK |
-				      OMAP2_SYSBOOT_3_MASK |
-				      OMAP2_SYSBOOT_2_MASK |
-				      OMAP2_SYSBOOT_1_MASK |
-				      OMAP2_SYSBOOT_0_MASK));
-	system_rev |= (ctrl_status & OMAP2_DEVICETYPE_MASK);
-}
-
-
-/*
- * _set_omap_chip - set the omap_chip global based on OMAP chip type
- *
- * Build the omap_chip bits.  This variable is used by powerdomain and
- * clockdomain code to indicate whether structures are applicable for
- * the current OMAP chip type by ANDing it against a 'platform' bitfield
- * in the structure.
- */
-static void __init _set_omap_chip(void)
-{
-	if (cpu_is_omap343x()) {
-
-		omap_chip.oc = CHIP_IS_OMAP3430;
-		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
-			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
-		else if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
-			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
-
-	} else if (cpu_is_omap243x()) {
-
-		/* Currently only supports 2430ES2.1 and 2430-all */
-		omap_chip.oc |= CHIP_IS_OMAP2430;
-
-	} else if (cpu_is_omap242x()) {
-
-		/* Currently only supports 2420ES2.1.1 and 2420-all */
-		omap_chip.oc |= CHIP_IS_OMAP2420;
+#define OMAP_TAP_IDCODE		0x0204
+#define OMAP_TAP_DIE_ID_0	0x0218
+#define OMAP_TAP_DIE_ID_1	0x021C
+#define OMAP_TAP_DIE_ID_2	0x0220
+#define OMAP_TAP_DIE_ID_3	0x0224
 
-	} else {
+#define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
 
-		/* Current CPU not supported by this code. */
-		printk(KERN_WARNING "OMAP chip type code does not yet support "
-		       "this CPU type.\n");
-		WARN_ON(1);
+struct omap_id {
+	u16	hawkeye;	/* Silicon type (Hawkeye id) */
+	u8	dev;		/* Device type from production_id reg */
+	u32	type;		/* Combined type id copied to system_rev */
+};
 
-	}
+/* Register values to detect the OMAP version */
+static struct omap_id omap_ids[] __initdata = {
+	{ .hawkeye = 0xb5d9, .dev = 0x0, .type = 0x24200024 },
+	{ .hawkeye = 0xb5d9, .dev = 0x1, .type = 0x24201024 },
+	{ .hawkeye = 0xb5d9, .dev = 0x2, .type = 0x24202024 },
+	{ .hawkeye = 0xb5d9, .dev = 0x4, .type = 0x24220024 },
+	{ .hawkeye = 0xb5d9, .dev = 0x8, .type = 0x24230024 },
+	{ .hawkeye = 0xb68a, .dev = 0x0, .type = 0x24300024 },
+};
 
-}
+static void __iomem *tap_base;
+static u16 tap_prod_id;
 
 void __init omap24xx_check_revision(void)
 {
 	int i, j;
-	u32 idcode;
-	u32 prod_id;
+	u32 idcode, prod_id;
 	u16 hawkeye;
-	u8  dev_type;
-	u8  rev;
+	u8  dev_type, rev;
 
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
 	prod_id = read_tap_reg(tap_prod_id);
@@ -220,18 +93,6 @@ void __init omap24xx_check_revision(void)
 	pr_debug("OMAP_TAP_PROD_ID_0: 0x%08x DEV_TYPE: %i\n",
 		 prod_id, dev_type);
 
-	/*
-	 * Detection for 34xx ES2.0 and above can be done with just
-	 * hawkeye and rev. See TRM 1.5.2 Device Identification.
-	 * Note that rev cannot be used directly as ES1.0 uses value 0.
-	 */
-	if (hawkeye == 0xb7ae) {
-		system_rev = 0x34300000 | ((1 + rev) << 12);
-		pr_info("OMAP%04x ES2.%i\n", system_rev >> 16, rev);
-		_set_omap_chip();
-		return;
-	}
-
 	/* Check hawkeye ids */
 	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
 		if (hawkeye == omap_ids[i].hawkeye)
@@ -255,28 +116,115 @@ void __init omap24xx_check_revision(void)
 		j = i;
 	}
 
-	_set_system_rev(omap_ids[j].type, rev);
-
-	_set_omap_chip();
-
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
 		pr_info("ES%x", (system_rev >> 12) & 0xf);
 	pr_info("\n");
+}
+
+void __init omap34xx_check_revision(void)
+{
+	u32 cpuid, idcode;
+	u16 hawkeye;
+	u8 rev;
+	char *rev_name = "ES1.0";
+
+	/*
+	 * We cannot access revision registers on ES1.0.
+	 * If the processor type is Cortex-A8 and the revision is 0x0
+	 * it means its Cortex r0p0 which is 3430 ES1.0.
+	 */
+	cpuid = read_cpuid(CPUID_ID);
+	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
+		system_rev = OMAP3430_REV_ES1_0;
+		goto out;
+	}
+
+	/*
+	 * Detection for 34xx ES2.0 and above can be done with just
+	 * hawkeye and rev. See TRM 1.5.2 Device Identification.
+	 * Note that rev does not map directly to our defined processor
+	 * revision numbers as ES1.0 uses value 0.
+	 */
+	idcode = read_tap_reg(OMAP_TAP_IDCODE);
+	hawkeye = (idcode >> 12) & 0xffff;
+	rev = (idcode >> 28) & 0xff;
 
+	if (hawkeye == 0xb7ae) {
+		switch (rev) {
+		case 0:
+			system_rev = OMAP3430_REV_ES2_0;
+			rev_name = "ES2.0";
+			break;
+		case 2:
+			system_rev = OMAP3430_REV_ES2_1;
+			rev_name = "ES2.1";
+			break;
+		case 3:
+			system_rev = OMAP3430_REV_ES3_0;
+			rev_name = "ES3.0";
+			break;
+		default:
+			/* Use the latest known revision as default */
+			system_rev = OMAP3430_REV_ES3_0;
+			rev_name = "Unknown revision\n";
+		}
+	}
+
+out:
+	pr_info("OMAP%04x %s\n", system_rev >> 16, rev_name);
 }
 
+/*
+ * Try to detect the exact revision of the omap we're running on
+ */
 void __init omap2_check_revision(void)
 {
-	omap24xx_check_revision();
+	/*
+	 * At this point we have an idea about the processor revision set
+	 * earlier with omap2_set_globals_tap().
+	 */
+	if (cpu_is_omap24xx())
+		omap24xx_check_revision();
+	else if (cpu_is_omap34xx())
+		omap34xx_check_revision();
+	else
+		pr_err("OMAP revision unknown, please fix!\n");
+
+	/*
+	 * OK, now we know the exact revision. Initialize omap_chip bits
+	 * for powerdowmain and clockdomain code.
+	 */
+	if (cpu_is_omap243x()) {
+		/* Currently only supports 2430ES2.1 and 2430-all */
+		omap_chip.oc |= CHIP_IS_OMAP2430;
+	} else if (cpu_is_omap242x()) {
+		/* Currently only supports 2420ES2.1.1 and 2420-all */
+		omap_chip.oc |= CHIP_IS_OMAP2420;
+	} else if (cpu_is_omap343x()) {
+		omap_chip.oc = CHIP_IS_OMAP3430;
+		if (system_rev == OMAP3430_REV_ES1_0)
+			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
+		else if (system_rev > OMAP3430_REV_ES1_0)
+			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
+	} else {
+		pr_err("Uninitialized omap_chip, please fix!\n");
+	}
 }
 
+/*
+ * Set up things for map_io and processor detection later on. Gets called
+ * pretty much first thing from board init. For multi-omap, this gets
+ * cpu_is_omapxxxx() working accurately enough for map_io. Then we'll try to
+ * detect the exact revision later on in omap2_detect_revision() once map_io
+ * is done.
+ */
 void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 {
-	class = omap2_globals->class;
+	system_rev = omap2_globals->class;
 	tap_base = omap2_globals->tap;
 
-	if (class == 0x3430)
+	if (cpu_is_omap34xx())
 		tap_prod_id = 0x0210;
 	else
 		tap_prod_id = 0x0208;
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index e046418..4325bbc 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -28,14 +28,19 @@
 
 struct omap_chip_id {
 	u8 oc;
+	u8 type;
 };
 
 #define OMAP_CHIP_INIT(x)	{ .oc = x }
 
+/*
+ * system_rev bits:
+ * CPU id bits	(0730, 1510, 1710, 2422...)	[31:16]
+ * CPU revision	(See _REV_ defined in cpu.h)	[15:08]
+ * CPU class bits (15xx, 16xx, 24xx, 34xx...)	[07:00]
+ */
 extern unsigned int system_rev;
 
-#define omap2_cpu_rev()		((system_rev >> 12) & 0x0f)
-
 /*
  * Test if multicore OMAP support is needed
  */
@@ -108,7 +113,7 @@ extern unsigned int system_rev;
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
  */
-#define GET_OMAP_CLASS	((system_rev >> 24) & 0xff)
+#define GET_OMAP_CLASS	(system_rev & 0xff)
 
 #define IS_OMAP_CLASS(class, id)			\
 static inline int is_omap ##class (void)		\
@@ -320,44 +325,20 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx())
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-/*
- * Macros to detect silicon revision of OMAP2/3 processors.
- * is_sil_rev_greater_than:	true if passed cpu type & its rev is greater.
- * is_sil_rev_lesser_than:	true if passed cpu type & its rev is lesser.
- * is_sil_rev_equal_to:		true if passed cpu type & its rev is equal.
- * get_sil_rev:			return the silicon rev value.
- */
-#define get_sil_omap_type(rev)	((rev & 0xffff0000) >> 16)
-#define get_sil_revision(rev)	((rev & 0x0000f000) >> 12)
 
-#define is_sil_rev_greater_than(rev) \
-		((get_sil_omap_type(system_rev) == get_sil_omap_type(rev)) && \
-		(get_sil_revision(system_rev) > get_sil_revision(rev)))
+/* Various silicon revisions for omap2 */
+#define OMAP242X_CLASS		0x24200024
+#define OMAP2420_REV_ES1_0	0x24200024
+#define OMAP2420_REV_ES2_0	0x24201024
 
-#define is_sil_rev_less_than(rev) \
-		((get_sil_omap_type(system_rev) == get_sil_omap_type(rev)) && \
-		(get_sil_revision(system_rev) < get_sil_revision(rev)))
+#define OMAP243X_CLASS		0x24300024
+#define OMAP2430_REV_ES1_0	0x24300024
 
-#define is_sil_rev_equal_to(rev) \
-		((get_sil_omap_type(system_rev) == get_sil_omap_type(rev)) && \
-		(get_sil_revision(system_rev) == get_sil_revision(rev)))
-
-#define get_sil_rev() \
-		get_sil_revision(system_rev)
-
-/* Various silicon macros defined here */
-#define OMAP242X_CLASS		0x24200000
-#define OMAP2420_REV_ES1_0	0x24200000
-#define OMAP2420_REV_ES2_0	0x24201000
-
-#define OMAP243X_CLASS		0x24300000
-#define OMAP2430_REV_ES1_0	0x24300000
-
-#define OMAP343X_CLASS		0x34300000
-#define OMAP3430_REV_ES1_0	0x34300000
-#define OMAP3430_REV_ES2_0	0x34301000
-#define OMAP3430_REV_ES2_1	0x34302000
-#define OMAP3430_REV_ES2_2	0x34303000
+#define OMAP343X_CLASS		0x34300034
+#define OMAP3430_REV_ES1_0	0x34300034
+#define OMAP3430_REV_ES2_0	0x34301034
+#define OMAP3430_REV_ES2_1	0x34302034
+#define OMAP3430_REV_ES3_0	0x34303034
 
 /*
  * omap_chip bits
@@ -382,23 +363,16 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define CHIP_IS_OMAP24XX       (CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
 int omap_chip_is(struct omap_chip_id oci);
-
+int omap_type(void);
 
 /*
  * Macro to detect device type i.e. EMU/HS/TST/GP/BAD
  */
-#define DEVICE_TYPE_TEST	0
-#define DEVICE_TYPE_EMU		1
-#define DEVICE_TYPE_SEC		2
-#define DEVICE_TYPE_GP		3
-#define DEVICE_TYPE_BAD		4
-
-#define get_device_type()	((system_rev & 0x700) >> 8)
-#define is_device_type_test()	(get_device_type() == DEVICE_TYPE_TEST)
-#define is_device_type_emu()	(get_device_type() == DEVICE_TYPE_EMU)
-#define is_device_type_sec()	(get_device_type() == DEVICE_TYPE_SEC)
-#define is_device_type_gp()	(get_device_type() == DEVICE_TYPE_GP)
-#define is_device_type_bad()	(get_device_type() == DEVICE_TYPE_BAD)
+#define OMAP2_DEVICE_TYPE_TEST		0
+#define OMAP2_DEVICE_TYPE_EMU		1
+#define OMAP2_DEVICE_TYPE_SEC		2
+#define OMAP2_DEVICE_TYPE_GP		3
+#define OMAP2_DEVICE_TYPE_BAD		4
 
 void omap2_check_revision(void);
 

