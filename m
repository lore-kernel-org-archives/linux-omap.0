From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/7] arm: mach-omap1: board-htcherald: make htcpld_chips and htcpld_pfdata static
Date: Tue, 18 Jan 2011 09:52:42 +0200
Message-ID: <1295337165-22934-5-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:44484 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab1ARHwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 02:52:36 -0500
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Eliminates the following sparse warnings:

	arch/arm/mach-omap1/board-htcherald.c:334:34: warning: symbol 'htcpld_chips' was not declared. Should it be static?
	arch/arm/mach-omap1/board-htcherald.c:369:34: warning: symbol 'htcpld_pfdata' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-htcherald.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index f2c5c58..ba05a51 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -331,7 +331,7 @@ static struct resource htcpld_resources[] = {
 	},
 };
 
-struct htcpld_chip_platform_data htcpld_chips[] = {
+static struct htcpld_chip_platform_data htcpld_chips[] = {
 	[0] = {
 		.addr		= 0x03,
 		.reset		= 0x04,
@@ -366,7 +366,7 @@ struct htcpld_chip_platform_data htcpld_chips[] = {
 	},
 };
 
-struct htcpld_core_platform_data htcpld_pfdata = {
+static struct htcpld_core_platform_data htcpld_pfdata = {
 	.int_reset_gpio_hi = HTCPLD_GPIO_INT_RESET_HI,
 	.int_reset_gpio_lo = HTCPLD_GPIO_INT_RESET_LO,
 	.i2c_adapter_id	   = 1,
-- 
1.5.6.5

