From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/5] mfd: tps65218: make INT1 our status_base register
Date: Fri, 26 Dec 2014 13:28:21 -0600
Message-ID: <1419622104-25812-3-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1419622104-25812-1-git-send-email-balbi@ti.com>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

If we don't tell regmap-irq that our first status
register is at offset 1, it will try to read offset
zero, which is the chipid register.

Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
Cc: <stable@vger.kernel.org> # v3.15+
Cc: Keerthy <j-keerthy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/tps65218.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 2243f75..d6b7643 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -204,6 +204,7 @@ static struct regmap_irq_chip tps65218_irq_chip = {
 
 	.num_regs = 2,
 	.mask_base = TPS65218_REG_INT_MASK1,
+	.status_base = TPS65218_REG_INT1,
 };
 
 static const struct of_device_id of_tps65218_match_table[] = {
-- 
2.2.0
