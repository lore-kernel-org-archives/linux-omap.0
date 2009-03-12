From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 76/86] [ARM] OMAP2/3 clock: convert remaining MPU barriers into OCP barriers
Date: Thu, 12 Mar 2009 11:28:26 -0700
Message-ID: <1236882516-29403-77-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259AbZCLSeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:10 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:08 -0700 (PDT)
In-Reply-To: <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Several parts of the OMAP2/3 clock code use wmb() to try to ensure
that the hardware write completes before continuing.  This approach is
problematic: wmb() only ensures that the write leaves the ARM.  It
does not ensure that the write actually reaches the endpoint device.
The endpoint device in this case - either the PRM, CM, or SCM - is
three interconnects away from the ARM - and the final interconnect is
low-speed.  And the OCP interconnects will post the write, and who
knows how long that will take to complete.  So the wmb() is not what
we want.  Worse, the wmb() is indiscriminate; it causes the ARM to
flush any other unrelated buffered writes and wait for the local
interconnect to acknowledge them - potentially very expensive.

Fix this by converting the wmb()s into readbacks of the same PRM/CM/SCM
register.  Since the PRM/CM/SCM devices use a single OCP thread, this
will cause the MPU to block while waiting for posted writes to that device
to complete.

linux-omap source commit is 260f5487848681b4d8ea7430a709a601bbcb21d1.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 7f12230..666274a 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -334,7 +334,7 @@ static int omap2_dflt_clk_enable(struct clk *clk)
 	else
 		v |= (1 << clk->enable_bit);
 	__raw_writel(v, clk->enable_reg);
-	wmb();
+	v = __raw_readl(clk->enable_reg); /* OCP barrier */
 
 	return 0;
 }
@@ -703,7 +703,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 	v &= ~clk->clksel_mask;
 	v |= field_val << __ffs(clk->clksel_mask);
 	__raw_writel(v, clk->clksel_reg);
-	wmb();
+	v = __raw_readl(clk->clksel_reg); /* OCP barrier */
 
 	clk->rate = clk->parent->rate / new_div;
 
@@ -788,7 +788,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	v &= ~clk->clksel_mask;
 	v |= field_val << __ffs(clk->clksel_mask);
 	__raw_writel(v, clk->clksel_reg);
-	wmb();
+	v = __raw_readl(clk->clksel_reg);    /* OCP barrier */
 
 	_omap2xxx_clk_commit(clk);
 
-- 
1.6.1.2

