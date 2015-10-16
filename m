From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC PATCH 1/3] arm: plat-omap: dmtimer: Add clock source from DT
Date: Fri, 16 Oct 2015 14:27:28 +0200
Message-ID: <5620ED30.2050507@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

Add a function which sets the timer source from the clocks
binding on dm_timer_prepare call.

In case the clocks property is not valid, it falls back to
the set_source() with 32_KHZ clock as default.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/plat-omap/dmtimer.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8ca94d3..5e8aece 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -137,9 +137,33 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	return 0;
 }

+static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
+{
+	int ret;
+	struct clk *parent;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	if (IS_ERR(timer->fclk))
+		return -EINVAL;
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
-	int rc;
+	int rc, ret;

 	/*
 	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
@@ -166,7 +190,11 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	__omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);

-	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	ret = omap_dm_timer_of_set_source(timer);
+	if (ret < 0 && ret == -ENODEV)
+		return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+
+	return ret;
 }

 static inline u32 omap_dm_timer_reserved_systimer(int id)
-- 
1.9.1
