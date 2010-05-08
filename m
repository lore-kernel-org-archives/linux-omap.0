From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 5/6] Devkit8000: Fix comment
Date: Sat,  8 May 2010 06:31:22 +0200
Message-ID: <1273293083-24063-6-git-send-email-weber@corscience.de>
References: <1273293083-24063-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56960 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0EHEbu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 May 2010 00:31:50 -0400
In-Reply-To: <1273293083-24063-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

Fix the comment about the pins supported
by the vmmc1 power source.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index c0905b0..4ca87f8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -281,7 +281,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 static struct regulator_consumer_supply devkit8000_vpll1_supply =
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
 
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT7 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data devkit8000_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
-- 
1.6.4.4

