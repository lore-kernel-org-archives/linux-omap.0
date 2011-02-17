From: Hema HK <hemahk@ti.com>
Subject: [3/7 v4] usb: otg: OMAP4430: Add phy_suspend function pointer to twl4030_usb_data
Date: Thu, 17 Feb 2011 12:06:06 +0530
Message-ID: <1297924570-3750-3-git-send-email-hemahk@ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58325 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726Ab1BQGgY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 01:36:24 -0500
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Kalliguddi, Hema" <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

From: Kalliguddi, Hema <hemahk@ti.com>

Declare the .phy_suspend function pointer to twl4030_usb_data structure.
OMAP internal phy suspend function will be hooked though this function
pointer to use in the transceiver driver.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 include/linux/i2c/twl.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/include/linux/i2c/twl.h
===================================================================
--- linux-2.6.orig/include/linux/i2c/twl.h
+++ linux-2.6/include/linux/i2c/twl.h
@@ -600,6 +600,8 @@ struct twl4030_usb_data {
 	int		(*phy_power)(struct device *dev, int iD, int on);
 	/* enable/disable  phy clocks */
 	int		(*phy_set_clock)(struct device *dev, int on);
+	/* suspend/resume of phy */
+	int		(*phy_suspend)(struct device *dev, int suspend);
 };
 
 struct twl4030_ins {
