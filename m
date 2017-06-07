From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 4/4] mfd: tps65217: Instantiate sub-devices from device tree
Date: Wed,  7 Jun 2017 12:32:42 +0200
Message-ID: <20170607103242.16008-4-enric.balletbo@collabora.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607103242.16008-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

The driver boots only via device tree but currently all the MFD sub-devices
are instatiated independently of the device tree configuration, i.e
although tps65217-charger is disabled by default it's instantiated by the
MFD driver.

Instead of register all sub-devices, if the TPS65217 device tree node has a
sub-node enabled, try to instatiate them as MFD sub-devices but not
instantiate sub-nodes that are not enabled.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/tps65217.c       | 56 +++++++-------------------------------------
 include/linux/mfd/tps65217.h |  6 -----
 2 files changed, 9 insertions(+), 53 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index f769c7d..9effdda 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -33,14 +33,7 @@
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
+#define TPS65217_NUM_IRQ	3
 
 static void tps65217_irq_lock(struct irq_data *data)
 {
@@ -86,29 +79,6 @@ static struct irq_chip tps65217_irq_chip = {
 	.irq_disable		= tps65217_irq_disable,
 };
 
-static struct mfd_cell tps65217s[] = {
-	{
-		.name = "tps65217-pmic",
-		.of_compatible = "ti,tps65217-pmic",
-	},
-	{
-		.name = "tps65217-bl",
-		.of_compatible = "ti,tps65217-bl",
-	},
-	{
-		.name = "tps65217-charger",
-		.num_resources = ARRAY_SIZE(charger_resources),
-		.resources = charger_resources,
-		.of_compatible = "ti,tps65217-charger",
-	},
-	{
-		.name = "tps65217-pwrbutton",
-		.num_resources = ARRAY_SIZE(pb_resources),
-		.resources = pb_resources,
-		.of_compatible = "ti,tps65217-pwrbutton",
-	},
-};
-
 static irqreturn_t tps65217_irq_thread(int irq, void *data)
 {
 	struct tps65217 *tps = data;
@@ -359,23 +329,8 @@ static int tps65217_probe(struct i2c_client *client,
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
-
-	ret = devm_mfd_add_devices(tps->dev, -1, tps65217s,
-				   ARRAY_SIZE(tps65217s), NULL, 0,
-				   tps->irq_domain);
-	if (ret < 0) {
-		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
-		return ret;
-	}
 
 	ret = tps65217_reg_read(tps, TPS65217_REG_CHIPID, &version);
 	if (ret < 0) {
@@ -384,6 +339,13 @@ static int tps65217_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
+				   &client->dev);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register sub-devices\n");
+		return ret;
+	}
+
 	/* Set the PMIC to shutdown on PWR_EN toggle */
 	if (status_off) {
 		ret = tps65217_set_bits(tps, TPS65217_REG_STATUS,
diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
index eac2857..dfc51f5 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -236,12 +236,6 @@ struct tps65217_bl_pdata {
 	int dft_brightness;
 };
 
-/* Interrupt numbers */
-#define TPS65217_IRQ_USB		0
-#define TPS65217_IRQ_AC			1
-#define TPS65217_IRQ_PB			2
-#define TPS65217_NUM_IRQ		3
-
 /**
  * struct tps65217_board - packages regulator init data
  * @tps65217_regulator_data: regulator initialization values
-- 
2.9.3
