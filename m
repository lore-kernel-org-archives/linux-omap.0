From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 10/10] usb: phy: generic: switch over to IS_ENABLED()
Date: Mon, 21 Apr 2014 10:56:52 -0500
Message-ID: <1398095812-14222-11-git-send-email-balbi@ti.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43412 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbaDUP70 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Apr 2014 11:59:26 -0400
In-Reply-To: <1398095812-14222-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, leigh@solinno.co.uk, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

when checking if our generic PHY is enabled,
it's a lot easier to use IS_ENABLED() instead
of manually checking for it. While at that, also
remove the bogus defined(MODULE) at the end of
the line.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/usb/usb_phy_generic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/usb_phy_generic.h b/include/linux/usb/usb_phy_generic.h
index 8346bcc..68adae8 100644
--- a/include/linux/usb/usb_phy_generic.h
+++ b/include/linux/usb/usb_phy_generic.h
@@ -13,7 +13,7 @@ struct usb_phy_generic_platform_data {
 	int gpio_reset;
 };
 
-#if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
+#if IS_ENABLED(CONFIG_NOP_USB_XCEIV)
 /* sometimes transceivers are accessed only through e.g. ULPI */
 extern struct platform_device *usb_phy_generic_register(void);
 extern void usb_phy_generic_unregister(struct platform_device *);
-- 
1.9.2.459.g68773ac

