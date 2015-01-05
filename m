From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 12/14] mfd: tps65218: Constify struct regmap_config
Date: Mon, 05 Jan 2015 10:01:31 +0100
Message-ID: <1420448493-9355-12-git-send-email-k.kozlowski@samsung.com>
References: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/tps65218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 0d256cb002eb..b019b3198afe 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -125,7 +125,7 @@ int tps65218_clear_bits(struct tps65218 *tps, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(tps65218_clear_bits);
 
-static struct regmap_config tps65218_regmap_config = {
+static const struct regmap_config tps65218_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
-- 
1.9.1
