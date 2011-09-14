From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 11/12 REPOST] OMAP: dmtimer: extend spinlock in request functions
Date: Wed, 14 Sep 2011 18:58:40 +0530
Message-ID: <1316006920-4785-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab1INN3C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 09:29:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

The request functions now verify the success of omap_dm_timer_prepare() call
after a timer is acquired. If *_prepare() fails then we have to release the
timer. In order to avoid race condition during this time, include *_prepare()
within lock.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 15fe01a..7c915e8 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -174,7 +174,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -183,6 +182,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer request failed!\n", __func__);
@@ -205,7 +205,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -214,6 +213,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer%d request failed!\n", __func__, id);
-- 
1.7.0.4

