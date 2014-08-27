From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] usb: phy: twl4030-usb: Simplify phy init to use runtime PM
Date: Wed, 27 Aug 2014 16:28:08 -0700
Message-ID: <1409182091-31191-3-git-send-email-tony@atomide.com>
References: <1409182091-31191-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409182091-31191-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: balbi@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can now let the interrupt and delayed work do all that's
needed with runtime PM.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/phy-twl4030-usb.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index bc28ecc..a292db0 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -471,16 +471,8 @@ static int twl4030_phy_power_on(struct phy *phy)
 	twl4030_usb_set_mode(twl, twl->usb_mode);
 	if (twl->usb_mode == T2_USB_MODE_ULPI)
 		twl4030_i2c_access(twl, 0);
+	schedule_delayed_work(&twl->id_workaround_work, 0);
 
-	/*
-	 * XXX When VBUS gets driven after musb goes to A mode,
-	 * ID_PRES related interrupts no longer arrive, why?
-	 * Register itself is updated fine though, so we must poll.
-	 */
-	if (twl->linkstat == OMAP_MUSB_ID_GROUND) {
-		cancel_delayed_work(&twl->id_workaround_work);
-		schedule_delayed_work(&twl->id_workaround_work, HZ);
-	}
 	return 0;
 }
 
@@ -612,16 +604,9 @@ static void twl4030_id_workaround_work(struct work_struct *work)
 static int twl4030_phy_init(struct phy *phy)
 {
 	struct twl4030_usb *twl = phy_get_drvdata(phy);
-	enum omap_musb_vbus_id_status status;
 
 	pm_runtime_get_sync(twl->dev);
-	status = twl4030_usb_linkstat(twl);
-	twl->linkstat = status;
-
-	if (status == OMAP_MUSB_ID_GROUND || status == OMAP_MUSB_VBUS_VALID)
-		omap_musb_mailbox(twl->linkstat);
-
-	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
+	schedule_delayed_work(&twl->id_workaround_work, 0);
 	pm_runtime_mark_last_busy(twl->dev);
 	pm_runtime_put_autosuspend(twl->dev);
 
@@ -698,6 +683,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
 	twl->vbus_supplied	= false;
+	twl->linkstat		= -EINVAL;
 	twl->asleep		= 1;
 	twl->linkstat		= OMAP_MUSB_UNKNOWN;
 
-- 
1.8.1.1
