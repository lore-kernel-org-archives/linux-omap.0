From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 6/8] arm: omap: sdram-nokia: delete redundant timing data
Date: Thu,  9 Dec 2010 18:39:22 +0200
Message-ID: <1291912764-12823-7-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:32466 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab0LIQip (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 11:38:45 -0500
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

41.5 MHz SDRAM clock is not usable.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 863586b..baf83ec 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -69,7 +69,6 @@ static const struct {
 	long rate;
 	struct sdram_timings const *data;
 } nokia_timings[] = {
-	{ 41500000, nokia_166mhz_timings },
 	{ 83000000, nokia_166mhz_timings },
 	{ 166000000, nokia_166mhz_timings },
 };
-- 
1.5.6.5

