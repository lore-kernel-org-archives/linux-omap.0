From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/5 v3] usb: otg: TWL4030: Update the last_event variable.
Date: Mon, 28 Feb 2011 14:19:32 +0530
Message-ID: <1298882976-4997-2-git-send-email-hemahk@ti.com>
References: <1298882976-4997-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298882976-4997-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Update the last_event variable of otg_transceiver. This will be used in
the musb platform glue driver for runtime idling the device.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/twl4030-usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 2362d83..e01b073 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
