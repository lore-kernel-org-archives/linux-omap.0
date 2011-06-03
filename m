From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/27] OMAP4: HWMOD: Remove unneeded DSS opt clocks
Date: Fri,  3 Jun 2011 13:00:30 +0300
Message-ID: <1307095237-14805-21-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44282 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754257Ab1FCKBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:45 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some of the optional clocks for dss_core are not needed. Remove them.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4f6ae94..b374cd0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1164,10 +1164,7 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_sys_clk" },
-	{ .role = "tv_clk", .clk = "dss_tv_clk" },
 	{ .role = "dss_clk", .clk = "dss_dss_clk" },
-	{ .role = "video_clk", .clk = "dss_48mhz_clk" },
 };
 
 static struct omap_hwmod omap44xx_dss_hwmod = {
-- 
1.7.4.1

