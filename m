From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/7] phy: omap-usb2: use omap_usb_power_off to power off the PHY during probe
Date: Tue, 4 Aug 2015 20:50:44 +0530
Message-ID: <1438701646-7876-6-git-send-email-kishon@ti.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438701646-7876-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
Cc: balbi@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Previously omap_control_phy_power() was used to power
off the PHY during probe. But once phy-omap-usb2 driver is adapted to
use syscon, omap_control_phy_power() cannot be used. Hence used
omap_usb_power_off to power off the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-omap-usb2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index c1a4686..b5c266a 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -241,7 +241,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy->control_dev = &control_pdev->dev;
-	omap_control_phy_power(phy->control_dev, 0);
 
 	otg->set_host		= omap_usb_set_host;
 	otg->set_peripheral	= omap_usb_set_peripheral;
@@ -261,6 +260,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy_set_drvdata(generic_phy, phy);
+	omap_usb_power_off(generic_phy);
 
 	phy_provider = devm_of_phy_provider_register(phy->dev,
 			of_phy_simple_xlate);
-- 
1.7.9.5
