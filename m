From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH RESEND 1/2] mfd: twl6040: The chip does not support bulk access
Date: Wed, 31 Aug 2016 14:46:20 +0300
Message-ID: <20160831114621.6301-2-peter.ujfalusi@ti.com>
References: <20160831114621.6301-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831114621.6301-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Bulk access is not working with twl6040, we need to use single register
access. Bulk access would happen when we try to sync the regcache after
power on.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index ab328ec49353..c3ad59ef43dd 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -609,6 +609,7 @@ static const struct regmap_config twl6040_regmap_config = {
 	.writeable_reg = twl6040_writeable_reg,
 
 	.cache_type = REGCACHE_RBTREE,
+	.use_single_rw = true,
 };
 
 static const struct regmap_irq twl6040_irqs[] = {
-- 
2.9.3
