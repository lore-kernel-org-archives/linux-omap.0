From: NeilBrown <neilb@suse.de>
Subject: [PATCH 1/4] usb: phy: twl4030: make runtime pm more reliable.
Date: Tue, 24 Feb 2015 14:40:37 +1100
Message-ID: <20150224034036.31400.6133.stgit@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224033730.31400.78200.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

A construct like:

        if (pm_runtime_suspended(twl->dev))
               pm_runtime_get_sync(twl->dev);

is against the spirit of the runtime_pm interface as it
makes the internal refcounting useless.

In this case it is also racy, particularly as 'put_autosuspend'
is use to drop a reference.
When that happens a timer is started and the device is
runtime-suspended after the timeout.
If the above code runs in this window, the device will not be
found to be suspended so no pm_runtime reference is taken.
When the timer expires the device will be suspended, which is
against the intention of the code.

So be more direct is taking and dropping references.
If twl->linkstat is VBUS_VALID or ID_GROUND, then hold a
pm_runtime reference, otherwise don't.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/phy/phy-twl4030-usb.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 8e87f54671f3..97c59074233f 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -536,8 +536,13 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 
 	mutex_lock(&twl->lock);
 	if (status >= 0 && status != twl->linkstat) {
+		status_changed =
+			(twl->linkstat == OMAP_MUSB_VBUS_VALID ||
+			 twl->linkstat == OMAP_MUSB_ID_GROUND)
+			!=
+			(status == OMAP_MUSB_VBUS_VALID ||
+			 status == OMAP_MUSB_ID_GROUND);
 		twl->linkstat = status;
-		status_changed = true;
 	}
 	mutex_unlock(&twl->lock);
 
@@ -555,13 +560,10 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		 */
 		if ((status == OMAP_MUSB_VBUS_VALID) ||
 		    (status == OMAP_MUSB_ID_GROUND)) {
-			if (pm_runtime_suspended(twl->dev))
-				pm_runtime_get_sync(twl->dev);
+			pm_runtime_get_sync(twl->dev);
 		} else {
-			if (pm_runtime_active(twl->dev)) {
-				pm_runtime_mark_last_busy(twl->dev);
-				pm_runtime_put_autosuspend(twl->dev);
-			}
+			pm_runtime_mark_last_busy(twl->dev);
+			pm_runtime_put_autosuspend(twl->dev);
 		}
 		omap_musb_mailbox(status);
 	}
@@ -768,6 +770,10 @@ static int twl4030_usb_remove(struct platform_device *pdev)
 
 	/* disable complete OTG block */
 	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
+
+	if (twl->linkstat == OMAP_MUSB_VBUS_VALID ||
+	    twl->linkstat == OMAP_MUSB_ID_GROUND)
+		pm_runtime_put_noidle(twl->dev);
 	pm_runtime_mark_last_busy(twl->dev);
 	pm_runtime_put(twl->dev);
 
