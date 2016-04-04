From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH 3/5] power_supply: tps65217-charger: Add support for IRQs
Date: Mon,  4 Apr 2016 19:11:03 +0200
Message-ID: <1459789865-3704-5-git-send-email-m.niestroj@grinn-global.com>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459789865-3704-1-git-send-email-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Make use of IRQ resources defined in tps65217 mfd code. If they are valid
we use them instead separate poll task, in order to define AC power state.

Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
---
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
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
