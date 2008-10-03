From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 4/7] twl4030-core cleanup
Date: Fri, 3 Oct 2008 09:00:48 -0700
Message-ID: <200810030900.49051.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32642 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753061AbYJCQbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

A variety of twl4030-core cleanups:

 - SIH register declarations moved from core.c to twl4030.h, for
   keypad, madc, bci; this decouples from twl4030-madc.h; add
   several omitted register decls; remove a duplicate.

 - Use a global "inuse" flag, not a per-slave one;

 - Remove pointless SLAVENUM_NUM symbols; just use 0/1/2/3

 - Comments:
     * Add comments:  header, register values
     * Add some section delimiters
     * Correct clock init and other comments

 - Minor stuff:
     * Group some variables and code with sibling
     * Make clock init a bit simpler
     * List twl5030 in supported i2c chips list
     * Remove needless "return;"

And one IRQ-related bugfix:  if the I2C timeout bug strikes while
reading PIH interrupt status, force an immediate retry.  Otherwise
the twl4030 IRQ will never get re-enabled...

Object size shrinks by 180 bytes, w00t!

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/twl4030-core.c       |  263 ++++++++++++++++++-------------------
 include/linux/i2c/twl4030-madc.h |    8 -
 include/linux/i2c/twl4030.h      |   51 +++++++
 3 files changed, 181 insertions(+), 141 deletions(-)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -39,7 +39,20 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
-#include <linux/i2c/twl4030-madc.h>
+
+
+/*
+ * The TWL4030 "Triton 2" is one of a family of a multi-function "Power
+ * Management and System Companion Device" chips originally designed for
+ * use in OMAP2 and OMAP 3 based systems.  Its control interfaces use I2C,
+ * often at around 3 Mbit/sec, including for interrupt handling.
+ *
+ * This driver core provides genirq support for the interrupts emitted,
+ * by the various modules, and exports register access primitives.
+ *
+ * FIXME this driver currently requires use of the first interrupt line
+ * (and associated registers).
+ */
 
 #define DRIVER_NAME			"twl4030"
 
@@ -108,23 +121,20 @@ static inline void activate_irq(int irq)
 
 #define TWL4030_NUM_SLAVES		4
 
-/* Slave address */
-#define TWL4030_SLAVENUM_NUM0		0x00
-#define TWL4030_SLAVENUM_NUM1		0x01
-#define TWL4030_SLAVENUM_NUM2		0x02
-#define TWL4030_SLAVENUM_NUM3		0x03
 
-/* Base Address defns */
-/* USB ID */
+/* Base Address defns for twl4030_map[] */
+
+/* subchip/slave 0 - USB ID */
 #define TWL4030_BASEADD_USB		0x0000
-/* AUD ID */
+
+/* subchip/slave 1 - AUD ID */
 #define TWL4030_BASEADD_AUDIO_VOICE	0x0000
 #define TWL4030_BASEADD_GPIO		0x0098
-
 #define TWL4030_BASEADD_INTBR		0x0085
 #define TWL4030_BASEADD_PIH		0x0080
 #define TWL4030_BASEADD_TEST		0x004C
-/* AUX ID */
+
+/* subchip/slave 2 - AUX ID */
 #define TWL4030_BASEADD_INTERRUPTS	0x00B9
 #define TWL4030_BASEADD_LED		0x00EE
 #define TWL4030_BASEADD_MADC		0x0000
@@ -135,7 +145,8 @@ static inline void activate_irq(int irq)
 #define TWL4030_BASEADD_PWMA		0x00EF
 #define TWL4030_BASEADD_PWMB		0x00F1
 #define TWL4030_BASEADD_KEYPAD		0x00D2
-/* POWER ID */
+
+/* subchip/slave 3 - POWER ID */
 #define TWL4030_BASEADD_BACKUP		0x0014
 #define TWL4030_BASEADD_INT		0x002E
 #define TWL4030_BASEADD_PM_MASTER	0x0036
@@ -143,44 +154,26 @@ static inline void activate_irq(int irq)
 #define TWL4030_BASEADD_RTC		0x001C
 #define TWL4030_BASEADD_SECURED_REG	0x0000
 
