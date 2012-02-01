From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 10/20] ARM: OMAP3+: SmartReflex: introduce notifiers flags
Date: Wed,  1 Feb 2012 09:49:49 +0100
Message-ID: <1328086199-28486-11-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40135 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab2BAIuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:35 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so753770wer.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:35 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

SmartReflex IP V1 and V2 have different registers and offsets.
Currently, we pass the status as is to the class driver. However,
since we don't pass the version of the underlying SR hardware
to the Class driver, it will not be unable to make consistent
sense of the status bits coming over to it.

A class driver should be able to function without dependency
on the exact IP version it is actually running on. We hence
introduce our own translation in software level for a generic
notification flag.

As part of this change, we will now call the notifier if we get
a match with the notifier flags that the class driver requested.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   78 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/smartreflex.h |    6 +++
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 5fd9cb1..8380201 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -121,27 +121,101 @@ static struct omap_sr *_sr_lookup(struct voltagedomain *voltdm)
 	return ERR_PTR(-ENODATA);
 }
 
+static inline u32 notifier_to_irqen_v1(u8 notify_flags)
+{
+	u32 val;
+
+	val = (notify_flags & SR_NOTIFY_MCUACCUM) ?
+		ERRCONFIG_MCUACCUMINTEN : 0;
+	val |= (notify_flags & SR_NOTIFY_MCUVALID) ?
+		ERRCONFIG_MCUVALIDINTEN : 0;
+	val |= (notify_flags & SR_NOTIFY_MCUBOUND) ?
+		ERRCONFIG_MCUBOUNDINTEN : 0;
+	val |= (notify_flags & SR_NOTIFY_MCUDISACK) ?
+		ERRCONFIG_MCUDISACKINTEN : 0;
+
+	return val;
+}
+
+static inline u32 notifier_to_irqen_v2(u8 notify_flags)
+{
+	u32 val;
+
+	val = (notify_flags & SR_NOTIFY_MCUACCUM) ?
+		IRQENABLE_MCUACCUMINT : 0;
+	val |= (notify_flags & SR_NOTIFY_MCUVALID) ?
+		IRQENABLE_MCUVALIDINT : 0;
+	val |= (notify_flags & SR_NOTIFY_MCUBOUND) ?
+		IRQENABLE_MCUBOUNDSINT : 0;
+	val |= (notify_flags & SR_NOTIFY_MCUDISACK) ?
+		IRQENABLE_MCUDISABLEACKINT : 0;
+
+	return val;
+}
+
+static inline u8 irqstat_to_notifier_v1(u32 status)
+{
+	u8 val;
+
+	val = (status & ERRCONFIG_MCUACCUMINTST) ?
+		SR_NOTIFY_MCUACCUM : 0;
+	val |= (status & ERRCONFIG_MCUVALIDINTEN) ?
+		SR_NOTIFY_MCUVALID : 0;
+	val |= (status & ERRCONFIG_MCUBOUNDINTEN) ?
+		SR_NOTIFY_MCUBOUND : 0;
+	val |= (status & ERRCONFIG_MCUDISACKINTEN) ?
+		SR_NOTIFY_MCUDISACK : 0;
+
+	return val;
+}
+
+static inline u8 irqstat_to_notifier_v2(u32 status)
+{
+	u8 val;
+
+	val = (status & IRQENABLE_MCUACCUMINT) ?
+		SR_NOTIFY_MCUACCUM : 0;
+	val |= (status & IRQENABLE_MCUVALIDINT) ?
+		SR_NOTIFY_MCUVALID : 0;
+	val |= (status & IRQENABLE_MCUBOUNDSINT) ?
+		SR_NOTIFY_MCUBOUND : 0;
+	val |= (status & IRQENABLE_MCUDISABLEACKINT) ?
+		SR_NOTIFY_MCUDISACK : 0;
+
+	return val;
+}
+
 static irqreturn_t sr_interrupt(int irq, void *data)
 {
 	struct omap_sr *sr_info = (struct omap_sr *)data;
 	u32 status = 0;
+	u32 value = 0;
 
 	if (sr_info->ip_type == SR_TYPE_V1) {
+		/* Status bits are one bit before enable bits in v1 */
+		value = notifier_to_irqen_v1(sr_class->notify_flags) >> 1;
+
 		/* Read the status bits */
 		status = sr_read_reg(sr_info, ERRCONFIG_V1);
+		status &= value;
 
 		/* Clear them by writing back */
-		sr_write_reg(sr_info, ERRCONFIG_V1, status);
+		sr_modify_reg(sr_info, ERRCONFIG_V1, value, status);
+
+		value = irqstat_to_notifier_v1(status);
 	} else if (sr_info->ip_type == SR_TYPE_V2) {
+		value = notifier_to_irqen_v2(sr_class->notify_flags);
 		/* Read the status bits */
 		status = sr_read_reg(sr_info, IRQSTATUS);
+		status &= value;
 
 		/* Clear them by writing back */
 		sr_write_reg(sr_info, IRQSTATUS, status);
+		value = irqstat_to_notifier_v2(status);
 	}
 
 	if (sr_class->notify)
-		sr_class->notify(sr_info->voltdm, status);
+		sr_class->notify(sr_info->voltdm, value);
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index dd5b21e..da00f8c 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -142,6 +142,12 @@
 #define OMAP3430_SR_ERRWEIGHT		0x04
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
 
+/* Smart reflex notifiers for class drivers to use */
+#define SR_NOTIFY_MCUDISACK		BIT(3)
+#define SR_NOTIFY_MCUBOUND		BIT(2)
+#define SR_NOTIFY_MCUVALID		BIT(1)
+#define SR_NOTIFY_MCUACCUM		BIT(0)
+
 /**
  * struct omap_sr_pmic_data - Strucutre to be populated by pmic code to pass
  *				pmic specific info to smartreflex driver
-- 
1.7.5.4

