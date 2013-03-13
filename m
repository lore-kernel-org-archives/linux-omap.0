From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/5] usb: otg: twl4030: fix cold plug on OMAP3
Date: Wed, 13 Mar 2013 14:17:10 +0530
Message-ID: <1363164430-19118-6-git-send-email-kishon@ti.com>
References: <1363164430-19118-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363164430-19118-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, notasas@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Having twl4030_usb_phy_init() (detects if a cable is connected before
twl4030 is probed) in twl4030 probe makes cable connect events to be
missed by musb glue, since it gets loaded after twl4030. Having
twl4030_usb_phy_init as a usb_phy ops lets twl4030_usb_phy_init to be
called when glue is ready.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/otg/twl4030-usb.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 5b20bb4..4040124 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -565,8 +565,9 @@ static void twl4030_id_workaround_work(struct work_struct *work)
 	}
 }
 
-static void twl4030_usb_phy_init(struct twl4030_usb *twl)
+static int twl4030_usb_phy_init(struct usb_phy *phy)
 {
+	struct twl4030_usb *twl = phy_to_twl(phy);
 	enum omap_musb_vbus_id_status status;
 
 	/*
@@ -581,6 +582,7 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 		omap_musb_mailbox(twl->linkstat);
 
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
+	return 0;
 }
 
 static int twl4030_set_suspend(struct usb_phy *x, int suspend)
@@ -657,6 +659,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->phy.otg		= otg;
 	twl->phy.type		= USB_PHY_TYPE_USB2;
 	twl->phy.set_suspend	= twl4030_set_suspend;
+	twl->phy.init		= twl4030_usb_phy_init;
 
 	otg->phy		= &twl->phy;
 	otg->set_host		= twl4030_set_host;
@@ -696,8 +699,6 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	twl4030_usb_phy_init(twl);
-
 	dev_info(&pdev->dev, "Initialized TWL4030 USB module\n");
 	return 0;
 }
-- 
1.7.10.4
