From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 5/5] ARM: OMAP: remove unnecessary locking in clk_get_rate()
Date: Tue, 20 May 2008 15:45:50 -0700
Message-ID: <1211323550-5318-6-git-send-email-khilman@mvista.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com>
 <1211323550-5318-2-git-send-email-khilman@mvista.com>
 <1211323550-5318-3-git-send-email-khilman@mvista.com>
 <1211323550-5318-4-git-send-email-khilman@mvista.com>
 <1211323550-5318-5-git-send-email-khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <1211323550-5318-5-git-send-email-khilman@mvista.com>
In-Reply-To: <483353F0.6090902@mvista.com>
References: <483353F0.6090902@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>
List-Id: linux-omap@vger.kernel.org

The locking in the get_rate() hook is unnecessary, and causes problems
when used with the -rt patch, since it may be called recursively.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/plat-omap/clock.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 714dbbf..3842540 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -134,15 +134,12 @@ EXPORT_SYMBOL(clk_get_usecount);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
-	unsigned long flags;
 	unsigned long ret = 0;
 
 	if (clk == NULL || IS_ERR(clk))
 		return 0;
 
-	spin_lock_irqsave(&clockfw_lock, flags);
 	ret = clk->rate;
-	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
 }
-- 
1.5.4.1.166.g6706d

