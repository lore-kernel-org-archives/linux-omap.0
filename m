From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/7] mfd: max8997-irq: 'inline' should be at the beginning of the declaration
Date: Thu, 15 Sep 2016 11:45:15 +0100
Message-ID: <20160915104521.14286-2-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Reported by [-Wold-style-declaration].

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/max8997-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
index b95a46d7..326f17b 100644
--- a/drivers/mfd/max8997-irq.c
+++ b/drivers/mfd/max8997-irq.c
@@ -139,7 +139,7 @@ static void max8997_irq_sync_unlock(struct irq_data *data)
 	mutex_unlock(&max8997->irqlock);
 }
 
-static const inline struct max8997_irq_data *
+inline static const struct max8997_irq_data *
 irq_to_max8997_irq(struct max8997_dev *max8997, struct irq_data *data)
 {
 	return &max8997_irqs[data->hwirq];
-- 
2.9.3
