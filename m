From: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>
Subject: [PATCH 50/57] OMAP3: CLOCK: Add capability to change rate of dpll4_m5_ck_3630
Date: Tue,  9 Feb 2010 15:32:02 +0200
Message-ID: <1265722329-7735-51-git-send-email-vimarsh.zutshi@nokia.com>
References: <1265722329-7735-1-git-send-email-vimarsh.zutshi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53585 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab0BINh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 08:37:57 -0500
In-Reply-To: <1265722329-7735-1-git-send-email-vimarsh.zutshi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: core-review@ok.research.nokia.com
Cc: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>, camera-review@projects.maemo.org, jouni.hogander@nokia.com, linux-omap@vger.kernel.org

Add necessary clk_sel definitions to clock framework to allow changing
dpll4_m5_ck_3630 rate. This is used by the ISP driver.

Signed-off-by: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>
---
 arch/arm/mach-omap2/clock34xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index f85e33a..8f15f18 100755
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -937,6 +937,8 @@ static struct clk dpll4_m5_ck_3630 __initdata = {
 	.clksel_shift	= OMAP3430_CLKSEL_CAM_SHIFT,
 	.clksel		= div32_dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
 	.recalc		= &omap2_clksel_recalc,
 };
 
-- 
1.5.6.5

