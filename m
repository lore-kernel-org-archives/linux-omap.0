From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3: clock: indicate that gpt12_fck and wdt1_fck are in
 the WKUP clockdomain
Date: Mon, 22 Aug 2011 16:20:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108221619430.10315@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56362 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab1HVWUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2011 18:20:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


The oscillator that supplies GPT12_FCLK and WDT1_FCLK exists in the
WKUP powerdomain[1].  This resolves at least one boot-time warning:

omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.

1. _OMAP34xx Multimedia High Security (HS) Device Silicon Revision 3.1.x
   Security Addendum Version K (SWPU119K)_  Figure 3-29.  August 2010.
---
Intended for 3.1-rc.

 arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index ffd55b1..b9b8446 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3078,6 +3078,7 @@ static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -3085,6 +3086,7 @@ static struct clk wdt1_fck = {
 	.name		= "wdt1_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.7.5.4

