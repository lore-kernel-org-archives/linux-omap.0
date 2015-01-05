From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 13/14] mfd: twl-core: Constify struct regmap_config and
 reg_default array
Date: Mon, 05 Jan 2015 10:01:32 +0100
Message-ID: <1420448493-9355-13-git-send-email-k.kozlowski@samsung.com>
References: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make array of
struct reg_default const as well.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/twl-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index db11b4f40611..489674a2497e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -207,7 +207,7 @@ static struct twl_mapping twl4030_map[] = {
 	{ 2, TWL5031_BASEADD_INTERRUPTS },
 };
 
-static struct reg_default twl4030_49_defaults[] = {
+static const struct reg_default twl4030_49_defaults[] = {
 	/* Audio Registers */
 	{ 0x01, 0x00}, /* CODEC_MODE	*/
 	{ 0x02, 0x00}, /* OPTION	*/
@@ -306,7 +306,7 @@ static const struct regmap_access_table twl4030_49_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(twl4030_49_volatile_ranges),
 };
 
-static struct regmap_config twl4030_regmap_config[4] = {
+static const struct regmap_config twl4030_regmap_config[4] = {
 	{
 		/* Address 0x48 */
 		.reg_bits = 8,
@@ -369,7 +369,7 @@ static struct twl_mapping twl6030_map[] = {
 	{ 1, TWL6030_BASEADD_GASGAUGE },
 };
 
-static struct regmap_config twl6030_regmap_config[3] = {
+static const struct regmap_config twl6030_regmap_config[3] = {
 	{
 		/* Address 0x48 */
 		.reg_bits = 8,
@@ -1087,7 +1087,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct twl4030_platform_data	*pdata = dev_get_platdata(&client->dev);
 	struct device_node		*node = client->dev.of_node;
 	struct platform_device		*pdev;
-	struct regmap_config		*twl_regmap_config;
+	const struct regmap_config	*twl_regmap_config;
 	int				irq_base = 0;
 	int				status;
 	unsigned			i, num_slaves;
-- 
1.9.1
