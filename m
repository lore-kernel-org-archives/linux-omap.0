From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 02/11] OMAP: mcbsp: Move core driver under sound/soc/omap
Date: Wed, 15 Feb 2012 17:37:51 +0200
Message-ID: <1329320280-1621-3-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46425 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179Ab2BOPiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:07 -0500
Received: by mail-bk0-f52.google.com with SMTP id ji1so1706853bkc.39
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:38:03 -0800 (PST)
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

In order to consolidate the McBSP driver move it out from
arch/arm/plat-omap directory under sound/soc/omap/

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/Kconfig                     |    8 --------
 arch/arm/plat-omap/Makefile                    |    2 --
 sound/soc/omap/Kconfig                         |    4 ++++
 sound/soc/omap/Makefile                        |    1 +
 {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c |    4 +++-
 5 files changed, 8 insertions(+), 11 deletions(-)
 rename {arch/arm/plat-omap => sound/soc/omap}/mcbsp.c (99%)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index aa59f42..8f81503 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -110,14 +110,6 @@ config OMAP_MUX_WARNINGS
 	  to change the pin multiplexing setup.	 When there are no warnings
 	  printed, it's safe to deselect OMAP_MUX for your product.
 
-config OMAP_MCBSP
-	bool "McBSP support"
-	depends on ARCH_OMAP
-	default y
-	help
-	  Say Y here if you want support for the OMAP Multichannel
-	  Buffered Serial Port.
-
 config OMAP_MBOX_FWK
 	tristate "Mailbox framework support"
 	depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 9a58461..c0fe275 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -17,8 +17,6 @@ obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
 
-obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
-
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 47b23fe..27a3a29 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -5,6 +5,10 @@ config SND_OMAP_SOC
 config SND_OMAP_SOC_DMIC
 	tristate
 
+config OMAP_MCBSP
+	tristate
+	depends on ARCH_OMAP
+
 config SND_OMAP_SOC_MCBSP
 	tristate
 	select OMAP_MCBSP
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 123ac18..9f8fbd5 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,6 +7,7 @@ snd-soc-omap-hdmi-objs := omap-hdmi.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
 obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
+obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
 obj-$(CONFIG_SND_OMAP_SOC_HDMI) += snd-soc-omap-hdmi.o
diff --git a/arch/arm/plat-omap/mcbsp.c b/sound/soc/omap/mcbsp.c
similarity index 99%
rename from arch/arm/plat-omap/mcbsp.c
rename to sound/soc/omap/mcbsp.c
index 3c704f3..36d83b0 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -1,9 +1,11 @@
 /*
- * linux/arch/arm/plat-omap/mcbsp.c
+ * sound/soc/omap/mcbsp.c
  *
  * Copyright (C) 2004 Nokia Corporation
  * Author: Samuel Ortiz <samuel.ortiz@nokia.com>
  *
+ * Contact: Jarkko Nikula <jarkko.nikula@bitmer.com>
+ *          Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.7.8.4

