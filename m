From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] phy: twl4030-usb: Fix unbalanced pm_runtime_enable on module reload
Date: Mon, 30 Nov 2015 21:39:54 -0800
Message-ID: <1448948394-32078-3-git-send-email-tony@atomide.com>
References: <1448948394-32078-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448948394-32078-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <b-liu@ti.com>, Felipe Balbi <balbi@ti.com>, NeilBrown <neil@brown.name>
List-Id: linux-omap@vger.kernel.org

If we reload phy-twl4030-usb, we get a warning about unbalanced
pm_runtime_enable. Let's fix the issue and also fix idling of the
device on unload before we attempt to shut it down.

If we don't properly idle the PHY before shutting it down on removal,
the twl4030 ends up consuming about 62mW of extra power compared to
running idle with the module loaded.

Cc: Bin Liu <b-liu@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: NeilBrown <neil@brown.name>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/phy-twl4030-usb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 79870c4..f96065a 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -715,6 +715,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
@@ -758,6 +759,13 @@ static int twl4030_usb_remove(struct platform_device *pdev)
 	/* set transceiver mode to power on defaults */
 	twl4030_usb_set_mode(twl, -1);
 
+	/* idle ulpi before powering off */
+	if (cable_present(twl->linkstat))
+		pm_runtime_put_noidle(twl->dev);
+	pm_runtime_mark_last_busy(twl->dev);
+	pm_runtime_put_sync_suspend(twl->dev);
+	pm_runtime_disable(twl->dev);
+
 	/* autogate 60MHz ULPI clock,
 	 * clear dpll clock request for i2c access,
 	 * disable 32KHz
@@ -772,11 +780,6 @@ static int twl4030_usb_remove(struct platform_device *pdev)
 	/* disable complete OTG block */
 	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
 
-	if (cable_present(twl->linkstat))
-		pm_runtime_put_noidle(twl->dev);
-	pm_runtime_mark_last_busy(twl->dev);
-	pm_runtime_put(twl->dev);
-
 	return 0;
 }
 
-- 
2.6.2
