From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] i2c: twl4030: warning: mixed declarations and code
Date: Wed, 11 Jun 2008 14:55:23 +0300
Message-ID: <1213185323-31758-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28334 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYFKL4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 07:56:53 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5BBuSNQ006158
	for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 14:56:46 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Latest patches for multi-omap support introduced
it, removing.

Trivial patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 7f93b4f..f546d42 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -625,8 +625,8 @@ static int twl4030_set_suspend(struct otg_transceiver *x, int suspend)
 static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
 		struct usb_gadget *gadget)
 {
-	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
 	u32 l;
+	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
 
 	if (!xceiv)
 		return -ENODEV;
-- 
1.5.6.rc1