-/* TWL4030 BCI registers */
-#define TWL4030_INTERRUPTS_BCIIMR1A	0x2
-#define TWL4030_INTERRUPTS_BCIIMR2A	0x3
-#define TWL4030_INTERRUPTS_BCIIMR1B	0x6
-#define TWL4030_INTERRUPTS_BCIIMR2B	0x7
-#define TWL4030_INTERRUPTS_BCIISR1A	0x0
-#define TWL4030_INTERRUPTS_BCIISR2A	0x1
-#define TWL4030_INTERRUPTS_BCIISR1B	0x4
-#define TWL4030_INTERRUPTS_BCIISR2B	0x5
-
-/* TWL4030 keypad registers */
-#define TWL4030_KEYPAD_KEYP_IMR1	0x12
-#define TWL4030_KEYPAD_KEYP_IMR2	0x14
-#define TWL4030_KEYPAD_KEYP_ISR1	0x11
-#define TWL4030_KEYPAD_KEYP_ISR2	0x13
-
-
 /* Triton Core internal information (END) */
 
+
 /* Few power values */
 #define R_CFG_BOOT			0x05
 #define R_PROTECT_KEY			0x0E
 
-/* access control */
+/* access control values for R_PROTECT_KEY */
 #define KEY_UNLOCK1			0xce
 #define KEY_UNLOCK2			0xec
 #define KEY_LOCK			0x00
 
+/* some fields in R_CFG_BOOT */
 #define HFCLK_FREQ_19p2_MHZ		(1 << 0)
 #define HFCLK_FREQ_26_MHZ		(2 << 0)
 #define HFCLK_FREQ_38p4_MHZ		(3 << 0)
 #define HIGH_PERF_SQ			(1 << 3)
 
-/* SIH_CTRL registers that aren't defined elsewhere */
-#define TWL4030_INTERRUPTS_BCISIHCTRL	0x0d
-#define TWL4030_MADC_MADC_SIH_CTRL	0x67
-#define TWL4030_KEYPAD_KEYP_SIH_CTRL	0x17
 
+/*----------------------------------------------------------------------*/
 
 /**
  * struct twl4030_mod_iregs - TWL module IMR/ISR regs to mask/clear at init
@@ -291,7 +284,7 @@ static const struct twl4030_mod_iregs __
 	},
 	{
 		.mod_no	  = TWL4030_MODULE_MADC,
-		.sih_ctrl = TWL4030_MADC_MADC_SIH_CTRL,
+		.sih_ctrl = TWL4030_MADC_SIH_CTRL,
 		.reg_cnt  = ARRAY_SIZE(twl4030_madc_imr_regs),
 		.imrs	  = twl4030_madc_imr_regs,
 		.isrs	  = twl4030_madc_isr_regs,
@@ -312,16 +305,15 @@ static const struct twl4030_mod_iregs __
 	},
 };
 
+/*----------------------------------------------------------------*/
 
-/* Data Structures */
-/* To have info on T2 IRQ substem activated or not */
-static struct completion irq_event;
+/* is driver active, bound to a chip? */
+static bool inuse;
 
-/* Structure to define on TWL4030 Slave ID */
+/* Structure for each TWL4030 Slave */
 struct twl4030_client {
 	struct i2c_client *client;
 	u8 address;
-	bool inuse;
 
 	/* max numb of i2c_msg required is for read =2 */
 	struct i2c_msg xfer_msg[2];
@@ -330,13 +322,15 @@ struct twl4030_client {
 	struct mutex xfer_lock;
 };
 
-/* Module Mapping */
+static struct twl4030_client twl4030_modules[TWL4030_NUM_SLAVES];
+
+
+/* mapping the module id to slave id and base address */
 struct twl4030mapping {
 	unsigned char sid;	/* Slave ID */
 	unsigned char base;	/* base address */
 };
 
-/* mapping the module id to slave id and base address */
 static struct twl4030mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
 	/*
 	 * NOTE:  don't change this table without updating the
@@ -344,38 +338,39 @@ static struct twl4030mapping twl4030_map
 	 * so they continue to match the order in this table.
 	 */
 
-	{ TWL4030_SLAVENUM_NUM0, TWL4030_BASEADD_USB },
+	{ 0, TWL4030_BASEADD_USB },
 
-	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_AUDIO_VOICE },
-	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_GPIO },
-	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_INTBR },
-	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_PIH },
-	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_TEST },
+	{ 1, TWL4030_BASEADD_AUDIO_VOICE },
+	{ 1, TWL4030_BASEADD_GPIO },
+	{ 1, TWL4030_BASEADD_INTBR },
+	{ 1, TWL4030_BASEADD_PIH },
+	{ 1, TWL4030_BASEADD_TEST },
 
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_KEYPAD },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_MADC },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_INTERRUPTS },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_LED },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_MAIN_CHARGE },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PRECHARGE },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PWM0 },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PWM1 },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PWMA },
-	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PWMB },
+	{ 2, TWL4030_BASEADD_KEYPAD },
+	{ 2, TWL4030_BASEADD_MADC },
+	{ 2, TWL4030_BASEADD_INTERRUPTS },
+	{ 2, TWL4030_BASEADD_LED },
+	{ 2, TWL4030_BASEADD_MAIN_CHARGE },
+	{ 2, TWL4030_BASEADD_PRECHARGE },
+	{ 2, TWL4030_BASEADD_PWM0 },
+	{ 2, TWL4030_BASEADD_PWM1 },
+	{ 2, TWL4030_BASEADD_PWMA },
+	{ 2, TWL4030_BASEADD_PWMB },
 
