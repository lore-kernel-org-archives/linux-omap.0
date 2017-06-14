From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v6 3/4] power: supply: twl4030-charger: move irq allocation to just before irqs are enabled
Date: Wed, 14 Jun 2017 11:25:55 +0200
Message-ID: <0eeffa7a6ab8e4213f518e2caf6982d2b77dc0b2.1497432355.git.hns@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497432355.git.hns@goldelico.com>
In-Reply-To: <cover.1497432355.git.hns@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This avoids a potential race if irqs are enabled and triggered too early
before the worker is properly set up.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 1fbbe0cc216a..3bebeecb4a1f 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -984,6 +984,16 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
+	if (bci->dev->of_node) {
+		struct device_node *phynode;
+
+		phynode = of_find_compatible_node(bci->dev->of_node->parent,
+						  NULL, "ti,twl4030-usb");
+		if (phynode)
+			bci->transceiver = devm_usb_get_phy_by_node(
+				bci->dev, phynode, &bci->usb_nb);
+	}
+
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
 		bci->channel_vac = NULL;
@@ -1006,6 +1016,10 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	INIT_WORK(&bci->work, twl4030_bci_usb_work);
+	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
+
+	bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
 	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_chg, NULL,
 			twl4030_charger_interrupt, IRQF_ONESHOT, pdev->name,
 			bci);
@@ -1023,20 +1037,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
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
