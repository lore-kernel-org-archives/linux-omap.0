From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 10/10] ARM: OMAP4: clock data: flag hw controlled clocks as autoidle
Date: Tue, 25 Sep 2012 12:32:45 +0300
Message-ID: <1348565565-14744-11-git-send-email-t-kristo@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52393 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497Ab2IYJdO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 05:33:14 -0400
In-Reply-To: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This makes sure these clocks are ignored by the clkdm / pwrdm usecounting.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 95834d7..d2fb4e8 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3356,8 +3356,11 @@ int __init omap4xxx_clk_init(void)
 	 */
 
 	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
-									  c++)
+									  c++) {
+		if (c->lk.clk->enable_bit == OMAP4430_MODULEMODE_HWCTRL)
+			c->lk.clk->autoidle = true;
 		clk_preinit(c->lk.clk);
+	}
 
 	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
 									  c++)
-- 
1.7.4.1

