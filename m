From: Tony Lindgren <tony@atomide.com>
Subject: Re: cpu_is_omap15xx() doesn't get set for OMAP310
Date: Tue, 9 Sep 2008 20:38:12 -0700
Message-ID: <20080910033811.GZ29054@atomide.com>
References: <20080904211036.GH2309@flint.arm.linux.org.uk> <20080904215109.GV23085@atomide.com> <20080904221027.GI2309@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56697 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbYIJDiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 23:38:21 -0400
Content-Disposition: inline
In-Reply-To: <20080904221027.GI2309@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080904 15:47]:
> On Thu, Sep 04, 2008 at 02:51:13PM -0700, Tony Lindgren wrote:
> > The ugly short term fix would be to define IS_OMAP_CLASS in a different
> > way for omap1 and omap2. Anyways, I can fix it properly unless you're
> > already patching it.
> 
> Haven't pushed any fix for it; my temporary workaround for it was quite
> hacky to the extent of breaking omap2.

Here's a fix (mostly untested) to look. I ended up removing bunch of
stuff from mach-omap2/id.c.. Ugly patch.. I guess it should be broken
down a bit.

Currently it does not apply to the mainline kernel, as it depends on
some patches from the pending omap2-upstream series.

Anyways, I'll post some better patches tomorrow and try to work out
something for mainline kernel.

Tony

--qcHopEYAB45HaUaB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-detect.patch"

>From b776efe3e4d77547d9d28c557160860b61a89572 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 9 Sep 2008 20:27:55 -0700
Subject: [PATCH] ARM: OMAP: Fix cpu detection

Fix cpu detection

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index da13c3e..4e79f3e 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -179,9 +179,6 @@ void __init omap_check_revision(void)
 	case 0x17:
 		system_rev |= 0x16;
 		break;
