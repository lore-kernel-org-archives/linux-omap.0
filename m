From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 1/1] OMAP3: PM: Add the wakeup source driver
Date: Tue, 3 Mar 2009 19:37:28 +0900
Message-ID: <4d34a0a70903030237i6e43461ei986266cdfb72b416@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:48750 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbZCCKhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 05:37:31 -0500
Received: by fxm24 with SMTP id 24so2370114fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 02:37:28 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

Sometimes, it is necessary to find out "what does wake up my board?".
Notifying wake-up source feature may be used to blame unexpected
wake-up events which increase power consumption. And user mode
applications can act smartly according to the wake-up event to
minimize power consumption. This driver uses sysfs interface to give
information to user mode applications like:

cat /sys/power/wakeup_irq
cat /sys/power/wakeup_event

This driver also privides the unified GPIO wake-up source
configuration. specific GPIO settings in the board files are:

/* Wakeup source configuration */
static struct gpio_wake boardname_gpio_wake[] = {
	{ 23,	IRQF_TRIGGER_RISING | IRQF_SHARED,	"BT_WAKEUP",	1},
	{ 24,	IRQF_TRIGGER_RISING | IRQF_SHARED,	"USB_DETECT",	1},
};

static struct omap_wake_platform_data boardname_wake_data = {
	.qpio_wakes		= boardname_gpio_wake,
	.gpio_wake_num		= ARRAY_SIZE(boardname_gpio_wake),
};

static struct platform_device boardname_wakeup = {
	.name			= "omap-wake",
	.id			= -1,
	.dev			= {
		.platform_data	= &boardname_wake_data,
	},
};

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/Makefile           |    1 +
 arch/arm/mach-omap2/irq.c              |   41 +++
 arch/arm/mach-omap2/prcm-common.h      |    4 +
 arch/arm/mach-omap2/prm-regbits-34xx.h |    6 +
 arch/arm/mach-omap2/wake34xx.c         |  470 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig             |    9 +
 arch/arm/plat-omap/include/mach/irqs.h |    1 +
 arch/arm/plat-omap/include/mach/wake.h |   29 ++
 8 files changed, 561 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/wake34xx.c
 create mode 100644 arch/arm/plat-omap/include/mach/wake.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ba65cab..1ab87e7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+obj-$(CONFIG_OMAP_WAKE)			+= wake34xx.o
 endif

 # SmartReflex driver
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 2842fe8..21f3d83 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -177,6 +177,47 @@ int omap_irq_pending(void)
 	return 0;
 }

