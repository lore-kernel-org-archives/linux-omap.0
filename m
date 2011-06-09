From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap: mark dt_compat __initconst
Date: Fri, 10 Jun 2011 00:59:26 +0300
Message-ID: <1307656766-20083-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45207 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756423Ab1FIV7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 17:59:32 -0400
Received: by mail-bw0-f50.google.com with SMTP id 2so1780661bwz.9
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 14:59:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

we have a special section for const data
which is only needed during init, that's
__initconst. Use that instead of __initdata
which is for non-const data.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

This patch is against devel-devicetree branch from
linux-omap.

 arch/arm/mach-omap2/board-igep0020.c    |    2 +-
 arch/arm/mach-omap2/board-igep0030.c    |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c  |    2 +-
 arch/arm/mach-omap2/board-overo.c       |    2 +-
 arch/arm/mach-omap2/board-zoom.c        |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index eb198a6..d9888eb 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -703,7 +703,7 @@ static void __init igep2_init(void)
 
 }
 
-static const char *igep2_dt_compat[] __initdata = {
+static const char *igep2_dt_compat[] __initconst = {
 	"ISEE,igep-v2",
 	NULL
 };
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index e13fdf0..984e4a1 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -447,7 +447,7 @@ static void __init igep3_init(void)
 
 }
 
-static const char *igep3_dt_compat[] __initdata = {
+static const char *igep3_dt_compat[] __initconst = {
 	"ISEE,igep-v3",
 	NULL
 };
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b9ad453..85ca38f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -681,7 +681,7 @@ static void __init omap3_beagle_init(void)
 	beagle_opp_init();
 }
 
-static const char *omap3_beagle_dt_match[] __initdata = {
+static const char *omap3_beagle_dt_match[] __initconst = {
 	"ti,omap3-beagle",
 	NULL
 };
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 47738db..58adeaf 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -741,7 +741,7 @@ static void __init omap4_panda_map_io(void)
 	omap44xx_map_common_io();
 }
 
-static const char *omap4_panda_match[] __initdata = {
+static const char *omap4_panda_match[] __initconst = {
 	"ti,omap4-panda",
 	NULL,
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e91942a..e88f846 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -785,7 +785,7 @@ static void __init overo_init(void)
 					"OVERO_GPIO_USBH_CPEN\n");
 }
 
-static const char *omap3_overo_dt_match[] __initdata = {
+static const char *omap3_overo_dt_match[] __initconst = {
 	"gumstix,omap3-overo",
 	NULL
 };
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 6cc9569..0627ea2 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -132,7 +132,7 @@ static void __init omap_zoom_init(void)
 	zoom_display_init();
 }
 
-static const char *zoom3_dt_match[] __initdata = {
+static const char *zoom3_dt_match[] __initconst = {
 	"ti,zoom3",
 	NULL
 };
-- 
1.7.6.rc1

