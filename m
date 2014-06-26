From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V4 09/16] irqchip: crossbar: Return proper error value
Date: Thu, 26 Jun 2014 12:40:27 +0530
Message-ID: <1403766634-18543-10-git-send-email-r.sricharan@ti.com>
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

crossbar_of_init always returns -ENOMEM in case of errors.
There can be other causes of failure like invalid data from
DT. So return a appropriate error value for that case.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index cee556b..10d723d 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -129,19 +129,25 @@ static const struct irq_domain_ops routable_irq_domain_ops = {
 
 static int __init crossbar_of_init(struct device_node *node)
 {
-	int i, size, max, reserved = 0, entry;
+	int i, size, max = 0, reserved = 0, entry;
 	const __be32 *irqsr;
+	int ret = -ENOMEM;
 
 	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
 
 	if (!cb)
-		return -ENOMEM;
+		return ret;
 
 	cb->crossbar_base = of_iomap(node, 0);
 	if (!cb->crossbar_base)
 		goto err1;
 
 	of_property_read_u32(node, "ti,max-irqs", &max);
+	if (!max) {
+		pr_err("missing 'ti,max-irqs' property\n");
+		ret = -EINVAL;
+		goto err2;
+	}
 	cb->irq_map = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->irq_map)
 		goto err2;
@@ -162,6 +168,7 @@ static int __init crossbar_of_init(struct device_node *node)
 						   i, &entry);
 			if (entry > max) {
 				pr_err("Invalid reserved entry\n");
+				ret = -EINVAL;
 				goto err3;
 			}
 			cb->irq_map[entry] = IRQ_RESERVED;
@@ -205,6 +212,7 @@ static int __init crossbar_of_init(struct device_node *node)
 		break;
 	default:
 		pr_err("Invalid reg-size property\n");
+		ret = -EINVAL;
 		goto err4;
 		break;
 	}
@@ -243,7 +251,7 @@ err2:
 	iounmap(cb->crossbar_base);
 err1:
 	kfree(cb);
-	return -ENOMEM;
+	return ret;
 }
 
 static const struct of_device_id crossbar_match[] __initconst = {
-- 
1.7.9.5
