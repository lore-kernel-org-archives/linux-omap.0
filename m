From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 11/19] ARM: OMAP3+: SmartReflex: introduce notifier_control
Date: Tue, 31 Jan 2012 10:58:24 +0100
Message-ID: <1328003912-11709-12-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32880 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2AaJ7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:13 -0500
Received: by mail-ww0-f44.google.com with SMTP id dt10so67497wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:12 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

We need some mechanism from class drivers to control when notifiers
should be triggered and when not, currently we have none, which makes
Class driver usage of the interrupt events almost impossible.

We also ensure that disable/enable or irq is always guarenteed to be
paired. The need to do this is because of the mixture of interrupt based
and polling based operations that is implemented as the most optimal
strategy for various SmartReflex AVS class

Introduce an SmartReflex driver API for doing the same. This is useful
for SmartReflex AVS class 1.5 or 2 drivers.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   65 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h |    8 ++++
 2 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 8380201..a24a228 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -50,6 +50,7 @@ struct omap_sr {
 	u32				senp_mod;
 	u32				senn_mod;
 	unsigned int			irq;
+	bool				irq_enabled;
 	void __iomem			*base;
 	struct platform_device		*pdev;
 	struct list_head		node;
@@ -765,6 +766,70 @@ void sr_disable(struct voltagedomain *voltdm)
 }
 
 /**
+ * sr_notifier_control() - control the notifier mechanism
+ * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @enable:	true to enable notifiers and false to disable the same
+ *
+ * SR modules allow an MCU interrupt mechanism that vary based on the IP
+ * revision, we allow the system to generate interrupt if the class driver
+ * has capability to handle the same. it is upto the class driver to ensure
+ * the proper sequencing and handling for a clean implementation. returns
+ * 0 if all goes fine, else returns failure results
+ */
+int sr_notifier_control(struct voltagedomain *voltdm, bool enable)
+{
+	struct omap_sr *sr = _sr_lookup(voltdm);
+	u32 value = 0;
+
+	if (!sr) {
+		pr_warning("%s: sr corresponding to domain not found\n",
+				__func__);
+		return -EINVAL;
+	}
+	if (!sr->autocomp_active)
+		return -EINVAL;
+
+	/* If I could never register an ISR, why bother?? */
+	if (!(sr_class && sr_class->notify && sr_class->notify_flags &&
+			sr->irq)) {
+		dev_warn(&sr->pdev->dev,
+			"%s: unable to setup IRQ without handling mechanism\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	switch (sr->ip_type) {
+	case SR_TYPE_V1:
+		value = notifier_to_irqen_v1(sr_class->notify_flags);
+		sr_modify_reg(sr, ERRCONFIG_V1, value,
+				(enable) ? value : 0);
+		break;
+	case SR_TYPE_V2:
+		value = notifier_to_irqen_v2(sr_class->notify_flags);
+		sr_write_reg(sr, (enable) ? IRQENABLE_SET : IRQENABLE_CLR,
+				value);
+		break;
+	default:
+		 dev_warn(&sr->pdev->dev, "%s: unknown type of sr??\n",
+				 __func__);
+		return -EINVAL;
+	}
+
+	if (!enable)
+		sr_write_reg(sr, IRQSTATUS, value);
+
+	if (enable != sr->irq_enabled) {
+		if (enable)
+			enable_irq(sr->irq);
+		else
+			disable_irq(sr->irq);
+		sr->irq_enabled = enable;
+	}
+
+	return 0;
+}
+
+/**
  * sr_register_class() - API to register a smartreflex class parameters.
  * @class_data:	The structure containing various sr class specific data.
  *
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index da00f8c..8660049 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -251,6 +251,7 @@ void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
 /* Smartreflex driver hooks to be called from Smartreflex class driver */
 int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
 void sr_disable(struct voltagedomain *voltdm);
+int sr_notifier_control(struct voltagedomain *voltdm, bool enable);
 int sr_configure_errgen(struct voltagedomain *voltdm);
 int sr_disable_errgen(struct voltagedomain *voltdm);
 int sr_configure_minmax(struct voltagedomain *voltdm);
@@ -260,6 +261,13 @@ int sr_register_class(struct omap_sr_class_data *class_data);
 #else
 static inline void omap_sr_enable(struct voltagedomain *voltdm) {}
 static inline void omap_sr_disable(struct voltagedomain *voltdm) {}
+
+static inline int sr_notifier_control(struct voltagedomain *voltdm,
+		bool enable)
+{
+	return -EINVAL;
+}
+
 static inline void omap_sr_disable_reset_volt(
 		struct voltagedomain *voltdm) {}
 static inline void omap_sr_register_pmic(
-- 
1.7.5.4

