From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH V2] OMAP2+: ads7846_init: put gpio_pendown into pdata if it's provided
Date: Thu, 22 Dec 2011 15:00:48 +0100
Message-ID: <1324562448-24066-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47265 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1LVOA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 09:00:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@infradead.org
Cc: sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>, Igor Grinberg <grinberg@compulab.co.il>

If platform data is provided by the caller gpio_pendown is put into
unused static ads7846_config structure and effectively has no effect.
Of course caller can set gpio_pendown field in platform data himself
but it seems natural to do this in ads7846_init to remove duplication.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>

---
Changes from V1:

 - existing if clause reused

 arch/arm/mach-omap2/common-board-devices.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 2d1d775..9498b0f 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -75,13 +75,15 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 			gpio_set_debounce(gpio_pendown, gpio_debounce);
 	}
 
-	ads7846_config.gpio_pendown = gpio_pendown;
-
 	spi_bi->bus_num	= bus_num;
 	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
 
-	if (board_pdata)
+	if (board_pdata) {
+		board_pdata->gpio_pendown = gpio_pendown;
 		spi_bi->platform_data = board_pdata;
+	} else {
+		ads7846_config.gpio_pendown = gpio_pendown;
+	}
 
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
-- 
1.7.6.4

