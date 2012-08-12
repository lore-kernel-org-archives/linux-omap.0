From: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: [PATCH 1/1] omap: dmtimers: Fix locking issue in omap_dm_timer_request*()
Date: Sun, 12 Aug 2012 13:45:34 +0300
Message-ID: <1344768334-1969-1-git-send-email-timo.t.kokkonen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:33613 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab2HLKpt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Aug 2012 06:45:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Calling omap_dm_timer_prepare while the spinlock is held is not
allowed as sleeping functions are called later on during the
preparation (namely within clk_get()).

dm_timer_lock is only required for protecting the
omap_timer_list. After the timer is marked as reserved, the lock is no
longer needed and should be freed.

Signed-off-by: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 626ad8c..1f66cac 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -189,6 +189,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -197,7 +198,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 			timer = NULL;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer request failed!\n", __func__);
@@ -220,6 +220,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -228,7 +229,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			timer = NULL;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer%d request failed!\n", __func__, id);
-- 
1.7.8.6

