From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 02/23] I2C: TWL4030: checkpatch.pl fixes for twl4030-usb.c
Date: Fri, 11 Apr 2008 11:28:15 +0300
Message-ID: <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40232 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304AbYDKI3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:29:50 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8VUtp032599
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:07 -0500
In-Reply-To: <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 1df5427..5cf1c5c 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -621,7 +621,8 @@ static int twl4030_set_suspend(struct otg_transceiver *x, int suspend)
 	return 0;
 }
 
-static int twl4030_set_peripheral(struct otg_transceiver *xceiv, struct usb_gadget *gadget)
+static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
+		struct usb_gadget *gadget)
 {
 	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
 
-- 
1.5.5.23.g2a5fe

