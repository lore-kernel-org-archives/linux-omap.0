From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 07/11] usb: phy: samsung: Enable runtime power management on
 usb2phy
Date: Mon, 01 Apr 2013 19:24:06 +0530
Message-ID: <1364824448-14732-8-git-send-email-gautam.vivek@samsung.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Enable autosuspending of Samsung usb2.0 PHY

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/phy/phy-samsung-usb2.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-samsung-usb2.c b/drivers/usb/phy/phy-samsung-usb2.c
index 45ffe03..d378fe9 100644
--- a/drivers/usb/phy/phy-samsung-usb2.c
+++ b/drivers/usb/phy/phy-samsung-usb2.c
@@ -423,6 +423,9 @@ static int samsung_usb2phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sphy);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return usb_add_phy(&sphy->phy, USB_PHY_TYPE_USB2);
 }
 
@@ -432,6 +435,8 @@ static int samsung_usb2phy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&sphy->phy);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (sphy->pmuregs)
 		iounmap(sphy->pmuregs);
 	if (sphy->sysreg)
-- 
1.7.6.5
