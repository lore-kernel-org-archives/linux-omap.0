From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 23/45] ARM: OMAP: hwmod: fix an incorrect clk type cast with _get_clkdm
Date: Thu, 29 Aug 2013 16:16:15 +0300
Message-ID: <1377782197-10611-24-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49143 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535Ab3H2NSb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:31 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

If the main clock for a hwmod is of basic clock type, it is illegal to type
cast this to clk_hw_omap and will result in bogus data. Fixed by checking
the clock flags before attempting the type cast.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9dade6c..ec82989 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -656,6 +656,8 @@ static struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
 	if (oh->clkdm) {
 		return oh->clkdm;
 	} else if (oh->_clk) {
+		if (__clk_get_flags(oh->_clk) & CLK_IS_BASIC)
+			return NULL;
 		clk = to_clk_hw_omap(__clk_get_hw(oh->_clk));
 		return  clk->clkdm;
 	}
-- 
1.7.9.5

