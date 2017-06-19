From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 2/2] power: supply: twl4030-charger: add deferred probing for phy and iio
Date: Mon, 19 Jun 2017 10:41:46 +0200
Message-ID: <63d2c2c5bfb1bb8ec006c1991bbd01e8d102c341.1497861705.git.hns@goldelico.com>
References: <cover.1497861705.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497861705.git.hns@goldelico.com>
In-Reply-To: <cover.1497861705.git.hns@goldelico.com>
References: <cover.1497861705.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This fixes an issue if both this twl4030_charger driver and
phy-twl4030-usb are compiled as modules and loaded in random order.

It has been observed on GTA04 and OpenPandora devices that in worst
case the boot process hangs and in best case the AC detection fails
with a warning.

Therefore we add deferred probing checks for the usb_phy and the
iio channel for AC detection.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 9d974f1e3957..0d2125e4f735 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -989,8 +989,12 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
+		ret = PTR_ERR(bci->channel_vac);
+		if (ret == -EPROBE_DEFER)
+			return ret;	/* iio not ready */
+		dev_warn(&pdev->dev, "could not request vac iio channel (%d)",
+			ret);
 		bci->channel_vac = NULL;
-		dev_warn(&pdev->dev, "could not request vac iio channel");
 	}
 
 	if (bci->dev->of_node) {
@@ -1002,6 +1006,14 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
 			bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
+			if (IS_ERR(bci->transceiver)) {
+				ret = PTR_ERR(bci->transceiver);
+				if (ret == -EPROBE_DEFER)
+					return ret;	/* phy not ready */
+				dev_warn(&pdev->dev, "could not request transceiver (%d)",
+					ret);
+				bci->transceiver = NULL;
+			}
 		}
 	}
 
-- 
2.12.2
