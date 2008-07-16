From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] PROTECT_KEY register is in the PM_MASTER module not in the
	PM_RECEIVER module
Date: Wed, 16 Jul 2008 19:53:25 +0300
Message-ID: <20080716165325.GA4424@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21770 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbYGPQxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 12:53:44 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6GGrY6c032595
	for <linux-omap@vger.kernel.org>; Wed, 16 Jul 2008 19:53:42 +0300
Received: from codecarver.research.nokia.com (esdhcp04096.research.nokia.com [172.21.40.96])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m6GGrQW4003874
	for <linux-omap@vger.kernel.org>; Wed, 16 Jul 2008 19:53:26 +0300
Received: from p2 by codecarver.research.nokia.com with local (Exim 4.69)
	(envelope-from <p2@codecarver.research.nokia.com>)
	id 1KJAFp-0006vS-Le
	for linux-omap@vger.kernel.org; Wed, 16 Jul 2008 19:53:25 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch fixes a write to the wrong address in the triton2 chip.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index ab335ca..20858b5 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -586,7 +586,7 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
 
 	/* disable access to power configuration registers */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, PROTECT_KEY);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, PROTECT_KEY);
 }
 
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
-- 
1.5.3.4

