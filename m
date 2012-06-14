From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP: fix the ads7846 init code
Date: Thu, 14 Jun 2012 11:16:21 +0300
Message-ID: <1339661781-5086-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59203 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370Ab2FNIQa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 04:16:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zumeng Chen <zumeng.chen@windriver.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Igor Grinberg <grinberg@compulab.co.il>

In case a board provides the gpio_pendown and not board_pdata,
the GPIO debounce is not taken care of.
Fix this by taking care of GPIO debounce in any case.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/common-board-devices.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 1706ebc..c187586 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -63,28 +63,30 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
 	int err;
 
-	if (board_pdata && board_pdata->get_pendown_state) {
-		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
-		if (err) {
-			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
-			return;
-		}
-		gpio_export(gpio_pendown, 0);
-
-		if (gpio_debounce)
-			gpio_set_debounce(gpio_pendown, gpio_debounce);
+	err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
+	if (err) {
+		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
+		return;
 	}
 
+	if (gpio_debounce)
+		gpio_set_debounce(gpio_pendown, gpio_debounce);
+
 	spi_bi->bus_num	= bus_num;
 	spi_bi->irq	= gpio_to_irq(gpio_pendown);
 
 	if (board_pdata) {
 		board_pdata->gpio_pendown = gpio_pendown;
 		spi_bi->platform_data = board_pdata;
+		if (board_pdata->get_pendown_state)
+			gpio_export(gpio_pendown, 0);
 	} else {
 		ads7846_config.gpio_pendown = gpio_pendown;
 	}
 
+	if (!board_pdata || (board_pdata && !board_pdata->get_pendown_state))
+		gpio_free(gpio_pendown);
+
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
 #else
-- 
1.7.3.4

