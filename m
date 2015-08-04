From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/7] phy: ti-pipe3: use ti_pipe3_power_off to power off the PHY during probe
Date: Tue, 4 Aug 2015 20:50:41 +0530
Message-ID: <1438701646-7876-3-git-send-email-kishon@ti.com>
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
off the PHY during probe. But once PIPE3 driver is adapted to use syscon,
omap_control_phy_power() cannot be used. Hence used ti_pipe3_power_off
to power off the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-ti-pipe3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 072d308..9782c16 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -474,8 +474,6 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	omap_control_phy_power(phy->control_dev, 0);
-
 	platform_set_drvdata(pdev, phy);
 	pm_runtime_enable(phy->dev);
 
@@ -494,6 +492,8 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 		return PTR_ERR(generic_phy);
 
 	phy_set_drvdata(generic_phy, phy);
+	ti_pipe3_power_off(generic_phy);
+
 	phy_provider = devm_of_phy_provider_register(phy->dev,
 			of_phy_simple_xlate);
 	if (IS_ERR(phy_provider))
-- 
1.7.9.5
