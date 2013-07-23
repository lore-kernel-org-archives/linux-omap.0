From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/4] mfd: twl6030-irq: add error check when IRQs are masked initially
Date: Tue, 23 Jul 2013 19:07:02 +0300
Message-ID: <1374595624-15054-3-git-send-email-grygorii.strashko@ti.com>
References: <1374595624-15054-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374595624-15054-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add a missed check for errors when TWL IRQs are masked
initially on probe and report an error in case of failure.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/mfd/twl6030-irq.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index b6030d9..790cc28 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -313,7 +313,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	struct			device_node *node = dev->of_node;
 	int			nr_irqs, irq_base, irq_end;
 	static struct irq_chip  twl6030_irq_chip;
-	int			status = 0;
+	int			status;
 	int			i;
 	u8			mask[3];
 
@@ -335,11 +335,16 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	mask[2] = 0xFF;
 
 	/* mask all int lines */
-	twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_MSK_LINE_A, 3);
+	status = twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_MSK_LINE_A, 3);
 	/* mask all int sts */
-	twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_MSK_STS_A, 3);
+	status |= twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_MSK_STS_A, 3);
 	/* clear INT_STS_A,B,C */
-	twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_STS_A, 3);
+	status |= twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_STS_A, 3);
+
+	if (status < 0) {
+		dev_err(dev, "I2C err writing TWL_MODULE_PIH: %d\n", status);
+		return status;
+	}
 
 	twl6030_irq_base = irq_base;
 
-- 
1.7.9.5
