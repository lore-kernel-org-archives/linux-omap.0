From: Rick Bronson <rick@efn.org>
Subject: [PATCH] ARM: OMAP: Fix for omap3_noncore_dpll_enable() warning
Date: Fri, 17 Oct 2008 08:57:03 -0700
Message-ID: <E1KqrhH-0001Gl-1p@amazonia.comcast.net>
References: <20081016160350.GI15820@atomide.com>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:42402 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757821AbYJQP5H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Oct 2008 11:57:07 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 79C7F170158
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 08:57:01 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1KqrhH-0001Gl-1p
	for linux-omap@vger.kernel.org; Fri, 17 Oct 2008 08:57:03 -0700
In-reply-to: <20081016160350.GI15820@atomide.com> (message from Tony Lindgren
	on Thu, 16 Oct 2008 09:03:53 -0700)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

  This patch fixes this warning which, as Tomi Valkeinen pointed out, is
really an error.

  CC      arch/arm/mach-omap2/clock34xx.o
arch/arm/mach-omap2/clock34xx.c: In function 'omap3_noncore_dpll_enable':
arch/arm/mach-omap2/clock34xx.c:290: warning: 'rate' is used uninitialized in this function

--- linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c.~1~	2008-10-16 13:33:26.000000000 -0700
+++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c	2008-10-17 07:35:50.000000000 -0700
@@ -270,8 +270,7 @@ static int _omap3_noncore_dpll_stop(stru
  */
 static int omap3_noncore_dpll_enable(struct clk *clk)
 {
-	int r;
-	long rate;
+	int rate;
 	struct dpll_data *dd;
 
 	if (clk == &dpll3_ck)
@@ -282,14 +281,14 @@ static int omap3_noncore_dpll_enable(str
 		return -EINVAL;
 
 	if (clk->rate == dd->bypass_clk->rate)
-		r = _omap3_noncore_dpll_bypass(clk);
+		rate = _omap3_noncore_dpll_bypass(clk);
 	else
-		r = _omap3_noncore_dpll_lock(clk);
+		rate = _omap3_noncore_dpll_lock(clk);
 
-	if (!r)
+	if (!rate)
 		clk->rate = rate;
 
-	return r;
+	return rate;
 }
 
 /**
