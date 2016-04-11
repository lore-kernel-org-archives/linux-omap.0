From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] usb: dwc3: core: fix PHY handling during suspend
Date: Mon, 11 Apr 2016 17:12:34 +0300
Message-ID: <1460383954-3240-3-git-send-email-rogerq@ti.com>
References: <1460383954-3240-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460383954-3240-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@kernel.org>

we need to power off the PHY during suspend and
power it back on during resume.

Signed-off-by: Felipe Balbi <balbi@kernel.org>
[nsekhar@ti.com: fix call to usb_phy_set_suspend() in dwc3_suspend()]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 17fd8144..44ff68e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1162,6 +1162,11 @@ static int dwc3_suspend(struct device *dev)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	WARN_ON(phy_power_off(dwc->usb2_generic_phy) < 0);
+	WARN_ON(phy_power_off(dwc->usb3_generic_phy) < 0);
+
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -1175,11 +1180,21 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_usb2phy_power;
+
 	usb_phy_init(dwc->usb3_phy);
 	usb_phy_init(dwc->usb2_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
 	if (ret < 0)
-		return ret;
+		goto err_usb3phy_power;
 
 	ret = phy_init(dwc->usb3_generic_phy);
 	if (ret < 0)
@@ -1212,6 +1227,12 @@ static int dwc3_resume(struct device *dev)
 err_usb2phy_init:
 	phy_exit(dwc->usb2_generic_phy);
 
+err_usb3phy_power:
+	phy_power_off(dwc->usb3_generic_phy);
+
+err_usb2phy_power:
+	phy_power_off(dwc->usb2_generic_phy);
+
 	return ret;
 }
 
-- 
2.5.0
