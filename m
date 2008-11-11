From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] i2c: twl4030_usb: add init section to regulators init
Date: Tue, 11 Nov 2008 14:31:43 +0200
Message-ID: <1226406703-26948-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54424 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbYKKMcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 07:32:11 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mABCW1t3031746
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 14:32:08 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

twl4030_usb_ldo_init is only called during probe. Make it
sit in the __init section.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index f967353..07b9349 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -487,7 +487,8 @@ static void twl4030_phy_resume(struct twl4030_usb *twl)
 	twl->asleep = 0;
 }
 
-static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
+/* REVISIT This should move to Voltage and Current Regulator Framework */
+static void __init twl4030_usb_ldo_init(struct twl4030_usb *twl)
 {
 	/* Enable writing to power configuration registers */
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0xC0, PROTECT_KEY);
-- 
1.6.0.3.523.g304d0

