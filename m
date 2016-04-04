From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH 2/5] power_supply: tps65217-charger: Fix NULL deref during property export
Date: Mon,  4 Apr 2016 19:11:02 +0200
Message-ID: <1459789865-3704-4-git-send-email-m.niestroj@grinn-global.com>
References: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459789865-3704-1-git-send-email-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
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

Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
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
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
