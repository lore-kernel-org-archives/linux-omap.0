From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 01/10] mfd: ti-lmu: constify mfd_cell tables
Date: Fri, 30 Mar 2018 19:24:05 +0200
Message-ID: <20180330172414.26575-2-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add const attribute to all mfd_cell structures.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/ti-lmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index cfb411cde51c..990437e5ed0a 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 
 struct ti_lmu_data {
-	struct mfd_cell *cells;
+	const struct mfd_cell *cells;
 	int num_cells;
 	unsigned int max_register;
 };
@@ -63,7 +63,7 @@ static void ti_lmu_disable_hw(struct ti_lmu *lmu)
 		gpio_set_value(lmu->en_gpio, 0);
 }
 
-static struct mfd_cell lm3532_devices[] = {
+static const struct mfd_cell lm3532_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3532,
@@ -78,7 +78,7 @@ static struct mfd_cell lm3532_devices[] = {
 	.of_compatible = "ti,lm363x-regulator",	\
 }						\
 
-static struct mfd_cell lm3631_devices[] = {
+static const struct mfd_cell lm3631_devices[] = {
 	LM363X_REGULATOR(LM3631_BOOST),
 	LM363X_REGULATOR(LM3631_LDO_CONT),
 	LM363X_REGULATOR(LM3631_LDO_OREF),
@@ -91,7 +91,7 @@ static struct mfd_cell lm3631_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3632_devices[] = {
+static const struct mfd_cell lm3632_devices[] = {
 	LM363X_REGULATOR(LM3632_BOOST),
 	LM363X_REGULATOR(LM3632_LDO_POS),
 	LM363X_REGULATOR(LM3632_LDO_NEG),
@@ -102,7 +102,7 @@ static struct mfd_cell lm3632_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3633_devices[] = {
+static const struct mfd_cell lm3633_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3633,
@@ -120,7 +120,7 @@ static struct mfd_cell lm3633_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3695_devices[] = {
+static const struct mfd_cell lm3695_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3695,
@@ -128,7 +128,7 @@ static struct mfd_cell lm3695_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3697_devices[] = {
+static const struct mfd_cell lm3697_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3697,
-- 
2.16.2
