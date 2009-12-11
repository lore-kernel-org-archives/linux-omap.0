From: balajitk@ti.com
Subject: [PATCH v4 05/08] OMAP4: PMIC: Add support for twl6030 irq framework
Date: Fri, 11 Dec 2009 21:36:12 +0530
Message-ID: <1260547572-23860-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933481AbZLKQGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 11:06:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, tony@atomide.com, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Balaji T K <balajitk@ti.com>

This version of patch series enables RUN TIME selection of TWL4030 or TWL6030.
CONFIG_TWL4030_CORE and CONFIG_TWL6030_CORE is replaced by CONFIG_TWL4030_CORE

This patch adds support for phoenix interrupt framework. New Interrupt status
register A, B, C are introduced in Phoenix and are cleared on write.
Due to difference in interrupt handling with respect to TWL4030,
twl6030-irq.c is created for TWL6030 PMIC

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |   16 ++-
 drivers/mfd/Kconfig                    |    4 +-
 drivers/mfd/Makefile                   |    2 +-
 drivers/mfd/twl-core.c                 |  113 +++++++++++--
 drivers/mfd/twl4030-irq.c              |    4 +-
 drivers/mfd/twl6030-irq.c              |  297 ++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h                |   64 +++++++
 7 files changed, 482 insertions(+), 18 deletions(-)
 create mode 100644 drivers/mfd/twl6030-irq.c

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index ce5dd2d..97d6c50 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -472,8 +472,22 @@
 #endif
 #define TWL4030_GPIO_IRQ_END	(TWL4030_GPIO_IRQ_BASE + TWL4030_GPIO_NR_IRQS)
 
+#define	TWL6030_IRQ_BASE	(OMAP_FPGA_IRQ_END)
+#ifdef CONFIG_TWL4030_CORE
+#define	TWL6030_BASE_NR_IRQS	20
+#else
+#define	TWL6030_BASE_NR_IRQS	0
+#endif
+#define TWL6030_IRQ_END		(TWL6030_IRQ_BASE + TWL6030_BASE_NR_IRQS)
+
 /* Total number of interrupts depends on the enabled blocks above */
-#define NR_IRQS			TWL4030_GPIO_IRQ_END
+#if (TWL4030_GPIO_IRQ_END > TWL6030_IRQ_END)
+#define TWL_IRQ_END 		TWL4030_GPIO_IRQ_END
+#else
+#define TWL_IRQ_END		TWL6030_IRQ_END
+#endif
+
+#define NR_IRQS			TWL_IRQ_END
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 08f2d07..9ee2ea4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -95,10 +95,10 @@ config MENELAUS
 	  cell phones and PDAs.
 
 config TWL4030_CORE
-	bool "Texas Instruments TWL4030/TPS659x0 Support"
+	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y && GENERIC_HARDIRQS
 	help
-	  Say yes here if you have TWL4030 family chip on your board.
+	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
 	  This core driver provides register access and IRQ handling
 	  facilities, and registers devices for the various functions
 	  so that function-specific drivers can bind to them.
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 986adfc..5f7fc28 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 
-obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o
+obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
 obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 obj-$(CONFIG_TWL4030_CODEC)	+= twl4030-codec.o
 
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d7f2bbd..3d67321 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -177,6 +177,30 @@
 /* Triton Core internal information (END) */
 
 
+/* subchip/slave 0 0x48 - POWER */
+#define TWL6030_BASEADD_RTC		0x0000
+#define TWL6030_BASEADD_MEM		0x0017
+#define TWL6030_BASEADD_PM_MASTER	0x001F
+#define TWL6030_BASEADD_PM_SLAVE_MISC	0x0030 /* PM_RECEIVER */
+#define TWL6030_BASEADD_PM_MISC		0x00E2
+#define TWL6030_BASEADD_PM_PUPD		0x00F0
+
+/* subchip/slave 1 0x49 - FEATURE */
+#define TWL6030_BASEADD_USB		0x0000
+#define TWL6030_BASEADD_GPADC_CTRL	0x002E
+#define TWL6030_BASEADD_AUX		0x0090
+#define TWL6030_BASEADD_PWM		0x00BA
+#define TWL6030_BASEADD_GASGAUGE	0x00C0
+#define TWL6030_BASEADD_PIH		0x00D0
+#define TWL6030_BASEADD_CHARGER		0x00E0
+
+/* subchip/slave 2 0x4A - DFT */
+#define TWL6030_BASEADD_DIEID		0x00C0
+
+/* subchip/slave 3 0x4B - AUDIO */
+#define TWL6030_BASEADD_AUDIO		0x0000
+#define TWL6030_BASEADD_RSV		0x0000
+
 /* Few power values */
 #define R_CFG_BOOT			0x05
 #define R_PROTECT_KEY			0x0E
