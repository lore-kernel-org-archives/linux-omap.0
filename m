From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/12] OMAP4: clock data: Add missing fields in
	iva_hsd_byp_clk_mux_ck
Date: Mon, 13 Dec 2010 23:34:47 -0700
Message-ID: <20101214063446.21555.74809.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50270 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0LNGf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:35:26 -0500
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jonathan Bergsagel <jbergsagel@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Jonathan Bergsagel <jbergsagel@ti.com>

Add register address, mask and link to the clksel structure that
were missing in the IVA DPLL mux clock node.

Signed-off-by: Jonathan Bergsagel <jbergsagel@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index aa503cb..421103c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -636,8 +636,12 @@ static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
 static struct clk iva_hsd_byp_clk_mux_ck = {
 	.name		= "iva_hsd_byp_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
+	.clksel		= iva_hsd_byp_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_CLKSEL_DPLL_IVA,
+	.clksel_mask	= OMAP4430_DPLL_BYP_CLKSEL_MASK,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* DPLL_IVA */


