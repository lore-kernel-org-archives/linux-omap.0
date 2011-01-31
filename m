From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v3 4/4] OMAP4: DSS2: clocks: Add ick as dummy clock
Date: Mon, 31 Jan 2011 21:57:46 +0530
Message-ID: <1296491266-6949-5-git-send-email-sumit.semwal@ti.com>
References: <1296491266-6949-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52772 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab1AaQbL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 11:31:11 -0500
In-Reply-To: <1296491266-6949-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Sumit Semwal <sumit.semwal@ti.com>

DSS code uses ick as one of the clocks in clk_get/clk_put. OMAP4 clock database
doesn't have ick for DSS, so adding ick as dummy clock.

This is needed for backward compatibility with OMAP2/3.

Once pm_runtime* APIs get introduced in DSS, this will be revisited.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 9bd3ae5..615a361 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3112,6 +3112,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap_dss",	"dss_clk",			&dss_dss_clk,	CK_443X),
 	CLK("omap_dss",	"video_clk",			&dss_48mhz_clk,	CK_443X),
 	CLK("omap_dss",	"fck",				&dss_fck,	CK_443X),
+	/*
+	 * On OMAP4, DSS ick is a dummy clock; this is needed for compatibility
+	 * with OMAP2/3.
+	 */
+	CLK("omap_dss",	"ick",				&dummy_ck,	CK_443X),
 	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
 	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
 	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
-- 
1.7.1

