From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 5/5] mfd: twl6030-irq: Add interrupt mapping table for the twl6032
Date: Thu, 25 Jul 2013 16:15:51 +0300
Message-ID: <1374758151-12097-6-git-send-email-grygorii.strashko@ti.com>
References: <1374758151-12097-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374758151-12097-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>

The TWL6032 PMIC has different IRQ status bits meaning.
Hence, add interrupt mapping table for the twl6032.

Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/mfd/twl6030-irq.c |   48 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index e3c54f8..517eda8 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -41,6 +41,7 @@
 #include <linux/suspend.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/of_device.h>
 
 #include "twl-core.h"
 
@@ -84,6 +85,36 @@ static int twl6030_interrupt_mapping[24] = {
 	CHARGERFAULT_INTR_OFFSET,	/* Bit 22	INT_CHRG	*/
 	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
 };
+
+static int twl6032_interrupt_mapping[24] = {
+	PWR_INTR_OFFSET,	/* Bit 0	PWRON			*/
+	PWR_INTR_OFFSET,	/* Bit 1	RPWRON			*/
+	PWR_INTR_OFFSET,	/* Bit 2	SYS_VLOW		*/
+	RTC_INTR_OFFSET,	/* Bit 3	RTC_ALARM		*/
+	RTC_INTR_OFFSET,	/* Bit 4	RTC_PERIOD		*/
+	HOTDIE_INTR_OFFSET,	/* Bit 5	HOT_DIE			*/
+	SMPSLDO_INTR_OFFSET,	/* Bit 6	VXXX_SHORT		*/
+	PWR_INTR_OFFSET,	/* Bit 7	SPDURATION		*/
+
+	PWR_INTR_OFFSET,	/* Bit 8	WATCHDOG		*/
+	BATDETECT_INTR_OFFSET,	/* Bit 9	BAT			*/
+	SIMDETECT_INTR_OFFSET,	/* Bit 10	SIM			*/
+	MMCDETECT_INTR_OFFSET,	/* Bit 11	MMC			*/
+	MADC_INTR_OFFSET,	/* Bit 12	GPADC_RT_EOC		*/
+	MADC_INTR_OFFSET,	/* Bit 13	GPADC_SW_EOC		*/
+	GASGAUGE_INTR_OFFSET,	/* Bit 14	CC_EOC			*/
+	GASGAUGE_INTR_OFFSET,	/* Bit 15	CC_AUTOCAL		*/
+
+	USBOTG_INTR_OFFSET,	/* Bit 16	ID_WKUP			*/
+	USBOTG_INTR_OFFSET,	/* Bit 17	VBUS_WKUP		*/
+	USBOTG_INTR_OFFSET,	/* Bit 18	ID			*/
+	USB_PRES_INTR_OFFSET,	/* Bit 19	VBUS			*/
+	CHARGER_INTR_OFFSET,	/* Bit 20	CHRG_CTRL		*/
+	CHARGERFAULT_INTR_OFFSET,	/* Bit 21	EXT_CHRG	*/
+	CHARGERFAULT_INTR_OFFSET,	/* Bit 22	INT_CHRG	*/
+	RSV_INTR_OFFSET,	/* Bit 23	Reserved		*/
+};
+
 /*----------------------------------------------------------------------*/
 
 struct twl6030_irq {
@@ -94,6 +125,7 @@ struct twl6030_irq {
 	struct notifier_block	pm_nb;
 	struct irq_chip		irq_chip;
 	struct irq_domain	*irq_domain;
+	const int		*irq_mapping_tbl;
 };
 
 static struct twl6030_irq *twl6030_irq;
@@ -168,7 +200,7 @@ static irqreturn_t twl6030_irq_thread(int irq, void *data)
 		if (sts.int_sts & 0x1) {
 			int module_irq =
 				irq_find_mapping(pdata->irq_domain,
-						 twl6030_interrupt_mapping[i]);
+						 pdata->irq_mapping_tbl[i]);
 			if (module_irq)
 				handle_nested_irq(module_irq);
 			else
@@ -347,12 +379,25 @@ static struct irq_domain_ops twl6030_irq_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 };
 
+static const struct of_device_id twl6030_of_match[] = {
+	{.compatible = "ti,twl6030", &twl6030_interrupt_mapping},
+	{.compatible = "ti,twl6032", &twl6032_interrupt_mapping},
+	{ },
+};
+
 int twl6030_init_irq(struct device *dev, int irq_num)
 {
 	struct			device_node *node = dev->of_node;
 	int			nr_irqs;
 	int			status;
 	u8			mask[3];
+	const struct of_device_id *of_id;
+
+	of_id = of_match_device(twl6030_of_match, dev);
+	if (!of_id || !of_id->data) {
+		dev_err(dev, "Unknown TWL device model\n");
+		return -EINVAL;
+	}
 
 	nr_irqs = TWL6030_NR_IRQS;
 
@@ -389,6 +434,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 
 	twl6030_irq->pm_nb.notifier_call = twl6030_irq_pm_notifier;
 	atomic_set(&twl6030_irq->wakeirqs, 0);
+	twl6030_irq->irq_mapping_tbl = of_id->data;
 
 	twl6030_irq->irq_domain =
 		irq_domain_add_linear(node, nr_irqs,
-- 
1.7.9.5
