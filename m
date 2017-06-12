From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/4] mfd: tps65217: remove duplicated interrupt resources.
Date: Mon, 12 Jun 2017 23:24:11 +0200
Message-ID: <20170612212412.22719-3-enric.balletbo@collabora.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612212412.22719-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, grygorii.strashko@ti.com, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

I don't think it makes sense to have the interrupt resources for charger
and power button in two different places, the driver and the DT binding.
That's confusing so remove the ones from the mfd driver in favour of
having the interrupt resources only described in the DT. Having the
resources in DT may help if there is or will be a similar pmic with
different resource allocation.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/tps65217.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index f769c7d..fd83bae 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -33,15 +33,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps65217.h>
 
-static struct resource charger_resources[] = {
-	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_AC, "AC"),
-	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
-};
-
-static struct resource pb_resources[] = {
-	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
-};
-
 static void tps65217_irq_lock(struct irq_data *data)
 {
 	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
@@ -97,14 +88,10 @@ static struct mfd_cell tps65217s[] = {
 	},
 	{
 		.name = "tps65217-charger",
-		.num_resources = ARRAY_SIZE(charger_resources),
-		.resources = charger_resources,
 		.of_compatible = "ti,tps65217-charger",
 	},
 	{
 		.name = "tps65217-pwrbutton",
-		.num_resources = ARRAY_SIZE(pb_resources),
-		.resources = pb_resources,
 		.of_compatible = "ti,tps65217-pwrbutton",
 	},
 };
@@ -359,15 +346,8 @@ static int tps65217_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (client->irq) {
+	if (client->irq)
 		tps65217_irq_init(tps, client->irq);
-	} else {
-		int i;
-
-		/* Don't tell children about IRQ resources which won't fire */
-		for (i = 0; i < ARRAY_SIZE(tps65217s); i++)
-			tps65217s[i].num_resources = 0;
-	}
 
 	ret = devm_mfd_add_devices(tps->dev, -1, tps65217s,
 				   ARRAY_SIZE(tps65217s), NULL, 0,
-- 
2.9.3
