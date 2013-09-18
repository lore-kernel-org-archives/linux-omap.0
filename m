From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 10/10] usb: phy: omap-usb2: Manage phy clock and not otg controller clock
Date: Wed, 18 Sep 2013 15:49:02 +0300
Message-ID: <1379508542-22389-11-git-send-email-rogerq@ti.com>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379508542-22389-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OTG_SS controller driver manages the OTG_SS clock. The phy driver
needs to manage the PHY's functional clock. So correct the clock name.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/phy-omap-usb2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-usb2.c b/drivers/usb/phy/phy-omap-usb2.c
index e7d4790..0fab250 100644
--- a/drivers/usb/phy/phy-omap-usb2.c
+++ b/drivers/usb/phy/phy-omap-usb2.c
@@ -179,9 +179,9 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 	clk_prepare(phy->wkupclk);
 
-	phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
+	phy->optclk = devm_clk_get(phy->dev, "usb_phy_refclk960m");
 	if (IS_ERR(phy->optclk))
-		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
+		dev_dbg(&pdev->dev, "unable to get refclk960m\n");
 	else
 		clk_prepare(phy->optclk);
 
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
