From: Matthias Brugger <mbrugger@iseebcn.com>
Subject: [PATCH] usb/musb/omap2430.c Delete unused variable.
Date: Thu, 16 Aug 2012 13:00:25 +0200
Message-ID: <1345114825-10331-1-git-send-email-mbrugger@iseebcn.com>
References: <20120816101917.GK10736@arwen.pp.htv.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120816101917.GK10736@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthias Brugger <mbrugger@iseebcn.com>
List-Id: linux-omap@vger.kernel.org

Variable ret is always evaluated as true, so we don't need to check it.

Signed-off-by: Matthias Brugger <mbrugger@iseebcn.com>
---
 drivers/usb/musb/omap2430.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 5fdb9da..2d207c6 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -140,7 +140,6 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
 	struct usb_otg	*otg = musb->xceiv->otg;
 	u8		devctl;
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
-	int ret = 1;
 	/* HDRC controls CPEN, but beware current surges during device
 	 * connect.  They can trigger transient overcurrent conditions
 	 * that must be ignored.
@@ -164,12 +163,11 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
 				if (time_after(jiffies, timeout)) {
 					dev_err(musb->controller,
 					"configured as A device timeout");
-					ret = -EINVAL;
 					break;
 				}
 			}
 
-			if (ret && otg->set_vbus)
+			if (otg->set_vbus)
 				otg_set_vbus(otg, 1);
 		} else {
 			musb->is_active = 1;
-- 
1.7.9.5
