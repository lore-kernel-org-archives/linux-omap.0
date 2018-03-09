From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 16/17] mfd: twl6030-irq: Delete an error message for a
 failed memory allocation in twl6030_init_irq()
Date: Fri, 9 Mar 2018 17:49:05 +0100
Message-ID: <575d5e65-381d-c12c-8d75-eadae7a92566@users.sourceforge.net>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:49:32 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

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
2.16.2
