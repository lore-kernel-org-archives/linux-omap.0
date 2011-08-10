From: Keerthy <j-keerthy@ti.com>
Subject: [RFC PATCH 1/6] OMAP4: Clock: Associate clocks for OMAP temperature sensor
Date: Wed, 10 Aug 2011 17:55:17 +0530
Message-ID: <1312979122-5896-2-git-send-email-j-keerthy@ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51222 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124Ab1HJM0J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 08:26:09 -0400
In-Reply-To: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lm-sensors@lm-sensors.org
Cc: vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, j-keerthy@ti.com

div_ts_ck feeds only the temperature sensor functional clock
and also has a clksel associated (for divider selection). Mapping this
as the functional clock for the temperature sensor in clkdev table,
so a clk_set_rate() in the driver would have the effect of changing the
temperature sensor clock rate indirectly.

Reviewd-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2af0e3f..4a788f4 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3187,7 +3187,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
 	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
 	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
-	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
+	CLK("omap_temp_sensor.0",	"fck",			&div_ts_ck,	CK_446X),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
-- 
1.7.0.4

