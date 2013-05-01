From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC 1/2] ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
Date: Wed,  1 May 2013 12:02:26 -0700
Message-ID: <1367434947-6442-2-git-send-email-Russ.Dill@ti.com>
References: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40568 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab3EATCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 15:02:36 -0400
Received: by mail-pd0-f170.google.com with SMTP id 15so950675pdi.1
        for <linux-omap@vger.kernel.org>; Wed, 01 May 2013 12:02:36 -0700 (PDT)
In-Reply-To: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds the ability to write an I2C sleep sequence from
SRAM just before WFI, and a wake sequence just after control is passed
from the M3. This is useful for adjusting voltages during sleep that cannot
be lowered while SDRAM is active.

Each sequence is a series of I2C transfers in the form:

u8 length | u8 chip address | u8 byte0/reg address | u8 byte 1 | u8 byte n ...

The length indicates the number of bytes to transfer, including the register
address. The length of the sequence is limited by the amount of space
reserved in SRAM, 127 bytes.

The sequences are taken from the i2c1 node in the device tree. The property
name for the sleep sequence is "sleep_sequence" and the property name for
the wake sequence is "wake_sequence". Each property should be an array of
bytes.

No actions are performed if the properties are not present in the device
tree.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/pm33xx.c    | 108 +++++++++++++++++++++++
 arch/arm/mach-omap2/pm33xx.h    |  23 +++++
 arch/arm/mach-omap2/sleep33xx.S | 184 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+)

diff --git a/arch/arm/mach-omap2/pm33xx.c b/arch/arm/mach-omap2/pm33xx.c
index 93f970f..8aeaf6e 100644
--- a/arch/arm/mach-omap2/pm33xx.c
+++ b/arch/arm/mach-omap2/pm33xx.c
@@ -47,10 +47,14 @@
 void (*am33xx_do_wfi_sram)(void);
 
 static void __iomem *am33xx_emif_base;
+static void __iomem *am33xx_i2c1_base;
 static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm;
 static struct clockdomain *gfx_l4ls_clkdm;
 static struct omap_hwmod *usb_oh, *cpsw_oh, *tptc0_oh, *tptc1_oh, *tptc2_oh;
+static struct omap_hwmod *i2c1_oh;
 static struct wkup_m3_context *wkup_m3;
+static char *am33xx_i2c_sleep_sequence;
+static char *am33xx_i2c_wake_sequence;
 
 static DECLARE_COMPLETION(wkup_m3_sync);
 
@@ -88,7 +92,10 @@ static int am33xx_pm_suspend(void)
 	/* Try to put GFX to sleep */
 	pwrdm_set_next_fpwrst(gfx_pwrdm, PWRDM_FUNC_PWRST_OFF);
 
+	/* We need I2C to send the sleep/wake sequences */
+	omap_hwmod_enable(i2c1_oh);
 	ret = cpu_suspend(0, am33xx_do_sram_idle);
+	omap_hwmod_idle(i2c1_oh);
 
 	status = pwrdm_read_fpwrst(gfx_pwrdm);
 	if (status != PWRDM_FUNC_PWRST_OFF)
@@ -403,6 +410,101 @@ void __iomem *am33xx_get_emif_base(void)
 	return am33xx_emif_base;
 }
 
