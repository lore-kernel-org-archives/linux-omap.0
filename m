From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 6/6] leds: lm3697: Add ramp rate feature
Date: Tue, 11 Sep 2018 12:08:25 -0500
Message-ID: <20180911170825.17789-7-dmurphy@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911170825.17789-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the runtime ramp up and down of the
LEDs in the specific control bank.

Each control bank can have separate ramp up
and ramp down values for the lighting zones
the control banks manage.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v7 - New change for the series to support feature in ti-lmu

 drivers/leds/leds-lm3697.c | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/leds/leds-lm3697.c b/drivers/leds/leds-lm3697.c
index 7416c545ec59..997c270a46b5 100644
--- a/drivers/leds/leds-lm3697.c
+++ b/drivers/leds/leds-lm3697.c
@@ -59,6 +59,8 @@ struct lm3697_led {
 	struct led_classdev led_dev;
 	struct lm3697 *priv;
 	int control_bank;
+	int ramp_up_rate;
+	int ramp_down_rate;
 };
 
 /**
@@ -178,6 +180,62 @@ static int lm3697_set_control_bank(struct lm3697 *priv)
 	return ret;
 }
 
+static int lm3697_find_ramp_reg_val(int rate)
+{
+	const static int lookup[16] = { 2, 262, 524, 1049, 2090, 4194, 8389,
+					16780, 33550, 41940, 50330, 58720,
+					67110, 83880, 100660, 117440};
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(lookup); i++) {
+		if (rate == lookup[i])
+			return i;
+
+		if (rate > lookup[i - 1] && rate < lookup[i]) {
+			if (rate - lookup[i - 1] < lookup[i] - rate)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int lm3697_set_ramp_rates(struct lm3697 *priv)
+{
+	u8 ramp, ramp_up, ramp_down;
+	struct lm3697_led *led;
+	u8 ramp_reg;
+	int i, ret = 0;
+
+	for (i = 0; i < 2; i++) {
+		led = &priv->leds[i];
+		if (led->ramp_up_rate == 0 && led->ramp_down_rate == 0)
+			continue;
+
+		if (led->control_bank == LM3697_CONTROL_A)
+			ramp_reg = LM3697_CTRL_A_RAMP;
+		else
+			ramp_reg = LM3697_CTRL_B_RAMP;
+
+		ramp_up = lm3697_find_ramp_reg_val(led->ramp_up_rate);
+		ramp_down = lm3697_find_ramp_reg_val(led->ramp_down_rate);
+
+		if (ramp_up < 0 || ramp_down < 0) {
+			dev_err(&priv->client->dev, "Cannot find ramp rate\n");
+			continue;
+		}
+
+		ramp = (ramp_up << 4) | ramp_down;
+		ret = regmap_write(priv->regmap, ramp_reg, ramp);
+		if (ret)
+			dev_err(&priv->client->dev, "Cannot write ramp config\n");
+	}
+
+	return ret;
+}
+
 static int lm3697_init(struct lm3697 *priv)
 {
 	int ret;
@@ -202,6 +260,9 @@ static int lm3697_init(struct lm3697 *priv)
 	if (ret)
 		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
 
+	ret = lm3697_set_ramp_rates(priv);
+	if (ret)
+		dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
 out:
 	return ret;
 }
@@ -254,6 +315,17 @@ static int lm3697_probe_dt(struct lm3697 *priv)
 			goto child_out;
 		}
 
+		ret = fwnode_property_read_u32(child, "runtime-ramp-up-msec",
+					       &led->ramp_up_rate);
+		if (ret)
+			dev_warn(&priv->client->dev, "runtime-ramp-up-msec property missing\n");
+
+		ret = fwnode_property_read_u32(child, "runtime-ramp-down-msec",
+					       &led->ramp_down_rate);
+		if (ret)
+			dev_warn(&priv->client->dev, "runtime-ramp-down-msec property missing\n");
+
+
 		fwnode_property_read_string(child, "linux,default-trigger",
 					    &led->led_dev.default_trigger);
 
-- 
2.17.0.1855.g63749b2dea
