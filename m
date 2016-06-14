From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 2/5] power_supply: tps65217-charger: Fix NULL deref during property export
Date: Tue, 14 Jun 2016 15:29:24 +0200
Message-ID: <20160614132927.3309-3-m.niestroj@grinn-global.com>
References: <20160614132927.3309-1-m.niestroj@grinn-global.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160614132927.3309-1-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>
List-Id: linux-omap@vger.kernel.org

This bug leads to:

[    1.906411] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[    1.914878] pgd = c0004000
[    1.917786] [0000000c] *pgd=00000000
[    1.921536] Internal error: Oops: 5 [#1] SMP ARM
[    1.926357] Modules linked in:
[    1.929556] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.4.5 #18
[    1.936006] Hardware name: Generic AM33XX (Flattened Device Tree)
[    1.942383] Workqueue: events power_supply_changed_work
[    1.947842] task: de2c41c0 ti: de2c8000 task.ti: de2c8000
[    1.953483] PC is at tps65217_ac_get_property+0x14/0x28
[    1.958937] LR is at tps65217_ac_get_property+0x10/0x28

Driver was trying to use drv_data in property get handler. However drv_data
was not set, so it caused NULL pointer dereference. This patch properly
sets drv_data during probe by power_supply_config parameter, so the
property get handler works as desired.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
 drivers/power/tps65217_charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/tps65217_charger.c b/drivers/power/tps65217_charger.c
index d9f5673..73dfae4 100644
--- a/drivers/power/tps65217_charger.c
+++ b/drivers/power/tps65217_charger.c
@@ -197,6 +197,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 {
 	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct tps65217_charger *charger;
+	struct power_supply_config cfg = {};
 	int ret;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
@@ -208,9 +209,12 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	charger->tps = tps;
 	charger->dev = &pdev->dev;
 
+	cfg.of_node = pdev->dev.of_node;
+	cfg.drv_data = charger;
+
 	charger->ac = devm_power_supply_register(&pdev->dev,
 						 &tps65217_charger_desc,
-						 NULL);
+						 &cfg);
 	if (IS_ERR(charger->ac)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		return PTR_ERR(charger->ac);
-- 
2.8.3

