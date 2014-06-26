From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V4 10/16] irqchip: crossbar: Change the goto naming
Date: Thu, 26 Jun 2014 12:40:28 +0530
Message-ID: <1403766634-18543-11-git-send-email-r.sricharan@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403766634-18543-1-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Using err1,2,3,4 etc makes it hard to ensure a new exit path in the
middle will not result in spurious changes, so rename the error paths
as per the function it does.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 drivers/irqchip/irq-crossbar.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 10d723d..afc35fd 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -140,17 +140,17 @@ static int __init crossbar_of_init(struct device_node *node)
 
 	cb->crossbar_base = of_iomap(node, 0);
 	if (!cb->crossbar_base)
-		goto err1;
+		goto err_cb;
 
 	of_property_read_u32(node, "ti,max-irqs", &max);
 	if (!max) {
 		pr_err("missing 'ti,max-irqs' property\n");
 		ret = -EINVAL;
-		goto err2;
+		goto err_base;
 	}
 	cb->irq_map = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->irq_map)
-		goto err2;
+		goto err_base;
 
 	cb->int_max = max;
 
@@ -169,7 +169,7 @@ static int __init crossbar_of_init(struct device_node *node)
 			if (entry > max) {
 				pr_err("Invalid reserved entry\n");
 				ret = -EINVAL;
-				goto err3;
+				goto err_irq_map;
 			}
 			cb->irq_map[entry] = IRQ_RESERVED;
 		}
@@ -187,7 +187,7 @@ static int __init crossbar_of_init(struct device_node *node)
 			if (entry > max) {
 				pr_err("Invalid skip entry\n");
 				ret = -EINVAL;
-				goto err3;
+				goto err_irq_map;
 			}
 			cb->irq_map[entry] = IRQ_SKIP;
 		}
@@ -196,7 +196,7 @@ static int __init crossbar_of_init(struct device_node *node)
 
 	cb->register_offsets = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->register_offsets)
-		goto err3;
+		goto err_irq_map;
 
 	of_property_read_u32(node, "ti,reg-size", &size);
 
@@ -213,7 +213,7 @@ static int __init crossbar_of_init(struct device_node *node)
 	default:
 		pr_err("Invalid reg-size property\n");
 		ret = -EINVAL;
-		goto err4;
+		goto err_reg_offset;
 		break;
 	}
 
@@ -230,7 +230,6 @@ static int __init crossbar_of_init(struct device_node *node)
 	}
 
 	of_property_read_u32(node, "ti,irqs-safe-map", &cb->safe_map);
-
 	/* Initialize the crossbar with safe map to start with */
 	for (i = 0; i < max; i++) {
 		if (cb->irq_map[i] == IRQ_RESERVED ||
@@ -243,13 +242,13 @@ static int __init crossbar_of_init(struct device_node *node)
 	register_routable_domain_ops(&routable_irq_domain_ops);
 	return 0;
 
-err4:
+err_reg_offset:
 	kfree(cb->register_offsets);
-err3:
+err_irq_map:
 	kfree(cb->irq_map);
-err2:
+err_base:
 	iounmap(cb->crossbar_base);
-err1:
+err_cb:
 	kfree(cb);
 	return ret;
 }
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
