From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 32/32] ARM: OMAP: RX51: set MMC capabilities and power-saving flag
Date: Fri, 10 Jul 2009 15:43:53 +0300
Message-ID: <20090710124353.1262.22788.sendpatchset@ahunter-tower>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37364 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771AbZGJMkW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 08:40:22 -0400
In-Reply-To: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 3865867159f25cf706480236f6d4f0e4adde5dac Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 10 Jul 2009 10:32:44 +0300
Subject: [PATCH] ARM: OMAP: RX51: set MMC capabilities and power-saving flag

Specify MMC capabilities and set the power-saving flag
for RX51.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9a0bf67..5cc815b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
 
 #include <mach/mcspi.h>
 #include <mach/mux.h>
@@ -102,6 +103,8 @@ static struct twl4030_hsmmc_info mmc[] = {
 		.cover_only	= true,
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
+		.power_saving	= true,
+		.caps		= MMC_CAP_SD_ONLY,
 	},
 	{
 		.name		= "internal",
@@ -109,6 +112,8 @@ static struct twl4030_hsmmc_info mmc[] = {
 		.wires		= 8,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.power_saving	= true,
+		.caps		= MMC_CAP_MMC_ONLY | MMC_CAP_NONREMOVABLE,
 	},
 	{}	/* Terminator */
 };
-- 
1.5.6.3

