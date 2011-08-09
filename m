From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 02/13] ARM: gpio: convert includes of mach/gpio.h and
 asm/gpio.h to linux/gpio.h
Date: Tue, 09 Aug 2011 09:05:00 +0100
Message-ID: <E1QqhJ6-0003a4-Eu@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41879 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1HIIFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 04:05:25 -0400
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>Grant Likely <grant.likely@secretlab.ca>Nicolas Pitre <nico@fluxnic.net>

Convert arch/arm includes of mach/gpio.h and asm/gpio.h to linux/gpio.h
before we start consolidating the individual platform implementations
of the gpio header files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/scoop.c                          |    2 +-
 arch/arm/mach-at91/at91cap9_devices.c            |    2 +-
 arch/arm/mach-at91/at91rm9200_devices.c          |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c         |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c         |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c         |    2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c         |    2 +-
 arch/arm/mach-at91/at91sam9rl_devices.c          |    2 +-
 arch/arm/mach-at91/board-1arm.c                  |    2 +-
 arch/arm/mach-at91/board-afeb-9260v1.c           |    2 +-
 arch/arm/mach-at91/board-cam60.c                 |    2 +-
 arch/arm/mach-at91/board-cap9adk.c               |    2 +-
 arch/arm/mach-at91/board-carmeva.c               |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c              |    2 +-
 arch/arm/mach-at91/board-cpuat91.c               |    2 +-
 arch/arm/mach-at91/board-csb337.c                |    2 +-
 arch/arm/mach-at91/board-csb637.c                |    2 +-
 arch/arm/mach-at91/board-eb9200.c                |    2 +-
 arch/arm/mach-at91/board-ecbat91.c               |    2 +-
 arch/arm/mach-at91/board-kafa.c                  |    2 +-
 arch/arm/mach-at91/board-kb9202.c                |    2 +-
 arch/arm/mach-at91/board-neocore926.c            |    2 +-
 arch/arm/mach-at91/board-picotux200.c            |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c             |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c              |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c              |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c            |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c             |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c          |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c              |    2 +-
 arch/arm/mach-at91/board-usb-a9260.c             |    2 +-
 arch/arm/mach-at91/board-usb-a9263.c             |    2 +-
 arch/arm/mach-at91/board-yl-9200.c               |    2 +-
 arch/arm/mach-at91/gpio.c                        |    3 +--
 arch/arm/mach-at91/leds.c                        |    2 +-
 arch/arm/mach-at91/pm.c                          |    2 +-
 arch/arm/mach-davinci/da830.c                    |    2 +-
 arch/arm/mach-davinci/da850.c                    |    2 +-
 arch/arm/mach-davinci/gpio.c                     |    4 +---
 arch/arm/mach-davinci/tnetv107x.c                |    2 +-
 arch/arm/mach-imx/iomux-imx31.c                  |    3 +--
 arch/arm/mach-imx/mach-mx27ads.c                 |    3 +--
 arch/arm/mach-ixp2000/core.c                     |    4 +---
 arch/arm/mach-ixp2000/ixdp2x00.c                 |    3 +--
 arch/arm/mach-ixp4xx/dsmg600-setup.c             |    3 +--
 arch/arm/mach-ixp4xx/fsg-setup.c                 |    3 +--
 arch/arm/mach-ixp4xx/nas100d-setup.c             |    3 +--
 arch/arm/mach-ixp4xx/nslu2-setup.c               |    3 +--
 arch/arm/mach-kirkwood/irq.c                     |    3 +--
 arch/arm/mach-kirkwood/mpp.c                     |    3 +--
 arch/arm/mach-ks8695/board-acs5k.c               |    3 +--
 arch/arm/mach-ks8695/board-dsm320.c              |    3 +--
 arch/arm/mach-ks8695/board-micrel.c              |    3 +--
 arch/arm/mach-ks8695/gpio.c                      |    3 +--
 arch/arm/mach-ks8695/leds.c                      |    3 +--
 arch/arm/mach-mmp/aspenite.c                     |    3 +--
 arch/arm/mach-mmp/mmp2.c                         |    3 +--
 arch/arm/mach-mmp/pxa168.c                       |    3 +--
 arch/arm/mach-mmp/pxa910.c                       |    3 +--
 arch/arm/mach-mmp/tavorevb.c                     |    3 +--
 arch/arm/mach-msm/board-msm7x27.c                |    3 +--
 arch/arm/mach-msm/board-msm7x30.c                |    3 +--
 arch/arm/mach-msm/board-qsd8x50.c                |    3 +--
 arch/arm/mach-msm/board-sapphire.c               |    3 +--
 arch/arm/mach-msm/board-trout-mmc.c              |    3 +--
 arch/arm/mach-msm/board-trout-panel.c            |    3 +--
 arch/arm/mach-mv78xx0/irq.c                      |    3 +--
 arch/arm/mach-mv78xx0/mpp.c                      |    3 +--
 arch/arm/mach-omap1/board-ams-delta.c            |    3 +--
 arch/arm/mach-omap1/board-fsample.c              |    3 +--
 arch/arm/mach-omap1/board-generic.c              |    3 +--
 arch/arm/mach-omap1/board-h2-mmc.c               |    3 +--
 arch/arm/mach-omap1/board-h2.c                   |    3 +--
 arch/arm/mach-omap1/board-h3-mmc.c               |    3 +--
 arch/arm/mach-omap1/board-h3.c                   |    3 +--
 arch/arm/mach-omap1/board-htcherald.c            |    1 -
 arch/arm/mach-omap1/board-innovator.c            |    3 +--
 arch/arm/mach-omap1/board-nokia770.c             |    3 +--
 arch/arm/mach-omap1/board-osk.c                  |    3 +--
 arch/arm/mach-omap1/board-palmte.c               |    3 +--
 arch/arm/mach-omap1/board-palmtt.c               |    2 +-
 arch/arm/mach-omap1/board-palmz71.c              |    2 +-
 arch/arm/mach-omap1/board-perseus2.c             |    3 +--
 arch/arm/mach-omap1/board-sx1-mmc.c              |    2 +-
 arch/arm/mach-omap1/board-sx1.c                  |    3 +--
 arch/arm/mach-omap1/board-voiceblue.c            |    2 +-
 arch/arm/mach-omap1/devices.c                    |    2 +-
 arch/arm/mach-omap1/fpga.c                       |    2 +-
 arch/arm/mach-omap1/irq.c                        |    3 +--
 arch/arm/mach-omap1/leds-h2p2-debug.c            |    2 +-
 arch/arm/mach-omap1/leds-osk.c                   |    3 +--
 arch/arm/mach-omap1/leds.c                       |    2 +-
 arch/arm/mach-omap1/serial.c                     |    3 +--
 arch/arm/mach-omap2/board-generic.c              |    3 +--
 arch/arm/mach-omap2/board-h4.c                   |    3 +--
 arch/arm/mach-omap2/board-ldp.c                  |    3 +--
 arch/arm/mach-omap2/devices.c                    |    3 +--
 arch/arm/mach-orion5x/db88f5281-setup.c          |    3 +--
 arch/arm/mach-orion5x/dns323-setup.c             |    3 +--
 arch/arm/mach-orion5x/irq.c                      |    3 +--
 arch/arm/mach-orion5x/kurobox_pro-setup.c        |    3 +--
 arch/arm/mach-orion5x/mv2120-setup.c             |    3 +--
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c     |    3 +--
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c      |    3 +--
 arch/arm/mach-orion5x/rd88f5182-setup.c          |    3 +--
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c     |    3 +--
 arch/arm/mach-orion5x/terastation_pro2-setup.c   |    3 +--
 arch/arm/mach-orion5x/ts209-setup.c              |    3 +--
 arch/arm/mach-orion5x/ts409-setup.c              |    3 +--
 arch/arm/mach-orion5x/wnr854t-setup.c            |    3 +--
 arch/arm/mach-orion5x/wrt350n-v2-setup.c         |    3 +--
 arch/arm/mach-pnx4008/gpio.c                     |    3 +--
 arch/arm/mach-pnx4008/serial.c                   |    3 +--
 arch/arm/mach-pxa/generic.c                      |    2 +-
 arch/arm/mach-pxa/include/mach/littleton.h       |    2 +-
 arch/arm/mach-pxa/irq.c                          |    3 +--
 arch/arm/mach-pxa/lpd270.c                       |    3 +--
 arch/arm/mach-pxa/lubbock.c                      |    2 +-
 arch/arm/mach-pxa/mainstone.c                    |    3 +--
 arch/arm/mach-pxa/mfp-pxa2xx.c                   |    3 +--
 arch/arm/mach-pxa/pcm990-baseboard.c             |    3 +--
 arch/arm/mach-pxa/pxa25x.c                       |    2 +-
 arch/arm/mach-pxa/pxa27x.c                       |    2 +-
 arch/arm/mach-pxa/pxa3xx.c                       |    3 +--
 arch/arm/mach-pxa/pxa95x.c                       |    3 +--
 arch/arm/mach-pxa/saarb.c                        |    3 +--
 arch/arm/mach-s3c2410/include/mach/h1940-latch.h |    2 +-
 arch/arm/mach-sa1100/generic.c                   |    2 +-
 arch/arm/mach-sa1100/gpio.c                      |    3 +--
 arch/arm/mach-tegra/board-trimslice-pinmux.c     |    3 +--
 arch/arm/mach-ux500/board-mop500-u8500uib.c      |    3 +--
 arch/arm/plat-omap/debug-devices.c               |    3 +--
 arch/arm/plat-omap/debug-leds.c                  |    3 +--
 arch/arm/plat-omap/devices.c                     |    3 +--
 arch/arm/plat-pxa/gpio.c                         |    4 +---
 138 files changed, 137 insertions(+), 222 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index a07b0e7..1cde34a 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -12,11 +12,11 @@
  */
 
 #include <linux/device.h>
