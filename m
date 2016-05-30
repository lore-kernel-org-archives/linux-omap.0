From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v1 04/14] mfd: twl6040: The chip does not support bulk access
Date: Mon, 30 May 2016 11:55:12 +0300
Message-ID: <20160530085522.30398-5-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Bulk access is not working with twl6040, we need to use single register
access. Bulk access would happen when we try to sync the regcache after
power on.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index f3dcf3a85e84..2596546553aa 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -608,6 +608,7 @@ static const struct regmap_config twl6040_regmap_config = {
 	.writeable_reg = twl6040_writeable_reg,
 
 	.cache_type = REGCACHE_RBTREE,
+	.use_single_rw = true,
 };
 
 static const struct regmap_irq twl6040_irqs[] = {
-- 
2.8.3
