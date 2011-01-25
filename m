From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v2 4/4] OMAP4: DSS2: clocks: Add ick as dummy clock
Date: Tue, 25 Jan 2011 18:29:58 +0530
Message-ID: <1295960398-25329-5-git-send-email-sumit.semwal@ti.com>
References: <1295960398-25329-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab1AYNAa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 08:00:30 -0500
In-Reply-To: <1295960398-25329-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Sumit Semwal <sumit.semwal@ti.com>

DSS code uses ick as one of the clocks in clk_get/clk_put. OMAP4 clock database
doesn't have ick for DSS, so adding ick as dummy clock.

Once pm_runtime* APIs get introduced in DSS, this will be revisited.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 74db324..8603b1f 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3109,6 +3109,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
 	/* dss clocks */
 	CLK(NULL,	"fck",				&dss_fck,	CK_443X),
+	CLK("omap_dss",	"ick",				&dummy_ck,	CK_443X),
+	/* on OMAP4, ick is a dummy clock */
 	/*
 	 * clocks handled via hwmod opt_clk mechanism need dev=NULL,
 	 * con=clock name as per actual clk structure, NOT role
-- 
1.7.1