-	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_BACKUP },
-	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_INT },
-	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_PM_MASTER },
-	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_PM_RECEIVER },
-	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_RTC },
-	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_SECURED_REG },
+	{ 3, TWL4030_BASEADD_BACKUP },
+	{ 3, TWL4030_BASEADD_INT },
+	{ 3, TWL4030_BASEADD_PM_MASTER },
+	{ 3, TWL4030_BASEADD_PM_RECEIVER },
+	{ 3, TWL4030_BASEADD_RTC },
+	{ 3, TWL4030_BASEADD_SECURED_REG },
 };
 
-static struct twl4030_client twl4030_modules[TWL4030_NUM_SLAVES];
+/*----------------------------------------------------------------------*/
 
 /*
  * TWL4030 doesn't have PIH mask, hence dummy function for mask
- * and unmask.
+ * and unmask of the (eight) interrupts reported at that level ...
+ * masking is only available from SIH (secondary) modules.
  */
 
 static void twl4030_i2c_ackirq(unsigned int irq)
@@ -390,7 +385,6 @@ static void twl4030_i2c_enableint(unsign
 {
 }
 
-/* information for processing in the Work Item */
 static struct irq_chip twl4030_irq_chip = {
 	.name	= "twl4030",
 	.ack	= twl4030_i2c_ackirq,
@@ -398,7 +392,9 @@ static struct irq_chip twl4030_irq_chip 
 	.unmask	= twl4030_i2c_enableint,
 };
 
-/* Global Functions */
+/*----------------------------------------------------------------------*/
+
+/* Exported Functions */
 
 /**
  * twl4030_i2c_write - Writes a n bit register in TWL4030
@@ -426,7 +422,7 @@ int twl4030_i2c_write(u8 mod_no, u8 *val
 	sid = twl4030_map[mod_no].sid;
 	twl = &twl4030_modules[sid];
 
-	if (unlikely(!twl->inuse)) {
+	if (unlikely(!inuse)) {
 		pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
 		return -EPERM;
 	}
@@ -476,7 +472,7 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
 	sid = twl4030_map[mod_no].sid;
 	twl = &twl4030_modules[sid];
 
-	if (unlikely(!twl->inuse)) {
+	if (unlikely(!inuse)) {
 		pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
 		return -EPERM;
 	}
@@ -537,12 +533,12 @@ int twl4030_i2c_read_u8(u8 mod_no, u8 *v
 }
 EXPORT_SYMBOL(twl4030_i2c_read_u8);
 
-/* Helper Functions */
+/*----------------------------------------------------------------------*/
 
 /*
  * do_twl4030_module_irq() is the desc->handle method for each of the twl4030
- * module interrupts.  It executes in kernel thread context.
- * On entry, cpu interrupts are disabled.
+ * module interrupts that doesn't chain to another irq_chip (GPIO, power, etc).
+ * It executes in kernel thread context.  On entry, cpu interrupts are disabled.
  */
 static void do_twl4030_module_irq(unsigned int irq, irq_desc_t *desc)
 {
@@ -603,10 +599,10 @@ static void do_twl4030_module_irq(unsign
 
 static unsigned twl4030_irq_base;
 
+static struct completion irq_event;
+
 /*
- * twl4030_irq_thread() runs as a kernel thread.  It queries the twl4030
- * interrupt controller to see which modules are generating interrupt requests
- * and then calls the desc->handle method for each module requesting service.
+ * This thread processes interrupts reported by the Primary Interrupt Handler.
  */
 static int twl4030_irq_thread(void *data)
 {
@@ -623,34 +619,36 @@ static int twl4030_irq_thread(void *data
 		int module_irq;
 		u8 pih_isr;
 
+		/* Wait for IRQ, then read PIH irq status (also blocking) */
 		wait_for_completion_interruptible(&irq_event);
 
 		ret = twl4030_i2c_read_u8(TWL4030_MODULE_PIH, &pih_isr,
 					  REG_PIH_ISR_P1);
 		if (ret) {
-			printk(KERN_WARNING "I2C error %d while reading TWL4030"
-					" PIH ISR register.\n", ret);
+			pr_warning("%s: I2C error %d reading PIH ISR\n",
+					DRIVER_NAME, ret);
 			if (++i2c_errors >= max_i2c_errors) {
 				printk(KERN_ERR "Maximum I2C error count"
 						" exceeded.  Terminating %s.\n",
 						__func__);
 				break;
 			}
+			complete(&irq_event);
 			continue;
 		}
 
-		for (module_irq = twl4030_irq_base; 0 != pih_isr;
-			 pih_isr >>= 1, module_irq++) {
+		/* these handlers deal with the relevant SIH irq status */
+		local_irq_disable();
+		for (module_irq = twl4030_irq_base;
+				pih_isr;
+				pih_isr >>= 1, module_irq++) {
 			if (pih_isr & 0x1) {
 				irq_desc_t *d = irq_desc + module_irq;
 
-				local_irq_disable();
-
 				d->handle_irq(module_irq, d);
-
-				local_irq_enable();
 			}
 		}
+		local_irq_enable();
 
 		desc->chip->unmask(irq);
 	}
@@ -688,6 +686,22 @@ static void do_twl4030_irq(unsigned int 
 	}
 }
 
+static struct task_struct * __init start_twl4030_irq_thread(long irq)
+{
+	struct task_struct *thread;
+
+	init_completion(&irq_event);
+	thread = kthread_run(twl4030_irq_thread, (void *)irq,
+			     "twl4030 irq %ld", irq);
+	if (!thread)
+		pr_err("%s: could not create twl4030 irq %ld thread!\n",
+		       DRIVER_NAME, irq);
+
+	return thread;
+}
+
+/*----------------------------------------------------------------------*/
+
 static int add_children(struct twl4030_platform_data *pdata)
 {
 	struct platform_device	*pdev = NULL;
@@ -695,7 +709,7 @@ static int add_children(struct twl4030_p
 	int			status = 0;
 
 	if (twl_has_bci() && pdata->bci) {
-		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+		twl = &twl4030_modules[3];
 
 		pdev = platform_device_alloc("twl4030_bci", -1);
 		if (!pdev) {
@@ -738,7 +752,7 @@ static int add_children(struct twl4030_p
 	}
 
 	if (twl_has_gpio() && pdata->gpio) {
-		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM1];
+		twl = &twl4030_modules[1];
 
 		pdev = platform_device_alloc("twl4030_gpio", -1);
 		if (!pdev) {
@@ -787,7 +801,7 @@ static int add_children(struct twl4030_p
 	if (twl_has_keypad() && pdata->keypad) {
 		pdev = platform_device_alloc("twl4030_keypad", -1);
 		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
+			twl = &twl4030_modules[2];
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
 			status = platform_device_add_data(pdev, pdata->keypad,
@@ -817,7 +831,7 @@ static int add_children(struct twl4030_p
 	if (twl_has_madc() && pdata->madc) {
 		pdev = platform_device_alloc("twl4030_madc", -1);
 		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
+			twl = &twl4030_modules[2];
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
 			status = platform_device_add_data(pdev, pdata->madc,
@@ -845,7 +859,7 @@ static int add_children(struct twl4030_p
 	}
 
 	if (twl_has_rtc()) {
-		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+		twl = &twl4030_modules[3];
 
 		pdev = platform_device_alloc("twl4030_rtc", -1);
 		if (!pdev) {
@@ -888,7 +902,7 @@ static int add_children(struct twl4030_p
 	}
 
 	if (twl_has_usb() && pdata->usb) {
-		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM0];
+		twl = &twl4030_modules[0];
 
 		pdev = platform_device_alloc("twl4030_usb", -1);
 		if (!pdev) {
@@ -937,25 +951,14 @@ err:
 	return status;
 }
 
-static struct task_struct * __init start_twl4030_irq_thread(long irq)
-{
-	struct task_struct *thread;
-
-	init_completion(&irq_event);
-	thread = kthread_run(twl4030_irq_thread, (void *)irq,
-			     "twl4030 irq %ld", irq);
-	if (!thread)
-		pr_err("%s: could not create twl4030 irq %ld thread!\n",
-		       DRIVER_NAME, irq);
-
-	return thread;
-}
+/*----------------------------------------------------------------------*/
 
 /*
- * These three functions should be part of Voltage frame work
- * added here to complete the functionality for now.
+ * These three functions initialize the on-chip clock framework,
+ * letting it generate the right frequencies for USB, MADC, and
+ * other purposes.
  */
-static int __init protect_pm_master(void)
+static inline int __init protect_pm_master(void)
 {
 	int e = 0;
 
@@ -964,7 +967,7 @@ static int __init protect_pm_master(void
 	return e;
 }
 
-static int __init unprotect_pm_master(void)
+static inline int __init unprotect_pm_master(void)
 {
 	int e = 0;
 
@@ -975,7 +978,7 @@ static int __init unprotect_pm_master(vo
 	return e;
 }
 
-static int __init power_companion_init(void)
+static void __init clocks_init(void)
 {
 	int e = 0;
 	struct clk *osc;
@@ -988,12 +991,15 @@ static int __init power_companion_init(v
 	else
 		osc = clk_get(NULL, "osc_sys_ck");
 #else
+	/* REVISIT for non-OMAP systems, pass the clock rate from
+	 * board init code, using platform_data.
+	 */
 	osc = ERR_PTR(-EIO);
 #endif
 	if (IS_ERR(osc)) {
 		printk(KERN_WARNING "Skipping twl4030 internal clock init and "
 				"using bootloader value (unknown osc rate)\n");
-		return 0;
+		return;
 	}
 
 	rate = clk_get_rate(osc);
@@ -1017,9 +1023,12 @@ static int __init power_companion_init(v
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
 
-	return e;
+	if (e < 0)
+		pr_err("%s: clock init err [%d]\n", DRIVER_NAME, e);
 }
 
+/*----------------------------------------------------------------------*/
+
 /**
  * twl4030_i2c_clear_isr - clear TWL4030 SIH ISR regs via read + write
  * @mod_no: TWL4030 module number
@@ -1098,16 +1107,12 @@ static void __init twl4030_mask_clear_in
 						      tmr.isrs[j], cor) < 0);
 		}
 	}
-
-	return;
 }
 
 
 static void twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 {
 	int	i;
-	int	res = 0;
-	char	*msg = "Unable to register interrupt subsystem";
 
 	/*
 	 * Mask and clear all TWL4030 interrupts since initially we do
@@ -1127,12 +1132,7 @@ static void twl_init_irq(int irq_num, un
 
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
 	set_irq_data(irq_num, start_twl4030_irq_thread(irq_num));
-	set_irq_type(irq_num, IRQ_TYPE_EDGE_FALLING);
 	set_irq_chained_handler(irq_num, do_twl4030_irq);
-
-	res = power_companion_init();
-	if (res < 0)
-		pr_err("%s: %s[%d]\n", DRIVER_NAME, msg, res);
 }
 
 /*----------------------------------------------------------------------*/
@@ -1153,8 +1153,8 @@ static int twl4030_remove(struct i2c_cli
 		if (twl->client && twl->client != client)
 			i2c_unregister_device(twl->client);
 		twl4030_modules[i].client = NULL;
-		twl4030_modules[i].inuse = false;
 	}
+	inuse = false;
 	return 0;
 }
 
@@ -1176,11 +1176,9 @@ twl4030_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
-		if (twl4030_modules[i].inuse || twl4030_irq_base) {
-			dev_dbg(&client->dev, "driver is already in use\n");
-			return -EBUSY;
-		}
+	if (inuse || twl4030_irq_base) {
+		dev_dbg(&client->dev, "driver is already in use\n");
+		return -EBUSY;
 	}
 
 	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
@@ -1201,17 +1199,15 @@ twl4030_probe(struct i2c_client *client,
 			strlcpy(twl->client->name, id->name,
 					sizeof(twl->client->name));
 		}
-		twl->inuse = true;
 		mutex_init(&twl->xfer_lock);
 	}
+	inuse = true;
 
-	/*
-	 * Check if the PIH module is initialized, if yes, then init
-	 * the T2 Interrupt subsystem
-	 */
-	if (twl4030_modules[twl4030_map[TWL4030_MODULE_PIH].sid].inuse
-			&& twl4030_irq_base == 0
-			&& client->irq
+	/* setup clock framework */
+	clocks_init();
+
+	/* Maybe init the T2 Interrupt subsystem */
+	if (client->irq
 			&& pdata->irq_base
 			&& pdata->irq_end > pdata->irq_base) {
 		twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
@@ -1231,6 +1227,7 @@ static const struct i2c_device_id twl403
 	{ "tps65950", 0 },	/* catalog version of twl4030 */
 	{ "tps65930", 0 },	/* fewer LDOs and DACs; no charger */
 	{ "tps65920", 0 },	/* fewer LDOs; no codec or charger */
+	{ "twl5030", 0 },	/* T2 updated */
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(i2c, twl4030_ids);
--- a/include/linux/i2c/twl4030-madc.h
+++ b/include/linux/i2c/twl4030-madc.h
@@ -75,14 +75,6 @@ enum sample_type {
 #define TWL4030_MADC_RTCH0_LSB		0x17
 #define TWL4030_MADC_GPCH0_LSB		0x37
 
-#define TWL4030_MADC_ISR1		0x61
-#define TWL4030_MADC_IMR1		0x62
-#define TWL4030_MADC_ISR2		0x63
-#define TWL4030_MADC_IMR2		0x64
-#define TWL4030_MADC_SIR		0x65
-#define TWL4030_MADC_EDR		0x66
-#define TWL4030_MADC_SIH_CTRL		0x67
-
 #define TWL4030_MADC_MADCON		(1<<0)	/* MADC power on */
 #define TWL4030_MADC_BUSY		(1<<0)	/* MADC busy */
 #define TWL4030_MADC_EOC_SW		(1<<1)	/* MADC conversion completion */
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -153,6 +153,57 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
 /*----------------------------------------------------------------------*/
 
 /*
+ * Keypad register offsets (use TWL4030_MODULE_KEYPAD)
+ * ... SIH/interrupt only
+ */
+
+#define TWL4030_KEYPAD_KEYP_ISR1	0x11
+#define TWL4030_KEYPAD_KEYP_IMR1	0x12
+#define TWL4030_KEYPAD_KEYP_ISR2	0x13
+#define TWL4030_KEYPAD_KEYP_IMR2	0x14
+#define TWL4030_KEYPAD_KEYP_SIR		0x15	/* test register */
+#define TWL4030_KEYPAD_KEYP_EDR		0x16
+#define TWL4030_KEYPAD_KEYP_SIH_CTRL	0x17
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * Multichannel ADC register offsets (use TWL4030_MODULE_MADC)
+ * ... SIH/interrupt only
+ */
+
+#define TWL4030_MADC_ISR1		0x61
+#define TWL4030_MADC_IMR1		0x62
+#define TWL4030_MADC_ISR2		0x63
+#define TWL4030_MADC_IMR2		0x64
+#define TWL4030_MADC_SIR		0x65	/* test register */
+#define TWL4030_MADC_EDR		0x66
+#define TWL4030_MADC_SIH_CTRL		0x67
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * Battery charger register offsets (use TWL4030_MODULE_INTERRUPTS)
+ */
+
+#define TWL4030_INTERRUPTS_BCIISR1A	0x0
+#define TWL4030_INTERRUPTS_BCIISR2A	0x1
+#define TWL4030_INTERRUPTS_BCIIMR1A	0x2
+#define TWL4030_INTERRUPTS_BCIIMR2A	0x3
+#define TWL4030_INTERRUPTS_BCIISR1B	0x4
+#define TWL4030_INTERRUPTS_BCIISR2B	0x5
+#define TWL4030_INTERRUPTS_BCIIMR1B	0x6
+#define TWL4030_INTERRUPTS_BCIIMR2B	0x7
+#define TWL4030_INTERRUPTS_BCISIR1	0x8	/* test register */
+#define TWL4030_INTERRUPTS_BCISIR2	0x9	/* test register */
+#define TWL4030_INTERRUPTS_BCIEDR1	0xa
+#define TWL4030_INTERRUPTS_BCIEDR2	0xb
+#define TWL4030_INTERRUPTS_BCIEDR3	0xc
+#define TWL4030_INTERRUPTS_BCISIHCTRL	0xd
+
+/*----------------------------------------------------------------------*/
+
+/*
  * Power Interrupt block register offsets (use TWL4030_MODULE_INT)
  */
 
