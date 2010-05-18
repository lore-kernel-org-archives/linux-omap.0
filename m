From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 09/14] OMAP2: Devkit8000: Fixing comment about pins used
Date: Tue, 18 May 2010 14:05:30 +0200
Message-ID: <1274184335-29322-10-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62553 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059Ab0ERMGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:04 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Fix the comment about the pins support by the vmmc1 power source.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 4a633f8..d8c1d81 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -291,7 +291,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 static struct regulator_consumer_supply devkit8000_vpll1_supply =
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
 
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT7 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data devkit8000_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
-- 
1.6.4.4

