From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v8 1/2] power: supply: twl4030-charger: move irq allocation to just before irqs are enabled
Date: Mon,  3 Jul 2017 18:37:10 +0200
Message-ID: <b7ff97460c40593e92a83abbb3b70a58316f9b63.1499099830.git.hns@goldelico.com>
References: <cover.1499099830.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1499099830.git.hns@goldelico.com>
In-Reply-To: <cover.1499099830.git.hns@goldelico.com>
References: <cover.1499099830.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

And initialize workers and notifiers as soon as possible.

This avoids a potential race if irqs are enabled and triggered too early
before the worker is properly set up.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 1fbbe0cc216a..fde6f07ba8c3 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -984,12 +984,27 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
+	INIT_WORK(&bci->work, twl4030_bci_usb_work);
+	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
+
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
 		bci->channel_vac = NULL;
 		dev_warn(&pdev->dev, "could not request vac iio channel");
 	}
 
+	if (bci->dev->of_node) {
+		struct device_node *phynode;
+
+		phynode = of_find_compatible_node(bci->dev->of_node->parent,
+						  NULL, "ti,twl4030-usb");
+		if (phynode) {
+			bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
+			bci->transceiver = devm_usb_get_phy_by_node(
+				bci->dev, phynode, &bci->usb_nb);
+		}
+	}
+
 	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
 					     NULL);
 	if (IS_ERR(bci->ac)) {
@@ -1023,20 +1038,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	INIT_WORK(&bci->work, twl4030_bci_usb_work);
-	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
-
-	bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
-	if (bci->dev->of_node) {
-		struct device_node *phynode;
-
-		phynode = of_find_compatible_node(bci->dev->of_node->parent,
-						  NULL, "ti,twl4030-usb");
-		if (phynode)
-			bci->transceiver = devm_usb_get_phy_by_node(
-				bci->dev, phynode, &bci->usb_nb);
-	}
-
 	/* Enable interrupts now. */
 	reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
 		TWL4030_TBATOR1 | TWL4030_BATSTS);
-- 
2.12.2
