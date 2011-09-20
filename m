From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/10] OMAP: Add DDC i2c_bus_num to board files
Date: Tue, 20 Sep 2011 11:18:23 +0300
Message-ID: <1316506706-18941-8-git-send-email-tomi.valkeinen@ti.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:40600 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754268Ab1ITITB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 04:19:01 -0400
Received: by mail-bw0-f48.google.com with SMTP id zu5so319316bkb.35
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:19:00 -0700 (PDT)
In-Reply-To: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add i2c bus number for DVI output for boards with DVI output where the
i2c bus has been confirmed to be connected and working. The driver uses
this to detect if a panel is connected and to read EDID.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-igep0020.c    |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/board-overo.c       |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 9fda8d8..6ff5222 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -458,6 +458,7 @@ static void igep2_disable_dvi(struct omap_dss_device *dssdev)
 static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= igep2_enable_dvi,
 	.platform_disable	= igep2_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 static struct omap_dss_device igep2_dvi_device = {
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

