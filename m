From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/3] ARM: AM33xx: clock: Add RNG clock data
Date: Tue, 6 Aug 2013 14:03:03 +0530
Message-ID: <1375777984-6267-3-git-send-email-lokeshvutla@ti.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57937 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834Ab3HFIdj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 04:33:39 -0400
In-Reply-To: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, devicetree@vger.kernel.org, rob@landley.net, rnayak@ti.com, benoit.cousson@linaro.org, lokeshvutla@ti.com

Add clock data for RNG module on AM33xx SoC.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/cclock33xx_data.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index ba6534d..865d30e 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -421,6 +421,10 @@ static struct clk aes0_fck;
 DEFINE_STRUCT_CLK_HW_OMAP(aes0_fck, NULL);
 DEFINE_STRUCT_CLK(aes0_fck, dpll_core_ck_parents, clk_ops_null);
 
+static struct clk rng_fck;
+DEFINE_STRUCT_CLK_HW_OMAP(rng_fck, NULL);
+DEFINE_STRUCT_CLK(rng_fck, dpll_core_ck_parents, clk_ops_null);
+
 /*
  * Modules clock nodes
  *
@@ -966,6 +970,7 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"smartreflex1_fck",	&smartreflex1_fck),
 	CLK(NULL,	"sha0_fck",		&sha0_fck),
 	CLK(NULL,	"aes0_fck",		&aes0_fck),
+	CLK(NULL,	"rng_fck",		&rng_fck),
 	CLK(NULL,	"timer1_fck",		&timer1_fck),
 	CLK(NULL,	"timer2_fck",		&timer2_fck),
 	CLK(NULL,	"timer3_fck",		&timer3_fck),
-- 
1.7.9.5

