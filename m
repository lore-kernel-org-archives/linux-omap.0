From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 11/14] mfd: tps65217: Constify struct regmap_config
Date: Mon, 05 Jan 2015 10:01:30 +0100
Message-ID: <1420448493-9355-11-git-send-email-k.kozlowski@samsung.com>
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
 drivers/mfd/tps65217.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 80a919a8ca97..7d1cfc1d3ce0 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -145,7 +145,7 @@ int tps65217_clear_bits(struct tps65217 *tps, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(tps65217_clear_bits);
 
-static struct regmap_config tps65217_regmap_config = {
+static const struct regmap_config tps65217_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-- 
1.9.1
