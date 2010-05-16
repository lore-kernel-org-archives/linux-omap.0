From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] dspbridge: improve Kconfig
Date: Sun, 16 May 2010 18:46:59 +0300
Message-ID: <1274024821-21178-4-git-send-email-felipe.contreras@gmail.com>
References: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:65511 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab0EPPrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:47:16 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178779fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:47:15 -0700 (PDT)
In-Reply-To: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/Kconfig |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 75c1a1c..b2af858 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig OMAP_DSP
 	tristate "DSP Bridge driver"
-	default n
+	depends on ARCH_OMAP34XX
 	select OMAP_MBOX_FWK
 	help
 	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
@@ -17,7 +17,6 @@ menuconfig OMAP_DSP
 config OMAP_DSP_DVFS
 	bool "Enable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
 	depends on OMAP_DSP && OMAP_PM_SRF && CPU_FREQ
-	default n
 	help
 	  DVFS allows DSP Bridge to initiate the operating point change to
 	  scale the chip voltage and frequency in order to match the
@@ -33,22 +32,22 @@ config OMAP_DSP_MEMPOOL_SIZE
 	  failure under heavy memory fragmentation after some use time.
 
 config OMAP_DSP_DEBUG
-	bool "DSP Bridge Debug Support"
+	bool "Debug Support"
 	depends on OMAP_DSP
 	help
 	  Say Y to enable Bridge debugging capabilities
 
 config OMAP_DSP_RECOVERY
-	bool "DSP Recovery Support"
+	bool "Recovery Support"
 	depends on OMAP_DSP
+	default y
 	help
 	  In case of DSP fatal error, BRIDGE driver will try to
 	  recover itself.
 
 config OMAP_DSP_CACHE_LINE_CHECK
-	bool "Check buffers to be 128 byte aligned"
+	bool "Check buffers to be 128-byte aligned"
 	depends on OMAP_DSP
-	default n
 	help
 	  When the DSP processes data, the DSP cache controller loads 128-Byte
 	  chunks (lines) from SDRAM and writes the data back in 128-Byte chunks.
@@ -60,27 +59,23 @@ config OMAP_DSP_CACHE_LINE_CHECK
 	  byte alignment, buffers failing this check will be rejected.
 
 config OMAP_DSP_WDT3
-	bool "Enable WDT3 interruptions"
+	bool "Enable watchdog timer"
 	depends on OMAP_DSP
-	default n
 	help
 	  WTD3 is managed by DSP and once it is enabled, DSP side bridge is in
 	  charge of refreshing the timer before overflow, if the DSP hangs MPU
 	  will caught the interrupt and try to recover DSP.
 
 config OMAP_DSP_WDT_TIMEOUT
-	int "DSP watchdog timer timeout (in secs)"
-	depends on OMAP_DSP_WDT3
+	int "Watchdog timer timeout (in secs)"
+	depends on OMAP_DSP && BRIDGE_WDT3
 	default 5
 	help
 	   Watchdog timer timeout value, after that time if the watchdog timer
 	   counter is not reset the wdt overflow interrupt will be triggered
 
-comment "Bridge Notifications"
-	depends on OMAP_DSP
-
 config OMAP_DSP_NTFY_PWRERR
-	bool "Notify DSP Power Error"
+	bool "Notify power errors"
 	depends on OMAP_DSP
 	help
 	  Enable notifications to registered clients on the event of power errror
-- 
1.7.1

