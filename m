From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [RESEND PATCH v4 2/3] mfd: tps65217: Add power button as subdevice
Date: Fri,  2 Sep 2016 12:35:25 +0200
Message-ID: <20160902103526.5050-3-m.niestroj@grinn-global.com>
References: <20160902103526.5050-1-m.niestroj@grinn-global.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160902103526.5050-1-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Marcin Niestroj <m.niestroj@grinn-global.com>
List-Id: linux-omap@vger.kernel.org

Add tps65217 power buttor subdevice with assigned IRQ resources.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Depends on patch 1 in series

Changes v1 -> v4: none

 drivers/mfd/tps65217.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 41b5d59..57c8741 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -38,6 +38,10 @@ static struct resource charger_resources[] = {
 	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
 };
 
+static struct resource pb_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
+};
+
 struct tps65217_irq {
 	int mask;
 	int interrupt;
@@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] = {
 		.resources = charger_resources,
 		.of_compatible = "ti,tps65217-charger",
 	},
+	{
+		.name = "tps65217-pwrbutton",
+		.num_resources = ARRAY_SIZE(pb_resources),
+		.resources = pb_resources,
+		.of_compatible = "ti,tps65217-pwrbutton",
+	},
 };
 
 static irqreturn_t tps65217_irq_thread(int irq, void *data)
-- 
2.9.3

