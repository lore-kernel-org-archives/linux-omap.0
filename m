From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/16] ARM: OMAP2: Move sys_clkout2 clk to core_clkdm
Date: Fri,  6 Jun 2008 19:12:31 -0700
Message-ID: <1212804762-18413-4-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56658 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbYFGCMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:12:50 -0400
In-Reply-To: <1212804762-18413-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

sys_clkout2 belongs in the core_clkdm (3430 TRM section 4.7.2.2).
It's not clear whether it actually is in the CORE clockdomain, or whether
it is technically in a different clockdomain; but this is closer to
reality than the present configuration.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index aa871c2..8f90b8c 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -977,6 +977,7 @@ static struct clk clkout2_src_ck = {
 	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
 	.clksel		= clkout2_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm_name	= "core_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
