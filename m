From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/12] ARM: OMAP2: clock: use DT clock boot if available
Date: Fri, 28 Feb 2014 11:23:04 +0200
Message-ID: <1393579384-23440-13-git-send-email-t-kristo@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43806 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbaB1JYm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 04:24:42 -0500
In-Reply-To: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Otherwise legacy boot clock data is used.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index af432b1..e57088d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -53,6 +53,7 @@
 #include "prm2xxx.h"
 #include "prm3xxx.h"
 #include "prm44xx.h"
+#include "opp2xxx.h"
 
 /*
  * omap_clk_soc_init: points to a function that does the SoC-specific
@@ -410,7 +411,12 @@ void __init omap2420_init_early(void)
 	omap242x_clockdomains_init();
 	omap2420_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_soc_init = omap2420_clk_init;
+	if (of_have_populated_dt()) {
+		omap_clk_soc_init = omap2420_dt_clk_init;
+		rate_table = omap2420_rate_table;
+	} else {
+		omap_clk_soc_init = omap2420_clk_init;
+	}
 }
 
 void __init omap2420_init_late(void)
@@ -439,7 +445,12 @@ void __init omap2430_init_early(void)
 	omap243x_clockdomains_init();
 	omap2430_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_soc_init = omap2430_clk_init;
+	if (of_have_populated_dt()) {
+		omap_clk_soc_init = omap2430_dt_clk_init;
+		rate_table = omap2430_rate_table;
+	} else {
+		omap_clk_soc_init = omap2430_clk_init;
+	}
 }
 
 void __init omap2430_init_late(void)
-- 
1.7.9.5

