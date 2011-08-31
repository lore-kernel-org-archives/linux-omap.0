From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/12] OMAP: Panda & Beagle: DVI: Add i2c_bus_num
Date: Wed, 31 Aug 2011 16:23:22 +0300
Message-ID: <1314797003-17638-12-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:46362 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755487Ab1HaNX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:56 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add i2c bus number for DVI output. The driver uses this to detect if a
panel is connected and to read EDID.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ae16b4..13244e9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -207,6 +207,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 	.name = "generic",
 	.platform_enable = beagle_enable_dvi,
 	.platform_disable = beagle_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 static struct omap_dss_device beagle_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9aaa960..d5760e3 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -459,6 +459,7 @@ static struct panel_generic_dpi_data omap4_dvi_panel = {
 	.name			= "generic",
 	.platform_enable	= omap4_panda_enable_dvi,
 	.platform_disable	= omap4_panda_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 struct omap_dss_device omap4_panda_dvi_device = {
-- 
1.7.4.1

