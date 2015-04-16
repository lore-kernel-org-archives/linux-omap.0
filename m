From: NeilBrown <neil@brown.name>
Subject: [PATCH 3/6] phy: twl4030-usb: remove incorrect
 pm_runtime_get_sync() in probe function.
Date: Thu, 16 Apr 2015 18:03:04 +1000
Message-ID: <20150416080304.23307.55760.stgit@notabene.brown>
References: <20150416075945.23307.24424.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150416075945.23307.24424.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-omap@vger.kernel.org

The USB phy should initialize with power-off, and will be powered on
by the USB system when a cable connection is detected.

Having this pm_runtime_get_sync() during probe causes the phy to
*always* be powered on.
Removing it returns to sensible power management.

Fixes: 96be39ab34b77c6f6f5cd6ae03aac6c6449ee5c4
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/phy/phy-twl4030-usb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 590c2b1c1a94..3a707dd14238 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -715,7 +715,6 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
