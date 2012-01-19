From: Ameya Palande <ameya.palande@ti.com>
Subject: [PATCH] OMAP4: Clock: Force a DPLL clkdm/pwrdm ON before a relock
Date: Thu, 19 Jan 2012 11:22:56 -0800
Message-ID: <1327000976-30912-1-git-send-email-ameya.palande@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39049 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932677Ab2ASTW6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 14:22:58 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q0JJMwBO031011
	for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 13:22:58 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q0JJMvXf025854
	for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 13:22:58 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, ameya.palande@ti.com, nm@ti.com

From: Rajendra Nayak <rnayak@ti.com>

All DPLLs except USB are in ALWON powerdomain. Make sure the
clkdm/pwrdm for USB DPLL (l3init) is turned on before attempting
a DPLL relock. So, mark the database accordingly.

Without this fix, it was seen that DPLL relock fails while testing
relock in a loop of USB DPLL.

CC: Nishanth Menon <nm@ti.com>
Tested-by: Ameya Palande <ameya.palande@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 08e86d7..9519374 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -974,6 +974,7 @@ static struct clk dpll_usb_ck = {
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
 static struct clk dpll_usb_clkdcoldo_ck = {
-- 
1.7.4.1