+void am33xx_fill_i2c_sequences(char *sleep, size_t ssz, char *wake, size_t wsz)
+{
+	if (am33xx_i2c_sleep_sequence)
+		memcpy(sleep, am33xx_i2c_sleep_sequence, ssz);
+	else
+		memset(sleep, 0, ssz);
+
+	if (am33xx_i2c_wake_sequence)
+		memcpy(wake, am33xx_i2c_wake_sequence, wsz);
+	else
+		memset(wake, 0, wsz);
+}
+
+static int __init am33xx_map_i2c1(void)
+{
+	am33xx_i2c1_base = ioremap(AM33XX_I2C0_BASE, SZ_4K);
+
+	if (!am33xx_i2c1_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void __iomem *am33xx_get_i2c1_base(void)
+{
+	return am33xx_i2c1_base;
+}
+
+static int __init am33xx_setup_sleep_sequence(void)
+{
+	int ret;
+	int sz;
+	const void *prop;
+	struct device *dev;
+	struct omap_hwmod *oh;
+
+	ret = am33xx_map_i2c1();
+	if (ret) {
+		pr_err("Could not ioremap i2c1\n");
+		return ret;
+	}
+
+	oh = omap_hwmod_lookup("i2c1");
+	if (!oh)
+		return -ENODEV;
+
+	/*
+	 * We put the device tree node in the I2C controller that will
+	 * be sending the sequence.
+	 */
+	dev = omap_device_get_by_hwmod_name("i2c1");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	prop = of_get_property(dev->of_node, "sleep_sequence", &sz);
+	if (prop) {
+		if (sz >= i2c_sleep_sequence_sz) {
+			pr_err("Sleep sequence too long\n");
+			return -EINVAL;
+		}
+		am33xx_i2c_sleep_sequence = kzalloc(i2c_sleep_sequence_sz,
+								GFP_KERNEL);
+		if (!am33xx_i2c_sleep_sequence)
+			return -ENOMEM;
+		memcpy(am33xx_i2c_sleep_sequence, prop, sz);
+	}
+
+	prop = of_get_property(dev->of_node, "wake_sequence", &sz);
+	if (prop) {
+		if (sz >= i2c_wake_sequence_sz) {
+			pr_err("Wake sequence too long\n");
+			ret = -EINVAL;
+			goto cleanup_sleep;
+		}
+		am33xx_i2c_wake_sequence = kzalloc(i2c_wake_sequence_sz,
+								GFP_KERNEL);
+		if (!am33xx_i2c_wake_sequence) {
+			ret = -ENOMEM;
+			goto cleanup_sleep;
+		}
+		memcpy(am33xx_i2c_wake_sequence, prop, sz);
+	}
+
+	/* Only take the I2C controller out of idle if a sequence exists */
+	if (am33xx_i2c_sleep_sequence || am33xx_i2c_wake_sequence)
+		i2c1_oh = oh;
+
+	return 0;
+
+cleanup_sleep:
+	kfree(am33xx_i2c_sleep_sequence);
+	am33xx_i2c_sleep_sequence = NULL;
+	return ret;
+}
+
 int __init am33xx_pm_init(void)
 {
 	int ret;
@@ -449,6 +551,12 @@ int __init am33xx_pm_init(void)
 		goto err;
 	}
 
+	ret = am33xx_setup_sleep_sequence();
+	if (ret) {
+		pr_err("Error fetching I2C sleep/wake sequence\n");
+		goto err;
+	}
+
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
 	/* CEFUSE domain can be turned off post bootup */
diff --git a/arch/arm/mach-omap2/pm33xx.h b/arch/arm/mach-omap2/pm33xx.h
index 13a2c85..69616ee 100644
--- a/arch/arm/mach-omap2/pm33xx.h
+++ b/arch/arm/mach-omap2/pm33xx.h
@@ -28,6 +28,9 @@ struct wkup_m3_context {
 	u8			state;
 };
 
+extern u32 i2c_sleep_sequence_sz;
+extern u32 i2c_wake_sequence_sz;
+
 #ifdef CONFIG_SUSPEND
 static void am33xx_m3_state_machine_reset(void);
 #else
@@ -52,5 +55,25 @@ extern void __iomem *am33xx_get_emif_base(void);
 
 #define AM33XX_OCMC_END			0x40310000
 #define AM33XX_EMIF_BASE		0x4C000000
+#define AM33XX_I2C0_BASE		0x44E0B000
+
+#define OMAP_I2C_STAT_BB		(1 << 12)
+#define OMAP_I2C_STAT_ARDY		(1 << 2)
+#define OMAP_I2C_STAT_NACK		(1 << 1)
+#define OMAP_I2C_STAT_AL		(1 << 0)
+
+#define OMAP_I2C_CON_EN			(1 << 15)
+#define OMAP_I2C_CON_MST		(1 << 10)
+#define OMAP_I2C_CON_TRX		(1 << 9)
+#define OMAP_I2C_CON_STP		(1 << 1)
+#define OMAP_I2C_CON_STT		(1 << 0)
+
+#define OMAP_I2C_STAT_RAW_REG		0x24
+#define OMAP_I2C_STAT_REG		0x28
+#define OMAP_I2C_IRQENABLE_CLR		0x30
+#define OMAP_I2C_CNT_REG		0x98
+#define OMAP_I2C_DATA_REG		0x9c
+#define OMAP_I2C_CON_REG		0xa4
+#define OMAP_I2C_SA_REG			0xac
 
 #endif
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index 98fa76c..85453e8 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -95,6 +95,19 @@ ENTRY(am33xx_do_wfi)
 	/* Save it for later use */
 	str	r0, emif_addr_virt
 
+	/* Get/save the i2c1 base virtual address */
+	ldr	r0, i2c_addr_func
+	blx	r0
+	str	r0, i2c_addr_virt
+
+	/* Load the sleep/wake sequences */
+	ldr	r4, i2c_sequence_func
+	adrl	r0, i2c_sleep_sequence
+	ldr	r1, i2c_sleep_sequence_sz
+	adrl	r2, i2c_wake_sequence
+	ldr	r3, i2c_sleep_sequence_sz
+	blx	r4
+
 	/* This ensures isb */
 	ldr	r0, dcache_flush
 	blx	r0
@@ -187,6 +200,10 @@ put_pll_bypass:
 	pll_bypass	per, virt_per_clk_mode, virt_per_idlest, per_val
 	pll_bypass	mpu, virt_mpu_clk_mode, virt_mpu_idlest, mpu_val
 
+	/* Write the sleep sequence, abort on suspend on error */
+	bl	am33xx_i2c_write_sleep
+	bne	wfi_abort
+
 	dsb
 	dmb
 	isb
@@ -209,6 +226,8 @@ put_pll_bypass:
 	nop
 
 	/* We come here in case of an abort due to a late interrupt */
+wfi_abort:
+	bl	am33xx_i2c_write_wake
 
 	/* Set MPU_CLKCTRL.MODULEMODE back to ENABLE */
 	ldr	r1, virt_mpu_clkctrl
@@ -312,6 +331,9 @@ ENTRY(am33xx_resume_offset)
 	.word . - am33xx_do_wfi
 
 ENTRY(am33xx_resume_from_deep_sleep)
+
+	bl	am33xx_i2c_write_wake
+
 	/* Take the PLLs out of LP_BYPASS */
 	pll_lock	mpu, phys_mpu_clk_mode, phys_mpu_idlest, mpu_val
 	pll_lock	per, phys_per_clk_mode, phys_per_idlest, per_val
@@ -415,6 +437,87 @@ wait_resume:
 	ldr	pc, resume_addr
 ENDPROC(am33xx_resume_from_deep_sleep)
 
+am33xx_i2c_write_wake:
+	adrl	r3, i2c_wake_sequence
+	ldr	r2, i2c_addr_phys
+	b	am33xx_i2c_write
+
+am33xx_i2c_write_sleep:
+	adrl	r3, i2c_sleep_sequence
+	ldr	r2, i2c_addr_virt
+
+am33xx_i2c_write:
+	/* Early out check, don't touch the hardware */
+	ldrb	r4, [r3]
+	tst	r4, r4
+	moveq	pc, lr
+
+	/* Disable all event interrupts */
+	movw	r5, #0xffff
+	strh	r5, [r2, #OMAP_I2C_IRQENABLE_CLR]
+
+i2c_transfer:
+	/* Ack all events */
+	strh	r5, [r2, #OMAP_I2C_STAT_REG]
+
+	/*
+	 * Loop through the I2C transfer list, a zero byte transfer
+	 * terminates the list.
+	 */
+	ldrb	r4, [r3], #1
+	tst	r4, r4
+	moveq	pc, lr
+
+	/* Wait for bus to be ready */
+	mov	r0, #1000
+1:	ldr	r1, [r2, #OMAP_I2C_STAT_RAW_REG]
+	tst	r1, #OMAP_I2C_STAT_BB
+	beq	bb_cleared
+	subs	r0, r0, #1
+	bne	1b
+	b	i2c_err
+
+bb_cleared:
+	/* Ack all events */
+	strh	r5, [r2, #OMAP_I2C_STAT_REG]
+
+	/* Program I2C target address */
+	ldrb	r1, [r3], #1
+	strh	r1, [r2, #OMAP_I2C_SA_REG]
+
+	/* Store the length of the transfer */
+	strh	r4, [r2, #OMAP_I2C_CNT_REG]
+
+	/* Configure I2C controller for transfer */
+	movw	r1, #(OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_TRX | \
+			OMAP_I2C_CON_STP | OMAP_I2C_CON_STT)
+	strh	r1, [r2, #OMAP_I2C_CON_REG]
+
+	/* Ack all events */
+	strh	r5, [r2, #OMAP_I2C_STAT_REG]
+
+	/* Write out data */
+1:	ldrb	r1, [r3], #1
+	strh	r1, [r2, #OMAP_I2C_DATA_REG]
+	subs	r4, r4, #1
+	bne 	1b
+
+	/* Wait for transfer to complete */
+	mov	r0, #1000
+1:	ldr	r1, [r2, #OMAP_I2C_STAT_RAW_REG]
+	tst	r1, #OMAP_I2C_STAT_NACK
+	tsteq	r1, #OMAP_I2C_STAT_AL
+	bne	i2c_err
+	tst	r1, #OMAP_I2C_STAT_ARDY
+	bne	i2c_transfer
+	subs	r0, r0, #1
+	bne	1b
+
+i2c_err:
+	/* ACK all events and return NE */
+	strh	r5, [r2, #OMAP_I2C_STAT_REG]
+	movs	r0, #1
+	mov	pc, lr
 
 /*
  * Local variables
@@ -578,6 +681,87 @@ clk_mode_ddr_val:
 clk_mode_core_val:
 	.word	0xDEADBEEF
 
+i2c_addr_func:
+	.word	am33xx_get_i2c1_base
+i2c_addr_virt:
+	.word	0xDEADBEEF
+i2c_addr_phys:
+	.word	AM33XX_I2C0_BASE
+
+/* I2C sleep/wake sequence data */
+i2c_sleep_sequence:
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+ENTRY(i2c_sleep_sequence_sz)
+	.word	. - i2c_sleep_sequence
+i2c_wake_sequence:
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+	.word	0xDEADBEEF
+ENTRY(i2c_wake_sequence_sz)
+	.word	. - i2c_wake_sequence
+i2c_sequence_func:
+	.word	am33xx_fill_i2c_sequences
+
 	.align 3
 ENTRY(am33xx_do_wfi_sz)
 	.word	. - am33xx_do_wfi
-- 
1.8.1.2

