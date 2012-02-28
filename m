From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 05/10] ARM: OMAP: Do not register omap-mcbsp-dai device
Date: Tue, 28 Feb 2012 09:40:15 +0200
Message-ID: <1330414820-4641-6-git-send-email-peter.ujfalusi@ti.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46444 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756490Ab2B1Hkq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:40:46 -0500
Received: by laap9 with SMTP id p9so3833341laa.24
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:40:43 -0800 (PST)
In-Reply-To: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

The driver for omap-mcbsp-dai no longer exist since it has been merged with
the omap-mcbsp driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/devices.c           |    9 ---------
 arch/arm/mach-omap2/devices.c           |   22 ----------------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    7 -------
 3 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 1d76a63..187b2fe 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -28,7 +28,6 @@
 #include <plat/mux.h>
 #include <plat/mmc.h>
 #include <plat/omap7xx.h>
-#include <plat/mcbsp.h>
 
 #include "clock.h"
 
@@ -250,16 +249,8 @@ static struct platform_device omap_pcm = {
 	.id	= -1,
 };
 
-OMAP_MCBSP_PLATFORM_DEVICE(1);
-OMAP_MCBSP_PLATFORM_DEVICE(2);
-OMAP_MCBSP_PLATFORM_DEVICE(3);
-
 static void omap_init_audio(void)
 {
-	platform_device_register(&omap_mcbsp1);
-	platform_device_register(&omap_mcbsp2);
-	if (!cpu_is_omap7xx())
-		platform_device_register(&omap_mcbsp3);
 	platform_device_register(&omap_pcm);
 }
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..e9fae65 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -26,7 +26,6 @@
 
 #include <plat/tc.h>
 #include <plat/board.h>
-#include <plat/mcbsp.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
@@ -304,29 +303,8 @@ static struct platform_device omap_pcm = {
 	.id	= -1,
 };
 
-/*
- * OMAP2420 has 2 McBSP ports
- * OMAP2430 has 5 McBSP ports
- * OMAP3 has 5 McBSP ports
- * OMAP4 has 4 McBSP ports
- */
-OMAP_MCBSP_PLATFORM_DEVICE(1);
-OMAP_MCBSP_PLATFORM_DEVICE(2);
-OMAP_MCBSP_PLATFORM_DEVICE(3);
-OMAP_MCBSP_PLATFORM_DEVICE(4);
-OMAP_MCBSP_PLATFORM_DEVICE(5);
-
 static void omap_init_audio(void)
 {
-	platform_device_register(&omap_mcbsp1);
-	platform_device_register(&omap_mcbsp2);
-	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		platform_device_register(&omap_mcbsp3);
-		platform_device_register(&omap_mcbsp4);
-	}
-	if (cpu_is_omap243x() || cpu_is_omap34xx())
-		platform_device_register(&omap_mcbsp5);
-
 	platform_device_register(&omap_pcm);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 437e375..8eb9b0e 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -27,13 +27,6 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 
-/* macro for building platform_device for McBSP ports */
-#define OMAP_MCBSP_PLATFORM_DEVICE(port_nr)		\
-static struct platform_device omap_mcbsp##port_nr = {	\
-	.name	= "omap-mcbsp-dai",			\
-	.id	= port_nr - 1,			\
-}
-
 #define MCBSP_CONFIG_TYPE2	0x2
 #define MCBSP_CONFIG_TYPE3	0x3
 #define MCBSP_CONFIG_TYPE4	0x4
-- 
1.7.8.4

