From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/8] OMAP4: clock data: Add missing fields in iva_hsd_byp_clk_mux_ck
Date: Thu, 9 Dec 2010 23:13:36 +0100
Message-ID: <1291932820-11163-5-git-send-email-b-cousson@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59874 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab0LIWOG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 17:14:06 -0500
In-Reply-To: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Bergsagel <jbergsagel@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Jonathan Bergsagel <jbergsagel@ti.com>

Add register address, mask and link to the clksel structure that
were missing in the IVA DPLL mux clock node.

Signed-off-by: Jonathan Bergsagel <jbergsagel@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 123aa6d..6558d91 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -636,8 +636,12 @@ static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
 static struct clk iva_hsd_byp_clk_mux_ck = {
 	.name		= "iva_hsd_byp_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
+	.clksel 	= iva_hsd_byp_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_CLKSEL_DPLL_IVA,
+	.clksel_mask	= OMAP4430_DPLL_BYP_CLKSEL_MASK,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* DPLL_IVA */
-- 
1.7.0.4