@@ -196,13 +220,19 @@
 /* chip-specific feature flags, for i2c_device_id.driver_data */
 #define TWL4030_VAUX2		BIT(0)	/* pre-5030 voltage ranges */
 #define TPS_SUBSET		BIT(1)	/* tps659[23]0 have fewer LDOs */
+#define TWL6030_CLASS		BIT(3)	/* TWL6030 class */
 
 /*----------------------------------------------------------------------*/
 
 /* is driver active, bound to a chip? */
 static bool inuse;
 
-/* Structure for each TWL4030 Slave */
+static unsigned int twl_id;
+unsigned int twl_rev(void)
+{
+	return twl_id;
+}
+/* Structure for each TWL4030/TWL6030 Slave */
 struct twl_client {
 	struct i2c_client *client;
 	u8 address;
@@ -222,11 +252,12 @@ struct twl_mapping {
 	unsigned char sid;	/* Slave ID */
 	unsigned char base;	/* base address */
 };
+struct twl_mapping *twl_map;
 
 static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
 	/*
 	 * NOTE:  don't change this table without updating the
-	 * <linux/i2c/twl4030.h> defines for TWL4030_MODULE_*
+	 * <linux/i2c/twl.h> defines for TWL4030_MODULE_*
 	 * so they continue to match the order in this table.
 	 */
 
@@ -257,6 +288,40 @@ static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
 	{ 3, TWL4030_BASEADD_SECURED_REG },
 };
 
+static struct twl_mapping twl6030_map[] = {
+	/*
+	 * NOTE:  don't change this table without updating the
+	 * <linux/i2c/twl.h> defines for TWL4030_MODULE_*
+	 * so they continue to match the order in this table.
+	 */
+	{ SUB_CHIP_ID1, TWL6030_BASEADD_USB },
+	{ SUB_CHIP_ID3, TWL6030_BASEADD_AUDIO },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_DIEID },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID1, TWL6030_BASEADD_PIH },
+
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID1, TWL6030_BASEADD_GPADC_CTRL },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+
+	{ SUB_CHIP_ID1, TWL6030_BASEADD_CHARGER },
+	{ SUB_CHIP_ID1, TWL6030_BASEADD_GASGAUGE },
+	{ SUB_CHIP_ID1, TWL6030_BASEADD_PWM },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_MASTER },
+	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_SLAVE_MISC },
+
+	{ SUB_CHIP_ID0, TWL6030_BASEADD_RTC },
+	{ SUB_CHIP_ID0, TWL6030_BASEADD_MEM },
+};
+
 /*----------------------------------------------------------------------*/
 
 /* Exported Functions */
@@ -284,7 +349,7 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
-	sid = twl4030_map[mod_no].sid;
+	sid = twl_map[mod_no].sid;
 	twl = &twl_modules[sid];
 
 	if (unlikely(!inuse)) {
@@ -302,7 +367,7 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 	msg->flags = 0;
 	msg->buf = value;
 	/* over write the first byte of buffer with the register address */
-	*value = twl4030_map[mod_no].base + reg;
+	*value = twl_map[mod_no].base + reg;
 	ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 1);
 	mutex_unlock(&twl->xfer_lock);
 
