From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/2] ARM: OMAP AM33XX: clock data: Enable clkout2 as part of init
Date: Tue, 7 May 2013 15:09:33 +0530
Message-ID: <1367919574-21353-2-git-send-email-hvaibhav@ti.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50818 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab3EGJpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 05:45:09 -0400
In-Reply-To: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

clkout2 comes out on the pad and is being used by various
external on-board peripherals like, Audio codecs and stuff.
So enable the clkout2 by default during init sequence itself.

Also, add the missing entry of "clkout2_ck" to the clock table.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/cclock33xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index 6fd0ed1..a8140b6 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -979,6 +979,7 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"trace_pmd_clk_mux_ck",	&trace_pmd_clk_mux_ck),
 	CLK(NULL,	"stm_clk_div_ck",	&stm_clk_div_ck),
 	CLK(NULL,	"trace_clk_div_ck",	&trace_clk_div_ck),
+	CLK(NULL,	"clkout2_ck",		&clkout2_ck),
 };
 
 
@@ -989,6 +990,7 @@ static const char *enable_init_clks[] = {
 	"l4hs_gclk",
 	"l4fw_gclk",
 	"l4ls_gclk",
+	"clkout2_ck",	/* Required for external peripherals like, Audio codecs */
 };
 
 int __init am33xx_clk_init(void)
-- 
1.7.0.4

