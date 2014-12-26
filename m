From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers volatile
Date: Fri, 26 Dec 2014 13:28:20 -0600
Message-ID: <1419622104-25812-2-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55833 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbaLZT3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 14:29:14 -0500
In-Reply-To: <1419622104-25812-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>

STATUS register can be modified by the HW, so we
should bypass cache because of that.

In the case of INT[12] registers, they are the ones
that actually clear the IRQ source at the time they
are read. If we rely on the cache for them, we will
never be able to clear the interrupt, which will cause
our IRQ line to be disabled due to IRQ throttling.

Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
Cc: <stable@vger.kernel.org> # v3.15+
Cc: Keerthy <j-keerthy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/tps65218.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 0d256cb..2243f75 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -125,10 +125,21 @@ int tps65218_clear_bits(struct tps65218 *tps, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(tps65218_clear_bits);
 
+static const struct regmap_range tps65218_yes_ranges[] = {
+	regmap_reg_range(TPS65218_REG_INT1, TPS65218_REG_INT2),
+	regmap_reg_range(TPS65218_REG_STATUS, TPS65218_REG_STATUS),
+};
+
+static const struct regmap_access_table tps65218_volatile_table = {
+	.yes_ranges = tps65218_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tps65218_yes_ranges),
+};
+
 static struct regmap_config tps65218_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
+	.volatile_table = &tps65218_volatile_table,
 };
 
 static const struct regmap_irq tps65218_irqs[] = {
-- 
2.2.0

