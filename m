From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: omap2: io: fix clk_get() error check
Date: Tue, 30 Nov 2010 16:17:58 +0200
Message-ID: <1291126678-2782-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:17852 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab0K3OSb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 09:18:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

clk_get() return value should be checked with IS_ERR().

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..a1939b1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -297,7 +297,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
 		return 0;
 
 	dpll3_m2_ck = clk_get(NULL, "dpll3_m2_ck");
-	if (!dpll3_m2_ck)
+	if (IS_ERR(dpll3_m2_ck))
 		return -EINVAL;
 
 	rate = clk_get_rate(dpll3_m2_ck);
-- 
1.5.6.5

