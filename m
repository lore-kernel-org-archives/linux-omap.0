From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Wed, 23 Dec 2015 11:58:37 +0100
Message-ID: <1450868319-20513-5-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450868319-20513-1-git-send-email-contact@paulk.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Kocialkowski <contact@paulk.fr>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

LP872x regulators are made active via the EN pin, which might be hooked to a
GPIO. This adds support for driving the GPIO high when the driver is in use.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../devicetree/bindings/regulator/lp872x.txt       |  1 +
 drivers/regulator/lp872x.c                         | 33 ++++++++++++++++++++--
 include/linux/regulator/lp872x.h                   |  2 ++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/Documentation/devicetree/bindings/regulator/lp872x.txt
index 7818318..0559c25 100644
--- a/Documentation/devicetree/bindings/regulator/lp872x.txt
+++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
@@ -28,6 +28,7 @@ Optional properties:
   - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872x devices.
   - ti,dvs-vsel: DVS selector. 0 = SEL_V1, 1 = SEL_V2.
   - ti,dvs-state: initial DVS pin state. 0 = DVS_LOW, 1 = DVS_HIGH.
+  - ti,enable-gpio: GPIO specifier for EN pin control of LP872x devices.
 
   Sub nodes for regulator_init_data
     LP8720 has maximum 6 nodes. (child name: ldo1 ~ 5 and buck)
diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 21c49d8..c8855f3 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -726,6 +726,27 @@ static struct regulator_desc lp8725_regulator_desc[] = {
 	},
 };
 
+static int lp872x_init_enable(struct lp872x *lp)
+{
+	int ret, gpio;
+
+	if (!lp->pdata)
+		return -EINVAL;
+
+	gpio = lp->pdata->enable_gpio;
+	if (!gpio_is_valid(gpio))
+		return 0;
+
+	/* Always set enable GPIO high. */
+	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
+	if (ret) {
+		dev_err(lp->dev, "gpio request err: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int lp872x_init_dvs(struct lp872x *lp)
 {
 	int ret, gpio;
@@ -763,14 +784,18 @@ static int lp872x_config(struct lp872x *lp)
 	int ret;
 
 	if (!pdata || !pdata->update_config)
-		goto init_dvs;
+		goto init_dvs_enable;
 
 	ret = lp872x_write_byte(lp, LP872X_GENERAL_CFG, pdata->general_config);
 	if (ret)
 		return ret;
 
-init_dvs:
-	return lp872x_init_dvs(lp);
+init_dvs_enable:
+	ret = lp872x_init_dvs(lp);
+	if (ret)
+		return ret;
+
+	return lp872x_init_enable(lp);
 }
 
 static struct regulator_init_data
@@ -875,6 +900,8 @@ static struct lp872x_platform_data
 	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
 	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
 
+	pdata->enable_gpio = of_get_named_gpio(np, "ti,enable-gpio", 0);
+
 	if (of_get_child_count(np) == 0)
 		goto out;
 
diff --git a/include/linux/regulator/lp872x.h b/include/linux/regulator/lp872x.h
index 132e05c..44316dd 100644
--- a/include/linux/regulator/lp872x.h
+++ b/include/linux/regulator/lp872x.h
@@ -79,12 +79,14 @@ struct lp872x_regulator_data {
  * @update_config     : if LP872X_GENERAL_CFG register is updated, set true
  * @regulator_data    : platform regulator id and init data
  * @dvs               : dvs data for buck voltage control
+ * @enable_gpio       : gpio pin number for enable control
  */
 struct lp872x_platform_data {
 	u8 general_config;
 	bool update_config;
 	struct lp872x_regulator_data regulator_data[LP872X_MAX_REGULATORS];
 	struct lp872x_dvs *dvs;
+	int enable_gpio;
 };
 
 #endif
-- 
1.9.1
