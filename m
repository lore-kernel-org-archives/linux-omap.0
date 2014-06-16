From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V3 05/16] irqchip: crossbar: change allocation logic by reversing search for free irqs
Date: Mon, 16 Jun 2014 16:53:05 +0530
Message-ID: <1402917796-31574-6-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com, tglx@linutronix.de, jason@lakedaemon.net, joe@perches.com
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

Reverse the search algorithm to ensure that address mapping and IRQ
allocation logics are proper. This makes the below bugs visible sooner.

class 1. address space errors -> example:
reg = <a size_b>
ti,max-irqs =  is a wrong parameter

class 2: irq-reserved list - which decides which entries in the
address space is not actually wired in

class 3: wrong list of routable-irqs.

In general allocating from max to min tends to have benefits in
ensuring the different issues that may be present in dts is easily
caught at definition time, rather than at a later point in time.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
[V3] Added more description to commit log.

 drivers/irqchip/irq-crossbar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index d1f67f6..9528cf2 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -58,7 +58,7 @@ static inline int get_prev_map_irq(int cb_no)
 {
 	int i;
 
-	for (i = 0; i < cb->int_max; i++)
+	for (i = cb->int_max - 1; i >= 0; i--)
 		if (cb->irq_map[i] == cb_no)
 			return i;
 
@@ -69,7 +69,7 @@ static inline int allocate_free_irq(int cb_no)
 {
 	int i;
 
-	for (i = 0; i < cb->int_max; i++) {
+	for (i = cb->int_max - 1; i >= 0; i--) {
 		if (cb->irq_map[i] == IRQ_FREE) {
 			cb->irq_map[i] = cb_no;
 			return i;
-- 
1.7.9.5
