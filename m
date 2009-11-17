From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/8] musb: Add structure to get board specific data
Date: Tue, 17 Nov 2009 20:39:49 +0530
Message-ID: <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33295 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbZKQPKk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 10:10:40 -0500
In-Reply-To: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, felipe.balbi@nokia.com, david-b@pacbell.net, cooloney@kernel.org, gadiyar@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Adding 'musb_hdrc_board_data' which will have all the board specific
parameters such as; mA power, potpgt, extvbus, gpios etc.

Currently only 'power' and 'potpgt' is being moved from existing
'musb_hdrc_platform_data' to 'musb_hdrc_board_data' but any further
board specific functions or parameter can be added to this structure
later.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 include/linux/usb/musb.h |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d437556..6e1426c 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -27,6 +27,15 @@ struct musb_hdrc_eps_bits {
 	u8		bits;
 };
 
+/* MUSB board-specific details */
+struct musb_hdrc_board_data {
+	/* power (mA/2) sourcing capability */
+	u8	power;
+	/* (HOST or OTG) msec/2 after VBUS on till power good */
+	u8		potpgt;
+
+};
+
 struct musb_hdrc_config {
 	/* MUSB configuration-specific details */
 	unsigned	multipoint:1;	/* multipoint device */
@@ -67,15 +76,9 @@ struct musb_hdrc_platform_data {
 	/* (HOST or OTG) switch VBUS on/off */
 	int		(*set_vbus)(struct device *dev, int is_on);
 
-	/* (HOST or OTG) mA/2 power supplied on (default = 8mA) */
-	u8		power;
-
 	/* (PERIPHERAL) mA/2 max power consumed (default = 100mA) */
 	u8		min_power;
 
-	/* (HOST or OTG) msec/2 after VBUS on till power good */
-	u8		potpgt;
-
 	/* Power the device on or off */
 	int		(*set_power)(int state);
 
@@ -84,6 +87,9 @@ struct musb_hdrc_platform_data {
 
 	/* MUSB configuration-specific details */
 	struct musb_hdrc_config	*config;
+
+	/* MUSB board-specific details */
+	struct musb_hdrc_board_data *board_data;
 };
 
 
-- 
1.6.2.4

