From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v11 02/10] arm: omap: timer: Wrap the inline functions under OMAP2PLUS define
Date: Thu, 15 Feb 2018 11:31:43 +0530
Message-ID: <1518674511-26421-3-git-send-email-j-keerthy@ti.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: j-keerthy@ti.com, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, s-anna@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

Wrap the inline functions under OMAP2PLUS/OMAP1 defines.
This patch also inlines omap_dm_timer_get_fclk function
for non OMAP1 Config.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/plat-omap/include/plat/dmtimer.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 8b7d8a6..831174f 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -132,7 +132,16 @@ struct omap_dm_timer {
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
 
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
+
+#ifndef CONFIG_ARCH_OMAP1
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
+#else
+static inline
+struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
+{
+	return NULL;
+}
+#endif
 
 int omap_dm_timer_trigger(struct omap_dm_timer *timer);
 int omap_dm_timer_start(struct omap_dm_timer *timer);
@@ -272,6 +281,12 @@ struct omap_dm_timer {
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+/*
+ * The below are inlined to optimize code size for system timers. Other code
+ * should not need these at all, see
+ * include/linux/platform_data/pwm_omap_dmtimer.h
+ */
+#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
 {
@@ -410,5 +425,5 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 {
 	writel_relaxed(value, timer->irq_stat);
 }
-
+#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.9.1
