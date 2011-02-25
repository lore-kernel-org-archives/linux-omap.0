From: Hema HK <hemahk@ti.com>
Subject: [PATCH 1/5] usb: otg: TWL4030: Update the last_event variable.
Date: Fri, 25 Feb 2011 15:40:59 +0530
Message-ID: <1298628663-27650-2-git-send-email-hemahk@ti.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56301 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab1BYKLM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 05:11:12 -0500
In-Reply-To: <1298628663-27650-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

Update the last_event variable of otg_transceiver. This will be used in
the musb platform glue driver for runtime idling the device.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/otg/twl4030-usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 6ca505f..013b804 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -275,6 +275,8 @@ static enum usb_xceiv_events twl4030_usb_linkstat(struct twl4030_usb *twl)
 	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
 			status, status, linkstat);
 
+	twl->otg.last_event = linkstat;
+
 	/* REVISIT this assumes host and peripheral controllers
 	 * are registered, and that both are active...
 	 */
-- 
1.7.0.4

