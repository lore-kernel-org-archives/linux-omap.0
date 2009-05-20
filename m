From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP3: PM: Smartreflex: Fix VDD2 OPP determining logic
Date: Wed, 20 May 2009 15:26:57 +0300
Message-ID: <1242822417-17829-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21772 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbZETMda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 08:33:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Use l3_ick clock rate to find out current VDD2 OPP since
VDD2 OPP table uses rates corresponding to L3 clock.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 061cd4e..422c917 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -184,7 +184,7 @@ static u16 get_vdd2_opp(void)
 	u16 opp;
 	struct clk *clk;
 
-	clk = clk_get(NULL, "dpll3_m2_ck");
+	clk = clk_get(NULL, "l3_ick");
 
 	if (clk == NULL || IS_ERR(clk) || l3_opps == NULL)
 		return 0;
-- 
1.6.0.4