@@ -334,7 +399,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
-	sid = twl4030_map[mod_no].sid;
+	sid = twl_map[mod_no].sid;
 	twl = &twl_modules[sid];
 
 	if (unlikely(!inuse)) {
@@ -347,7 +412,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 	msg->addr = twl->address;
 	msg->len = 1;
 	msg->flags = 0;	/* Read the register value */
-	val = twl4030_map[mod_no].base + reg;
+	val = twl_map[mod_no].base + reg;
 	msg->buf = &val;
 	/* [MSG2] fill the data rx buffer */
 	msg = &twl->xfer_msg[1];
@@ -464,6 +529,7 @@ add_regulator_linked(int num, struct regulator_init_data *pdata,
 		struct regulator_consumer_supply *consumers,
 		unsigned num_consumers)
 {
+	unsigned sub_chip_id;
 	/* regulator framework demands init_data ... */
 	if (!pdata)
 		return NULL;
@@ -474,7 +540,8 @@ add_regulator_linked(int num, struct regulator_init_data *pdata,
 	}
 
 	/* NOTE:  we currently ignore regulator IRQs, e.g. for short circuits */
-	return add_numbered_child(3, "twl_reg", num,
+	sub_chip_id = twl_map[TWL_MODULE_PM_MASTER].sid;
+	return add_numbered_child(sub_chip_id, "twl_reg", num,
 		pdata, sizeof(*pdata), false, 0, 0);
 }
 
@@ -494,6 +561,7 @@ static int
 add_children(struct twl4030_platform_data *pdata, unsigned long features)
 {
 	struct device	*child;
+	unsigned sub_chip_id;
 
 	if (twl_has_bci() && pdata->bci && !(features & TPS_SUBSET)) {
 		child = add_child(3, "twl4030_bci",
@@ -538,7 +606,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		 * Eventually, Linux might become more aware of such
 		 * HW security concerns, and "least privilege".
 		 */
-		child = add_child(3, "twl_rtc",
+		sub_chip_id = twl_map[TWL_MODULE_RTC].sid;
+		child = add_child(sub_chip_id, "twl_rtc",
 				NULL, 0,
 				true, pdata->irq_base + RTC_INTR_OFFSET, 0);
 		if (IS_ERR(child))
@@ -763,15 +832,21 @@ static void clocks_init(struct device *dev)
 
 /*----------------------------------------------------------------------*/
 
-int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
-int twl_exit_irq(void);
+int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+int twl4030_exit_irq(void);
+int twl6030_exit_irq(void);
 
 static int twl_remove(struct i2c_client *client)
 {
 	unsigned i;
 	int status;
 
-	status = twl_exit_irq();
+	if (twl_class_is_4030())
+		status = twl4030_exit_irq();
+	else
+		status = twl6030_exit_irq();
+
 	if (status < 0)
 		return status;
 
@@ -830,6 +905,13 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		mutex_init(&twl->xfer_lock);
 	}
 	inuse = true;
+	if ((id->driver_data) & TWL6030_CLASS) {
+		twl_id = TWL6030_CLASS_ID;
+		twl_map = &twl6030_map[0];
+	} else {
+		twl_id = TWL4030_CLASS_ID;
+		twl_map = &twl4030_map[0];
+	}
 
 	/* setup clock framework */
 	clocks_init(&client->dev);
@@ -842,7 +924,13 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (client->irq
 			&& pdata->irq_base
 			&& pdata->irq_end > pdata->irq_base) {
-		status = twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
+		if (twl_class_is_4030()) {
+			status = twl4030_init_irq(client->irq, pdata->irq_base,
+			pdata->irq_end);
+		} else {
+			status = twl6030_init_irq(client->irq, pdata->irq_base,
+			pdata->irq_end);
+		}
 		if (status < 0)
 			goto fail;
 	}
@@ -860,6 +948,7 @@ static const struct i2c_device_id twl_ids[] = {
 	{ "tps65950", 0 },		/* catalog version of twl5030 */
 	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
 	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
+	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(i2c, twl_ids);
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index ef04922..94a29e8 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -668,7 +668,7 @@ int twl4030_sih_setup(int module)
 /* FIXME pass in which interrupt line we'll use ... */
 #define twl_irq_line	0
 
-int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
+int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 {
 	static struct irq_chip	twl4030_irq_chip;
 
@@ -747,7 +747,7 @@ fail:
 	return status;
 }
 
-int twl_exit_irq(void)
+int twl4030_exit_irq(void)
 {
 	/* FIXME undo twl_init_irq() */
 	if (twl4030_irq_base) {
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
new file mode 100644
index 0000000..b8d7d9d
--- /dev/null
+++ b/drivers/mfd/twl6030-irq.c
@@ -0,0 +1,297 @@
+/*
+ * twl6030-irq.c - TWL6030 irq support
+ *
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ *
+ * Modifications to defer interrupt handling to a kernel thread:
+ * Copyright (C) 2006 MontaVista Software, Inc.
+ *
+ * Based on tlv320aic23.c:
+ * Copyright (c) by Kai Svahn <kai.svahn@nokia.com>
+ *
+ * Code cleanup and modifications to IRQ handler.
+ * by syed khasim <x0khasim@ti.com>
+ *
+ * TWL6030 specific code and IRQ handling changes by
+ * Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
+ * Balaji T K <balajitk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kthread.h>
+#include <linux/i2c/twl.h>
+
+/*
+ * TWL6030 (unlike its predecessors, which had two level interrupt handling)
+ * three interrupt registers INT_STS_A, INT_STS_B and INT_STS_C.
+ * It exposes status bits saying who has raised an interrupt. There are
+ * three mask registers that corresponds to these status registers, that
+ * enables/disables these interrupts.
+ *
+ * We set up IRQs starting at a platform-specified base. An interrupt map table,
+ * specifies mapping between interrupt number and the associated module.
+ *
+ */
+
+static int twl6030_interrupt_mapping[24] = {
+	PWR_INTR_OFFSET,	/* Bit 0	PWRON			*/
+	PWR_INTR_OFFSET,	/* Bit 1	RPWRON			*/
+	PWR_INTR_OFFSET,	/* Bit 2	BAT_VLOW		*/
+	RTC_INTR_OFFSET,	/* Bit 3	RTC_ALARM		*/
+	RTC_INTR_OFFSET,	/* Bit 4	RTC_PERIOD		*/
+	HOTDIE_INTR_OFFSET,	/* Bit 5	HOT_DIE			*/
+	SMPSLDO_INTR_OFFSET,	/* Bit 6	VXXX_SHORT		*/
+	SMPSLDO_INTR_OFFSET,	/* Bit 7	VMMC_SHORT		*/
+
+	SMPSLDO_INTR_OFFSET,	/* Bit 8	VUSIM_SHORT		*/
+	BATDETECT_INTR_OFFSET,	/* Bit 9	BAT			*/
+	SIMDETECT_INTR_OFFSET,	/* Bit 10	SIM			*/
+	MMCDETECT_INTR_OFFSET,	/* Bit 11	MMC			*/
+	RSV_INTR_OFFSET,  	/* Bit 12	Reserved		*/
+	MADC_INTR_OFFSET,	/* Bit 13	GPADC_RT_EOC		*/
+	MADC_INTR_OFFSET,	/* Bit 14	GPADC_SW_EOC		*/
+	GASGAUGE_INTR_OFFSET,	/* Bit 15	CC_AUTOCAL		*/
+
+	USBOTG_INTR_OFFSET,	/* Bit 16	ID_WKUP			*/
+	USBOTG_INTR_OFFSET,	/* Bit 17	VBUS_WKUP		*/
+	USBOTG_INTR_OFFSET,	/* Bit 18	ID			*/
+	USBOTG_INTR_OFFSET,	/* Bit 19	VBUS			*/
+	CHARGER_INTR_OFFSET,	/* Bit 20	CHRG_CTRL		*/
+	CHARGER_INTR_OFFSET,	/* Bit 21	EXT_CHRG		*/
+	CHARGER_INTR_OFFSET,	/* Bit 22	INT_CHRG		*/
+	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
+};
+/*----------------------------------------------------------------------*/
+
+static unsigned twl6030_irq_base;
+
+static struct completion irq_event;
+
+/*
+ * This thread processes interrupts reported by the Primary Interrupt Handler.
+ */
+static int twl6030_irq_thread(void *data)
+{
+	long irq = (long)data;
+	static unsigned i2c_errors;
+	static const unsigned max_i2c_errors = 100;
+	int ret;
+
+	current->flags |= PF_NOFREEZE;
+
+	while (!kthread_should_stop()) {
+		int i;
+		union {
+		u8 bytes[4];
+		u32 int_sts;
+		} sts;
+
+		/* Wait for IRQ, then read PIH irq status (also blocking) */
+		wait_for_completion_interruptible(&irq_event);
+
+		/* read INT_STS_A, B and C in one shot using a burst read */
+		ret = twl_i2c_read(TWL_MODULE_PIH, sts.bytes,
+				REG_INT_STS_A, 3);
+		if (ret) {
+			pr_warning("twl6030: I2C error %d reading PIH ISR\n",
+					ret);
+			if (++i2c_errors >= max_i2c_errors) {
+				printk(KERN_ERR "Maximum I2C error count"
+						" exceeded.  Terminating %s.\n",
+						__func__);
+				break;
+			}
+			complete(&irq_event);
+			continue;
+		}
+
+
+
+		sts.bytes[3] = 0; /* Only 24 bits are valid*/
+
+		for (i = 0; sts.int_sts; sts.int_sts >>= 1, i++) {
+			local_irq_disable();
+			if (sts.int_sts & 0x1) {
+				int module_irq = TWL6030_IRQ_BASE +
+					twl6030_interrupt_mapping[i];
+				struct irq_desc *d = irq_to_desc(module_irq);
+
+				if (!d) {
+					pr_err("twl6030: Invalid SIH IRQ: %d\n",
+					       module_irq);
+					return -EINVAL;
+				}
+
+				/* These can't be masked ... always warn
+				 * if we get any surprises.
+				 */
+				if (d->status & IRQ_DISABLED)
+					note_interrupt(module_irq, d,
+							IRQ_NONE);
+				else
+					d->handle_irq(module_irq, d);
+
+			}
+		local_irq_enable();
+		}
+		ret = twl_i2c_write(TWL_MODULE_PIH, sts.bytes,
+				REG_INT_STS_A, 3); /* clear INT_STS_A */
+		if (ret)
+			pr_warning("twl6030: I2C error in clearing PIH ISR\n");
+
+		enable_irq(irq);
+	}
+
+	return 0;
+}
+
+/*
+ * handle_twl6030_int() is the desc->handle method for the twl6030 interrupt.
+ * This is a chained interrupt, so there is no desc->action method for it.
+ * Now we need to query the interrupt controller in the twl6030 to determine
+ * which module is generating the interrupt request.  However, we can't do i2c
+ * transactions in interrupt context, so we must defer that work to a kernel
+ * thread.  All we do here is acknowledge and mask the interrupt and wakeup
+ * the kernel thread.
+ */
+static irqreturn_t handle_twl6030_pih(int irq, void *devid)
+{
+	disable_irq_nosync(irq);
+	complete(devid);
+	return IRQ_HANDLED;
+}
+
+/*----------------------------------------------------------------------*/
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
+}
+
+/*----------------------------------------------------------------------*/
+
+static unsigned twl6030_irq_next;
+
+/*----------------------------------------------------------------------*/
+int twl6030_interrupt_unmask(u8 bit_mask, u8 offset)
+{
+	int ret;
+	u8 unmask_value;
+	ret = twl_i2c_read_u8(TWL_MODULE_PIH, &unmask_value,
+			REG_INT_STS_A + offset);
+	unmask_value &= (~(bit_mask));
+	ret |= twl_i2c_write_u8(TWL_MODULE_PIH, unmask_value,
+			REG_INT_STS_A + offset); /* unmask INT_MSK_A/B/C */
+	return ret;
+}
+
+int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
+{
+	int ret;
+	u8 mask_value;
+	ret = twl_i2c_read_u8(TWL_MODULE_PIH, &mask_value,
+			REG_INT_STS_A + offset);
+	mask_value |= (bit_mask);
+	ret |= twl_i2c_write_u8(TWL_MODULE_PIH, mask_value,
+			REG_INT_STS_A + offset); /* mask INT_MSK_A/B/C */
+	return ret;
+}
+
+int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
+{
+
+	int	status = 0;
+	int	i;
+	struct task_struct	*task;
+	int ret;
+	u8 mask[4];
+
+	static struct irq_chip	twl6030_irq_chip;
+	mask[1] = 0xFF;
+	mask[2] = 0xFF;
+	mask[3] = 0xFF;
+	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
+			REG_INT_MSK_LINE_A, 3); /* MASK ALL INT LINES */
+	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
+			REG_INT_MSK_STS_A, 3); /* MASK ALL INT STS */
+	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
+			REG_INT_STS_A, 3); /* clear INT_STS_A,B,C */
+
+	twl6030_irq_base = irq_base;
+
+	/* install an irq handler for each of the modules;
+	 * clone dummy irq_chip since PIH can't *do* anything
+	 */
+	twl6030_irq_chip = dummy_irq_chip;
+	twl6030_irq_chip.name = "twl6030";
+	twl6030_irq_chip.set_type = NULL;
+
+	for (i = irq_base; i < irq_end; i++) {
+		set_irq_chip_and_handler(i, &twl6030_irq_chip,
+				handle_simple_irq);
+		activate_irq(i);
+	}
+
+	twl6030_irq_next = i;
+	pr_info("twl6030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
+			irq_num, irq_base, twl6030_irq_next - 1);
+
+	/* install an irq handler to demultiplex the TWL6030 interrupt */
+	init_completion(&irq_event);
+	task = kthread_run(twl6030_irq_thread, (void *)irq_num, "twl6030-irq");
+	if (IS_ERR(task)) {
+		pr_err("twl6030: could not create irq %d thread!\n", irq_num);
+		status = PTR_ERR(task);
+		goto fail_kthread;
+	}
+
+	status = request_irq(irq_num, handle_twl6030_pih, IRQF_DISABLED,
+				"TWL6030-PIH", &irq_event);
+	if (status < 0) {
+		pr_err("twl6030: could not claim irq%d: %d\n", irq_num, status);
+		goto fail_irq;
+	}
+	return status;
+fail_irq:
+	free_irq(irq_num, &irq_event);
+
+fail_kthread:
+	for (i = irq_base; i < irq_end; i++)
+		set_irq_chip_and_handler(i, NULL, NULL);
+	return status;
+}
+
+int twl6030_exit_irq(void)
+{
+
+	if (twl6030_irq_base) {
+		pr_err("twl6030: can't yet clean up IRQs?\n");
+		return -ENOSYS;
+	}
+	return 0;
+}
+
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 27a6094..3c91ee3 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -86,6 +86,67 @@
 #define BCI_PRES_INTR_OFFSET	9
 #define USB_PRES_INTR_OFFSET	10
 #define RTC_INTR_OFFSET		11
+
+/*
+ * Offset from TWL6030_IRQ_BASE / pdata->irq_base
+ */
+#define PWR_INTR_OFFSET		0
+#define HOTDIE_INTR_OFFSET	12
+#define SMPSLDO_INTR_OFFSET	13
+#define BATDETECT_INTR_OFFSET	14
+#define SIMDETECT_INTR_OFFSET	15
+#define MMCDETECT_INTR_OFFSET	16
+#define GASGAUGE_INTR_OFFSET	17
+#define USBOTG_INTR_OFFSET	4
+#define CHARGER_INTR_OFFSET	2
+#define RSV_INTR_OFFSET		0
+
+/* INT register offsets */
+#define REG_INT_STS_A			0x00
+#define REG_INT_STS_B			0x01
+#define REG_INT_STS_C			0x02
+
+#define REG_INT_MSK_LINE_A		0x03
+#define REG_INT_MSK_LINE_B		0x04
+#define REG_INT_MSK_LINE_C		0x05
+
+#define REG_INT_MSK_STS_A		0x06
+#define REG_INT_MSK_STS_B		0x07
+#define REG_INT_MSK_STS_C		0x08
+
+/* MASK INT REG GROUP A */
+#define TWL6030_PWR_INT_MASK 		0x07
+#define TWL6030_RTC_INT_MASK 		0x18
+#define TWL6030_HOTDIE_INT_MASK 	0x20
+#define TWL6030_SMPSLDOA_INT_MASK	0xC0
+
+/* MASK INT REG GROUP B */
+#define TWL6030_SMPSLDOB_INT_MASK 	0x01
+#define TWL6030_BATDETECT_INT_MASK 	0x02
+#define TWL6030_SIMDETECT_INT_MASK 	0x04
+#define TWL6030_MMCDETECT_INT_MASK 	0x08
+#define TWL6030_GPADC_INT_MASK 		0x60
+#define TWL6030_GASGAUGE_INT_MASK 	0x80
+
+/* MASK INT REG GROUP C */
+#define TWL6030_USBOTG_INT_MASK  	0x0F
+#define TWL6030_CHARGER_CTRL_INT_MASK 	0x10
+#define TWL6030_CHARGER_FAULT_INT_MASK 	0x60
+
+
+#define TWL4030_CLASS_ID 		0x4030
+#define TWL6030_CLASS_ID 		0x6030
+unsigned int twl_rev(void);
+#define GET_TWL_REV (twl_rev())
+#define TWL_CLASS_IS(class, id)			\
+static inline int twl_class_is_ ##class(void)	\
+{						\
+	return ((id) == (GET_TWL_REV)) ? 1 : 0;	\
+}
+
+TWL_CLASS_IS(4030, TWL4030_CLASS_ID)
+TWL_CLASS_IS(6030, TWL6030_CLASS_ID)
+
 /*
  * Read and write single 8-bit registers
  */
@@ -101,6 +162,9 @@ int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
 int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
+int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
+int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
+
 /*----------------------------------------------------------------------*/
 
 /*
-- 
1.5.4.7

