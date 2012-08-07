From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] arm: OMAP3+: am33xx: Add new clk node entry for d_can modules
Date: Tue, 7 Aug 2012 19:00:50 +0530
Message-ID: <1344346250-27606-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52983 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab2HGNdq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 09:33:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

The d_can0/1 module integrated with AM335x device, requires
only one clock (fck) and driver expects clock to be available
without specifying any connection id (con_id) -

  clk_get(&pdev->dev, NULL);

This is acceptable as module has only one clock and platform
code should respect this request, so create new clock nodes
inside am33xx clock-tree table based on dev_id and "con_id = NULL"
for both d_can0 and d_can1 instances.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
This patch is boot tested on BeagleBone platform, and checked for
clk_get() api return value.

 arch/arm/mach-omap2/clock33xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index ae27de8..23251fa 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1027,7 +1027,9 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"cefuse_fck",		&cefuse_fck,	CK_AM33XX),
 	CLK(NULL,	"clkdiv32k_ick",	&clkdiv32k_ick,	CK_AM33XX),
 	CLK(NULL,	"dcan0_fck",		&dcan0_fck,	CK_AM33XX),
+	CLK("d_can.0",	NULL,			&dcan0_fck,	CK_AM33XX),
 	CLK(NULL,	"dcan1_fck",		&dcan1_fck,	CK_AM33XX),
+	CLK("d_can.1",	NULL,			&dcan1_fck,	CK_AM33XX),
 	CLK(NULL,	"debugss_ick",		&debugss_ick,	CK_AM33XX),
 	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk,	CK_AM33XX),
 	CLK("davinci-mcasp.0",  NULL,           &mcasp0_fck,    CK_AM33XX),
--
1.7.0.4

