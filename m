From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH pm-wip/uart 3/4] OMAP2420: hwmod: UART3 needs prcm_reg_id = 2
Date: Wed, 26 May 2010 16:05:14 -0700
Message-ID: <1274915115-28355-4-git-send-email-khilman@deeprootsystems.com>
References: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36727 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab0EZXF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 19:05:27 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so430965pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 16:05:26 -0700 (PDT)
In-Reply-To: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

PRCM bits for UART3 are in PRCM reg id 2 (CM_IDLEST2_CORE, etc.)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b9a957d..c1618a5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -307,7 +307,7 @@ static struct omap_hwmod omap2420_uart3_hwmod = {
 	.main_clk	= "uart3_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
+			.prcm_reg_id = 2,
 			.module_bit = OMAP24XX_EN_UART3_SHIFT,
 		},
 	},
-- 
1.7.0.2

