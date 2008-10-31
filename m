From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [OMAP tree][RFC 2.6.28-rc2-omap 1/9] USB: EHCI-OMAP: Switch to gpio_request/free calls
Date: Fri, 31 Oct 2008 14:18:49 +0200
Message-ID: <1225455537-14017-2-git-send-email-jarkko.nikula@nokia.com>
References: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62526 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYJaMUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 08:20:06 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9VCJwTH002376
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 14:20:04 +0200
In-Reply-To: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/usb/host/ehci-omap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 4dffba6..1b3266c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -225,9 +225,9 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 #ifdef EXTERNAL_PHY_RESET
 	/* Refer: ISSUE1 */
-	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT1);
+	gpio_request(EXT_PHY_RESET_GPIO_PORT1, "USB1 PHY reset");
 	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 0);
-	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT2);
+	gpio_request(EXT_PHY_RESET_GPIO_PORT2, "USB2 PHY reset");
 	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 0);
 	/* Hold the PHY in RESET for enough time till DIR is high */
 	udelay(EXT_PHY_RESET_DELAY);
@@ -393,8 +393,8 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 
 #ifdef EXTERNAL_PHY_RESET
-	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT1);
-	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT2);
+	gpio_free(EXT_PHY_RESET_GPIO_PORT1);
+	gpio_free(EXT_PHY_RESET_GPIO_PORT2);
 #endif
 
 	dev_dbg(hcd->self.controller,
-- 
1.5.6.5

