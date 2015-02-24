From: NeilBrown <neilb@suse.de>
Subject: [PATCH 03/15] twl4030_charger: use devres for power_supply_register
 and kzalloc.
Date: Tue, 24 Feb 2015 15:33:50 +1100
Message-ID: <20150224043350.4243.6164.stgit@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224043341.4243.23291.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Final allocations/registrations are now managed by devres.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 300dd7a34e80..51321f0c5548 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -565,7 +565,7 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	int ret;
 	u32 reg;
 
-	bci = kzalloc(sizeof(*bci), GFP_KERNEL);
+	bci = devm_kzalloc(&pdev->dev, sizeof(*bci), GFP_KERNEL);
 	if (bci == NULL)
 		return -ENOMEM;
 
@@ -580,7 +580,7 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	ret = twl4030_is_battery_present(bci);
 	if  (ret) {
 		dev_crit(&pdev->dev, "Battery was not detected:%d\n", ret);
-		goto fail_no_battery;
+		goto fail;
 	}
 
 	platform_set_drvdata(pdev, bci);
@@ -590,10 +590,10 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	bci->ac.num_properties = ARRAY_SIZE(twl4030_charger_props);
 	bci->ac.get_property = twl4030_bci_get_property;
 
-	ret = power_supply_register(&pdev->dev, &bci->ac);
+	ret = devm_power_supply_register(&pdev->dev, &bci->ac);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ac: %d\n", ret);
-		goto fail_register_ac;
+		goto fail;
 	}
 
 	bci->usb.name = "twl4030_usb";
@@ -604,10 +604,10 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 
 	bci->usb_reg = regulator_get(bci->dev, "bci3v1");
 
-	ret = power_supply_register(&pdev->dev, &bci->usb);
+	ret = devm_power_supply_register(&pdev->dev, &bci->usb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register usb: %d\n", ret);
-		goto fail_register_usb;
+		goto fail;
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_chg, NULL,
@@ -667,13 +667,6 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
-	power_supply_unregister(&bci->usb);
-fail_register_usb:
-	power_supply_unregister(&bci->ac);
-fail_register_ac:
-fail_no_battery:
-	kfree(bci);
-
 	return ret;
 }
 
@@ -691,10 +684,6 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR2A);
 
-	power_supply_unregister(&bci->usb);
-	power_supply_unregister(&bci->ac);
-	kfree(bci);
-
 	return 0;
 }
 
