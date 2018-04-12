From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 12/14] OMAP: CLK: CLKSRC: Add suspend resume hooks
Date: Thu, 12 Apr 2018 09:23:57 +0530
Message-ID: <1523505239-16229-13-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

Add the save and restore for clksrc as part of suspend and resume
so that it saves the counter value and restores. This is needed in
modes like rtc+ddr in self-refresh not doing this stalls the time.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/timer.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4fb4dc2..35fef97 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -442,6 +442,38 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 	return ret;
 }
 
+static unsigned int omap2_gptimer_clksrc_load;
+
+static void omap2_gptimer_clksrc_suspend(struct clocksource *unused)
+{
+	struct omap_hwmod *oh;
+
+	omap2_gptimer_clksrc_load =
+		__omap_dm_timer_read_counter(&clksrc, OMAP_TIMER_NONPOSTED);
+
+	oh = omap_hwmod_lookup(clocksource_gpt.name);
+	if (!oh)
+		return;
+
+	omap_hwmod_idle(oh);
+}
+
+static void omap2_gptimer_clksrc_resume(struct clocksource *unused)
+{
+	struct omap_hwmod *oh;
+
+	oh = omap_hwmod_lookup(clocksource_gpt.name);
+	if (!oh)
+		return;
+
+	omap_hwmod_enable(oh);
+
+	__omap_dm_timer_load_start(&clksrc,
+				   OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR,
+				   omap2_gptimer_clksrc_load,
+				   OMAP_TIMER_NONPOSTED);
+}
+
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						  const char *fck_source,
 						  const char *property)
@@ -451,6 +483,11 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	clksrc.id = gptimer_id;
 	clksrc.errata = omap_dm_timer_get_errata();
 
+	if (soc_is_am43xx()) {
+		clocksource_gpt.suspend = omap2_gptimer_clksrc_suspend;
+		clocksource_gpt.resume = omap2_gptimer_clksrc_resume;
+	}
+
 	res = omap_dm_timer_init_one(&clksrc, fck_source, property,
 				     &clocksource_gpt.name,
 				     OMAP_TIMER_NONPOSTED);
-- 
1.9.1
