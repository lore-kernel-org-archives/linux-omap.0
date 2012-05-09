From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Wed,  9 May 2012 10:31:35 +0300
Message-ID: <1336548695-6412-1-git-send-email-grinberg@compulab.co.il>
References: <20120508162436.GA10200@kroah.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:36505
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753025Ab2EIHbv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 03:31:51 -0400
In-Reply-To: <20120508162436.GA10200@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Igor Grinberg <grinberg@compulab.co.il>

When PHY reset pin is connected to a GPIO on external GPIO chip
(e.g. I2C), we should not call the gpio_set_value() function, but
gpio_set_value_cansleep().

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Acked-by: Felipe Balbi <balbi@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
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

