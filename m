From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 05/13] mfd: menelaus: use for_each_set_bit()
Date: Wed, 27 Nov 2013 13:06:49 -0600
Message-ID: <1385579217-20127-6-git-send-email-balbi@ti.com>
References: <1385579217-20127-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385579217-20127-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com
Cc: lee.jones@linaro.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

that macro just helps removing some extra
line of code and hides ffs() calls.

while at that, also fix a variable shadowing
bug where 'int irq' was being redeclared inside
inner loop while it was also argument to interrupt
handler.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 11dc4d3..9ccbb79 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -795,24 +795,22 @@ static irqreturn_t menelaus_irq(int irq, void *_menelaus)
 {
 	struct menelaus_chip *menelaus = _menelaus;
 	void (*handler)(struct menelaus_chip *menelaus);
-	unsigned isr;
+	unsigned long isr;
+	unsigned long i;
 
 	isr = (menelaus_read_reg(MENELAUS_INT_STATUS2)
 			& ~menelaus->mask2) << 8;
 	isr |= menelaus_read_reg(MENELAUS_INT_STATUS1)
 		& ~menelaus->mask1;
 
-	while (isr) {
-		int irq = fls(isr) - 1;
-		isr &= ~(1 << irq);
-
+	for_each_set_bit(i, &isr, 16) {
 		mutex_lock(&menelaus->lock);
-		menelaus_disable_irq(irq);
-		menelaus_ack_irq(irq);
-		handler = menelaus->handlers[irq];
+		menelaus_disable_irq(i);
+		menelaus_ack_irq(i);
+		handler = menelaus->handlers[i];
 		if (handler)
 			handler(menelaus);
-		menelaus_enable_irq(irq);
+		menelaus_enable_irq(i);
 		mutex_unlock(&menelaus->lock);
 	}
 
-- 
1.8.4.GIT
