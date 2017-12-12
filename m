From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v5 2/8] arm: omap: timer: Wrap the inline functions under OMAP2PLUS define
Date: Tue, 12 Dec 2017 11:42:11 +0530
Message-ID: <1513059137-21593-3-git-send-email-j-keerthy@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Wrap the inline functions under OMAP2PLUS/OMAP1 defines.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index dd79f30..862ad62 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -276,6 +276,12 @@ struct omap_dm_timer {
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
@@ -414,5 +420,5 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 {
 	writel_relaxed(value, timer->irq_stat);
 }
-
+#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.9.1
