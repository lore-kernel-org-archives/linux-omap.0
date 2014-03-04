From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 12/14] ARM: OMAP2: clock: use DT clock boot if available
Date: Tue, 4 Mar 2014 11:18:18 +0200
Message-ID: <1393924700-6510-13-git-send-email-t-kristo@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44040 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756697AbaCDJTt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 04:19:49 -0500
In-Reply-To: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, mturquette@linaro.org, paul@pwsan.com
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

