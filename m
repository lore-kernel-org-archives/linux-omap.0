From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V5 5/6] ARM: OMAP: Disable venc for OMAP4
Date: Mon, 20 Aug 2012 18:54:47 +0530
Message-ID: <a07a3a216827e830cfa249f4f39ad26e75dc0afd.1345468541.git.cmahapatra@ti.com>
References: <cover.1343912532.git.cmahapatra@ti.com> <cover.1345468541.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37536 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756014Ab2HTN3Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 09:29:16 -0400
In-Reply-To: <cover.1345468541.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

This is a alternative to "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4 to
prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> to prevent
VENC from crashing OMAP4 kernel. This prevents OMAPDSS from initial registration
of a device for VENC on OMAP4.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 arch/arm/mach-omap2/display.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index af1ed7d..ee40739 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -95,7 +95,6 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_core", "omapdss_dss", -1 },
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
-	{ "dss_venc", "omapdss_venc", -1 },
 	{ "dss_dsi1", "omapdss_dsi", 0 },
 	{ "dss_dsi2", "omapdss_dsi", 1 },
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
-- 
1.7.10

