From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC PATCH v2 1/3] arm: plat-omap: dmtimer: Add clock source from DT
Date: Mon, 19 Oct 2015 17:01:57 +0200
Message-ID: <562505E5.1040706@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

Add a function which sets the timer source from the clocks
binding on dm_timer_prepare call.

In case the clocks property is not valid, it falls back to
the set_source() with 32_KHZ clock as default.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/plat-omap/dmtimer.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8ca94d3..7c7f260 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -137,6 +137,31 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	return 0;
 }

+static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
+{
+	int ret;
+	struct clk *parent;
+
+	/*
+	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
+	 * do not call clk_get() for these devices.
+	 */
+	if (!timer->fclk)
+		return -ENODEV;
+
+	parent = clk_get(&timer->pdev->dev, NULL);
+	if (IS_ERR(parent))
+		return -ENODEV;
+
+	ret = clk_set_parent(timer->fclk, parent);
+	if (ret < 0)
+		pr_err("%s: failed to set parent\n", __func__);
+
+	clk_put(parent);
+
+	return ret;
+}
+
 static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
 	int rc;
@@ -166,7 +191,11 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	__omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);

-	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	rc = omap_dm_timer_of_set_source(timer);
+	if (rc == -ENODEV)
+		return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+
+	return rc;
 }

 static inline u32 omap_dm_timer_reserved_systimer(int id)
-- 
1.9.1
