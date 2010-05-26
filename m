From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH pm-wip/uart 4/4] 24xx: need .module_offs = CORE_MOD
Date: Wed, 26 May 2010 16:05:15 -0700
Message-ID: <1274915115-28355-5-git-send-email-khilman@deeprootsystems.com>
References: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63990 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab0EZXF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 19:05:28 -0400
Received: by pvg3 with SMTP id 3so1350260pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 16:05:28 -0700 (PDT)
In-Reply-To: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index c1618a5..682eecd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -239,6 +239,7 @@ static struct omap_hwmod omap2420_uart1_hwmod = {
 	.main_clk	= "uart1_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP24XX_EN_UART1_SHIFT,
 		},
@@ -273,6 +274,7 @@ static struct omap_hwmod omap2420_uart2_hwmod = {
 	.main_clk	= "uart2_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP24XX_EN_UART2_SHIFT,
 		},
@@ -307,6 +309,7 @@ static struct omap_hwmod omap2420_uart3_hwmod = {
 	.main_clk	= "uart3_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 2,
 			.module_bit = OMAP24XX_EN_UART3_SHIFT,
 		},
-- 
1.7.0.2

