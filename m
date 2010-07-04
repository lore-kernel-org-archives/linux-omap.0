From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] staging: ti dspbridge: improve Kconfig
Date: Sun,  4 Jul 2010 16:36:24 +0300
Message-ID: <1278250586-17062-4-git-send-email-felipe.contreras@gmail.com>
References: <1278250586-17062-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65451 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab0GDNgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:36:36 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295721bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:36:35 -0700 (PDT)
In-Reply-To: <1278250586-17062-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/Kconfig |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/staging/tidspbridge/Kconfig
index 6ce443a..4d63b66 100644
--- a/drivers/staging/tidspbridge/Kconfig
+++ b/drivers/staging/tidspbridge/Kconfig
@@ -17,7 +17,6 @@ menuconfig TIDSPBRIDGE
 config TIDSPBRIDGE_DVFS
 	bool "Enable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
 	depends on TIDSPBRIDGE && OMAP_PM_SRF && CPU_FREQ
-	default n
 	help
 	  DVFS allows DSP Bridge to initiate the operating point change to
 	  scale the chip voltage and frequency in order to match the
@@ -33,14 +32,15 @@ config TIDSPBRIDGE_MEMPOOL_SIZE
 	  failure under heavy memory fragmentation after some use time.
 
 config TIDSPBRIDGE_DEBUG
-	bool "DSP Bridge Debug Support"
+	bool "Debug Support"
 	depends on TIDSPBRIDGE
 	help
 	  Say Y to enable Bridge debugging capabilities
 
 config TIDSPBRIDGE_RECOVERY
-	bool "DSP Recovery Support"
+	bool "Recovery Support"
 	depends on TIDSPBRIDGE
+	default y
 	help
 	  In case of DSP fatal error, BRIDGE driver will try to
 	  recover itself.
@@ -48,7 +48,6 @@ config TIDSPBRIDGE_RECOVERY
 config TIDSPBRIDGE_CACHE_LINE_CHECK
 	bool "Check buffers to be 128 byte aligned"
 	depends on TIDSPBRIDGE
-	default n
 	help
 	  When the DSP processes data, the DSP cache controller loads 128-Byte
 	  chunks (lines) from SDRAM and writes the data back in 128-Byte chunks.
@@ -60,27 +59,23 @@ config TIDSPBRIDGE_CACHE_LINE_CHECK
 	  byte alignment, buffers failing this check will be rejected.
 
 config TIDSPBRIDGE_WDT3
-	bool "Enable WDT3 interruptions"
+	bool "Enable watchdog timer"
 	depends on TIDSPBRIDGE
-	default n
 	help
 	  WTD3 is managed by DSP and once it is enabled, DSP side bridge is in
 	  charge of refreshing the timer before overflow, if the DSP hangs MPU
 	  will caught the interrupt and try to recover DSP.
 
 config TIDSPBRIDGE_WDT_TIMEOUT
-	int "DSP watchdog timer timeout (in secs)"
-	depends on TIDSPBRIDGE_WDT3
+	int "Watchdog timer timeout (in secs)"
+	depends on TIDSPBRIDGE && TIDSPBRIDGE_WDT3
 	default 5
 	help
 	   Watchdog timer timeout value, after that time if the watchdog timer
 	   counter is not reset the wdt overflow interrupt will be triggered
 
-comment "Bridge Notifications"
-	depends on TIDSPBRIDGE
-
 config TIDSPBRIDGE_NTFY_PWRERR
-	bool "Notify DSP Power Error"
+	bool "Notify power errors"
 	depends on TIDSPBRIDGE
 	help
 	  Enable notifications to registered clients on the event of power errror
-- 
1.7.1

