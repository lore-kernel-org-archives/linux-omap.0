From: Archit Taneja <archit@ti.com>
Subject: [PATCH 8/9] OMAP: DSS2: DSI: Build a platform device instance for DSI2
Date: Wed,  4 May 2011 13:08:23 +0530
Message-ID: <1304494704-7285-9-git-send-email-archit@ti.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44209 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab1EDHeB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 03:34:01 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p447Y0Hp027582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 02:34:01 -0500
In-Reply-To: <1304494704-7285-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a platform device instance for DSI2. Use "dss_dsi2" hwmod name and
"omapdss_dsi" platfrom device name to build the platform_device instance. Add
"omapdss_dsi.1" as a regulator consumer for "vdds_dsi".

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    1 +
 arch/arm/mach-omap2/display.c       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index eafadb4..1f48499 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -376,6 +376,7 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.1"),
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index f0e9cbf..07ac97d 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -83,6 +83,7 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
 	{ "dss_dsi1", "omapdss_dsi", 0 },
+	{ "dss_dsi2", "omapdss_dsi", 1 },
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
-- 
1.7.1

