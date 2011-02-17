From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 07/12] usb: otg: OMAP4430: Add phy_suspend function pointer to twl4030_usb_data
Date: Thu, 17 Feb 2011 14:38:44 +0200
Message-ID: <1297946329-9353-8-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:50446 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756197Ab1BQMjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:39:18 -0500
In-Reply-To: <1297946329-9353-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Hema HK <hemahk@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

Declare the .phy_suspend function pointer to twl4030_usb_data structure.
OMAP internal phy suspend function will be hooked though this function
pointer to use in the transceiver driver.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/i2c/twl.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 61b9609..a4bd05b 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -600,6 +600,8 @@ struct twl4030_usb_data {
 	int		(*phy_power)(struct device *dev, int iD, int on);
 	/* enable/disable  phy clocks */
 	int		(*phy_set_clock)(struct device *dev, int on);
+	/* suspend/resume of phy */
+	int		(*phy_suspend)(struct device *dev, int suspend);
 };
 
 struct twl4030_ins {
-- 
1.7.4.rc2

