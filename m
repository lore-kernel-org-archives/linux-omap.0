From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 14/15] OMAP: Panda, Beagle, Overo: DVI: Add i2c_bus_num
Date: Mon, 12 Sep 2011 12:13:37 +0300
Message-ID: <1315818818-18733-15-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40178 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754541Ab1ILJOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:25 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add i2c bus number for DVI output. The driver uses this to detect if a
panel is connected and to read EDID.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/board-overo.c       |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 26bc860..742ac45 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -206,6 +206,7 @@ static void beagle_disable_dvi(struct omap_dss_device *dssdev)
 static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable = beagle_enable_dvi,
 	.platform_disable = beagle_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 static struct omap_dss_device beagle_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c35384e..a38ed273 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -458,6 +458,7 @@ static void omap4_panda_disable_dvi(struct omap_dss_device *dssdev)
 static struct panel_dvi_platform_data omap4_dvi_panel = {
 	.platform_enable	= omap4_panda_enable_dvi,
 	.platform_disable	= omap4_panda_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 struct omap_dss_device omap4_panda_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 06064d5..da94376 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -186,6 +186,7 @@ static void overo_panel_disable_dvi(struct omap_dss_device *dssdev)
 static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= overo_panel_enable_dvi,
 	.platform_disable	= overo_panel_disable_dvi,
+	.i2c_bus_num		= 3,
 };
 
 static struct omap_dss_device overo_dvi_device = {
-- 
1.7.4.1

