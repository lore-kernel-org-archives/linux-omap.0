From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RESEND 3/3] mfd: twl6040: Clear the interrupt ID register before requesting IRQ
Date: Tue, 1 Apr 2014 16:45:01 +0300
Message-ID: <1396359901-32656-4-git-send-email-peter.ujfalusi@ti.com>
References: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

If for some reason the boot loader enabled the audpwron GPIO we will have
pending IRQs to be handled. This seams to break twl6040 for some reason
leading to non working i2c communication (i2c timeouts). Clearing the INTID
register after we requested the audpwron GPIO (and set it to low) will
ensure that the chip will operate normally in this case as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index dc5c05940e96..2e6504a8e1e3 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -687,6 +687,9 @@ static int twl6040_probe(struct i2c_client *client,
 					    GPIOF_OUT_INIT_LOW, "audpwron");
 		if (ret)
 			goto gpio_err;
+
+		/* Clear any pending interrupt */
+		twl6040_reg_read(twl6040, TWL6040_REG_INTID);
 	}
 
 	ret = regmap_add_irq_chip(twl6040->regmap, twl6040->irq, IRQF_ONESHOT,
-- 
1.9.1