+#include <linux/gpio.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <asm/gpio.h>
 #include <asm/hardware/scoop.h>
 
 /* PCMCIA to Scoop linkage
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index dba0d8d..f87f504 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -16,6 +16,7 @@
 #include <asm/mach/irq.h>
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
@@ -23,7 +24,6 @@
 
 #include <mach/board.h>
 #include <mach/cpu.h>
-#include <mach/gpio.h>
 #include <mach/at91cap9.h>
 #include <mach/at91cap9_matrix.h>
 #include <mach/at91sam9_smc.h>
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 7227755..978be95 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -14,11 +14,11 @@
 #include <asm/mach/map.h>
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91rm9200.h>
 #include <mach/at91rm9200_mc.h>
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 39f81f4..a53b3de 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -13,11 +13,11 @@
 #include <asm/mach/map.h>
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9260.h>
 #include <mach/at91sam9260_matrix.h>
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 0f91792..4e647b6 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -14,6 +14,7 @@
 #include <asm/mach/map.h>
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
@@ -21,7 +22,6 @@
 #include <video/atmel_lcdc.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9261.h>
 #include <mach/at91sam9261_matrix.h>
 #include <mach/at91sam9_smc.h>
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index a050f41..dd7662b 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -13,6 +13,7 @@
 #include <asm/mach/map.h>
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
@@ -20,7 +21,6 @@
 #include <video/atmel_lcdc.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9263.h>
 #include <mach/at91sam9263_matrix.h>
 #include <mach/at91sam9_smc.h>
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 600bffb..c3dfb1b 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -13,6 +13,7 @@
 #include <asm/mach/map.h>
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 #include <linux/atmel-mci.h>
@@ -21,7 +22,6 @@
 #include <video/atmel_lcdc.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9g45.h>
 #include <mach/at91sam9g45_matrix.h>
 #include <mach/at91sam9_smc.h>
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index aacb19d..305a851 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -10,6 +10,7 @@
 #include <asm/mach/map.h>
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
@@ -17,7 +18,6 @@
 #include <video/atmel_lcdc.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9rl.h>
 #include <mach/at91sam9rl_matrix.h>
 #include <mach/at91sam9_smc.h>
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 5aa5885..367d5cd 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -34,7 +35,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/cpu.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index b0c796d..0487ea1 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -43,7 +44,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index d1abd58..747b2ea 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -38,7 +39,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 679b0b7..0626703 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -41,7 +42,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91cap9_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/system_rev.h>
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index c578c5d..774c87f 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -35,7 +36,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index f4da8a1..fc885a4 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -40,7 +41,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91sam9260_matrix.h>
 
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2d919f5..d35e65b 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -36,7 +37,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/cpu.h>
 
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 17654d5..c393666 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -38,7 +39,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 72b5567..586100e 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -20,6 +20,7 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/gpio.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -35,7 +36,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 01170a2..45db7a3 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -35,7 +36,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 7c0313c..2f9c16d2 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -37,7 +38,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/cpu.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 4a17089..3bae73e 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -34,7 +35,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/cpu.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 9dc8d49..15a3f1a 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -35,7 +36,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/cpu.h>
 #include <mach/at91rm9200_mc.h>
 
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 9bc6ab3..6094496 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -44,7 +45,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index b7b8390..0a8fe6a 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -37,7 +38,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91rm9200_mc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 81f9110..938cc39 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -40,7 +41,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 6f08faa..b4ac30e 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -39,7 +40,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91rm9200_mc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 85bcccd..99fd7f8 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -39,7 +40,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91rm9200_mc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 4d3a02f..2a21e79 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -37,7 +38,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 8a50c3e..89c8b57 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -41,7 +42,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 5096a0e..3741f43 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -45,7 +46,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index ea8f185..a580dd4 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -44,7 +45,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 817f59d..8d77c2f 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -41,7 +42,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/system_rev.h>
 
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ad234cc..2d6203a 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -38,7 +39,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 #include <mach/system_rev.h>
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 4f14b54..39a28ef 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -30,7 +31,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 8c4c1a0..bac9b65 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -40,7 +41,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index 25e7937..5bd7357 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -39,7 +40,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 95edcbd..3c288b3 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -43,7 +44,6 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/cpu.h>
 
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 2225042..224e9e2 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/debugfs.h>
@@ -23,8 +24,6 @@
 #include <mach/hardware.h>
 #include <mach/at91_pio.h>
 
-#include <asm/gpio.h>
-
 #include "generic.h"
 
 struct at91_gpio_chip {
diff --git a/arch/arm/mach-at91/leds.c b/arch/arm/mach-at91/leds.c
index 0415a839..8dfafe7 100644
--- a/arch/arm/mach-at91/leds.c
+++ b/arch/arm/mach-at91/leds.c
@@ -9,13 +9,13 @@
  * 2 of the License, or (at your option) any later version.
 */
 
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
 
 
 /* ------------------------------------------------------------------------- */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 4159eca..7046158 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -10,6 +10,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/gpio.h>
 #include <linux/suspend.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
