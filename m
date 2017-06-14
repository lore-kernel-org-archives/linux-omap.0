From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v6 2/4] power: supply: twl4030-charger: move allocation of iio channel to the beginning
Date: Wed, 14 Jun 2017 11:25:54 +0200
Message-ID: <0aa7052c6c8183ef12c08ed6aa069ddf8c748809.1497432355.git.hns@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497432355.git.hns@goldelico.com>
In-Reply-To: <cover.1497432355.git.hns@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is in prepraration for EPROBE_DEFER handling because it is quite
likely that geting the (madc) iio channel is deferred more often than
later steps.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 9507c24495ba..1fbbe0cc216a 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -984,6 +984,12 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
+	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
+	if (IS_ERR(bci->channel_vac)) {
+		bci->channel_vac = NULL;
+		dev_warn(&pdev->dev, "could not request vac iio channel");
+	}
+
 	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
 					     NULL);
 	if (IS_ERR(bci->ac)) {
@@ -1017,12 +1023,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
-	if (IS_ERR(bci->channel_vac)) {
-		bci->channel_vac = NULL;
-		dev_warn(&pdev->dev, "could not request vac iio channel");
-	}
-
 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
 	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
 
-- 
2.12.2
