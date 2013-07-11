From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4+: Get rid of the HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags for uart
Date: Thu, 11 Jul 2013 16:23:05 +0530
Message-ID: <1373539986-27272-3-git-send-email-rnayak@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48995 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113Ab3GKKxy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 06:53:54 -0400
In-Reply-To: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

The HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags don't belong in the
SoC data but instead need to be set runtime based on the uart thats used
for debug console, so hwmod avoids doing a reset followed by a idling of
the device. This is already happening as part of the omap_serial_early_init()
so remove these flags from the static SoC data.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index d04b5e6..f80f120 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2858,8 +2858,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
-				HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index f37ae96..e816edd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1375,7 +1375,6 @@ static struct omap_hwmod omap54xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-- 
1.7.9.5

