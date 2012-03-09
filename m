From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: Remove CONFIG_OMAP_MCBSP references
Date: Fri,  9 Mar 2012 10:51:17 +0200
Message-ID: <1331283078-14846-2-git-send-email-peter.ujfalusi@ti.com>
References: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59129 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753730Ab2CIIvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 03:51:33 -0500
Received: by lahm13 with SMTP id m13so1809466lah.23
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 00:51:31 -0800 (PST)
In-Reply-To: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

The McBSP driver stack has been moved to ASoC. The CONFIG_OMAP_MCBSP will
be removed since the CONFIG_SND_OMAP_SOC_MCBSP will trigger to build the
McBSP (audio) drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap1/Kconfig  |    3 ---
 arch/arm/mach-omap1/Makefile |    4 +++-
 arch/arm/mach-omap2/Makefile |    4 +++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 4f8d66f..922ab0d 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -37,7 +37,6 @@ comment "OMAP Board Type"
 config MACH_OMAP_INNOVATOR
 	bool "TI Innovator"
 	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
-	select OMAP_MCBSP
 	help
           TI OMAP 1510 or 1610 Innovator board support. Say Y here if you
           have such a board.
@@ -45,7 +44,6 @@ config MACH_OMAP_INNOVATOR
 config MACH_OMAP_H2
 	bool "TI H2 Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
-	select OMAP_MCBSP
     	help
 	  TI OMAP 1610/1611B H2 board support. Say Y here if you have such
 	  a board.
@@ -72,7 +70,6 @@ config MACH_HERALD
 config MACH_OMAP_OSK
 	bool "TI OSK Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
-	select OMAP_MCBSP
     	help
 	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
           if you have such a board.
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 11c85cd..9923f92 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -6,7 +6,9 @@
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
 obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
 
-obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
+obj-y += mcbsp.o
+endif
 
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bd76394..06326a6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -17,7 +17,9 @@ obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
 
-obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
+obj-y += mcbsp.o
+endif
 
 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
-- 
1.7.8.5

