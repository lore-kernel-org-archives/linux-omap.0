From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 4/7] dmtimer: Add timer ops to the platform data structure
Date: Wed, 8 Nov 2017 17:58:25 +0530
Message-ID: <1510144108-29563-5-git-send-email-j-keerthy@ti.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add timer ops to the platform data structure

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

No code changes in this v2 version. Only enhanced patch
statistics for renames.

 include/linux/platform_data/dmtimer-omap.h | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index a19b78d..a3e1794 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -20,12 +20,50 @@
 #ifndef __PLATFORM_DATA_DMTIMER_OMAP_H__
 #define __PLATFORM_DATA_DMTIMER_OMAP_H__
 
+struct omap_dm_timer_ops {
+	struct omap_dm_timer *(*request_by_node)(struct device_node *np);
+	struct omap_dm_timer *(*request_specific)(int timer_id);
+	struct omap_dm_timer *(*request)(void);
+
+	int	(*free)(struct omap_dm_timer *timer);
+
+	void	(*enable)(struct omap_dm_timer *timer);
+	void	(*disable)(struct omap_dm_timer *timer);
+
+	int	(*get_irq)(struct omap_dm_timer *timer);
+	int	(*set_int_enable)(struct omap_dm_timer *timer,
+				  unsigned int value);
+	int	(*set_int_disable)(struct omap_dm_timer *timer, u32 mask);
+
+	struct clk *(*get_fclk)(struct omap_dm_timer *timer);
+
+	int	(*start)(struct omap_dm_timer *timer);
+	int	(*stop)(struct omap_dm_timer *timer);
+	int	(*set_source)(struct omap_dm_timer *timer, int source);
+
+	int	(*set_load)(struct omap_dm_timer *timer, int autoreload,
+			    unsigned int value);
+	int	(*set_match)(struct omap_dm_timer *timer, int enable,
+			     unsigned int match);
+	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
+			   int toggle, int trigger);
+	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
+
+	unsigned int (*read_counter)(struct omap_dm_timer *timer);
+	int	(*write_counter)(struct omap_dm_timer *timer,
+				 unsigned int value);
+	unsigned int (*read_status)(struct omap_dm_timer *timer);
+	int	(*write_status)(struct omap_dm_timer *timer,
+				unsigned int value);
+};
+
 struct dmtimer_platform_data {
 	/* set_timer_src - Only used for OMAP1 devices */
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	u32 timer_capability;
 	u32 timer_errata;
 	int (*get_context_loss_count)(struct device *);
+	struct omap_dm_timer_ops *timer_ops;
 };
 
 #endif /* __PLATFORM_DATA_DMTIMER_OMAP_H__ */
-- 
1.9.1