@@ -25,7 +26,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/at91_pmc.h>
-#include <mach/gpio.h>
 #include <mach/cpu.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2ed2f82..358ed0d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -8,6 +8,7 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 
@@ -19,7 +20,6 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
-#include <mach/gpio.h>
 
 #include "clock.h"
 #include "mux.h"
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 935dbed..71a4aa2 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -11,6 +11,7 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
@@ -27,7 +28,6 @@
 #include <mach/da8xx.h>
 #include <mach/cpufreq.h>
 #include <mach/pm.h>
-#include <mach/gpio.h>
 
 #include "clock.h"
 #include "mux.h"
diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index cafbe13..a8066e8 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -9,15 +9,13 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-
+#include <linux/gpio.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <mach/gpio.h>
-
 #include <asm/mach/irq.h>
 
 struct davinci_gpio_regs {
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 1b28fdd..c92641a 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -12,6 +12,7 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
@@ -27,7 +28,6 @@
 #include <mach/psc.h>
 #include <mach/cp_intc.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 #include <mach/hardware.h>
 #include <mach/tnetv107x.h>
 
diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
index cf8f809..82bd440 100644
--- a/arch/arm/mach-imx/iomux-imx31.c
+++ b/arch/arm/mach-imx/iomux-imx31.c
@@ -17,13 +17,12 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  * MA 02110-1301, USA.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/iomux-mx3.h>
 
 /*
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index fc26ed7..e1addc1 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -13,7 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
@@ -27,7 +27,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/gpio.h>
 #include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
index 4068166..e95c5e7 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -13,7 +13,7 @@
  * License version 2. This program is licensed "as is" without any 
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
@@ -39,8 +39,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
-#include <mach/gpio.h>
-
 static DEFINE_SPINLOCK(ixp2000_slowport_lock);
 static unsigned long ixp2000_slowport_irq_flags;
 
diff --git a/arch/arm/mach-ixp2000/ixdp2x00.c b/arch/arm/mach-ixp2000/ixdp2x00.c
index 235638f..f615068 100644
--- a/arch/arm/mach-ixp2000/ixdp2x00.c
+++ b/arch/arm/mach-ixp2000/ixdp2x00.c
@@ -14,6 +14,7 @@
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
  */
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -40,8 +41,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/arch.h>
 
-#include <mach/gpio.h>
-
 
 /*************************************************************************
  * IXDP2x00 IRQ Initialization
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 03e5451..96e3783 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -16,7 +16,7 @@
  * Author: Rod Whitby <rod@whitby.id.au>
  * Maintainers: http://www.nslu2-linux.org/
  */
-
+#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/jiffies.h>
 #include <linux/timer.h>
@@ -31,7 +31,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/time.h>
-#include <asm/gpio.h>
 
 #define DSMG600_SDA_PIN		5
 #define DSMG600_SCL_PIN		4
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 23a8b36..72333a0 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -14,7 +14,7 @@
  * Maintainers: http://www.nslu2-linux.org/
  *
  */
-
+#include <linux/gpio.h>
 #include <linux/if_ether.h>
 #include <linux/irq.h>
 #include <linux/serial.h>
@@ -27,7 +27,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-#include <asm/gpio.h>
 
 #define FSG_SDA_PIN		12
 #define FSG_SCL_PIN		13
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index afb5187..b752fa4 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -17,7 +17,7 @@
  * Maintainers: http://www.nslu2-linux.org/
  *
  */
-
+#include <linux/gpio.h>
 #include <linux/if_ether.h>
 #include <linux/irq.h>
 #include <linux/jiffies.h>
@@ -32,7 +32,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-#include <asm/gpio.h>
 
 #define NAS100D_SDA_PIN		5
 #define NAS100D_SCL_PIN		6
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 69e40f2..0411a0a 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -16,7 +16,7 @@
  * Maintainers: http://www.nslu2-linux.org/
  *
  */
-
+#include <linux/gpio.h>
 #include <linux/if_ether.h>
 #include <linux/irq.h>
 #include <linux/serial.h>
@@ -30,7 +30,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/time.h>
-#include <asm/gpio.h>
 
 #define NSLU2_SDA_PIN		7
 #define NSLU2_SCL_PIN		6
diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
index 05d193a..c4c68e5 100644
--- a/arch/arm/mach-kirkwood/irq.c
+++ b/arch/arm/mach-kirkwood/irq.c
@@ -7,14 +7,13 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
-#include <asm/gpio.h>
 #include "common.h"
 
 static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index b0a7d97..cc431fa 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -7,12 +7,11 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
-#include <asm/gpio.h>
 #include <mach/hardware.h>
 #include <plat/mpp.h>
 #include "common.h"
diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index 3ca4f8e..dee45cb 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -34,7 +34,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/devices.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-ks8695/board-dsm320.c b/arch/arm/mach-ks8695/board-dsm320.c
index 1338cb3..e3ccf1a 100644
--- a/arch/arm/mach-ks8695/board-dsm320.c
+++ b/arch/arm/mach-ks8695/board-dsm320.c
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -29,7 +29,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/devices.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-ks8695/board-micrel.c b/arch/arm/mach-ks8695/board-micrel.c
index e2e3cba..e887778 100644
--- a/arch/arm/mach-ks8695/board-micrel.c
+++ b/arch/arm/mach-ks8695/board-micrel.c
@@ -5,7 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -18,7 +18,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/gpio.h>
 #include <mach/devices.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-ks8695/gpio.c b/arch/arm/mach-ks8695/gpio.c
index 31e4565..b3fdfe1 100644
--- a/arch/arm/mach-ks8695/gpio.c
+++ b/arch/arm/mach-ks8695/gpio.c
@@ -18,7 +18,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -31,7 +31,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/regs-gpio.h>
-#include <mach/gpio.h>
 
 /*
  * Configure a GPIO line for either GPIO function, or its internal
diff --git a/arch/arm/mach-ks8695/leds.c b/arch/arm/mach-ks8695/leds.c
index 184ef74..4bd7075 100644
--- a/arch/arm/mach-ks8695/leds.c
+++ b/arch/arm/mach-ks8695/leds.c
@@ -7,14 +7,13 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
 #include <asm/leds.h>
 #include <mach/devices.h>
-#include <mach/gpio.h>
 
 
 static inline void ks8695_led_on(unsigned int led)
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5fa8..cf87518 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -8,7 +8,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  publishhed by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -23,7 +23,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
-#include <mach/gpio.h>
 #include <video/pxa168fb.h>
 #include <linux/input.h>
 #include <plat/pxa27x_keypad.h>
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 079c188..1935834 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -9,7 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -25,7 +25,6 @@
 #include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
-#include <mach/gpio.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
 
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 0156f53..9581551 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -21,7 +21,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 #include <mach/dma.h>
 #include <mach/devices.h>
 #include <mach/mfp.h>
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 1464607..c70b4dd 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,7 +20,6 @@
 #include <mach/regs-apmu.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index c296b75..143e52e 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -7,7 +7,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  publishhed by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -18,7 +18,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
-#include <mach/gpio.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-msm/board-msm7x27.c b/arch/arm/mach-msm/board-msm7x27.c
index c03f269..1a313e1 100644
--- a/arch/arm/mach-msm/board-msm7x27.c
+++ b/arch/arm/mach-msm/board-msm7x27.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  *
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -34,7 +34,6 @@
 
 #include <mach/vreg.h>
 #include <mach/mpp.h>
-#include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index b7a8496..92afaf6 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -14,7 +14,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
@@ -30,7 +30,6 @@
 #include <asm/memory.h>
 #include <asm/setup.h>
 
-#include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 #include <mach/dma.h>
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 6a96911..24e9b89 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -14,7 +14,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
@@ -32,7 +32,6 @@
 #include <mach/board.h>
 #include <mach/irqs.h>
 #include <mach/sirc.h>
-#include <mach/gpio.h>
 #include <mach/vreg.h>
 #include <mach/mmc.h>
 
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index 68f930f..863394c 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -11,7 +11,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
 */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -22,7 +22,6 @@
 
 #include <linux/delay.h>
 
-#include <asm/gpio.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-msm/board-trout-mmc.c b/arch/arm/mach-msm/board-trout-mmc.c
index f7a9724..8650342 100644
--- a/arch/arm/mach-msm/board-trout-mmc.c
+++ b/arch/arm/mach-msm/board-trout-mmc.c
@@ -1,7 +1,7 @@
 /* linux/arch/arm/mach-msm/board-trout-mmc.c
 ** Author: Brian Swetland <swetland@google.com>
 */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -11,7 +11,6 @@
 #include <linux/err.h>
 #include <linux/debugfs.h>
 
-#include <asm/gpio.h>
 #include <asm/io.h>
 
 #include <mach/vreg.h>
diff --git a/arch/arm/mach-msm/board-trout-panel.c b/arch/arm/mach-msm/board-trout-panel.c
index 729bb49..25105c1 100644
--- a/arch/arm/mach-msm/board-trout-panel.c
+++ b/arch/arm/mach-msm/board-trout-panel.c
@@ -1,7 +1,7 @@
 /* linux/arch/arm/mach-msm/board-trout-mddi.c
 ** Author: Brian Swetland <swetland@google.com>
 */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -11,7 +11,6 @@
 #include <linux/err.h>
 
 #include <asm/io.h>
-#include <asm/gpio.h>
 #include <asm/mach-types.h>
 
 #include <mach/msm_fb.h>
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index 3e24431..e421b70 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -7,12 +7,11 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
-#include <asm/gpio.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
 #include "common.h"
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 59b7686..cf4e494 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -7,13 +7,12 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <plat/mpp.h>
-#include <asm/gpio.h>
 #include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 312ea6b..d86e9af 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -11,7 +11,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -30,7 +30,6 @@
 
 #include <plat/io.h>
 #include <plat/board-ams-delta.h>
-#include <mach/gpio.h>
 #include <plat/keypad.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index a6b1bea..dd814b3 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -28,7 +28,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
-#include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/flash.h>
 #include <plat/fpga.h>
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 04fc356..8f7d115 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -12,7 +12,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -22,7 +22,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index f2fc43d..da0e37d 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -11,13 +11,12 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 
 #include <linux/i2c/tps65010.h>
 
 #include <plat/mmc.h>
-#include <mach/gpio.h>
 
 #include "board-h2.h"
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index cb7fb1a..0796ad7 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -18,7 +18,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
@@ -32,7 +32,6 @@
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
-#include <asm/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 2098525..f8242aa 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -11,13 +11,12 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 
 #include <linux/i2c/tps65010.h>
 
 #include <plat/mmc.h>
-#include <mach/gpio.h>
 
 #include "board-h3.h"
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 31f3487..fe1814c 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -13,7 +13,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/major.h>
@@ -34,7 +34,6 @@
 #include <asm/setup.h>
 #include <asm/page.h>
 #include <mach/hardware.h>
-#include <asm/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 36e06ea..4af7bfa 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -23,7 +23,6 @@
  * 02110-1301, USA.
  *
  */
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 0b1ba46..e603e5e 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -15,7 +15,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -34,7 +34,6 @@
 #include <plat/mux.h>
 #include <plat/flash.h>
 #include <plat/fpga.h>
-#include <mach/gpio.h>
 #include <plat/tc.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 5469ce2..8420535 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
@@ -26,7 +26,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index b08a213..bf1ebe5 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -25,7 +25,7 @@
  * with this program; if not, write  to the Free Software Foundation, Inc.,
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -42,7 +42,6 @@
 #include <linux/i2c/tps65010.h>
 
 #include <mach/hardware.h>
-#include <asm/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 459cb6b..45596b5 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -16,7 +16,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -33,7 +33,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index b214f45..f942221 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -30,7 +31,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/led.h>
-#include <mach/gpio.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 9b0ea48..2b912d4 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -32,7 +33,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 67acd41..7e2efe5 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -28,7 +28,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
-#include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
 #include <plat/flash.h>
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index e8ddd86..b59f788 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -12,11 +12,11 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <plat/mmc.h>
-#include <mach/gpio.h>
 #include <plat/board-sx1.h>
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 9c3b7c5..172a28f 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -14,7 +14,7 @@
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -32,7 +32,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 036edc0e..236b7de 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -33,7 +34,6 @@
 
 #include <plat/board-voiceblue.h>
 #include <plat/common.h>
-#include <mach/gpio.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 36f26c3..7c50ecf 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -24,7 +25,6 @@
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mux.h>
-#include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/omap7xx.h>
 #include <plat/mcbsp.h>
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index cddbf8b..0a17a1a 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -28,7 +29,6 @@
 #include <asm/mach/irq.h>
 
 #include <plat/fpga.h>
-#include <mach/gpio.h>
 
 static void fpga_mask_irq(struct irq_data *d)
 {
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index e2b9c90..e5b104b 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -35,7 +35,7 @@
  * with this program; if not, write  to the Free Software Foundation, Inc.,
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -45,7 +45,6 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
-#include <mach/gpio.h>
 #include <plat/cpu.h>
 
 #define IRQ_BANK(irq) ((irq) >> 5)
diff --git a/arch/arm/mach-omap1/leds-h2p2-debug.c b/arch/arm/mach-omap1/leds-h2p2-debug.c
index b4f9be5..4b818eb 100644
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -9,6 +9,7 @@
  * The "surfer" expansion board and H2 sample board also have two-color
  * green+red LEDs (in parallel), used here for timer and idle indicators.
  */
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
@@ -20,7 +21,6 @@
 #include <asm/mach-types.h>
 
 #include <plat/fpga.h>
-#include <mach/gpio.h>
 
 #include "leds.h"
 
diff --git a/arch/arm/mach-omap1/leds-osk.c b/arch/arm/mach-omap1/leds-osk.c
index 499d7ad..da09f43 100644
--- a/arch/arm/mach-omap1/leds-osk.c
+++ b/arch/arm/mach-omap1/leds-osk.c
@@ -3,14 +3,13 @@
  *
  * LED driver for OSK with optional Mistral QVGA board
  */
+#include <linux/gpio.h>
 #include <linux/init.h>
 
 #include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/system.h>
 
-#include <mach/gpio.h>
-
 #include "leds.h"
 
 
diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
index 22eb11d..ae6dd93 100644
--- a/arch/arm/mach-omap1/leds.c
+++ b/arch/arm/mach-omap1/leds.c
@@ -3,13 +3,13 @@
  *
  * OMAP LEDs dispatcher
  */
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 
-#include <mach/gpio.h>
 #include <plat/mux.h>
 
 #include "leds.h"
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 550ca9d..93ae8f2 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -24,7 +24,6 @@
 
 #include <plat/board.h>
 #include <plat/mux.h>
-#include <mach/gpio.h>
 #include <plat/fpga.h>
 
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 54db41a..bb4af05 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,7 +15,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -25,7 +25,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 45de2b3..95319e7 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -31,7 +31,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpio.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 218764c..ddff45c 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -34,7 +34,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/mcspi.h>
-#include <mach/gpio.h>
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 1077ad6..5391079 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -8,7 +8,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -26,7 +26,6 @@
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mcbsp.h>
-#include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index a3e3e9e..6d771cb 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -9,7 +9,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -21,7 +21,6 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index a6eddae..64e68fa 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -13,7 +13,7 @@
  * License, or (at your option) any later version.
  *
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -30,7 +30,6 @@
 #include <linux/phy.h>
 #include <linux/marvell_phy.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 43cf8bc..b1b45ff 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -9,12 +9,11 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <asm/gpio.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
 #include "common.h"
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 0038124..f88f54b 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -7,7 +7,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -21,7 +21,6 @@
 #include <linux/serial_reg.h>
 #include <linux/ata_platform.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 63ff10c..525eb12 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -7,7 +7,7 @@
  * published by the Free Software Foundation; either version 2 of the
  * License, or (at your option) any later version.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -20,7 +20,6 @@
 #include <linux/i2c.h>
 #include <linux/ata_platform.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <mach/orion5x.h>
 #include "common.h"
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 291d22b..50aae6f 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -7,7 +7,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -18,7 +18,6 @@
 #include <linux/ethtool.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 3f02362..35f106a 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -7,7 +7,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -19,7 +19,6 @@
 #include <linux/i2c.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 27fd38e..9bb2b8b 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -9,7 +9,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -20,7 +20,6 @@
 #include <linux/ata_platform.h>
 #include <linux/i2c.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index ad2eba9..1d00df9 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -7,7 +7,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -21,7 +21,6 @@
 #include <linux/ethtool.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/leds.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index a34e4fa..c9dd31d 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -8,7 +8,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -20,7 +20,6 @@
 #include <linux/i2c.h>
 #include <linux/serial_reg.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index c983161..764307b 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -8,7 +8,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -23,7 +23,6 @@
 #include <linux/serial_reg.h>
 #include <linux/ata_platform.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index cc33b22..0572dd1 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -11,7 +11,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -25,7 +25,6 @@
 #include <linux/i2c.h>
 #include <linux/serial_reg.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 2653595..cdad50b 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -5,7 +5,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -17,7 +17,6 @@
 #include <linux/ethtool.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 251ef15..8f10ffd 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -5,7 +5,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -20,7 +20,6 @@
 #include <linux/input.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
-#include <asm/gpio.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-pnx4008/gpio.c b/arch/arm/mach-pnx4008/gpio.c
index f219914..eef531b 100644
--- a/arch/arm/mach-pnx4008/gpio.c
+++ b/arch/arm/mach-pnx4008/gpio.c
@@ -13,14 +13,13 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-
+#include <linux/gpio.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <mach/gpio.h>
 
 /* register definitions */
 #define PIO_VA_BASE	IO_ADDRESS(PNX4008_PIO_BASE)
diff --git a/arch/arm/mach-pnx4008/serial.c b/arch/arm/mach-pnx4008/serial.c
index f40961e..eb29fac 100644
--- a/arch/arm/mach-pnx4008/serial.c
+++ b/arch/arm/mach-pnx4008/serial.c
@@ -9,7 +9,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/io.h>
@@ -19,7 +19,6 @@
 
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
-#include <mach/gpio.h>
 
 #include <mach/clock.h>
 
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index f5d91ef..5432ecb 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -16,6 +16,7 @@
  * initialization stuff for PXA machines which can be overridden later if
  * need be.
  */
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -26,7 +27,6 @@
 #include <asm/mach-types.h>
 
 #include <mach/reset.h>
-#include <mach/gpio.h>
 #include <mach/smemc.h>
 #include <mach/pxa3xx-regs.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/littleton.h b/arch/arm/mach-pxa/include/mach/littleton.h
index 2a5726c..1c585a7 100644
--- a/arch/arm/mach-pxa/include/mach/littleton.h
+++ b/arch/arm/mach-pxa/include/mach/littleton.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_ARCH_LITTLETON_H
 #define __ASM_ARCH_LITTLETON_H
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 #define LITTLETON_ETH_PHYS	0x30000000
 
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index b09e848..dafb4bf 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -11,7 +11,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -21,7 +21,6 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index c171d6e..a3acd96 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -12,7 +12,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
@@ -39,7 +39,6 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa27x.h>
-#include <mach/gpio.h>
 #include <mach/lpd270.h>
 #include <mach/audio.h>
 #include <mach/pxafb.h>
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index a8c696b..c48ce6d 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -11,6 +11,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -42,7 +43,6 @@
 #include <asm/hardware/sa1111.h>
 
 #include <mach/pxa25x.h>
-#include <mach/gpio.h>
 #include <mach/audio.h>
 #include <mach/lubbock.h>
 #include <mach/udc.h>
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 4622eb7..6bc784b 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -12,7 +12,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
@@ -43,7 +43,6 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa27x.h>
-#include <mach/gpio.h>
 #include <mach/mainstone.h>
 #include <mach/audio.h>
 #include <mach/pxafb.h>
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index b27544b..b129527 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -12,13 +12,12 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/syscore_ops.h>
 
-#include <mach/gpio.h>
 #include <mach/pxa2xx-regs.h>
 #include <mach/mfp-pxa2xx.h>
 
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 6d5b7e0..9a9c539 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -19,7 +19,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
@@ -28,7 +28,6 @@
 
 #include <media/soc_camera.h>
 
-#include <asm/gpio.h>
 #include <mach/camera.h>
 #include <asm/mach/map.h>
 #include <mach/pxa27x.h>
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 9c434d2..6bb3fa5 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -16,6 +16,7 @@
  * initialization stuff for PXA machines which can be overridden later if
  * need be.
  */
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -28,7 +29,6 @@
 #include <asm/suspend.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 #include <mach/pxa25x.h>
 #include <mach/reset.h>
 #include <mach/pm.h>
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 9d2400b..d2cdcd6 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -11,6 +11,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -26,7 +27,6 @@
 #include <asm/irq.h>
 #include <asm/suspend.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 #include <mach/pxa27x.h>
 #include <mach/reset.h>
 #include <mach/ohci.h>
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index b5cd9e5..3ab9e84 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -12,7 +12,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/reset.h>
 #include <mach/ohci.h>
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 0ee166b..de25ceb 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -9,7 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -21,7 +21,6 @@
 #include <linux/syscore_ops.h>
 
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/pxa930.h>
 #include <mach/reset.h>
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index ebd6379..87e9b75 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -9,7 +9,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  publishhed by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
@@ -23,7 +23,6 @@
 #include <mach/hardware.h>
 #include <mach/mfp.h>
 #include <mach/mfp-pxa930.h>
-#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
index 97e42bf..fc897d3 100644
--- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
+++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
@@ -14,7 +14,7 @@
 #ifndef __ASM_ARCH_H1940_LATCH_H
 #define __ASM_ARCH_H1940_LATCH_H
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 #define H1940_LATCH_GPIO(x)		(S3C_GPIO_END + (x))
 
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index e21f347..5fa5ae1 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -24,7 +25,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 #include <asm/irq.h>
-#include <asm/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-sa1100/gpio.c b/arch/arm/mach-sa1100/gpio.c
index 0d3829a..e547ed4 100644
--- a/arch/arm/mach-sa1100/gpio.c
+++ b/arch/arm/mach-sa1100/gpio.c
@@ -7,11 +7,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
 
-#include <asm/gpio.h>
 #include <mach/hardware.h>
 #include "generic.h"
 
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index 47c596c..bcb1916 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -13,12 +13,11 @@
  * GNU General Public License for more details.
  *
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 
 #include <mach/pinmux.h>
-#include <mach/gpio.h>
 
 #include "gpio-names.h"
 #include "board-trimslice.h"
diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
index 8ce46c0..feb5744 100644
--- a/arch/arm/mach-ux500/board-mop500-u8500uib.c
+++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
@@ -4,7 +4,7 @@
  * Board data for the U8500 UIB, also known as the New UIB
  * License terms: GNU General Public License (GPL), version 2
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
@@ -13,7 +13,6 @@
 #include <linux/mfd/tc3589x.h>
 #include <linux/input/matrix_keypad.h>
 
-#include <mach/gpio.h>
 #include <mach/irqs.h>
 
 #include "board-mop500.h"
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index 923c962..caa1f7b 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -18,7 +18,6 @@
 #include <mach/hardware.h>
 
 #include <plat/board.h>
-#include <mach/gpio.h>
 
 
 /* Many OMAP development platforms reuse the same "debug board"; these
diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index fc05b10..61a1ec2 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
@@ -19,7 +19,6 @@
 #include <asm/mach-types.h>
 
 #include <plat/fpga.h>
-#include <mach/gpio.h>
 
 
 /* Many OMAP development platforms reuse the same "debug board"; these
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ea28f98..64c3bd4 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -8,7 +8,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -24,7 +24,6 @@
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mmc.h>
-#include <mach/gpio.h>
 #include <plat/menelaus.h>
 #include <plat/mcbsp.h>
 #include <plat/omap44xx.h>
diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index a11dc36..5d6a86b 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -11,15 +11,13 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
-#include <mach/gpio.h>
-
 int pxa_last_gpio;
 
 struct pxa_gpio_chip {
-- 
1.7.4.4

