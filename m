From: Kyle Manna <kyle.manna@fuel7.com>
Subject: [PATCH v3 3/6] mfd: TPS65910: Fix typo that clobbers genirq
Date: Thu,  3 Nov 2011 12:08:03 -0500
Message-ID: <1320340086-15371-4-git-send-email-kyle.manna@fuel7.com>
References: <1320340086-15371-1-git-send-email-kyle.manna@fuel7.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320340086-15371-1-git-send-email-kyle.manna@fuel7.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kyle Manna <kyle.manna@fuel7.com>
List-Id: linux-omap@vger.kernel.org

Fix a typo that clobbers other interrupts in an unobvious way.

Signed-off-by: Kyle Manna <kyle.manna@fuel7.com>
---
 drivers/mfd/tps65910.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 0d9c3eb..87cb3c9 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -177,7 +177,7 @@ static int tps65910_i2c_probe(struct i2c_client *i2c,
 		goto err2;
 
 	init_data->irq = pmic_plat_data->irq;
-	init_data->irq_base = pmic_plat_data->irq;
+	init_data->irq_base = pmic_plat_data->irq_base;
 
 	tps65910_gpio_init(tps65910, pmic_plat_data->gpio_base);
 
-- 
1.7.5.4
