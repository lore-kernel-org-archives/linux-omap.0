From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/7] mfd: Fix all W=1 warnings
Date: Thu, 15 Sep 2016 13:35:30 +0200
Message-ID: <5506538.euWBouSNJd@wuerfel>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday, September 15, 2016 11:45:14 AM CEST Lee Jones wrote:
> It really is as simple as it sounds!
> 

I seem to have one that you didn't find.

	Arnd

8<--------
>From 6c63171eba728fc6d8bc6358884deaccd4cee33d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 4 Aug 2016 15:28:51 +0200
Subject: [PATCH] mfd: tps65912: move regmap config into core driver

When building with extra warnings enabled, most files including
linux/mfd/tps65912.h warn about a static variable defined in the
header:

include/linux/mfd/tps65912.h:331:35: warning: 'tps65912_regmap_config' defined but not used [-Wunused-const-variable=]

We also duplicate the data structure between the i2c and spi front-end
drivers. Moving it into the driver code avoids the warning and
the duplication.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mfd/tps65912-core.c b/drivers/mfd/tps65912-core.c
index a88cfa80dbc4..f33567bc428d 100644
--- a/drivers/mfd/tps65912-core.c
+++ b/drivers/mfd/tps65912-core.c
@@ -77,6 +77,23 @@ static struct regmap_irq_chip tps65912_irq_chip = {
 	.init_ack_masked = true,
 };
 
+static const struct regmap_range tps65912_yes_ranges[] = {
+	regmap_reg_range(TPS65912_INT_STS, TPS65912_GPIO5),
+};
+
+static const struct regmap_access_table tps65912_volatile_table = {
+	.yes_ranges = tps65912_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tps65912_yes_ranges),
+};
+
+const struct regmap_config tps65912_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_table = &tps65912_volatile_table,
+};
+EXPORT_SYMBOL_GPL(tps65912_regmap_config);
+
 int tps65912_device_init(struct tps65912 *tps)
 {
 	int ret;
diff --git a/include/linux/mfd/tps65912.h b/include/linux/mfd/tps65912.h
index 1a603701550e..b25d0297ba88 100644
--- a/include/linux/mfd/tps65912.h
+++ b/include/linux/mfd/tps65912.h
@@ -319,21 +319,7 @@ struct tps65912 {
 	struct regmap_irq_chip_data *irq_data;
 };
 
-static const struct regmap_range tps65912_yes_ranges[] = {
-	regmap_reg_range(TPS65912_INT_STS, TPS65912_GPIO5),
-};
-
-static const struct regmap_access_table tps65912_volatile_table = {
-	.yes_ranges = tps65912_yes_ranges,
-	.n_yes_ranges = ARRAY_SIZE(tps65912_yes_ranges),
-};
-
-static const struct regmap_config tps65912_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_table = &tps65912_volatile_table,
-};
+extern const struct regmap_config tps65912_regmap_config;
 
 int tps65912_device_init(struct tps65912 *tps);
 int tps65912_device_exit(struct tps65912 *tps);
