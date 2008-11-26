From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Typo fix for clock_allow_idle
Date: Wed, 26 Nov 2008 15:30:42 -0800
Message-ID: <20081126233042.GP11997@atomide.com>
References: <20081126232707.GN11997@atomide.com> <20081126232833.GO11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63717 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYKZXam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 18:30:42 -0500
Content-Disposition: inline
In-Reply-To: <20081126232833.GO11997@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

>From 147dcf5489fb86c4bfe400520186f9f11b304783 Mon Sep 17 00:00:00 2001
From: Amit Kucheria <amit.kucheria@verdurent.com>
Date: Tue, 25 Nov 2008 15:11:12 -0800
Subject: [PATCH] ARM: OMAP: Typo fix for clock_allow_idle

The second clk_deny_idle instance should be clk_allow_idle instead.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/pm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index 768eb6e..2a9c27a 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -128,7 +128,7 @@ void clk_deny_idle(struct clk *clk);
  * clk_allow_idle - Counters previous clk_deny_idle
  * @clk: clock signal handle
  */
-void clk_deny_idle(struct clk *clk);
+void clk_allow_idle(struct clk *clk);
 
 extern void omap_pm_idle(void);
 extern void omap_pm_suspend(void);
-- 
1.5.6.rc3.21.g8c6b5

