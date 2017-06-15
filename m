From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] power: supply: cpcap-charger: Add missing power_supply_config
Date: Wed, 14 Jun 2017 21:41:08 -0700
Message-ID: <20170615044108.26707-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

Otherwise cpcap-battery won't probe properly with the power-supplies
property configured but will fail with "Not all required supplies found,
defer probe".

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -637,6 +637,7 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 {
 	struct cpcap_charger_ddata *ddata;
 	const struct of_device_id *of_id;
+	struct power_supply_config psy_cfg = {};
 	int error;
 
 	of_id = of_match_device(of_match_ptr(cpcap_charger_id_table),
@@ -665,9 +666,12 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 
 	atomic_set(&ddata->active, 1);
 
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = ddata;
+
 	ddata->usb = devm_power_supply_register(ddata->dev,
 						&cpcap_charger_usb_desc,
-						NULL);
+						&psy_cfg);
 	if (IS_ERR(ddata->usb)) {
 		error = PTR_ERR(ddata->usb);
 		dev_err(ddata->dev, "failed to register USB charger: %i\n",
-- 
2.13.0
