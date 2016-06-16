From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v3 3/5] power_supply: tps65217-charger: Add support for IRQs
Date: Thu, 16 Jun 2016 13:41:08 +0200
Message-ID: <20160616114110.23455-4-m.niestroj@grinn-global.com>
References: <20160616114110.23455-1-m.niestroj@grinn-global.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160616114110.23455-1-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>
List-Id: linux-omap@vger.kernel.org

Make use of IRQ resources defined in tps65217 mfd code. If they are valid
we use them instead separate poll task, in order to define AC power state.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
depends on patch 1 and 2 in series

 drivers/power/tps65217_charger.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/power/tps65217_charger.c b/drivers/power/tps65217_charger.c
index 73dfae4..c8c4a0c 100644
--- a/drivers/power/tps65217_charger.c
+++ b/drivers/power/tps65217_charger.c
@@ -46,6 +46,8 @@ struct tps65217_charger {
 	int	prev_ac_online;
 
 	struct task_struct	*poll_task;
+
+	int	irq;
 };
 
 static enum power_supply_property tps65217_ac_props[] = {
@@ -198,6 +200,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct tps65217_charger *charger;
 	struct power_supply_config cfg = {};
+	int irq;
 	int ret;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
@@ -220,18 +223,40 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->ac);
 	}
 
+	irq = platform_get_irq_byname(pdev, "AC");
+	if (irq < 0)
+		irq = -ENXIO;
+	charger->irq = irq;
+
 	ret = tps65217_config_charger(charger);
 	if (ret < 0) {
 		dev_err(charger->dev, "charger config failed, err %d\n", ret);
 		return ret;
 	}
 
-	charger->poll_task = kthread_run(tps65217_charger_poll_task,
-				      charger, "ktps65217charger");
-	if (IS_ERR(charger->poll_task)) {
-		ret = PTR_ERR(charger->poll_task);
-		dev_err(charger->dev, "Unable to run kthread err %d\n", ret);
-		return ret;
+	if (irq != -ENXIO) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						tps65217_charger_irq,
+						0, "tps65217-charger",
+						charger);
+		if (ret) {
+			dev_err(charger->dev,
+				"Unable to register irq %d err %d\n", irq,
+				ret);
+			return ret;
+		}
+
+		/* Check current state */
+		tps65217_charger_irq(irq, charger);
+	} else {
+		charger->poll_task = kthread_run(tps65217_charger_poll_task,
+						charger, "ktps65217charger");
+		if (IS_ERR(charger->poll_task)) {
+			ret = PTR_ERR(charger->poll_task);
+			dev_err(charger->dev,
+				"Unable to run kthread err %d\n", ret);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -241,7 +266,8 @@ static int tps65217_charger_remove(struct platform_device *pdev)
 {
 	struct tps65217_charger *charger = platform_get_drvdata(pdev);
 
-	kthread_stop(charger->poll_task);
+	if (charger->irq == -ENXIO)
+		kthread_stop(charger->poll_task);
 
 	return 0;
 }
-- 
2.8.3

