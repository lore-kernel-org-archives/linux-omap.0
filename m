From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/8] memory: emif: Handle devices which are not rated for >85C
Date: Mon, 11 Mar 2013 10:36:01 +0530
Message-ID: <1362978365-5593-5-git-send-email-lokeshvutla@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org
Cc: Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

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
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/memory/emif.c                   |   27 +++++++++++++++++++++++++++
 include/linux/platform_data/emif_plat.h |    1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 37e0c77..927fb55 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -914,6 +914,7 @@ static irqreturn_t handle_temp_alert(void __iomem *base, struct emif_data *emif)
 {
 	u32		old_temp_level;
 	irqreturn_t	ret = IRQ_HANDLED;
+	struct emif_custom_configs *custom_configs;
 
 	spin_lock_irqsave(&emif_lock, irq_state);
 	old_temp_level = emif->temperature_level;
@@ -926,6 +927,29 @@ static irqreturn_t handle_temp_alert(void __iomem *base, struct emif_data *emif)
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
@@ -1224,6 +1248,9 @@ static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
 		cust_cfgs->temp_alert_poll_interval_ms = *poll_intvl;
 	}
 
+	if (of_find_property(np_emif, "extended-temp-part", &len))
+		cust_cfgs->mask |= EMIF_CUSTOM_CONFIG_EXTENDED_TEMP_PART;
+
 	if (!is_custom_config_valid(cust_cfgs, emif->dev)) {
 		devm_kfree(emif->dev, cust_cfgs);
 		return;
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
