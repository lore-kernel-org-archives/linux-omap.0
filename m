From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] ARM: OMAP1: Move omap_init_audio() to keep the devices
 in alphabetical order
Date: Mon, 23 Apr 2012 17:08:25 -0700
Message-ID: <20120424000825.17783.14785.stgit@muffinssi.local>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40084 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2DXAI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:26 -0400
In-Reply-To: <20120424000607.17783.81686.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

The comments in omap1_init_devices() ask to keep the devices in
alphabetical order. Only omap_init_audio() is not following this,
so let's move it. No functional changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index dcd8ddb..51387a4 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -31,6 +31,22 @@
 #include "common.h"
 #include "clock.h"
 
+#if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
+
+static struct platform_device omap_pcm = {
+	.name	= "omap-pcm-audio",
+	.id	= -1,
+};
+
+static void omap_init_audio(void)
+{
+	platform_device_register(&omap_pcm);
+}
+
+#else
+static inline void omap_init_audio(void) {}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
@@ -242,24 +258,6 @@ void __init omap1_camera_init(void *info)
 
 static inline void omap_init_sti(void) {}
 
-#if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
-
-static struct platform_device omap_pcm = {
-	.name	= "omap-pcm-audio",
-	.id	= -1,
-};
-
-static void omap_init_audio(void)
-{
-	platform_device_register(&omap_pcm);
-}
-
-#else
-static inline void omap_init_audio(void) {}
-#endif
-
-/*-------------------------------------------------------------------------*/
-
 /*
  * This gets called after board-specific INIT_MACHINE, and initializes most
  * on-chip peripherals accessible on this board (except for few like USB):
@@ -292,11 +290,11 @@ static int __init omap1_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 
+	omap_init_audio();
 	omap_init_mbox();
 	omap_init_rtc();
 	omap_init_spi100k();
 	omap_init_sti();
-	omap_init_audio();
 
 	return 0;
 }

