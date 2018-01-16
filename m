From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] mfd/twl6030-irq: Delete an error message for a failed memory
 allocation in twl6030_init_irq()
Date: Tue, 16 Jan 2018 17:17:49 +0100
Message-ID: <d030ee42-5e28-4b92-1ea0-ebc9fca2f192@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jan 2018 17:06:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/twl6030-irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index e3ec8dfa9f1e..e939431ed10c 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -392,10 +392,8 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	nr_irqs = TWL6030_NR_IRQS;
 
 	twl6030_irq = devm_kzalloc(dev, sizeof(*twl6030_irq), GFP_KERNEL);
-	if (!twl6030_irq) {
-		dev_err(dev, "twl6030_irq: Memory allocation failed\n");
+	if (!twl6030_irq)
 		return -ENOMEM;
-	}
 
 	mask[0] = 0xFF;
 	mask[1] = 0xFF;
-- 
2.15.1

