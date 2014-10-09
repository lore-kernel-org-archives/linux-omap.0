From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH 5/6] ARM: OMAP4: fix RFBI iclk
Date: Thu, 9 Oct 2014 17:03:18 +0300
Message-ID: <1412863399-9508-6-git-send-email-tomi.valkeinen@ti.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44063 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755857AbaJIODk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Oct 2014 10:03:40 -0400
In-Reply-To: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

RFBI iclk was set to point to hacky "dss_fck", which will be removed.
Instead use "l3_div_ck", which is the proper clock for this. "l3_div_ck"
is the parent of "dss_fck", so the clock rate is the same as previously.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi               | 2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 69408b53200d..4c15409a9056 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -880,7 +880,7 @@
 				reg = <0x58002000 0x1000>;
 				status = "disabled";
 				ti,hwmods = "dss_rfbi";
-				clocks = <&dss_dss_clk>, <&dss_fck>;
+				clocks = <&dss_dss_clk>, <&l3_div_ck>;
 				clock-names = "fck", "ick";
 			};
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 8126f178d57e..d6f41e1b6d1b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -824,7 +824,7 @@ static struct omap_hwmod_dma_info omap44xx_dss_rfbi_sdma_reqs[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
-	{ .role = "ick", .clk = "dss_fck" },
+	{ .role = "ick", .clk = "l3_div_ck" },
 };
 
 static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
-- 
2.1.1

