From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 2/6] new twl4030 SIH irq init
Date: Fri, 10 Oct 2008 14:20:46 -0700
Message-ID: <200810101420.46221.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44631 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759995AbYJJV3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 17:29:50 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Switch to a different twl4030-irq SIH irq init scheme.  Its goal
is to remove some section issues while providing a data structure
that can be reused by generic SIH IRQ handling code.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/twl4030-irq.c |  394 ++++++++++++++++++++++----------------------
 1 file changed, 201 insertions(+), 193 deletions(-)

--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -35,156 +35,139 @@
 #include <linux/i2c/twl4030.h>
 
 
-static inline void activate_irq(int irq)
-{
-#ifdef CONFIG_ARM
-	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
-	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
-	 */
-	set_irq_flags(irq, IRQF_VALID);
-#else
-	/* same effect on other architectures */
-	set_irq_noprobe(irq);
-#endif
-}
+/*
+ * TWL4030 IRQ handling has two stages in hardware, and thus in software.
+ * The Primary Interrupt Handler (PIH) stage exposes status bits saying
+ * which Secondary Interrupt Handler (SIH) stage is raising an interrupt.
+ * SIH modules are more traditional IRQ components, which support per-IRQ
+ * enable/disable and trigger controls; they do most of the work.
+ *
+ * These chips are designed to support IRQ handling from two different
+ * I2C masters.  Each has a dedicated IRQ line, and dedicated IRQ status
+ * and mask registers in the PIH and SIH modules.
+ *
+ * We set up IRQs starting at a platform-specified base, always starting
+ * with PIH and the SIH for PWR_INT and then usually adding GPIO:
+ *	base + 0  .. base + 7	PIH
+ *	base + 8  .. base + 15	SIH for PWR_INT
+ *	base + 16 .. base + 33	SIH for GPIO
+ */
 
 /* PIH register offsets */
 #define REG_PIH_ISR_P1			0x01
 #define REG_PIH_ISR_P2			0x02
 #define REG_PIH_SIR			0x03	/* for testing */
 
-/*----------------------------------------------------------------------*/
 
-/**
- * struct twl4030_mod_iregs - TWL module IMR/ISR regs to mask/clear at init
- * @mod_no: TWL4030 module number (e.g., TWL4030_MODULE_GPIO)
- * @sih_ctrl: address of module SIH_CTRL register
- * @reg_cnt: number of IMR/ISR regs
- * @imrs: pointer to array of TWL module interrupt mask register indices
- * @isrs: pointer to array of TWL module interrupt status register indices
- *
- * Ties together TWL4030 modules and lists of IMR/ISR registers to mask/clear
- * during twl_init_irq().
- */
-struct twl4030_mod_iregs {
-	const u8 mod_no;
-	const u8 sih_ctrl;
-	const u8 reg_cnt;
-	const u8 *imrs;
-	const u8 *isrs;
-};
-
-/* TWL4030 INT module interrupt mask registers */
-static const u8 __initconst twl4030_int_imr_regs[] = {
-	TWL4030_INT_PWR_IMR1,
-	TWL4030_INT_PWR_IMR2,
-};
-
-/* TWL4030 INT module interrupt status registers */
-static const u8 __initconst twl4030_int_isr_regs[] = {
-	TWL4030_INT_PWR_ISR1,
-	TWL4030_INT_PWR_ISR2,
-};
-
-/* TWL4030 INTERRUPTS module interrupt mask registers */
-static const u8 __initconst twl4030_interrupts_imr_regs[] = {
-	TWL4030_INTERRUPTS_BCIIMR1A,
-	TWL4030_INTERRUPTS_BCIIMR1B,
-	TWL4030_INTERRUPTS_BCIIMR2A,
-	TWL4030_INTERRUPTS_BCIIMR2B,
-};
+/* Linux could (eventually) use either IRQ line */
+static int irq_line;
 
