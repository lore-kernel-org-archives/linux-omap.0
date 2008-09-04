From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] The clockdomain of clkout2_src_ck fixed
Date: Thu,  4 Sep 2008 11:54:29 +0300
Message-ID: <1220518469-26036-1-git-send-email-tomi.valkeinen@nokia.com>
References: <20080904014448.GP23085@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23581 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbYIDIzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 04:55:11 -0400
In-Reply-To: <20080904014448.GP23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

The clockdomain of clkout2_src_ck was set to "core_clkdm", which does not
exist.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 5d855e9..8da0097 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1010,7 +1010,7 @@ static struct clk clkout2_src_ck = {
 	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
 	.clksel		= clkout2_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
-	.clkdm		= { .name = "core_clkdm" },
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
-- 
1.6.0.1

