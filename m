From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] usb: otg: twl4030: fix cold plug on OMAP3
Date: Fri, 15 Mar 2013 18:58:52 +0530
Message-ID: <1363354132-27523-4-git-send-email-kishon@ti.com>
References: <1363354132-27523-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363354132-27523-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Having twl4030_usb_phy_init() (detects if a cable is connected before
twl4030 is probed) in twl4030 probe makes cable connect events to be
missed by musb glue, since it gets loaded after twl4030. Having
twl4030_usb_phy_init as a usb_phy ops lets twl4030_usb_phy_init to be
called when glue is ready.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Tested-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/phy/phy-twl4030-usb.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
index e14b03e..1986c78 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
@@ -510,8 +510,9 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 	return IRQ_HANDLED;
 }
 
-static void twl4030_usb_phy_init(struct twl4030_usb *twl)
+static int twl4030_usb_phy_init(struct usb_phy *phy)
 {
+	struct twl4030_usb *twl = phy_to_twl(phy);
 	enum omap_musb_vbus_id_status status;
 
 	status = twl4030_usb_linkstat(twl);
@@ -528,6 +529,7 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 		omap_musb_mailbox(twl->linkstat);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
+	return 0;
 }
 
 static int twl4030_set_suspend(struct usb_phy *x, int suspend)
@@ -604,6 +606,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->phy.otg		= otg;
 	twl->phy.type		= USB_PHY_TYPE_USB2;
 	twl->phy.set_suspend	= twl4030_set_suspend;
+	twl->phy.init		= twl4030_usb_phy_init;
 
 	otg->phy		= &twl->phy;
 	otg->set_host		= twl4030_set_host;
@@ -641,11 +644,6 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	/* Power down phy or make it work according to
-	 * current link state.
-	 */
-	twl4030_usb_phy_init(twl);
