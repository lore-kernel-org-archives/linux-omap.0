From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V3 03/16] irqchip: crossbar: introduce ti,irqs-skip to skip
Date: Mon, 16 Jun 2014 16:53:03 +0530
Message-ID: <1402917796-31574-4-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
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

When, in the system due to varied reasons, interrupts might be unusable
due to hardware behavior, but register maps do exist, then those interrupts
should be skipped while mapping irq to crossbars.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
[V3] introduced ti,irqs-skip dt property to list the
     irqs to be skipped.

 .../devicetree/bindings/arm/omap/crossbar.txt      |    4 ++++
 drivers/irqchip/irq-crossbar.c                     |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index fb88585..cfcbd52 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -17,6 +17,10 @@ Required properties:
 		 so crossbar bar driver should not consider them as free
 		 lines.
 
+Optional properties:
+- ti,irqs-skip: This is similar to "ti,irqs-reserved", but are irq mappings
+  which are not supposed to be used for errata or other reasons(virtualization).
+
 Examples:
 		crossbar_mpu: @4a020000 {
 			compatible = "ti,irq-crossbar";
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 51d4b87..27049de 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -18,6 +18,7 @@
 
 #define IRQ_FREE	-1
 #define IRQ_RESERVED	-2
+#define IRQ_SKIP	-3
 #define GIC_IRQ_START	32
 
 /*
@@ -160,6 +161,25 @@ static int __init crossbar_of_init(struct device_node *node)
 		}
 	}
 
+	/* Skip the ones marked as skip */
+	irqsr = of_get_property(node, "ti,irqs-skip", &size);
+	if (irqsr) {
+		size /= sizeof(__be32);
+
+		for (i = 0; i < size; i++) {
+			of_property_read_u32_index(node,
+						   "ti,irqs-skip",
+						   i, &entry);
+			if (entry > max) {
+				pr_err("Invalid skip entry\n");
+				ret = -EINVAL;
+				goto err3;
+			}
+			cb->irq_map[entry] = IRQ_SKIP;
+		}
+	}
+
+
 	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);
 	if (!cb->register_offsets)
 		goto err3;
-- 
1.7.9.5
