From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] The clockdomain of clkout2_src_ck fixed
Date: Fri, 29 Aug 2008 17:48:29 +0300
Message-ID: <1220021309-17275-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53209 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbYH2Os4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 10:48:56 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7TEmWVh019105
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 09:48:54 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

The clockdomain of clkout2_src_ck was set to "core_clkdm", which does not
exist.
---
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index d7d6ffd..3504e48 100644
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
1.5.4.3

