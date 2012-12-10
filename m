From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/9] memory: emif: Handle devices which are not rated for >85C
Date: Mon, 10 Dec 2012 12:39:13 +0530
Message-ID: <1355123358-5273-5-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38828 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331Ab2LJHJe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 02:09:34 -0500
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org, b-cousson@ti.com, lokeshvutla@ti.com, Nishanth Menon <nm@ti.com>

From: Nishanth Menon <nm@ti.com>

As per JESD209-2E specification for LPDDR2,
      http://www.jedec.org/standards-documents/results/jesd209-2E
Table 73, LPDDR2 memories come in two flavors - Standard and
Extended. The Standard types can operate from -25C to +85C
However, beyond that and upto +105C can only be supported by
Extended types.

Unfortunately, it seems there is no info in MR0(device info) or
MR[1,2](device feature) for run time detection of this capability
as far as seen on the spec. Hence, we provide a custom_config
flag to be populated by platforms which have these "extended"
type memories.

For the "Standard" memories, we need to consider MR4 notifications
of temperature triggers >85C as equivalent to thermal shutdown
events (equivalent to Spec specified thermal shutdown events for
"extended" parts).

Reported-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/memory/emif.c                   |   24 ++++++++++++++++++++++++
 include/linux/platform_data/emif_plat.h |    1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 27a3ce1..ffbdf9e 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -916,6 +916,7 @@ static irqreturn_t handle_temp_alert(void __iomem *base, struct emif_data *emif)
 {
 	u32		old_temp_level;
 	irqreturn_t	ret = IRQ_HANDLED;
+	struct emif_custom_configs *custom_configs;
 
 	spin_lock_irqsave(&emif_lock, irq_state);
 	old_temp_level = emif->temperature_level;
@@ -928,6 +929,29 @@ static irqreturn_t handle_temp_alert(void __iomem *base, struct emif_data *emif)
 		goto out;
 	}
 
+	custom_configs = emif->plat_data->custom_configs;
+
+	/*
+	 * IF we detect higher than "nominal rating" from DDR sensor
+	 * on an unsupported DDR part, shutdown system
+	 */
+	if (custom_configs && !(custom_configs->mask &
+				EMIF_CUSTOM_CONFIG_EXTENDED_TEMP_PART)) {
+		if (emif->temperature_level >= SDRAM_TEMP_HIGH_DERATE_REFRESH) {
+			dev_err(emif->dev,
+				"%s:NOT Extended temperature capable memory."
+				"Converting MR4=0x%02x as shutdown event\n",
+				__func__, emif->temperature_level);
+			/*
+			 * Temperature far too high - do kernel_power_off()
+			 * from thread context
+			 */
+			emif->temperature_level = SDRAM_TEMP_VERY_HIGH_SHUTDOWN;
+			ret = IRQ_WAKE_THREAD;
+			goto out;
+		}
+	}
+
 	if (emif->temperature_level < old_temp_level ||
 		emif->temperature_level == SDRAM_TEMP_VERY_HIGH_SHUTDOWN) {
 		/*
diff --git a/include/linux/platform_data/emif_plat.h b/include/linux/platform_data/emif_plat.h
index 03378ca..5c19a2a 100644
--- a/include/linux/platform_data/emif_plat.h
+++ b/include/linux/platform_data/emif_plat.h
@@ -40,6 +40,7 @@
 /* Custom config requests */
 #define EMIF_CUSTOM_CONFIG_LPMODE			0x00000001
 #define EMIF_CUSTOM_CONFIG_TEMP_ALERT_POLL_INTERVAL	0x00000002
+#define EMIF_CUSTOM_CONFIG_EXTENDED_TEMP_PART		0x00000004
 
 #ifndef __ASSEMBLY__
 /**
-- 
1.7.9.5

