From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] [PATCH v2] OMAP: DMA: Fix omapfb/lcdc on Amstrad Delta broken when PM set
Date: Tue, 3 Nov 2009 20:24:38 +0100
Message-ID: <200911032024.47741.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754280AbZKCT0W@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With CONFIG_PM=y, the omapfb/lcdc device on Amstrad Delta, after initially
starting correctly, breaks with the following error messages:

omapfb omapfb: resetting (status 0xffffff96,reset count 1)
...
omapfb omapfb: resetting (status 0xffffff96,reset count 100)
omapfb omapfb: too many reset attempts, giving up.

Looking closer at this I have found that it had been broken almost 2 years ago
with commit 2418996e3b100114edb2ae110d5d4acb928909d2, PM fixes for OMAP1.

The definite reason for broken omapfb/lcdc behavoiur in PM mode
appeared to be ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle regardless of LCD
DMA possibly running. The bit were set based on return value of the
omap_dma_running() function that did not check for dedicated LCD DMA
channel status. The patch below fixes this.

Created and tested against linux-2.6.32-rc5

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Hi,
If there are still no comments, especially on the bug possible impact on other 
OMAP1510 boards (or even OMAP1610 with internal LCD controller), then Tony, 
please apply it as is. Until it is accepted, I am stuck with new 
ams_delta_defconfig.

Thanks,
Janusz

--- linux-2.6.32-rc5/arch/arm/plat-omap/dma.c.orig	2009-10-16 02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/arch/arm/plat-omap/dma.c	2009-11-03 20:15:35.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <asm/mach-types.h>
 #include <asm/system.h>
 #include <mach/hardware.h>
 #include <mach/dma.h>
@@ -1110,6 +1111,14 @@ int omap_dma_running(void)
 {
 	int lch;
 
+	/*
+	 * On Amstrad Delta, the OMAP internal LCD controller will start the
+	 * transfer when it gets enabled, so assume DMA running if LCD enabled.
+	 */
+	if (machine_is_ams_delta())
+		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
+			return 1;
+
 	/* Check if LCD DMA is running */
 	if (cpu_is_omap16xx())
 		if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
