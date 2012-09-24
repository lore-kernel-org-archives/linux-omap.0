From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: am33xx: clk: Update clkdev table to add mcasp alias
Date: Mon, 24 Sep 2012 23:26:39 +0530
Message-ID: <1348509399-3391-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34773 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab2IXSAK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 14:00:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

After Rajendra's common-clock preparation series,
commit (a1978ef4da1 - ARM: omap: hwmod: get rid of
all omap_clk_get_by_name usage) the clkdev table need to
update with an entry for clocks used by hwmod to have
clock name same as the alias.

Without this, the clk_get() in omap_hwmod would fail.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index b87b88c..114ab4b 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1035,6 +1035,8 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk,	CK_AM33XX),
 	CLK("davinci-mcasp.0",  NULL,           &mcasp0_fck,    CK_AM33XX),
 	CLK("davinci-mcasp.1",  NULL,           &mcasp1_fck,    CK_AM33XX),
+	CLK(NULL,	"mcasp0_fck",		&mcasp0_fck,	CK_AM33XX),
+	CLK(NULL,	"mcasp1_fck",		&mcasp1_fck,	CK_AM33XX),
 	CLK("NULL",	"mmc2_fck",		&mmc2_fck,	CK_AM33XX),
 	CLK(NULL,	"mmu_fck",		&mmu_fck,	CK_AM33XX),
 	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck,	CK_AM33XX),
-- 
1.7.0.4

