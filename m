From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 3/8] arm: omap: sdram-nokia: prepare for new memory timings
Date: Thu,  9 Dec 2010 18:39:19 +0200
Message-ID: <1291912764-12823-4-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:32318 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab0LIQih (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 11:38:37 -0500
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rename the current timings to indicate they're for 166 MHz. Based on
patches by Eduardo Valentin and Juha Keski-Saari.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 261efc8..97d1673 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -46,7 +46,7 @@ struct sdram_timings {
 
 static struct omap_sdrc_params nokia_sdrc_params[4];
 
-static const struct sdram_timings memory_timings[] = {
+static const struct sdram_timings nokia_166mhz_timings[] = {
 	{
 		.casl = 3,
 		.tDAL = 33000,
@@ -160,7 +160,8 @@ static int set_sdrc_timing_regval_ps(u32 *regval, int st_bit, int end_bit,
 		err = -1;
 #endif
 
-static int sdrc_timings(int id, long rate)
+static int sdrc_timings(int id, long rate,
+			const struct sdram_timings *memory_timings)
 {
 	u32 ticks_per_ms;
 	u32 rfr, l;
@@ -213,9 +214,9 @@ struct omap_sdrc_params *nokia_get_sdram_timings(void)
 {
 	int err;
 
-	err = sdrc_timings(0, 41500000);
-	err |= sdrc_timings(1, 83000000);
-	err |= sdrc_timings(2, 166000000);
+	err = sdrc_timings(0, 41500000, nokia_166mhz_timings);
+	err |= sdrc_timings(1, 83000000, nokia_166mhz_timings);
+	err |= sdrc_timings(2, 166000000, nokia_166mhz_timings);
 
 	return &nokia_sdrc_params[0];
 }
-- 
1.5.6.5

