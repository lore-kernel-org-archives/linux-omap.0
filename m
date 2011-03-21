From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/2] USB: twl4030-usb: do board specific phy_power up/down
Date: Mon, 21 Mar 2011 15:50:19 +0200
Message-ID: <1300715420-25602-2-git-send-email-kalle.jokiniemi@nokia.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:64549 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab1CUNv7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:51:59 -0400
In-Reply-To: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, tony@atomide.com, heikki.krogerus@nokia.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

In case some board has special powering sequences for
the USB tranceiver, call those during __twl4030_phy_power
calls.

This is a preparation patch to allow powering down the
ISP1707 USB serial tranceiver in Nokia N900.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
 drivers/usb/otg/twl4030-usb.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 6ca505f..dea99b1 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -348,13 +348,20 @@ static void twl4030_i2c_access(struct twl4030_usb *twl, int on)
 
 static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
 {
-	u8 pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
+	u8 pwr;
+	struct twl4030_usb_data *board = twl->dev->platform_data;
+
+	pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
 
 	if (on)
 		pwr &= ~PHY_PWR_PHYPWD;
 	else
 		pwr |= PHY_PWR_PHYPWD;
 
+	/* do board specific power up/down, if available */
+	if (board->phy_power)
+		board->phy_power(twl->dev, 0, on);
+
 	WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
 }
 
-- 
1.7.1

