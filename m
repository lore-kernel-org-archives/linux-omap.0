From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] usb: phy: omap-otg: do not write to unallocated memory
Date: Fri, 20 Nov 2015 00:43:01 +0100
Message-ID: <1447976581-12666-1-git-send-email-xypron.glpk@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-Id: linux-omap@vger.kernel.org

The current coding writes to memory before allocating it.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/usb/phy/phy-omap-otg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
index 1270906..8bbf121 100644
--- a/drivers/usb/phy/phy-omap-otg.c
+++ b/drivers/usb/phy/phy-omap-otg.c
@@ -105,12 +105,13 @@ static int omap_otg_probe(struct platform_device *pdev)
 	extcon = extcon_get_extcon_dev(config->extcon);
 	if (!extcon)
 		return -EPROBE_DEFER;
-	otg_dev->extcon = extcon;
 
 	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
 	if (!otg_dev)
 		return -ENOMEM;
 
+	otg_dev->extcon = extcon;
+
 	otg_dev->base = devm_ioremap_resource(&pdev->dev, &pdev->resource[0]);
 	if (IS_ERR(otg_dev->base))
 		return PTR_ERR(otg_dev->base);
-- 
2.1.4
