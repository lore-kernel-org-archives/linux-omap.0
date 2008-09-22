From: kucheria.amit@gmail.com
Subject: [PATCH 1/2] Typo fix for clock_allow_idle
Date: Mon, 22 Sep 2008 10:23:09 +0300
Message-ID: <1222068189-10663-1-git-send-email-kucheria.amit@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23285 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYIVHXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 03:23:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Amit Kucheria <amit.kucheria@verdurent.com>

From: Amit Kucheria <amit.kucheria@verdurent.com>

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
---
 arch/arm/plat-omap/include/mach/pm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index e4cf1c5..15c19f0 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -131,7 +131,7 @@ void clk_deny_idle(struct clk *clk);
  * clk_allow_idle - Counters previous clk_deny_idle
  * @clk: clock signal handle
  */
-void clk_deny_idle(struct clk *clk);
+void clk_allow_idle(struct clk *clk);
 
 extern void omap_pm_idle(void);
 extern void omap_pm_suspend(void);
-- 
1.5.6.3

