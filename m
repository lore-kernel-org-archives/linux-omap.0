From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] OMAP2+: ads7846_init: put gpio_pendown into pdata if it's provided
Date: Wed, 21 Dec 2011 17:31:26 +0100
Message-ID: <1324485086-31410-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59268 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab1LUQba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 11:31:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

If platform data is provided by the caller gpio_pendown is put into
unused static ads7846_config structure and effectively has no effect.
Of course caller can set gpio_pendown field in platform data himself
but it seems natural to do this in ads7846_init to remove duplication.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/arm/mach-omap2/common-board-devices.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 2d1d775..eb408dd 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -75,7 +75,10 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 			gpio_set_debounce(gpio_pendown, gpio_debounce);
 	}
 
-	ads7846_config.gpio_pendown = gpio_pendown;
+	if (!board_pdata)
+		ads7846_config.gpio_pendown = gpio_pendown;
+	else
+		board_pdata->gpio_pendown = gpio_pendown;
 
 	spi_bi->bus_num	= bus_num;
 	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
-- 
1.7.6.4

