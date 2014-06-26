From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V4 02/16] irqchip: crossbar: Check for premapped crossbar
 before allocating
Date: Thu, 26 Jun 2014 12:40:20 +0530
Message-ID: <1403766634-18543-3-git-send-email-r.sricharan@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nm@ti.com, linux@arm.linux.org.uk, jason@lakedaemon.net, tony@atomide.com, rnayak@ti.com, r.sricharan@ti.com, santosh.shilimkar@ti.com, joe@perches.com, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

If irq_of_parse_and_map is executed twice, the same crossbar is mapped to two
different GIC interrupts. This is completely undesirable. Instead, check
if the requested crossbar event is pre-allocated and provide that GIC
mapping back to caller if already allocated.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 20105bc..51d4b87 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -51,6 +51,17 @@ static inline void crossbar_writeb(int irq_no, int cb_no)
 	writeb(cb_no, cb->crossbar_base + cb->register_offsets[irq_no]);
 }
 
+static inline int get_prev_map_irq(int cb_no)
+{
+	int i;
+
+	for (i = 0; i < cb->int_max; i++)
+		if (cb->irq_map[i] == cb_no)
+			return i;
+
+	return -ENODEV;
+}
+
 static inline int allocate_free_irq(int cb_no)
 {
 	int i;
@@ -88,11 +99,16 @@ static int crossbar_domain_xlate(struct irq_domain *d,
 {
 	unsigned long ret;
 
+	ret = get_prev_map_irq(intspec[1]);
+	if (!IS_ERR_VALUE(ret))
+		goto found;
+
 	ret = allocate_free_irq(intspec[1]);
 
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
+found:
 	*out_hwirq = ret + GIC_IRQ_START;
 	return 0;
 }
-- 
1.7.9.5
