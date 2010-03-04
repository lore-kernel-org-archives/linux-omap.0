From: felipe.balbi@nokia.com
Subject: [PATCH 1/2] Revert "omap: Fix compile for early_param and omap_smc1"
Date: Thu,  4 Mar 2010 09:40:15 +0200
Message-ID: <1267688416-5998-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48026 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab0CDHlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 02:41:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

This reverts commit a91741262f0ae82d651c7270bc1354016c5bb9dd.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |   12 ++++++------
 drivers/video/omap2/vram.c                 |   14 +++++---------
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index a462d50..180ac11 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -49,7 +49,7 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
-#if defined(CONFIG_SMP) && defined(CONFIG_CACHE_L2X0)
+#ifdef CONFIG_CACHE_L2X0
 noinline void omap_smc1(u32 fn, u32 arg)
 {
 	register u32 r12 asm("r12") = fn;
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 07b7a32..3943d0f 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -493,7 +493,7 @@ static void __init omap3touchbook_flash_init(void)
 	}
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
@@ -518,14 +518,14 @@ static void omap3_touchbook_poweroff(void)
 	gpio_direction_output(TB_KILL_POWER_GPIO, 0);
 }
 
-static int __init early_touchbook_revision(char *p)
+static void __init early_touchbook_revision(char **p)
 {
-	if (!p)
-		return 0;
+	if (!*p)
+		return;
 
-	return strict_strtoul(p, 10, &touchbook_revision);
+	strict_strtoul(*p, 10, &touchbook_revision);
 }
-early_param("tbr", early_touchbook_revision);
+__early_param("tbr=", early_touchbook_revision);
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 1d88425..55a4de5 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -511,17 +511,13 @@ static u32 omap_vram_sdram_size __initdata;
 static u32 omap_vram_def_sdram_size __initdata;
 static u32 omap_vram_def_sdram_start __initdata;
 
-static int __init omap_vram_early_vram(char *p)
+static void __init omap_vram_early_vram(char **p)
 {
-	char *endp;
-
-	omap_vram_def_sdram_size = memparse(p, &endp);
-	if (*endp == ',')
-		omap_vram_def_sdram_start = simple_strtoul(endp + 1, &p, 16);
-
-	return 0;
+	omap_vram_def_sdram_size = memparse(*p, p);
+	if (**p == ',')
+		omap_vram_def_sdram_start = simple_strtoul((*p) + 1, p, 16);
 }
-early_param("vram", omap_vram_early_vram);
+__early_param("vram=", omap_vram_early_vram);
 
 /*
  * Called from map_io. We need to call to this early enough so that we
-- 
1.7.0.rc0.33.g7c3932

