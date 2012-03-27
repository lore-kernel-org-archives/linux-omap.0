From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Tue, 27 Mar 2012 16:08:55 +0200
Message-ID: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:36469
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752374Ab2C0OJM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 10:09:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>

When PHY reset pin is connected to a GPIO on external GPIO chip
(e.g. I2C), we should not call the gpio_set_value() function, but
gpio_set_value_cansleep().

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
This patch depends on the patch from Keshava [1]:
ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue

[1] http://www.spinics.net/lists/linux-omap/msg66774.html

 drivers/usb/host/ehci-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 5c78f9e..26e9241 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		udelay(10);
 
 		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value(pdata->reset_gpio_port[0], 1);
+			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
 
 		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value(pdata->reset_gpio_port[1], 1);
+			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
 	}
 
 	return 0;
-- 
1.7.3.4

