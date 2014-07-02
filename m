From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 5/6] phy: omap-usb2: Balance pm_runtime_enable() on probe failure
Date: Wed, 2 Jul 2014 15:03:57 +0300
Message-ID: <1404302638-3003-6-git-send-email-rogerq@ti.com>
References: <1404302638-3003-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404302638-3003-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, kishon@ti.com, balbi@ti.com
Cc: nsekhar@ti.com, nm@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If probe fails then we need to call pm_runtime_disable() to balance
out the previous pm_runtime_enable() call. Else it will cause
unbalanced pm_runtime_enable() call in the succeding probe call.

This anomaly was observed when the call to devm_phy_create() failed
with -EPROBE_DEFER.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-omap-usb2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index 7007c11..c6f9809 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -265,15 +265,19 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	pm_runtime_enable(phy->dev);
 
 	generic_phy = devm_phy_create(phy->dev, &ops, NULL);
-	if (IS_ERR(generic_phy))
+	if (IS_ERR(generic_phy)) {
+		pm_runtime_disable(phy->dev);
 		return PTR_ERR(generic_phy);
+	}
 
 	phy_set_drvdata(generic_phy, phy);
 
 	phy_provider = devm_of_phy_provider_register(phy->dev,
 			of_phy_simple_xlate);
-	if (IS_ERR(phy_provider))
+	if (IS_ERR(phy_provider)) {
+		pm_runtime_disable(phy->dev);
 		return PTR_ERR(phy_provider);
+	}
 
 	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
 	if (IS_ERR(phy->wkupclk)) {
-- 
1.8.3.2
