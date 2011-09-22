From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 6/6] OMAP4460: Clock: Adding support for 4460 specific clocks
Date: Thu, 22 Sep 2011 20:59:21 +0530
Message-ID: <1316705361-12175-7-git-send-email-j-keerthy@ti.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49379 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab1IVP32 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 11:29:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MFTOHj022866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 10:29:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MFTOTY025741
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 20:59:24 +0530 (IST)
In-Reply-To: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com

From: Vishwanath BS <vishwanath.bs@ti.com>

OMAP4460 specific clocks are not getting added as the
cpu_is_omap44xx is choosing only OMAP4430 specific clock nodes.
Changing it to add to OMAP4460 specific clocks also.
This is clocks are required of temperature sensor.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Cc: paul@pwsan.com 
---
 arch/arm/mach-omap2/clock44xx_data.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index c51e513..f72513b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1398,9 +1398,9 @@ static struct clk dss_dss_clk = {
 };
 
 static const struct clksel_rate div3_8to32_rates[] = {
-	{ .div = 8, .val = 0, .flags = RATE_IN_44XX },
-	{ .div = 16, .val = 1, .flags = RATE_IN_44XX },
-	{ .div = 32, .val = 2, .flags = RATE_IN_44XX },
+	{ .div = 8, .val = 0, .flags = RATE_IN_4460 },
+	{ .div = 16, .val = 1, .flags = RATE_IN_4460 },
+	{ .div = 32, .val = 2, .flags = RATE_IN_4460 },
 	{ .div = 0 },
 };
 
@@ -3403,12 +3403,12 @@ int __init omap4xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg;
 
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
 		cpu_clkflg = CK_443X;
 	} else if (cpu_is_omap446x()) {
-		cpu_mask = RATE_IN_4460;
-		cpu_clkflg = CK_446X;
+		cpu_mask = RATE_IN_4460 | RATE_IN_4430;
+		cpu_clkflg = CK_446X | CK_443X;
 	} else {
 		return 0;
 	}
-- 
1.7.0.4

