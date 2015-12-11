From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Remove device creation for omap-pcm-audio
Date: Fri, 11 Dec 2015 14:50:20 +0200
Message-ID: <1449838220-24309-3-git-send-email-peter.ujfalusi@ti.com>
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
 arch/arm/mach-omap2/devices.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9374da313e8e..9cda974a3009 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -94,22 +94,6 @@ static inline void omap_init_mbox(void) { }
 
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
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
@@ -239,13 +223,12 @@ static int __init omap2_init_devices(void)
 	if (!of_have_populated_dt())
 		pinctrl_provide_dummies();
 
-	/*
-	 * please keep these calls, and their implementations above,
-	 * in alphabetical order so they're easier to sort through.
-	 */
-	omap_init_audio();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
+		/*
+		 * please keep these calls, and their implementations above,
+		 * in alphabetical order so they're easier to sort through.
+		 */
 		omap_init_mbox();
 		omap_init_mcspi();
 		omap_init_sham();
-- 
2.6.4
