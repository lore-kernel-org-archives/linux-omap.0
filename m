From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH pm-wip/uart 1/4] OMAP3: hwmod: UART: add module offs
Date: Wed, 26 May 2010 16:05:12 -0700
Message-ID: <1274915115-28355-2-git-send-email-khilman@deeprootsystems.com>
References: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:65055 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0EZXFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 19:05:23 -0400
Received: by pzk6 with SMTP id 6so3038799pzk.1
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 16:05:23 -0700 (PDT)
In-Reply-To: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

fold into OMAP3 hwmod patch
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f88bfff..5bf8690 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -287,6 +287,7 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.main_clk	= "uart1_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP3430_EN_UART1_SHIFT,
 		},
@@ -321,6 +322,7 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.main_clk	= "uart2_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP3430_EN_UART2_SHIFT,
 		},
@@ -355,6 +357,7 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.main_clk	= "uart3_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = OMAP3430_PER_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP3430_EN_UART3_SHIFT,
 		},
-- 
1.7.0.2

