From: Archit Taneja <archit@ti.com>
Subject: [PATCH 11/11] [experimental] arm: omap: omap4 hwmod data: Split hdmi address space
Date: Tue, 17 Sep 2013 12:36:37 +0530
Message-ID: <1379401597-27222-12-git-send-email-archit@ti.com>
References: <1379401597-27222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab3IQHID (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Sep 2013 03:08:03 -0400
In-Reply-To: <1379401597-27222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Split hdmi address space in order to get base addresses of hdmi submodules by
name. This is just a demonstration patch for the hdmi refactoring to work. The
address data should belong to the hdmi DT node.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9c3b504..3b12339 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3843,7 +3843,26 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
 
 static struct omap_hwmod_addr_space omap44xx_dss_hdmi_addrs[] = {
 	{
+		.name		= "hdmi_wp",
 		.pa_start	= 0x48046000,
+		.pa_end		= 0x480461ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.name		= "hdmi_pllctrl",
+		.pa_start	= 0x48046200,
+		.pa_end		= 0x480462ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.name		= "hdmi_txphy",
+		.pa_start	= 0x48046300,
+		.pa_end		= 0x480463ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.name		= "hdmi_core",
+		.pa_start	= 0x48046400,
 		.pa_end		= 0x48046fff,
 		.flags		= ADDR_TYPE_RT
 	},
-- 
1.8.1.2

