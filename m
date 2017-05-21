From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v5 3/3] drivers:power:twl4030-charger: add deferred probing for phy and iio
Date: Sun, 21 May 2017 12:38:18 +0200
Message-ID: <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1495363097.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1495363097.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1495363097.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This fixes an issue if both this twl4030_charger driver and
phy-twl4030-usb are compiled as modules and loaded in random order.
It has been observed on GTA04 and OpenPandora devices that in worst
case the boot process hangs and in best case the AC detection fails
with a warning.

Therefore we add deferred probing checks for the usb_phy and the
iio channel for AC detection.

For implementing this we must reorder code because we can't safely
return -EPROBE_DEFER after allocating any devm managed interrupt
(it might already/still be enabled without working interrupt handler).

So the check for required resources that may abort probing by
returning -EPROBE_DEFER, must come first.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 drivers/power/supply/twl4030_charger.c | 37 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 785a07bc4f39..945eabdbbc89 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -984,6 +984,28 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
+	if (bci->dev->of_node) {
+		struct device_node *phynode;
+
+		phynode = of_find_compatible_node(bci->dev->of_node->parent,
+						  NULL, "ti,twl4030-usb");
+		if (phynode) {
+			bci->transceiver = devm_usb_get_phy_by_node(
+				bci->dev, phynode, &bci->usb_nb);
+			if (IS_ERR(bci->transceiver) &&
+			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;	/* PHY not ready */
+		}
+	}
+
+	bci->channel_vac = iio_channel_get(&pdev->dev, "vac");
+	if (IS_ERR(bci->channel_vac)) {
+		if (PTR_ERR(bci->channel_vac) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;	/* iio not ready */
+		dev_warn(&pdev->dev, "could not request vac iio channel");
+		bci->channel_vac = NULL;
+	}
+
 	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
 					     NULL);
 	if (IS_ERR(bci->ac)) {
@@ -1017,25 +1039,10 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	bci->channel_vac = iio_channel_get(&pdev->dev, "vac");
-	if (IS_ERR(bci->channel_vac)) {
-		bci->channel_vac = NULL;
-		dev_warn(&pdev->dev, "could not request vac iio channel");
-	}
-
 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
 	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
 
 	bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
-	if (bci->dev->of_node) {
-		struct device_node *phynode;
-
-		phynode = of_find_compatible_node(bci->dev->of_node->parent,
-						  NULL, "ti,twl4030-usb");
-		if (phynode)
-			bci->transceiver = devm_usb_get_phy_by_node(
-				bci->dev, phynode, &bci->usb_nb);
-	}
 
 	/* Enable interrupts now. */
 	reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
