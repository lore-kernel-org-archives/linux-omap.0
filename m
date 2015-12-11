From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: OMAP1: Remove device creation for omap-pcm-audio
Date: Fri, 11 Dec 2015 14:50:19 +0200
Message-ID: <1449838220-24309-2-git-send-email-peter.ujfalusi@ti.com>
References: <1449838220-24309-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449838220-24309-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The omap-pcm in ASoC is no longer a platform device. No need to create this
device anymore.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap1/devices.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 263c07a566cb..8c8be861fff2 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -33,24 +33,6 @@
 #include "mmc.h"
 #include "sram.h"
 
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
 #if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
 
 #define	OMAP_RTC_BASE		0xfffb4800
@@ -425,7 +407,6 @@ static int __init omap1_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 
-	omap_init_audio();
 	omap_init_mbox();
 	omap_init_rtc();
 	omap_init_spi100k();
-- 
2.6.4