+/*
+ * Get the first pending MPU IRQ number from 'irq_start'.
+ * If none, return -1.
+ */
+int omap_get_pending_mpu_irq(unsigned int irq_start)
+{
+	struct omap_irq_bank *bank = irq_banks;
+	int irq, bits_skip, bit_start;
+
+	if (irq_start >= bank->nr_irqs)
+		return -1;
+
+	bits_skip = irq_start % IRQ_BITS_PER_REG;
+	bit_start = irq_start - bits_skip;
+
+	for (irq = bit_start; irq < bank->nr_irqs; irq += IRQ_BITS_PER_REG) {
+		int ret, i, limit, offset = irq & (~(IRQ_BITS_PER_REG - 1));
+
+		ret = intc_bank_read_reg(bank, (INTC_PENDING_IRQ0 + offset));
+		if (!ret)
+			continue;
+
+		limit = IRQ_BITS_PER_REG;
+
+		if (bit_start == irq) {
+			ret >>= bits_skip;
+			limit -= bits_skip;
+		} else
+			bits_skip = 0;
+
+		for (i = 0; i < limit; i++) {
+			if (ret & 0x1)
+				return irq + i + bits_skip;
+			else
+				ret >>= 1;
+		}
+	}
+
+	return -1;
+}
+
 void __init omap_init_irq(void)
 {
 	unsigned long nr_of_irqs = 0;
diff --git a/arch/arm/mach-omap2/prcm-common.h
b/arch/arm/mach-omap2/prcm-common.h
index cb1ae84..1f340aa 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -273,6 +273,10 @@
 #define OMAP3430_ST_D2D_SHIFT				3
 #define OMAP3430_ST_D2D_MASK				(1 << 3)

+/* PM_WKST3_CORE, CM_IDLEST3_CORE shared bits */
+#define OMAP3430_ST_USBTLL_SHIFT			2
+#define OMAP3430_ST_USBTLL_MASK				(1 << 2)
+
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
 #define OMAP3430_EN_GPIO1				(1 << 3)
 #define OMAP3430_EN_GPIO1_SHIFT				3
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h
b/arch/arm/mach-omap2/prm-regbits-34xx.h
index d73eee8..661d37d 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -332,6 +332,8 @@
 /* PM_IVA2GRPSEL1_CORE specific bits */

 /* PM_WKST1_CORE specific bits */
+#define OMAP3430_ST_MMC3_SHIFT				30
+#define OMAP3430_ST_MMC3_MASK				(1 << 30)

 /* PM_PWSTCTRL_CORE specific bits */
 #define OMAP3430_MEM2ONSTATE_SHIFT			18
@@ -373,6 +375,7 @@
 /* PM_IVA2GRPSEL_WKUP specific bits */

 /* PM_WKST_WKUP specific bits */
+#define OMAP3430_ST_IO_CHAIN				(1 << 16)
 #define OMAP3430_ST_IO					(1 << 8)

 /* PRM_CLKSEL */
@@ -430,6 +433,9 @@

 /* PM_PREPWSTST_PER specific bits */

+/* PM_WKST_USBHOST specific bits */
+#define OMAP3430_ST_USBHOST				(1 << 0)
+
 /* RM_RSTST_EMU specific bits */

 /* PM_PWSTST_EMU specific bits */
diff --git a/arch/arm/mach-omap2/wake34xx.c b/arch/arm/mach-omap2/wake34xx.c
new file mode 100644
index 0000000..2390bca
--- /dev/null
+++ b/arch/arm/mach-omap2/wake34xx.c
@@ -0,0 +1,466 @@
+/*
+ * wake34xx.c
+ *
+ * Copyright (c) 2009 Samsung Eletronics
+ *
+ * Author: Kim Kyuwon <q1.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+
+#include <mach/gpio.h>
+#include <mach/wake.h>
+
+#include "prm-regbits-34xx.h"
+
+/*
+ * Sometimes, it is necessary to find out "what does wake up my board?"
+ * Notifying wake-up source feature may be used to blame unexpected wake-up
+ * events which increase power consumption. And user mode applications can
+ * act smartly according to the wake-up event to minimize power consumption.
+ * This driver uses sysfs interface to give information to user mode
+ * applications.
+ */
+
+#define WAKE_STR_LEN	64
+
+char wakeup_irq[WAKE_STR_LEN] = "None";
+char wakeup_event[WAKE_STR_LEN] = "None";
+
+struct wake_event {
+	int 		index;
+	const char 	*name;
+};
+
+static struct wake_event omap3_wkup_events[] = {
+	{ OMAP3430_ST_IO_CHAIN,			"ST_IO" },
+	{ OMAP3430_ST_IO,			"ST_SR2" },
+	{ OMAP3430_ST_SR2_MASK,			"ST_SR2" },
+	{ OMAP3430_ST_SR1_MASK,			"ST_SR1" },
+	{ OMAP3430_ST_GPIO1_MASK,		"ST_GPIO1" },
+	{ OMAP3430_ST_GPT12_MASK,		"ST_GPT12" },
+	{ OMAP3430_ST_GPT1_MASK,		"ST_GPT1" },
+};
+
+static struct wake_event omap3_per_events[] = {
+	{ OMAP3430_ST_GPIO6_MASK,		"ST_GPIO6" },
+	{ OMAP3430_ST_GPIO5_MASK,		"ST_GPIO5" },
+	{ OMAP3430_ST_GPIO4_MASK,		"ST_GPIO4" },
+	{ OMAP3430_ST_GPIO3_MASK,		"ST_GPIO3" },
+	{ OMAP3430_ST_GPIO2_MASK,		"ST_GPIO2" },
+	{ OMAP3430_ST_UART3_MASK,		"ST_UART3" },
+	{ OMAP3430_ST_GPT9_MASK,		"ST_GPT9" },
+	{ OMAP3430_ST_GPT8_MASK,		"ST_GPT8" },
+	{ OMAP3430_ST_GPT7_MASK,		"ST_GPT7" },
+	{ OMAP3430_ST_GPT6_MASK,		"ST_GPT6" },
+	{ OMAP3430_ST_GPT5_MASK,		"ST_GPT5" },
+	{ OMAP3430_ST_GPT4_MASK,		"ST_GPT4" },
+	{ OMAP3430_ST_GPT3_MASK,		"ST_GPT3" },
+	{ OMAP3430_ST_GPT2_MASK,		"ST_GPT2" },
+	{ OMAP3430_EN_MCBSP4,			"EN_MCBSP4" },
+	{ OMAP3430_EN_MCBSP3,			"EN_MCBSP3" },
+	{ OMAP3430_EN_MCBSP2,			"EN_MCBSP2" },
+};
+
+static struct wake_event omap3_core1_events[] = {
+	{ OMAP3430_ST_MMC3_MASK,		"ST_MMC3" },
+	{ OMAP3430_ST_MMC2_MASK,		"ST_MMC2" },
+	{ OMAP3430_ST_MMC1_MASK,		"ST_MMC1" },
+	{ OMAP3430_ST_MCSPI4_MASK,		"ST_MCSPI4" },
+	{ OMAP3430_ST_MCSPI3_MASK,		"ST_MCSPI3" },
+	{ OMAP3430_ST_MCSPI2_MASK,		"ST_MCSPI2" },
+	{ OMAP3430_ST_MCSPI1_MASK,		"ST_MCSPI1" },
+	{ OMAP3430_ST_I2C3_MASK,		"ST_I2C3" },
+	{ OMAP3430_ST_I2C2_MASK,		"ST_I2C2" },
+	{ OMAP3430_ST_I2C1_MASK,		"ST_I2C1" },
+	{ OMAP3430_ST_UART1_MASK,		"ST_UART1" },
+	{ OMAP3430_ST_GPT11_MASK,		"ST_GPT11" },
+	{ OMAP3430_ST_GPT10_MASK,		"ST_GPT10" },
+	{ OMAP3430_ST_MCBSP5_MASK,		"ST_MCBSP5" },
+	{ OMAP3430_ST_MCBSP1_MASK,		"ST_MCBSP1" },
+};
+
+static struct wake_event omap3es1_core1_events[] = {
+	{ OMAP3430ES1_ST_FSHOSTUSB_MASK,	"ST_FSHOSTUSB" },
+	{ OMAP3430ES1_ST_HSOTGUSB_MASK,		"ST_HSOTGUSB" },
+	{ OMAP3430_ST_D2D_MASK,			"ST_D2D" },
+};
+
+static struct wake_event omap3es2_core1_events[] = {
+	{ OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK,	"ST_HSOTGUSB" },
+};
+
+static struct wake_event omap3_core2_events[] = {
+	{ OMAP3430_ST_USBTLL_MASK,		"ST_USBTLL" },
+};
+
+static struct wake_event omap3_usbhost_events[] = {
+	{ OMAP3430_ST_USBHOST,			"ST_USBHOST" },
+};
+
+static ssize_t wakeup_source_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf);
+
+static void omap_wake_update_event(char *event)
+{
+	int len;
+
+	if (wakeup_event[0])
+		len = strlen(wakeup_event) + strlen(event) + 2;
+	else
+		len = strlen(wakeup_event) + strlen(event);
+
+	if (len > WAKE_STR_LEN - 1) {
+		printk(KERN_ERR "Can't record the wakeup event: %s\n", event);
+		return;
+	}
+
+	if (wakeup_event[0])
+		strcat(wakeup_event, ", ");
+	strcat(wakeup_event, event);
+}
+
+static void omap_wake_detect_wkup(u32 wkst, char *event)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(omap3_wkup_events); i++)
+		if (wkst & omap3_wkup_events[i].index) {
+			sprintf(event, "%s",
+					omap3_wkup_events[i].name);
+			return;
+		}
+
+	sprintf(event, "WKUP:0x%08x", wkst);
+}
+
+static void omap_wake_detect_per(u32 wkst, char *event)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(omap3_per_events); i++)
+		if (wkst & omap3_per_events[i].index) {
+			sprintf(event, "%s",
+					omap3_per_events[i].name);
+			return;
+		}
+
+	sprintf(event, "PER:0x%08x", wkst);
+}
+
+static void omap_wake_detect_core1(u32 wkst, char *event)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(omap3_core1_events); i++)
+		if (wkst & omap3_core1_events[i].index) {
+			sprintf(event, "%s",
+					omap3_core1_events[i].name);
+			return;
+		}
+
+	if (omap_rev() == OMAP3430_REV_ES1_0) {
+		for (i = 0; i < ARRAY_SIZE(omap3es1_core1_events); i++) {
+			if (wkst & omap3es1_core1_events[i].index) {
+				sprintf(event, "%s",
+					omap3es1_core1_events[i].name);
+				return;
+			}
+		}
+	} else {
+		for (i = 0; i < ARRAY_SIZE(omap3es2_core1_events); i++) {
+			if (wkst & omap3es2_core1_events[i].index) {
+				sprintf(event, "%s",
+					omap3es2_core1_events[i].name);
+				return;
+			}
+		}
+	}
+
+	sprintf(event, "CORE1:0x%08x", wkst);
+}
+
+static void omap_wake_detect_core2(u32 wkst, char *event)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(omap3_core2_events); i++)
+		if (wkst & omap3_core2_events[i].index) {
+			sprintf(event, "%s",
+					omap3_core2_events[i].name);
+			return;
+		}
+
+	sprintf(event, "CORE2:0x%08x", wkst);
+}
+
+static void omap_wake_detect_usbhost(u32 wkst, char *event)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(omap3_usbhost_events); i++)
+		if (wkst & omap3_usbhost_events[i].index) {
+			sprintf(event, "%s",
+					omap3_usbhost_events[i].name);
+			return;
+		}
+
+	sprintf(event, "USBHOST:0x%08x", wkst);
+}
+
+/* Detect wake-up events */
+static void omap_wake_detect_wakeup(void)
+{
+	u32 wkst;
+	char buf[32] = {0, };
+	int irq, len;
+
+	/* Initialize global string variables */
+	memset(wakeup_irq, 0x0, WAKE_STR_LEN);
+	memset(wakeup_event, 0x0, WAKE_STR_LEN);
+
+	/* IRQ */
+	irq = omap_get_pending_mpu_irq(0);
+	while (irq >= 0) {
+		if (irq == INT_34XX_SYS_NIRQ)
+			omap_wake_update_event("sys_nirq");
+
+		len = strlen(wakeup_irq) + sprintf(buf, "%d", irq);
+		if (len > WAKE_STR_LEN - 1)
+			break;
+
+		strcat(wakeup_irq, buf);
+
+		irq = omap_get_pending_mpu_irq(irq + 1);
+		if (irq >= 0) {
+			len = strlen(wakeup_irq) + 2;
+			if (len > WAKE_STR_LEN - 1)
+				break;
+
+			strcat(wakeup_irq, ", ");
+		}
+	}
+	if (!wakeup_irq[0])
+		strncpy(wakeup_irq, "Unknown", WAKE_STR_LEN - 1);
+	printk(KERN_INFO "Wake-up IRQ: %s\n", wakeup_irq);
+
+	/* WKUP */
+	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
+	if (wkst) {
+		omap_wake_detect_wkup(wkst, buf);
+		omap_wake_update_event(buf);
+	}
+
+	/* PER */
+	wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
+	if (wkst) {
+		omap_wake_detect_per(wkst, buf);
+		omap_wake_update_event(buf);
+	}
+
+	/* CORE */
+	wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+	if (wkst) {
+		omap_wake_detect_core1(wkst, buf);
+		omap_wake_update_event(buf);
+	}
+	wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
+	if (wkst) {
+		omap_wake_detect_core2(wkst, buf);
+		omap_wake_update_event(buf);
+	}
+
+	/* USBHOST */
+	wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
+	if (wkst) {
+		omap_wake_detect_usbhost(wkst, buf);
+		omap_wake_update_event(buf);
+	}
+
+	if (!wakeup_event[0])
+		strncpy(wakeup_event, "Unknown", WAKE_STR_LEN - 1);
+}
+
+static struct kobj_attribute wakeup_irq_attr =
+	__ATTR(wakeup_irq, 0644, wakeup_source_show, NULL);
+
+static struct kobj_attribute wakeup_event_attr =
+	__ATTR(wakeup_event, 0644, wakeup_source_show, NULL);
+
+static ssize_t wakeup_source_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	if (attr == &wakeup_irq_attr)
+		return sprintf(buf, "%s\n", wakeup_irq);
+	else if (attr == &wakeup_event_attr)
+		return sprintf(buf, "%s\n", wakeup_event);
+	else
+		return -EINVAL;
+}
+
+static irqreturn_t omap_wake_detect_gpio(int irq, void *dev_id)
+{
+	if (!strncmp(wakeup_event, "Unknown", WAKE_STR_LEN - 1))
+		strncpy(wakeup_event, dev_id, WAKE_STR_LEN - 1);
+	else
+		omap_wake_update_event(dev_id);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit omap_wake_probe(struct platform_device *pdev)
+{
+	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_wake *gw;
+	int i, ret;
+
+	/*
+	 * It may be good to configure GPIO wake-up sources in each driver.
+	 * Buf if the specific device driver doesn't exist, you can use
+	 * omap-wake driver to configure gpio wake-up sources.
+	 */
+	for (i = 0; i < pdata->gpio_wake_num; i++) {
+		gw = pdata->qpio_wakes + i;
+
+		if (gw->request) {
+			ret = gpio_request(gw->gpio, gw->name);
+			if (ret) {
+				dev_err(&pdev->dev, "can't request gpio%d"
+					", return %d\n", gw->gpio, ret);
+				goto failed_free_gpio;
+			}
+		}
+		gpio_direction_input(gw->gpio);
+		enable_irq_wake(gpio_to_irq(gw->gpio));
+	}
+
+	ret = sysfs_create_file(power_kobj, &wakeup_irq_attr.attr);
+	if (ret)
+		dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
+					wakeup_irq_attr.attr.name, ret);
+
+	ret = sysfs_create_file(power_kobj, &wakeup_event_attr.attr);
+	if (ret)
+		dev_err(&pdev->dev, "sysfs_create_file %s failed: %d\n",
+					wakeup_event_attr.attr.name, ret);
+
+	return 0;
+
+failed_free_gpio:
+	for (i--; i >= 0; i--) {
+		gw = pdata->qpio_wakes + i;
+
+		if (gw->request)
+			gpio_free(gw->gpio);
+	}
+
+	return ret;
+}
+
+static int __devexit omap_wake_remove(struct platform_device *pdev)
+{
+	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_wake *gw;
+	int i;
+
+	for (i = 0; i < pdata->gpio_wake_num; i++) {
+		gw = pdata->qpio_wakes + i;
+
+		if (gw->request)
+			gpio_free(gw->gpio);
+
+		disable_irq_wake(gpio_to_irq(gw->gpio));
+	}
+
+	return 0;
+}
+
+static int omap_wake_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_wake *gw;
+	int i, ret;
+
+	for (i = 0; i < pdata->gpio_wake_num; i++) {
+		gw = pdata->qpio_wakes + i;
+
+		ret = request_irq(gpio_to_irq(gw->gpio), omap_wake_detect_gpio,
+				gw->irqflag, gw->name, (void *)gw->name);
+		if (ret) {
+			dev_err(&pdev->dev, "can't get IRQ%d, return %d\n",
+					gpio_to_irq(gw->gpio), ret);
+			goto failed_free_irq;
+		}
+	}
+
+	return 0;
+
+failed_free_irq:
+	for (i--; i >= 0; i--) {
+		gw = pdata->qpio_wakes + i;
+		free_irq(gpio_to_irq(gw->gpio),  (void *)gw->name);
+	}
+
+	return ret;
+}
+
+static int omap_wake_resume_early(struct platform_device *pdev)
+{
+	omap_wake_detect_wakeup();
+
+	return 0;
+}
+
+static int omap_wake_resume(struct platform_device *pdev)
+{
+	struct omap_wake_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_wake *gw;
+	int i;
+
+	for (i = 0; i < pdata->gpio_wake_num; i++) {
+		gw = pdata->qpio_wakes + i;
+
+		free_irq(gpio_to_irq(gw->gpio), (void *)gw->name);
+	}
+
+	printk(KERN_INFO "Wake-up event: %s\n", wakeup_event);
+
+	return 0;
+}
+
+static struct platform_driver omap_wake_driver = {
+	.probe          = omap_wake_probe,
+	.remove		= __devexit_p(omap_wake_remove),
+	.suspend	= omap_wake_suspend,
+	.resume_early	= omap_wake_resume_early,
+	.resume		= omap_wake_resume,
+	.driver         = {
+		.name   = "omap-wake",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init omap_wake_init(void)
+{
+	return platform_driver_register(&omap_wake_driver);
+}
+
+module_init(omap_wake_init);
+
+static void __exit omap_wake_exit(void)
+{
+	platform_driver_unregister(&omap_wake_driver);
+}
+module_exit(omap_wake_exit);
+
+MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
+MODULE_DESCRIPTION("OMAP34xx wakeup driver");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 407bd32..7a73c95 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -176,6 +176,15 @@ config OMAP_MBOX_FWK
 	  Say Y here if you want to use OMAP Mailbox framework support for
 	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.

+config OMAP_WAKE
+	tristate "OMAP34xx wakeup source support"
+	depends on ARCH_OMAP34XX && PM
+	default n
+	help
+	  Select this option if you want to know what kind of wake-up event
+	  wakes up your board from the low power mode. And this option
+	  provides the unified GPIO wake-up source configuration.
+
 choice
         prompt "System timer"
 	default OMAP_MPU_TIMER
diff --git a/arch/arm/plat-omap/include/mach/irqs.h
b/arch/arm/plat-omap/include/mach/irqs.h
index d12c39f..656cc04 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -385,6 +385,7 @@
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
 extern int omap_irq_pending(void);
+extern int omap_get_pending_mpu_irq(unsigned int irq_start);
 #endif

 #include <mach/hardware.h>
diff --git a/arch/arm/plat-omap/include/mach/wake.h
b/arch/arm/plat-omap/include/mach/wake.h
new file mode 100644
index 0000000..213b263
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/wake.h
@@ -0,0 +1,30 @@
+/*
+ * wake.h
+ *
+ * Copyright (c) 2009 Samsung Eletronics
+ *
+ * Author: Kim Kyuwon <q1.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _WAKE_H_
+#define _WAKE_H_
+
+struct gpio_wake {
+	unsigned int 	gpio;
+	unsigned long	irqflag;
+	const char 	*name;
+	int		request;
+};
+
+struct omap_wake_platform_data{
+	struct gpio_wake	*qpio_wakes;
+	int			gpio_wake_num;
+};
+
+#endif /* _WAKE_H_ */
+
-- 
1.5.2.5


-- 
Q1
