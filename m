From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/6] OMAP4: Clock: Associate clocks for OMAP temperature sensor
Date: Thu, 22 Sep 2011 20:59:17 +0530
Message-ID: <1316705361-12175-3-git-send-email-j-keerthy@ti.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53952 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab1IVP31 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 11:29:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MFTNrL013199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 10:29:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MFTMZJ025719
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 20:59:22 +0530 (IST)
In-Reply-To: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com

div_ts_ck feeds only the temperature sensor functional clock
and also has a clksel associated (for divider selection). Mapping this
as well as the bandgap_ts_fclk the fclk of temperature sensor in clkdev table,
so a clk_set_rate() on the div_ts_ck in the driver would have the effect of
changing the temperature sensor clock rate indirectly.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com
Cc: paul@pwsan.com 
---
 arch/arm/mach-omap2/clock44xx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 946bf04..c51e513 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3185,9 +3185,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
 	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
 	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
-	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
+	CLK("omap4460plus_scm.0",	"fck",		&bandgap_ts_fclk,	CK_446X),
 	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
-	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
+	CLK("omap4460plus_scm.0",	"div_ck",			&div_ts_ck,	CK_446X),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
-- 
1.7.0.4

