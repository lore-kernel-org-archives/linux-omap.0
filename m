From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type fails
Date: Thu, 17 Mar 2016 14:19:08 +0000
Message-ID: <1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Setting the interrupt type for private peripheral interrupts (PPIs) may
not be supported by a given GIC because it is IMPLEMENTATION DEFINED
whether this is allowed. There is no way to know if setting the type is
supported for a given GIC and so the value written is read back to
verify it matches the desired configuration. If it does not match then
an error is return.

There are cases where the interrupt configuration read from firmware
(such as a device-tree blob), has been incorrect and hence
gic_configure_irq() has returned an error. This error has gone
undetected because the error code returned was ignored but the interrupt
still worked fine because the configuration for the interrupt could not
be overwritten.

Given that this has done undetected and we should only fail to set the
type for PPIs whose configuration cannot be changed anyway, don't return
an error and simply WARN if this fails. This will allows us to fix up any
places in the kernel where we should be checking the return status and
maintain back compatibility with firmware images that may have incorrect
interrupt configurations.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/irqchip/irq-gic-common.c | 13 ++++---------
 drivers/irqchip/irq-gic-common.h |  2 +-
 drivers/irqchip/irq-gic-v3.c     |  4 +++-
 drivers/irqchip/irq-gic.c        |  4 +++-
 drivers/irqchip/irq-hip04.c      |  5 ++---
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index ffff5a45f1e3..423a345d7b75 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -32,13 +32,12 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 	}
 }
 
-int gic_configure_irq(unsigned int irq, unsigned int type,
+void gic_configure_irq(unsigned int irq, unsigned int type,
 		       void __iomem *base, void (*sync_access)(void))
 {
 	u32 confmask = 0x2 << ((irq % 16) * 2);
 	u32 confoff = (irq / 16) * 4;
 	u32 val, oldval;
-	int ret = 0;
 
 	/*
 	 * Read current configuration register, and insert the config
@@ -52,21 +51,17 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 
 	/* If the current configuration is the same, then we are done */
 	if (val == oldval)
-		return 0;
+		return;
 
 	/*
 	 * Write back the new configuration, and possibly re-enable
-	 * the interrupt. If we fail to write a new configuration,
-	 * return an error.
+	 * the interrupt. WARN if we fail to write a new configuration.
 	 */
 	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
-	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val)
-		ret = -EINVAL;
+	WARN_ON(readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val);
 
 	if (sync_access)
 		sync_access();
-
-	return ret;
 }
 
 void __init gic_dist_config(void __iomem *base, int gic_irqs,
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index fff697db8e22..73dee3bc6bba 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -27,7 +27,7 @@ struct gic_quirk {
 	u32 mask;
 };
 
-int gic_configure_irq(unsigned int irq, unsigned int type,
+void gic_configure_irq(unsigned int irq, unsigned int type,
                        void __iomem *base, void (*sync_access)(void));
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void));
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5b7d3c2129d8..c569c466fa31 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -310,7 +310,9 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		rwp_wait = gic_dist_wait_for_rwp;
 	}
 
-	return gic_configure_irq(irq, type, base, rwp_wait);
+	gic_configure_irq(irq, type, base, rwp_wait);
+
+	return 0;
 }
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 282344b95ec2..6c555a2c5315 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -279,7 +279,9 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	return gic_configure_irq(gicirq, type, base, NULL);
+	gic_configure_irq(gicirq, type, base, NULL);
+
+	return 0;
 }
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 9688d2e2a636..12be5906e91a 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -120,7 +120,6 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = hip04_dist_base(d);
 	unsigned int irq = hip04_irq(d);
-	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (irq < 16)
@@ -133,11 +132,11 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&irq_controller_lock);
 
-	ret = gic_configure_irq(irq, type, base, NULL);
+	gic_configure_irq(irq, type, base, NULL);
 
 	raw_spin_unlock(&irq_controller_lock);
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_SMP
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
