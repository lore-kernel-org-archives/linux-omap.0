From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v6 4/4] power: supply: twl4030-charger: add deferred probing for phy and iio
Date: Wed, 14 Jun 2017 11:25:56 +0200
Message-ID: <6573ec523aa73971562c9b7e7d89f6045185d8c4.1497432355.git.hns@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1497432355.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1497432355.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1497432355.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This fixes an issue if both this twl4030_charger driver and
phy-twl4030-usb are compiled as modules and loaded in random order.

It has been observed on GTA04 and OpenPandora devices that in worst
case the boot process hangs and in best case the AC detection fails
with a warning.

Therefore we add deferred probing checks for the usb_phy and the
iio channel for AC detection.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 drivers/power/supply/twl4030_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 3bebeecb4a1f..6ac8816262bd 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -989,15 +989,21 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 		phynode = of_find_compatible_node(bci->dev->of_node->parent,
 						  NULL, "ti,twl4030-usb");
-		if (phynode)
+		if (phynode) {
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
+			if (IS_ERR(bci->transceiver) &&
+			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;	/* PHY not ready */
+		}
 	}
 
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
-		bci->channel_vac = NULL;
+		if (PTR_ERR(bci->channel_vac) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;	/* iio not ready */
 		dev_warn(&pdev->dev, "could not request vac iio channel");
+		bci->channel_vac = NULL;
 	}
 
 	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
