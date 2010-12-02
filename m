From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/6] OMAP4: clock data: Add control for pad_clks_ck and slimbus_clk
Date: Thu, 2 Dec 2010 11:44:48 +0100
Message-ID: <1291286693-32538-2-git-send-email-b-cousson@ti.com>
References: <1291286693-32538-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38798 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0LBKpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:45:54 -0500
In-Reply-To: <1291286693-32538-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Rajendra Nayak <rnayak@ti.com>

The gating of pad_clks and slimbus_ck is controlled by the PRCM, but
since the clock source is external, this is the SW responsability
to gate / un-gate it when the mcpdm or slimbus module need to be used.
There is no autogating possible with such external clock.

Add SW control to enable / disable this SW gating in the pad_clks_ck
and slimbus_clk clock node.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 1599836..4395e2e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -47,7 +47,9 @@ static struct clk extalt_clkin_ck = {
 static struct clk pad_clks_ck = {
 	.name		= "pad_clks_ck",
 	.rate		= 12000000,
-	.ops		= &clkops_null,
+	.ops            = &clkops_omap2_dflt,
+	.enable_reg     = OMAP4430_CM_CLKSEL_ABE,
+	.enable_bit     = OMAP4430_PAD_CLKS_GATE_SHIFT,
 };
 
 static struct clk pad_slimbus_core_clks_ck = {
@@ -65,7 +67,9 @@ static struct clk secure_32k_clk_src_ck = {
 static struct clk slimbus_clk = {
 	.name		= "slimbus_clk",
 	.rate		= 12000000,
-	.ops		= &clkops_null,
+	.ops            = &clkops_omap2_dflt,
+	.enable_reg     = OMAP4430_CM_CLKSEL_ABE,
+	.enable_bit     = OMAP4430_SLIMBUS_CLK_GATE_SHIFT,
 };
 
 static struct clk sys_32k_ck = {
-- 
1.7.0.4

