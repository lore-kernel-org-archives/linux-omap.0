From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch-v2.6.32-omap1+ 2/2] arm: omap: add missing __initdata to omap_board_config_kernel
Date: Wed, 16 Dec 2009 23:52:35 +0200
Message-ID: <1261000355-2174-3-git-send-email-felipe.balbi@nokia.com>
References: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63931 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZLPVxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 16:53:38 -0500
In-Reply-To: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <kjh@hilman.org>, Felipe Balbi <felipe.balbi@nokia.com>

we still need to get rid of the OMAP_TAG_LCD, but while
it's still there, let's kill the section mismatches.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

Tony, do you think this is the right thing to do now ?
Would the lcd drivers cope with the config being
__initdata ?

 arch/arm/mach-omap1/board-ams-delta.c |    2 +-
 arch/arm/mach-omap1/board-fsample.c   |    2 +-
 arch/arm/mach-omap1/board-innovator.c |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c   |    2 +-
 arch/arm/mach-omap2/board-apollon.c   |    2 +-
 arch/arm/mach-omap2/board-generic.c   |    2 +-
 arch/arm/mach-omap2/board-h4.c        |    2 +-
 arch/arm/mach-omap2/board-rx51.c      |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 7fc11c3..1ceb85a 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -171,7 +171,7 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_board_config_kernel ams_delta_config[] = {
+static struct omap_board_config_kernel ams_delta_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 7e70c3c..9cbf732 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -278,7 +278,7 @@ static struct omap_lcd_config fsample_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel fsample_config[] = {
+static struct omap_board_config_kernel fsample_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&fsample_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2133b00..7e3a58a 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -380,7 +380,7 @@ static inline void innovator_mmc_init(void)
 }
 #endif
 
-static struct omap_board_config_kernel innovator_config[] = {
+static struct omap_board_config_kernel innovator_config[] __initdata = {
 	{ OMAP_TAG_LCD,		NULL },
 };
 
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 1691835..fcb3dfa 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -150,7 +150,7 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 	.pins[2]	= 6,
 };
 
-static struct omap_board_config_kernel voiceblue_config[] = {
+static struct omap_board_config_kernel voiceblue_config[] __initdata = {
 };
 
 static void __init voiceblue_init_irq(void)
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index e508904..d9bfc35 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -139,7 +139,7 @@ static inline void board_smc91x_init(void)
 
 #endif
 
-static struct omap_board_config_kernel sdp2430_config[] = {
+static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index fbbd68d..58e5fa5 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -269,7 +269,7 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel apollon_config[] = {
+static struct omap_board_config_kernel apollon_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 7e6e6ca..68e219b 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -31,7 +31,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 
-static struct omap_board_config_kernel generic_config[] = {
+static struct omap_board_config_kernel generic_config[] __initdata = {
 };
 
 static void __init omap_generic_init_irq(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index cfb7f12..6a8decb 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -305,7 +305,7 @@ static struct omap_usb_config h4_usb_config __initdata = {
 #endif
 };
 
-static struct omap_board_config_kernel h4_config[] = {
+static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 67bb347..9adf236 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -49,7 +49,7 @@ static struct omap_fbmem_config rx51_fbmem2_config = {
 	.size = 752 * 1024,
 };
 
-static struct omap_board_config_kernel rx51_config[] = {
+static struct omap_board_config_kernel rx51_config[] __initdata = {
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem0_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem1_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem2_config },
-- 
1.6.6.rc0

