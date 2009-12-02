From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 01/10] arm: omap1: clock: fix section mismatch
Date: Thu,  3 Dec 2009 00:35:43 +0200
Message-ID: <1259793352-29864-2-git-send-email-felipe.balbi@nokia.com>
References: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51008 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885AbZLBWgH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:07 -0500
In-Reply-To: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

omap1_clk_functions was only used by
omap1_clk_init() which sits in __init
section, so make omap1_clock_functions
be __initdata to avoid the section mismatch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 42cbe20..d28ace2 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -744,7 +744,7 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
 #define omap1_clk_disable_unused	NULL
 #endif
 
-static struct clk_functions omap1_clk_functions = {
+static struct clk_functions omap1_clk_functions __initdata = {
 	.clk_enable		= omap1_clk_enable,
 	.clk_disable		= omap1_clk_disable,
 	.clk_round_rate		= omap1_clk_round_rate,
-- 
1.6.6.rc0

