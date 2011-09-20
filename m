From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v16 10/12] OMAP: dmtimer: extend spinlock in request functions
Date: Tue, 20 Sep 2011 17:00:25 +0530
Message-ID: <1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab1ITLak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 07:30:40 -0400
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
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
index f549c63..631b6af 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -166,7 +166,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -175,6 +174,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer request failed!\n", __func__);
@@ -197,7 +197,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -206,6 +205,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer%d request failed!\n", __func__, id);
-- 
1.7.0.4

