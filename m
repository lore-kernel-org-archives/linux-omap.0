From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: omap4: clock data: Add missing clkdm association for dpll_usb
Date: Fri, 25 Jan 2013 12:06:35 +0530
Message-ID: <1359095795-9538-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58003 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab3AYGgr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jan 2013 01:36:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

dpll_usb needs the clkdm association so the clkdm can be
turned on before a relock. All other dplls for omap4 belong
to the ALWON (always on) domain.

The association was present as part of the older data file
(clock44xx_data.c) but looks like was accidently dropped with
the common clk convertion.

More details of the patch which fixed this up in the older
data file can be dound here..
http://www.spinics.net/lists/linux-omap/msg63076.html

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 5789a5e..fdea8da 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -601,6 +601,7 @@ static struct clk_hw_omap dpll_usb_ck_hw = {
 	},
 	.dpll_data	= &dpll_usb_dd,
 	.ops		= &clkhwops_omap3_dpll,
+	.clkdm_name	= "l3_init_clkdm",
 };
 
 DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_usb_ck_parents, dpll_ck_ops);
-- 
1.7.9.5

