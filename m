From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 20/22] twl4030-gpio: remove legacy irq triggering calls and user
Date: Mon, 29 Sep 2008 16:14:37 +0300
Message-ID: <1222694079-16289-21-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-17-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-18-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-19-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-20-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29690 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbYI2NP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:29 -0400
In-Reply-To: <1222694079-16289-20-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Make the hsmmc code use genirq interfaces to make sure the
card detect IRQ triggers on both edges.  Remove the older
TWL-specific infrastructure for making that happen.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c   |    5 -----
 drivers/gpio/twl4030-gpio.c   |   38 ++++++++------------------------------
 drivers/mmc/host/omap_hsmmc.c |    4 +++-
 include/linux/i2c/twl4030.h   |    4 ----
 4 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 7334d86..2ba9986 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -65,11 +65,6 @@ static int hsmmc_late_init(struct device *dev)
 	if (ret)
 		goto err;
 
-	ret = twl4030_set_gpio_edge_ctrl(MMC1_CD_IRQ,
-			TWL4030_GPIO_EDGE_RISING | TWL4030_GPIO_EDGE_FALLING);
-	if (ret)
-		goto err;
-
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0x02,
 						TWL_GPIO_PUPDCTR1);
 	if (ret)
diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index e709fbb..404cb34 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -509,10 +509,7 @@ int twl4030_set_gpio_pull(int gpio, int pull_dircn)
 }
 #endif
 
-/*
- * Configure Edge control for a GPIO pin on TWL4030
- */
-int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
+static int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 {
 	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
 	u8 c_off = GET_GPIO_CTL_OFF(gpio);
@@ -521,33 +518,26 @@ int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 	u8 base = 0;
 	int ret = 0;
 
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
 	base = REG_GPIO_EDR1 + c_bnk;
 
-	if (edge & TWL4030_GPIO_EDGE_RISING)
+	if (edge & IRQ_TYPE_EDGE_RISING)
 		c_msk |= MASK_GPIO_EDR1_GPIOxRISING(c_off);
-
-	if (edge & TWL4030_GPIO_EDGE_FALLING)
+	if (edge & IRQ_TYPE_EDGE_FALLING)
 		c_msk |= MASK_GPIO_EDR1_GPIOxFALLING(c_off);
 
 	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		/* clear the previous rising/falling values */
-		reg =
-		(u8) (ret &
-			~(MASK_GPIO_EDR1_GPIOxFALLING(c_off) |
-			MASK_GPIO_EDR1_GPIOxRISING(c_off)));
+		reg = (u8) ret;
+		reg &= ~( MASK_GPIO_EDR1_GPIOxFALLING(c_off)
+			| MASK_GPIO_EDR1_GPIOxRISING(c_off));
 		reg |= c_msk;
 		ret = gpio_twl4030_write(base, reg);
 	}
 	mutex_unlock(&gpio_lock);
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_set_gpio_edge_ctrl);
 
 /*
  * Configure debounce timing value for a GPIO pin on TWL4030
@@ -652,7 +642,7 @@ static int twl4030_gpio_unmask_thread(void *data)
 				gpio_trigger;
 				gpio_trigger >>= 1, irq++) {
 			struct irq_desc *desc;
-			unsigned type, edge;
+			unsigned type;
 
 			if (!(gpio_trigger & 0x1))
 				continue;
@@ -662,19 +652,7 @@ static int twl4030_gpio_unmask_thread(void *data)
 			type = desc->status & IRQ_TYPE_SENSE_MASK;
 			spin_unlock_irq(&desc->lock);
 
-			switch (type) {
-			case IRQ_TYPE_EDGE_RISING:
-				edge = TWL4030_GPIO_EDGE_RISING;
-				break;
-			case IRQ_TYPE_EDGE_FALLING:
-				edge = TWL4030_GPIO_EDGE_FALLING;
-				break;
-			default:
-				edge = TWL4030_GPIO_EDGE_RISING
-					| TWL4030_GPIO_EDGE_FALLING;
-				break;
-			}
-			twl4030_set_gpio_edge_ctrl(irq, edge);
+			twl4030_set_gpio_edge_ctrl(irq, type);
 		}
 
 		local_irq_disable();
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7744669..4f5c0ab 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -918,7 +918,9 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	/* Request IRQ for card detect */
 	if ((mmc_slot(host).card_detect_irq) && (mmc_slot(host).card_detect)) {
 		ret = request_irq(mmc_slot(host).card_detect_irq,
-				  omap_mmc_cd_handler, IRQF_DISABLED,
+				  omap_mmc_cd_handler,
+				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+					  | IRQF_DISABLED,
 				  mmc_hostname(mmc), host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 1c79c89..f26fda1 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -149,9 +149,6 @@ struct twl4030_platform_data {
 #define TWL4030_GPIO_PULL_UP		0
 #define TWL4030_GPIO_PULL_DOWN		1
 #define TWL4030_GPIO_PULL_NONE		2
-#define TWL4030_GPIO_EDGE_NONE		0
-#define TWL4030_GPIO_EDGE_RISING	1
-#define TWL4030_GPIO_EDGE_FALLING	2
 
 /* Functions to read and write from TWL4030 */
 
@@ -177,7 +174,6 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
  */
 int twl4030_get_gpio_datain(int gpio);
 int twl4030_request_gpio(int gpio);
-int twl4030_set_gpio_edge_ctrl(int gpio, int edge);
 int twl4030_set_gpio_debounce(int gpio, int enable);
 int twl4030_free_gpio(int gpio);
 
-- 
1.6.0.2.307.gc427