-/* TWL4030 INTERRUPTS module interrupt status registers */
-static const u8 __initconst twl4030_interrupts_isr_regs[] = {
-	TWL4030_INTERRUPTS_BCIISR1A,
-	TWL4030_INTERRUPTS_BCIISR1B,
-	TWL4030_INTERRUPTS_BCIISR2A,
-	TWL4030_INTERRUPTS_BCIISR2B,
-};
+struct sih {
+	char	name[8];
+	u8	module;			/* module id */
+	u8	control_offset;		/* for SIH_CTRL */
+	bool	set_cor;
 
-/* TWL4030 MADC module interrupt mask registers */
-static const u8 __initconst twl4030_madc_imr_regs[] = {
-	TWL4030_MADC_IMR1,
-	TWL4030_MADC_IMR2,
-};
+	u8	bits;			/* valid in isr/imr */
+	u8	bytes_ixr;		/* bytelen of ISR/IMR/SIR */
 
-/* TWL4030 MADC module interrupt status registers */
-static const u8 __initconst twl4030_madc_isr_regs[] = {
-	TWL4030_MADC_ISR1,
-	TWL4030_MADC_ISR2,
-};
+	u8	edr_offset;
+	u8	bytes_edr;		/* bytelen of EDR */
 
-/* TWL4030 keypad module interrupt mask registers */
-static const u8 __initconst twl4030_keypad_imr_regs[] = {
-	TWL4030_KEYPAD_KEYP_IMR1,
-	TWL4030_KEYPAD_KEYP_IMR2,
+	/* SIR ignored -- set interrupt, for testing only */
+	struct irq_data {
+		u8	isr_offset;
+		u8	imr_offset;
+	} mask[2];
+	/* + 2 bytes padding */
 };
 
-/* TWL4030 keypad module interrupt status registers */
-static const u8 __initconst twl4030_keypad_isr_regs[] = {
-	TWL4030_KEYPAD_KEYP_ISR1,
-	TWL4030_KEYPAD_KEYP_ISR2,
-};
+#define SIH_INITIALIZER(modname, nbits) \
+	.module		= TWL4030_MODULE_ ## modname, \
+	.control_offset = TWL4030_ ## modname ## _SIH_CTRL, \
+	.bits		= nbits, \
+	.bytes_ixr	= DIV_ROUND_UP(nbits, 8), \
+	.edr_offset	= TWL4030_ ## modname ## _EDR, \
+	.bytes_edr	= DIV_ROUND_UP((2*(nbits)), 8), \
+	.mask = { { \
+		.isr_offset	= TWL4030_ ## modname ## _ISR1, \
+		.imr_offset	= TWL4030_ ## modname ## _IMR1, \
+	}, \
+	{ \
+		.isr_offset	= TWL4030_ ## modname ## _ISR2, \
+		.imr_offset	= TWL4030_ ## modname ## _IMR2, \
+	}, },
 
-/* TWL4030 GPIO module interrupt mask registers */
-static const u8 __initconst twl4030_gpio_imr_regs[] = {
-	REG_GPIO_IMR1A,
-	REG_GPIO_IMR1B,
-	REG_GPIO_IMR2A,
-	REG_GPIO_IMR2B,
-	REG_GPIO_IMR3A,
-	REG_GPIO_IMR3B,
-};
+/* register naming policies are inconsistent ... */
+#define TWL4030_INT_PWR_EDR		TWL4030_INT_PWR_EDR1
+#define TWL4030_MODULE_KEYPAD_KEYP	TWL4030_MODULE_KEYPAD
+#define TWL4030_MODULE_INT_PWR		TWL4030_MODULE_INT
 
-/* TWL4030 GPIO module interrupt status registers */
-static const u8 __initconst twl4030_gpio_isr_regs[] = {
-	REG_GPIO_ISR1A,
-	REG_GPIO_ISR1B,
-	REG_GPIO_ISR2A,
-	REG_GPIO_ISR2B,
-	REG_GPIO_ISR3A,
-	REG_GPIO_ISR3B,
-};
 
-/* TWL4030 modules that have IMR/ISR registers that must be masked/cleared */
-static const struct twl4030_mod_iregs __initconst twl4030_mod_regs[] = {
-	{
-		.mod_no	  = TWL4030_MODULE_INT,
-		.sih_ctrl = TWL4030_INT_PWR_SIH_CTRL,
-		.reg_cnt  = ARRAY_SIZE(twl4030_int_imr_regs),
-		.imrs	  = twl4030_int_imr_regs,
-		.isrs	  = twl4030_int_isr_regs,
+/* Order in this table matches order in PIH_ISR.  That is,
+ * BIT(n) in PIH_ISR is sih_modules[n].
+ */
+static const struct sih sih_modules[6] = {
+	[0] = {
+		.name		= "gpio",
+		.module		= TWL4030_MODULE_GPIO,
+		.control_offset	= REG_GPIO_SIH_CTRL,
+		.set_cor	= true,
+		.bits		= TWL4030_GPIO_MAX,
+		.bytes_ixr	= 3,
+		/* Note: *all* of these IRQs default to no-trigger */
+		.edr_offset	= REG_GPIO_EDR1,
+		.bytes_edr	= 5,
+		.mask = { {
+			.isr_offset	= REG_GPIO_ISR1A,
+			.imr_offset	= REG_GPIO_IMR1A,
+		}, {
+			.isr_offset	= REG_GPIO_ISR1B,
+			.imr_offset	= REG_GPIO_IMR1B,
+		}, },
 	},
-	{
-		.mod_no	  = TWL4030_MODULE_INTERRUPTS,
-		.sih_ctrl = TWL4030_INTERRUPTS_BCISIHCTRL,
-		.reg_cnt  = ARRAY_SIZE(twl4030_interrupts_imr_regs),
-		.imrs	  = twl4030_interrupts_imr_regs,
-		.isrs	  = twl4030_interrupts_isr_regs,
+	[1] = {
+		.name		= "keypad",
+		.set_cor	= true,
+		SIH_INITIALIZER(KEYPAD_KEYP, 4)
 	},
-	{
-		.mod_no	  = TWL4030_MODULE_MADC,
-		.sih_ctrl = TWL4030_MADC_SIH_CTRL,
-		.reg_cnt  = ARRAY_SIZE(twl4030_madc_imr_regs),
-		.imrs	  = twl4030_madc_imr_regs,
-		.isrs	  = twl4030_madc_isr_regs,
+	[2] = {
+		.name		= "bci",
+		.module		= TWL4030_MODULE_INTERRUPTS,
+		.control_offset	= TWL4030_INTERRUPTS_BCISIHCTRL,
+		.bits		= 12,
+		.bytes_ixr	= 2,
+		.edr_offset	= TWL4030_INTERRUPTS_BCIEDR1,
+		/* Note: most of these IRQs default to no-trigger */
+		.bytes_edr	= 3,
+		.mask = { {
+			.isr_offset	= TWL4030_INTERRUPTS_BCIISR1A,
+			.imr_offset	= TWL4030_INTERRUPTS_BCIIMR1A,
+		}, {
+			.isr_offset	= TWL4030_INTERRUPTS_BCIISR1B,
+			.imr_offset	= TWL4030_INTERRUPTS_BCIIMR1B,
+		}, },
 	},
-	{
-		.mod_no	  = TWL4030_MODULE_KEYPAD,
-		.sih_ctrl = TWL4030_KEYPAD_KEYP_SIH_CTRL,
-		.reg_cnt  = ARRAY_SIZE(twl4030_keypad_imr_regs),
-		.imrs	  = twl4030_keypad_imr_regs,
-		.isrs	  = twl4030_keypad_isr_regs,
+	[3] = {
+		.name		= "madc",
+		SIH_INITIALIZER(MADC, 4)
 	},
-	{
-		.mod_no	  = TWL4030_MODULE_GPIO,
-		.sih_ctrl = REG_GPIO_SIH_CTRL,
-		.reg_cnt  = ARRAY_SIZE(twl4030_gpio_imr_regs),
-		.imrs	  = twl4030_gpio_imr_regs,
-		.isrs	  = twl4030_gpio_isr_regs,
+	[4] = {
+		/* USB doesn't use the same SIH organization */
+		.name		= "usb",
 	},
+	[5] = {
+		.name		= "power",
+		.set_cor	= true,
+		SIH_INITIALIZER(INT_PWR, 8)
+	},
+		/* there are no SIH modules #6 or #7 ... */
 };
 
+#undef TWL4030_MODULE_KEYPAD_KEYP
+#undef TWL4030_MODULE_INT_PWR
+#undef TWL4030_INT_PWR_EDR
+
 /*----------------------------------------------------------------------*/
 
 static unsigned twl4030_irq_base;
@@ -282,99 +265,124 @@ static struct task_struct *start_twl4030
 
 /*----------------------------------------------------------------------*/
 
-/**
- * twl4030_i2c_clear_isr - clear TWL4030 SIH ISR regs via read + write
- * @mod_no: TWL4030 module number
- * @reg: register index to clear
- * @cor: value of the <module>_SIH_CTRL.COR bit (1 or 0)
+/*
+ * twl4030_init_sih_modules() ... start from a known state where no
+ * IRQs will be coming in, and where we can quickly enable them then
+ * handle them as they arrive.  Mask all IRQs: maybe init SIH_CTRL.
  *
- * Either reads (cor == 1) or writes (cor == 0) to a TWL4030 interrupt
- * status register to ensure that any prior interrupts are cleared.
- * Returns the status from the I2C read operation.
+ * NOTE:  we don't touch EDR registers here; they stay with hardware
+ * defaults or whatever the last value was.  Note that when both EDR
+ * bits for an IRQ are clear, that's as if its IMR bit is set...
  */
-static int __init twl4030_i2c_clear_isr(u8 mod_no, u8 reg, u8 cor)
+static int twl4030_init_sih_modules(unsigned line)
 {
-	u8 tmp;
-
-	return (cor) ? twl4030_i2c_read_u8(mod_no, &tmp, reg) :
-		twl4030_i2c_write_u8(mod_no, 0xff, reg);
-}
+	const struct sih *sih;
+	u8 buf[4];
+	int i;
+	int status;
 
-/**
- * twl4030_read_cor_bit - are TWL module ISRs cleared by reads or writes?
- * @mod_no: TWL4030 module number
- * @reg: register index to clear
- *
- * Returns 1 if the TWL4030 SIH interrupt status registers (ISRs) for
- * the specified TWL module are cleared by reads, or 0 if cleared by
- * writes.
- */
-static int twl4030_read_cor_bit(u8 mod_no, u8 reg)
-{
-	u8 tmp = 0;
+	/* line 0 == int1_n signal; line 1 == int2_n signal */
+	if (line > 1)
+		return -EINVAL;
 
-	WARN_ON(twl4030_i2c_read_u8(mod_no, &tmp, reg) < 0);
+	irq_line = line;
 
-	tmp &= TWL4030_SIH_CTRL_COR_MASK;
-	tmp >>= __ffs(TWL4030_SIH_CTRL_COR_MASK);
+	/* disable all interrupts on our line */
+	memset(buf, 0xff, sizeof buf);
+	sih = sih_modules;
+	for (i = 0; i < ARRAY_SIZE(sih_modules); i++, sih++) {
 
-	return tmp;
-}
+		/* skip USB -- it's funky */
+		if (!sih->bytes_ixr)
+			continue;
 
-/**
- * twl4030_mask_clear_intrs - mask and clear all TWL4030 interrupts
- * @t: pointer to twl4030_mod_iregs array
- * @t_sz: ARRAY_SIZE(t) (starting at 1)
- *
- * Mask all TWL4030 interrupt mask registers (IMRs) and clear all
- * interrupt status registers (ISRs).  No return value, but will WARN if
- * any I2C operations fail.
- */
-static void __init twl4030_mask_clear_intrs(const struct twl4030_mod_iregs *t,
-					    const u8 t_sz)
-{
-	int i, j;
+		status = twl4030_i2c_write(sih->module, buf,
+				sih->mask[line].imr_offset, sih->bytes_ixr);
+		if (status < 0)
+			pr_err("twl4030: err %d initializing %s %s\n",
+					status, sih->name, "IMR");
 
-	/*
-	 * N.B. - further efficiency is possible here.  Eight I2C
-	 * operations on BCI and GPIO modules are avoidable if I2C
-	 * burst read/write transactions were implemented.  Would
-	 * probably save about 1ms of boot time and a small amount of
-	 * power.
-	 */
-	for (i = 0; i < t_sz; i++) {
-		const struct twl4030_mod_iregs tmr = t[i];
-		int cor;
+		/* Maybe disable "exclusive" mode; buffer second pending irq;
+		 * set Clear-On-Read (COR) bit.
+		 *
+		 * NOTE that sometimes COR polarity is documented as being
+		 * inverted:  for MADC and BCI, COR=1 means "clear on write".
+		 * And for PWR_INT it's not documented...
+		 */
+		if (sih->set_cor) {
+			status = twl4030_i2c_write_u8(sih->module,
+					TWL4030_SIH_CTRL_COR_MASK,
+					sih->control_offset);
+			if (status < 0)
+				pr_err("twl4030: err %d initializing %s %s\n",
+						status, sih->name, "SIH_CTRL");
+		}
+	}
 
-		/* Are ISRs cleared by reads or writes? */
-		cor = twl4030_read_cor_bit(tmr.mod_no, tmr.sih_ctrl);
+	sih = sih_modules;
+	for (i = 0; i < ARRAY_SIZE(sih_modules); i++, sih++) {
+		u8 rxbuf[4];
+		int j;
 
-		for (j = 0; j < tmr.reg_cnt; j++) {
+		/* skip USB */
+		if (!sih->bytes_ixr)
+			continue;
 
-			/* Mask interrupts at the TWL4030 */
-			WARN_ON(twl4030_i2c_write_u8(tmr.mod_no, 0xff,
-						     tmr.imrs[j]) < 0);
+		/* Clear pending interrupt status.  Either the read was
+		 * enough, or we need to write those bits.  Repeat, in
+		 * case an IRQ is pending (PENDDIS=0) ... that's not
+		 * uncommon with PWR_INT.PWRON.
+		 */
+		for (j = 0; j < 2; j++) {
+			status = twl4030_i2c_read(sih->module, rxbuf,
+				sih->mask[line].isr_offset, sih->bytes_ixr);
+			if (status < 0)
+				pr_err("twl4030: err %d initializing %s %s\n",
+					status, sih->name, "ISR");
 
-			/* Clear TWL4030 ISRs */
-			WARN_ON(twl4030_i2c_clear_isr(tmr.mod_no,
-						      tmr.isrs[j], cor) < 0);
+			if (!sih->set_cor)
+				status = twl4030_i2c_write(sih->module, buf,
+					sih->mask[line].isr_offset,
+					sih->bytes_ixr);
+			/* else COR=1 means read sufficed.
+			 * (for most SIH modules...)
+			 */
 		}
 	}
+
+	return 0;
+}
+
+static inline void activate_irq(int irq)
+{
+#ifdef CONFIG_ARM
+	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
+	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
+	 */
+	set_irq_flags(irq, IRQF_VALID);
+#else
+	/* same effect on other architectures */
+	set_irq_noprobe(irq);
+#endif
 }
 
+/* FIXME pass in which interrupt line we'll use ... */
+#define twl_irq_line	0
 
 int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 {
 	static struct irq_chip	twl4030_irq_chip;
 
+	int			status;
 	int			i;
 
 	/*
 	 * Mask and clear all TWL4030 interrupts since initially we do
 	 * not have any TWL4030 module interrupt handlers present
 	 */
-	twl4030_mask_clear_intrs(twl4030_mod_regs,
-				 ARRAY_SIZE(twl4030_mod_regs));
+	status = twl4030_init_sih_modules(twl_irq_line);
+	if (status < 0)
+		return status;
 
 	twl4030_irq_base = irq_base;
 
@@ -394,7 +402,7 @@ int twl_init_irq(int irq_num, unsigned i
 	set_irq_data(irq_num, start_twl4030_irq_thread(irq_num));
 	set_irq_chained_handler(irq_num, handle_twl4030_pih);
 
-	return 0;
+	return status;
 }
 
 int twl_exit_irq(void)
