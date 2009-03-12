From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 78/86] [ARM] omap: fix usecount decrement bug
Date: Thu, 12 Mar 2009 11:28:28 -0700
Message-ID: <1236882516-29403-79-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-77-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-78-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264AbZCLSeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:17 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:15 -0700 (PDT)
In-Reply-To: <1236882516-29403-78-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Based upon a patch from Paul Walmsley <paul@pwsan.com>:

 If _omap2_clk_enable() fails, the clock's usecount must be decremented
 by one no matter whether the clock has a parent or not.

but reorganised a bit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 666274a..222c2c0 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -419,30 +419,30 @@ int omap2_clk_enable(struct clk *clk)
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
-		if (clk->parent)
+		if (clk->parent) {
 			ret = omap2_clk_enable(clk->parent);
-
-		if (ret != 0) {
-			clk->usecount--;
-			return ret;
+			if (ret)
+				goto err;
 		}
 
 		if (clk->clkdm)
 			omap2_clkdm_clk_enable(clk->clkdm, clk);
 
 		ret = _omap2_clk_enable(clk);
-
-		if (ret != 0) {
+		if (ret) {
 			if (clk->clkdm)
 				omap2_clkdm_clk_disable(clk->clkdm, clk);
 
-			if (clk->parent) {
+			if (clk->parent)
 				omap2_clk_disable(clk->parent);
-				clk->usecount--;
-			}
+
+			goto err;
 		}
 	}
+	return ret;
 
+err:
+	clk->usecount--;
 	return ret;
 }
 
-- 
1.6.1.2

