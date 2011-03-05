From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 15/19] OMAP3+: SR: introduce notifier_control
Date: Sat,  5 Mar 2011 20:59:18 +0530
Message-ID: <1299338962-5602-16-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42429 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751466Ab1CEPcB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:32:01 -0500
Received: by yia25 with SMTP id 25so1560251yia.35
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:32:00 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

We need some mechanism from class drivers to control when notifiers
should be triggered and when not, currently we have none, which makes
Class driver usage of the interrupt events almost impossible.

Introduce an SmartReflex driver API for doing the same. This is useful
for SmartReflex AVS class 1.5 or 2 drivers.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   57 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h |    8 +++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 21944e2..f6e44a1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -712,6 +712,63 @@ void sr_disable(struct voltagedomain *voltdm)
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
+	if (IS_ERR_OR_NULL(sr)) {
+		pr_warning("%s: sr corresponding to domain not found\n",
+				__func__);
+		return -EINVAL;
+	}
+	if (!sr->autocomp_active)
+		return -EINVAL;
+
+	/* if I could never register an isr, why bother?? */
+	if (!(sr_class && sr_class->notify && sr_class->notify_flags &&
+			sr->irq)) {
+		dev_warn(&sr->pdev->dev,
+			"%s: unable to setup irq without handling mechanism\n",
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
+	if (enable)
+		enable_irq(sr->irq);
+	else
+		disable_irq_nosync(sr->irq);
+
+	return 0;
+}
+
+/**
  * sr_register_class() - API to register a smartreflex class parameters.
  * @class_data:	The structure containing various sr class specific data.
  *
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 2976bf6..4a1ada4 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -242,6 +242,7 @@ void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
 /* Smartreflex driver hooks to be called from Smartreflex class driver */
 int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
 void sr_disable(struct voltagedomain *voltdm);
+int sr_notifier_control(struct voltagedomain *voltdm, bool enable);
 int sr_configure_errgen(struct voltagedomain *voltdm);
 int sr_configure_minmax(struct voltagedomain *voltdm);
 
@@ -250,6 +251,13 @@ int sr_register_class(struct omap_sr_class_data *class_data);
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
1.7.1

