From: Ambresh K <ambresh@ti.com>
Subject: [PATCH] OMAP4: DMTIMER: enable autoidle mode
Date: Wed, 15 Jun 2011 14:12:35 -0700
Message-ID: <1308172355-1694-1-git-send-email-ambresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Ambresh K <ambresh@ti.com>

Currently autoidle is only enabled for OMAP2/3; by enabling autoidle,
the automatic L4 clock gating strategy is applied based on L4 activity,
otherwise L4 clock to module will be a free running.

Signed-off-by: Ambresh K <ambresh@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ee9f6eb..02d0f7a 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -342,8 +342,8 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	l |= 0x02 << 3;  /* Set to smart-idle mode */
 	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
 
-	/* Enable autoidle on OMAP2 / OMAP3 */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	/* Enable autoidle on OMAP2 CPUs. */
+	if (cpu_class_is_omap2())
 		l |= 0x1 << 0;
 
 	/*
-- 
1.6.0
