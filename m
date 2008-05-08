From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/11] ARM: OMAP: Warn on disabling clocks with no users
Date: Thu,  8 May 2008 15:49:27 -0700
Message-ID: <1210286975-29506-4-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61422 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761121AbYEHWtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:42 -0400
In-Reply-To: <1210286975-29506-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Instead of BUG(), warn on disabling clocks with no users.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/clock.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 72d34a2..2946c19 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -134,9 +134,17 @@ void clk_disable(struct clk *clk)
 		return;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	BUG_ON(clk->usecount == 0);
+	if (clk->usecount == 0) {
+		printk(KERN_ERR "Trying disable clock %s with 0 usecount\n",
+		       clk->name);
+		WARN_ON(1);
+		goto out;
+	}
+
 	if (arch_clock->clk_disable)
 		arch_clock->clk_disable(clk);
+
+out:
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
-- 
1.5.3.6

