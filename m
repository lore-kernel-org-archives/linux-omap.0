From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] arm: omap2plus: fix ads7846 pendown gpio request
Date: Wed,  4 May 2011 18:04:55 +0300
Message-ID: <1304521495-20578-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:33769
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754440Ab1EDPE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 11:04:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

introduced by: 96974a24
(omap: consolidate touch screen initialization among different boards)

ads7846 driver can use either gpio_pendown or get_pendown_state()
callback. In case of gpio_pendown, it requests the provided gpio_pendown
thus resulting in double requesting that gpio:

ads7846 spi1.0: failed to request pendown GPIO57
ads7846: probe of spi1.0 failed with error -16

Fix this by restricting the gpio request to the case of
get_pendown_state() callback is used.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/common-board-devices.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index d57c71d..61fee80 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -83,17 +83,17 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
 	int err;
 
-	err = gpio_request(gpio_pendown, "TS PenDown");
-	if (err) {
-		pr_err("Could not obtain gpio for TS PenDown: %d\n", err);
-		return;
-	}
-
-	gpio_direction_input(gpio_pendown);
-	gpio_export(gpio_pendown, 0);
+	if (board_pdata && board_pdata->get_pendown_state) {
+		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
+		if (err) {
+			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
+			return;
+		}
+		gpio_export(gpio_pendown, 0);
 
-	if (gpio_debounce)
-		gpio_set_debounce(gpio_pendown, gpio_debounce);
+		if (gpio_debounce)
+			gpio_set_debounce(gpio_pendown, gpio_debounce);
+	}
 
 	ads7846_config.gpio_pendown = gpio_pendown;
 
-- 
1.7.3.4

