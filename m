From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/3] mfd: twl6040: Add twl6040-gpio child
Date: Thu, 16 Aug 2012 15:13:14 +0300
Message-ID: <1345119195-7490-3-git-send-email-peter.ujfalusi@ti.com>
References: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:33898 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753855Ab2HPMNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:13:07 -0400
Received: by obbta17 with SMTP id ta17so4302861obb.8
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 05:13:06 -0700 (PDT)
In-Reply-To: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, peter.ujfalusi@ti.com, Sergio Aguirre <saaguirre@ti.com>

Add needed platform data structure and code to be able to load
the GPO child of twl6040.
Update the devicetree binding documentation at the same time.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/mfd/twl6040.txt |    9 ++++++---
 drivers/mfd/twl6040-core.c                        |   15 +++++++++++++++
 include/linux/mfd/twl6040.h                       |    9 ++++++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/twl6040.txt b/Documentation/devicetree/bindings/mfd/twl6040.txt
index c855240..0f5dd70 100644
--- a/Documentation/devicetree/bindings/mfd/twl6040.txt
+++ b/Documentation/devicetree/bindings/mfd/twl6040.txt
@@ -1,7 +1,7 @@
 Texas Instruments TWL6040 family
 
-The TWL6040s are 8-channel high quality low-power audio codecs providing audio
-and vibra functionality on OMAP4+ platforms.
+The TWL6040s are 8-channel high quality low-power audio codecs providing audio,
+vibra and GPO functionality on OMAP4+ platforms.
 They are connected ot the host processor via i2c for commands, McPDM for audio
 data and commands.
 
@@ -10,6 +10,8 @@ Required properties:
 - reg: must be 0x4b for i2c address
 - interrupts: twl6040 has one interrupt line connecteded to the main SoC
 - interrupt-parent: The parent interrupt controller
+- gpio-controller:
+- #gpio-cells = <1>: twl6040 provides GPO lines.
 - twl6040,audpwron-gpio: Power on GPIO line for the twl6040
 
 - vio-supply: Regulator for the twl6040 VIO supply
@@ -37,7 +39,6 @@ Example:
 &i2c1 {
 	twl6040: twl@4b {
 		compatible = "ti,twl6040";
-		reg = <0x4b>;
 
 		interrupts = <0 119 4>;
 		interrupt-parent = <&gic>;
@@ -60,3 +61,5 @@ Example:
 		};
 	};
 };
+
+/include/ "twl6040.dtsi"
diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
index b0fad0f..413df8e 100644
--- a/drivers/mfd/twl6040-core.c
+++ b/drivers/mfd/twl6040-core.c
@@ -631,6 +631,21 @@ static int __devinit twl6040_probe(struct i2c_client *client,
 		children++;
 	}
 
+	/*
+	 * Enable the GPO driver in the following cases:
+	 * DT booted kernel or legacy boot with valid gpo platform_data
+	 */
+	if (!pdata || (pdata && pdata->gpo)) {
+		cell = &twl6040->cells[children];
+		cell->name = "twl6040-gpo";
+
+		if (pdata) {
+			cell->platform_data = pdata->gpo;
+			cell->pdata_size = sizeof(*pdata->gpo);
+		}
+		children++;
+	}
+
 	ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
 			      NULL, 0);
 	if (ret)
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 269b706..8991532 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -158,7 +158,7 @@
 #define TWL6040_VIBROCDET		0x20
 #define TWL6040_TSHUTDET                0x40
 
-#define TWL6040_CELLS			2
+#define TWL6040_CELLS			3
 
 #define TWL6040_REV_ES1_0		0x00
 #define TWL6040_REV_ES1_1		0x01 /* Rev ES1.1 and ES1.2 */
@@ -176,6 +176,8 @@
 #define TWL6040_SYSCLK_SEL_LPPLL	0
 #define TWL6040_SYSCLK_SEL_HPPLL	1
 
+#define TWL6040_GPO_MAX	3
+
 struct twl6040_codec_data {
 	u16 hs_left_step;
 	u16 hs_right_step;
@@ -192,12 +194,17 @@ struct twl6040_vibra_data {
 	int vddvibr_uV;			/* VDDVIBR volt, set 0 for fixed reg */
 };
 
+struct twl6040_gpo_data {
+	int gpio_base;
+};
+
 struct twl6040_platform_data {
 	int audpwron_gpio;	/* audio power-on gpio */
 	unsigned int irq_base;
 
 	struct twl6040_codec_data *codec;
 	struct twl6040_vibra_data *vibra;
+	struct twl6040_gpo_data *gpo;
 };
 
 struct regmap;
-- 
1.7.8.6