-	case 0x24:
-		system_rev |= 0x24;
-		break;
 	default:
 		printk("Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
diff --git a/arch/arm/mach-omap2/board-3430sdp-flash.c b/arch/arm/mach-omap2/board-3430sdp-flash.c
index 945a2ae..835c8f6 100644
--- a/arch/arm/mach-omap2/board-3430sdp-flash.c
+++ b/arch/arm/mach-omap2/board-3430sdp-flash.c
@@ -148,7 +148,7 @@ void __init sdp3430_flash_init(void)
 	u8		onenandcs = GPMC_CS_NUM + 1;
 
 	/* Configure start address and size of NOR device */
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		sdp_nor_resource.start	= FLASH_BASE_SDPV2;
 		sdp_nor_resource.end	= FLASH_BASE_SDPV2
 						+ FLASH_SIZE_SDPV2 - 1;
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d27158e..8823ee2 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -135,7 +135,8 @@ static int twl4030_rtc_init(void)
 	int ret = 0;
 
 	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
-	if (is_device_type_gp() && is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
+			system_rev < OMAP3430_REV_ES2_0) {
 		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
 		int mux_mask = 0x04;
 		u16 tmp;
@@ -166,8 +167,8 @@ out:
 
 static void twl4030_rtc_exit(void)
 {
-	if (is_device_type_gp() &&
-			is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
+			system_rev < OMAP3430_REV_ES2_0) {
 		omap_free_gpio(TWL4030_MSECURE_GPIO);
 	}
 }
@@ -298,7 +299,7 @@ static inline void __init sdp3430_init_smc91x(void)
 	sdp3430_smc91x_resources[0].end   = cs_mem_base + 0xf;
 	udelay(100);
 
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
+	if (system_rev > OMAP3430_REV_ES1_0)
 		eth_gpio = OMAP34XX_ETHR_GPIO_IRQ_SDPV2;
 	else
 		eth_gpio = OMAP34XX_ETHR_GPIO_IRQ_SDPV1;
@@ -357,7 +358,7 @@ static void __init omap_3430sdp_init(void)
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
+	if (system_rev > OMAP3430_REV_ES1_0)
 		ts_gpio = OMAP34XX_TS_GPIO_IRQ_SDPV2;
 	else
 		ts_gpio = OMAP34XX_TS_GPIO_IRQ_SDPV1;
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 987f860..ab714a3 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -55,7 +55,8 @@ static int twl4030_rtc_init(void)
 	int ret = 0;
 
 	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
-	if (is_device_type_gp() && is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
+	if (omap_device_type() == OMAP2_DEVICE_TYPE_GP &&
+			system_rev < OMAP3430_REV_ES2_0) {
 		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
 		int mux_mask = 0x04;
 		u16 tmp;
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 88c8ef4..4713918 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -261,7 +261,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 		    (reg & 0x0f) == 0 &&
 		    clk->enable_bit == OMAP3430_EN_SSI_SHIFT) {
 
-			if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+			if (system_rev == OMAP3430_REV_ES1_0)
 				return;
 
 			idlest_bit = OMAP3430ES2_ST_SSI_IDLE;
@@ -271,7 +271,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 		if (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0)) {
 
 			/* 3430ES1 DSS has no target idlest bits */
-			if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+			if (system_rev == OMAP3430_REV_ES1_0)
 				return;
 
 			/*
@@ -285,7 +285,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 		}
 
 		/* USBHOST */
-		if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0) &&
+		if (system_rev > OMAP3430_REV_ES1_0 &&
 		    prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, 0)) {
 
 			/*
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 21492c2..152d095 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -336,7 +336,7 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
 	 * on DPLL4.
 	 */
-	if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0) &&
+	if (system_rev == OMAP3430_REV_ES1_0 &&
 	    !strcmp("dpll4_ck", clk->name)) {
 		printk(KERN_ERR "clock: DPLL4 cannot change rate due to "
 		       "silicon 'Limitation 2.5' on 3430ES1.\n");
@@ -682,7 +682,7 @@ int __init omap2_clk_init(void)
 		 * Update this if there are further clock changes between ES2
 		 * and production parts
 		 */
-		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0)) {
+		if (system_rev == OMAP3430_REV_ES1_0) {
 			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
 			cpu_clkflg |= CLOCK_IN_OMAP3430ES1;
 		} else {
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a526c0f..10b668a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -20,39 +20,6 @@
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
@@ -68,135 +35,61 @@ int omap_chip_is(struct omap_chip_id oci)
 }
 EXPORT_SYMBOL(omap_chip_is);
 
-static u32 __init read_tap_reg(int reg)
+int omap_type(void)
 {
-	unsigned int regval = 0;
-	u32 cpuid;
-
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
+	u32 val = 0;
 
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
 	if (cpu_is_omap24xx()) {
-		i = OMAP24XX_CONTROL_STATUS;
-	} else if (cpu_is_omap343x()) {
-		i = OMAP343X_CONTROL_STATUS;
+		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+	} else if (cpu_is_omap34xx()) {
+		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else {
-		printk(KERN_ERR "id: unknown CPU type\n");
-		BUG();
+		pr_err("Cannot detect omap type!\n");
+		goto out;
 	}
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
+	val &= OMAP2_DEVICETYPE_MASK;
+	val >>= 8;
 
-	} else if (cpu_is_omap243x()) {
-
-		/* Currently only supports 2430ES2.1 and 2430-all */
-		omap_chip.oc |= CHIP_IS_OMAP2430;
-
-	} else if (cpu_is_omap242x()) {
+out:
+	return val;
+}
+EXPORT_SYMBOL(omap_type);
 
-		/* Currently only supports 2420ES2.1.1 and 2420-all */
-		omap_chip.oc |= CHIP_IS_OMAP2420;
+/*----------------------------------------------------------------------------*/
 
-	} else {
+#define OMAP_TAP_IDCODE		0x0204
+#define OMAP_TAP_DIE_ID_0	0x0218
+#define OMAP_TAP_DIE_ID_1	0x021C
+#define OMAP_TAP_DIE_ID_2	0x0220
+#define OMAP_TAP_DIE_ID_3	0x0224
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
 
-void __init omap2_check_revision(void)
+void __init omap24xx_check_revision(void)
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
@@ -218,18 +111,6 @@ void __init omap2_check_revision(void)
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
@@ -253,49 +134,115 @@ void __init omap2_check_revision(void)
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
-
 }
 
-#ifdef CONFIG_ARCH_OMAP3
-/*
- * OMAP3 has L2 cache which has to be enabled by bootloader.
- */
-static int __init omap3_check_l2cache(void)
+void __init omap34xx_check_revision(void)
 {
-	u32 val;
+	u32 cpuid, idcode;
+	u16 hawkeye;
+	u8 rev;
+	char *rev_name;
+
+	/*
+	 * If the processor type is Cortex-A8 and the revision is 0x0
+	 * it means its Cortex r0p0 which is 3430 ES1
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
+	 * Note that rev cannot be used directly as ES1.0 uses value 0.
+	 */
+	idcode = read_tap_reg(OMAP_TAP_IDCODE);
+	hawkeye = (idcode >> 12) & 0xffff;
+	rev = (idcode >> 28) & 0x0f;
 
-	if (class < OMAP3430_REV_ES1_0)
-		return -ENODEV;
+	if (hawkeye == 0xb7ae)
+		system_rev = 0x34300034 | ((1 + rev) << 12);
 
-	/* Get CP15 AUX register, bit 1 enabled indicates L2 cache is on */
-	asm volatile("mrc p15, 0, %0, c1, c0, 1":"=r" (val));
+out:
+	switch (system_rev) {
+	case OMAP3430_REV_ES1_0:
+		rev_name = "ES1.0";
+		break;
+	case OMAP3430_REV_ES2_0:
+		rev_name = "ES2.0";
+		break;
+	case OMAP3430_REV_ES2_1:
+		rev_name = "ES2.1";
+		break;
+	case OMAP3430_REV_ES2_2:
+		rev_name = "ES2.2";
+		break;
+	case OMAP3430_REV_ES3_0:
+		rev_name = "ES3.0";
+		break;
+	default:
+		rev_name = "Unknown revision\n";
+	}
 
-	if ((val & 0x2) == 0)
-		printk(KERN_WARNING "Warning: L2 cache not enabled. Check "
-		       "your bootloader. L2 off results in performance loss\n");
+	pr_info("OMAP%04x %s\n", system_rev >> 16, rev_name);
+}
+
+/*
+ * Try to detect the exact revision of the omap we're running on
+ */
+void __init omap2_check_revision(void)
+{
+	/*
+	 * At this point we have an idea about the processor revision set
+	 * earlier with omap2_set_globals_tap().
+	 */
+	if (cpu_is_omap24xx())
+		omap24xx_check_revision();
+	else if (cpu_is_omap34xx())
+		omap34xx_check_revision();
 	else
-		pr_info("OMAP3 L2 cache enabled\n");
+		pr_err("OMAP revision unknown, please fix!\n");
 
-	return 0;
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
 
-arch_initcall(omap3_check_l2cache);
-#endif /* CONFIG_ARCH_OMAP3 */
-
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
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a16eb33..688be12 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -109,7 +109,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
 	}
 
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		/* USBHOST */
 		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
 		if (wkst) {
@@ -187,7 +187,7 @@ static int omap3_fclks_active(void)
 
 	fck_core1 = cm_read_mod_reg(CORE_MOD,
 				    CM_FCLKEN1);
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		fck_core3 = cm_read_mod_reg(CORE_MOD,
 					    OMAP3430ES2_CM_FCLKEN3);
 		fck_sgx = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
@@ -377,7 +377,7 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
 		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
 	} else
@@ -427,7 +427,7 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_AUTO_DES1,
 		CORE_MOD, CM_AUTOIDLE2);
 
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		cm_write_mod_reg(
 			OMAP3430ES2_AUTO_USBTLL,
 			CORE_MOD, CM_AUTOIDLE3);
@@ -474,7 +474,7 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_PER_MOD,
 		CM_AUTOIDLE);
 
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		cm_write_mod_reg(
 			OMAP3430ES2_AUTO_USBHOST,
 			OMAP3430ES2_USBHOST_MOD,
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ffd49d1..e54c0fb 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -766,7 +766,7 @@ static int __init omap3_sr_init(void)
 	int ret = 0;
 	u8 RdReg;
 
-	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		current_vdd1_opp = PRCM_VDD1_OPP3;
 		current_vdd2_opp = PRCM_VDD2_OPP3;
 	} else {
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index e046418..01202c6 100644
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
@@ -320,44 +325,21 @@ IS_OMAP_TYPE(3430, 0x3430)
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
+#define OMAP3430_REV_ES2_2	0x34303034
+#define OMAP3430_REV_ES3_0	0x34304034
 
 /*
  * omap_chip bits
@@ -382,23 +364,16 @@ IS_OMAP_TYPE(3430, 0x3430)
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
 

--qcHopEYAB45HaUaB--
