From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/7] omap3: dpll: Populate clkops for dpll1_ck
Date: Thu, 10 Feb 2011 14:46:35 +0530
Message-ID: <1297329400-5936-3-git-send-email-rnayak@ti.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
 <1297329400-5936-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56503 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918Ab1BJJQ4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 04:16:56 -0500
In-Reply-To: <1297329400-5936-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

DPLL1 on omap3 is very similar to the rest of
the non-core dpll's.
Hence populate clkops_omap3_noncore_dpll_ops
as the clkops for it, instead of the
currently populated clkops_null.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 403a4a1..3e9d721 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -296,7 +296,7 @@ static struct dpll_data dpll1_dd = {
 
 static struct clk dpll1_ck = {
 	.name		= "dpll1_ck",
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap3_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll1_dd,
 	.round_rate	= &omap2_dpll_round_rate,
-- 
1.7.0.4

