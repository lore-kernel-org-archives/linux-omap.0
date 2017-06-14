From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v6 1/4] power: supply: twl4030-charger: allocate iio by devm_iio_channel_get() and fix error path
Date: Wed, 14 Jun 2017 11:25:53 +0200
Message-ID: <cf004f21916eb8bc1c9421b076c298d801b90de0.1497432355.git.hns@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1497432355.git.hns@goldelico.com>
In-Reply-To: <cover.1497432355.git.hns@goldelico.com>
References: <cover.1497432355.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 785a07bc4f39..9507c24495ba 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1017,7 +1017,7 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	bci->channel_vac = iio_channel_get(&pdev->dev, "vac");
+	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
 		bci->channel_vac = NULL;
 		dev_warn(&pdev->dev, "could not request vac iio channel");
@@ -1044,7 +1044,7 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 			       TWL4030_INTERRUPTS_BCIIMR1A);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
-		goto fail;
+		return ret;
 	}
 
 	reg = ~(u32)(TWL4030_VBATOV | TWL4030_VBUSOV | TWL4030_ACCHGOV);
@@ -1073,10 +1073,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		twl4030_charger_enable_backup(0, 0);
 
 	return 0;
-fail:
-	iio_channel_release(bci->channel_vac);
-
-	return ret;
 }
 
 static int twl4030_bci_remove(struct platform_device *pdev)
@@ -1087,8 +1083,6 @@ static int twl4030_bci_remove(struct platform_device *pdev)
 	twl4030_charger_enable_usb(bci, false);
 	twl4030_charger_enable_backup(0, 0);
 
-	iio_channel_release(bci->channel_vac);
-
 	device_remove_file(&bci->usb->dev, &dev_attr_mode);
 	device_remove_file(&bci->ac->dev, &dev_attr_mode);
 	/* mask interrupts */
-- 
2.12.2
