From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 06/11] ARM: OMAP: Do not register omap-mcbsp-dai
	device
Date: Wed, 15 Feb 2012 17:37:55 +0200
Message-ID: <1329320280-1621-7-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The driver for omap-mcbsp-dai no longer exist since it has been merged with
the omap-mcbsp driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
index 0b510ad..ba540aa 100644
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
