From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 2/3] arm: mach-omap2: sdram-nokia: add 200 MHz memory timings info
Date: Fri,  9 Dec 2011 17:06:50 +0200
Message-ID: <1323443211-3648-3-git-send-email-aaro.koskinen@nokia.com>
References: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:42328 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294Ab1LIPFH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 10:05:07 -0500
In-Reply-To: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Igor Dmitriev <ext-dmitriev.igor@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Igor Dmitriev <ext-dmitriev.igor@nokia.com>

Add memory timing info regarding the 200 MHz memory in sdram-nokia.

Signed-off-by: Igor Dmitriev <ext-dmitriev.igor@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 14caa22..b394a0e 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -1,7 +1,7 @@
 /*
  * SDRC register values for Nokia boards
  *
- * Copyright (C) 2008, 2010 Nokia Corporation
+ * Copyright (C) 2008, 2010-2011 Nokia Corporation
  *
  * Lauri Leukkunen <lauri.leukkunen@nokia.com>
  *
@@ -107,14 +107,37 @@ static const struct sdram_timings nokia_195dot2mhz_timings[] = {
 	},
 };
 
+static const struct sdram_timings nokia_200mhz_timings[] = {
+	{
+		.casl = 3,
+		.tDAL = 30000,
+		.tDPL = 15000,
+		.tRRD = 10000,
+		.tRCD = 20000,
+		.tRP = 15000,
+		.tRAS = 40000,
+		.tRC = 55000,
+		.tRFC = 140000,
+		.tXSR = 200000,
+
+		.tREF = 7800,
+
+		.tXP = 2,
+		.tCKE = 4,
+		.tWTR = 2
+	},
+};
+
 static const struct {
 	long rate;
 	struct sdram_timings const *data;
 } nokia_timings[] = {
 	{ 83000000, nokia_166mhz_timings },
 	{ 97600000, nokia_97dot6mhz_timings },
+	{ 100000000, nokia_200mhz_timings },
 	{ 166000000, nokia_166mhz_timings },
 	{ 195200000, nokia_195dot2mhz_timings },
+	{ 200000000, nokia_200mhz_timings },
 };
 static struct omap_sdrc_params nokia_sdrc_params[ARRAY_SIZE(nokia_timings) + 1];
 
-- 
1.7.2.5

