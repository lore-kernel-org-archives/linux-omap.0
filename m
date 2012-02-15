From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 1/2] staging: tidspbridge: always compile dsp wdt code
Date: Tue, 14 Feb 2012 21:00:33 -0600
Message-ID: <1329274834-30154-2-git-send-email-omar.ramirez@ti.com>
References: <1329274834-30154-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:53379 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757629Ab2BODAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 22:00:51 -0500
Received: by mail-tul01m020-f181.google.com with SMTP id up10so915175obb.26
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 19:00:50 -0800 (PST)
In-Reply-To: <1329274834-30154-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, devel@driverdev.osuosl.org, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

In order to detect it at runtime, we need the code handling wdt
clock available at runtime to decide whether to enable or disable
based on the baseimage symbols. Default timeout has been set to 5
seconds.

Downside is that we will lose the option to set a custom timeout
for overflow, but than can be added (if needed) as part of debugfs.

Signed-off-by: Omar Ramirez <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/Kconfig                |   16 -------------
 drivers/staging/tidspbridge/core/wdt.c             |   24 +-------------------
 .../tidspbridge/include/dspbridge/_chnl_sm.h       |    4 ---
 3 files changed, 1 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/staging/tidspbridge/Kconfig
index d660891..0dd479f 100644
--- a/drivers/staging/tidspbridge/Kconfig
+++ b/drivers/staging/tidspbridge/Kconfig
@@ -52,22 +52,6 @@ config TIDSPBRIDGE_CACHE_LINE_CHECK
 	  This can lead to heap corruption. Say Y, to enforce the check for 128
 	  byte alignment, buffers failing this check will be rejected.
 
-config TIDSPBRIDGE_WDT3
-	bool "Enable watchdog timer"
-	depends on TIDSPBRIDGE
-	help
-	  WTD3 is managed by DSP and once it is enabled, DSP side bridge is in
-	  charge of refreshing the timer before overflow, if the DSP hangs MPU
-	  will caught the interrupt and try to recover DSP.
-
-config TIDSPBRIDGE_WDT_TIMEOUT
-	int "Watchdog timer timeout (in secs)"
-	depends on TIDSPBRIDGE && TIDSPBRIDGE_WDT3
-	default 5
-	help
-	   Watchdog timer timeout value, after that time if the watchdog timer
-	   counter is not reset the wdt overflow interrupt will be triggered
-
 config TIDSPBRIDGE_NTFY_PWRERR
 	bool "Notify power errors"
 	depends on TIDSPBRIDGE
diff --git a/drivers/staging/tidspbridge/core/wdt.c b/drivers/staging/tidspbridge/core/wdt.c
index 2126f59..70055c8 100644
--- a/drivers/staging/tidspbridge/core/wdt.c
+++ b/drivers/staging/tidspbridge/core/wdt.c
@@ -25,8 +25,6 @@
 #include <dspbridge/host_os.h>
 
 
-#ifdef CONFIG_TIDSPBRIDGE_WDT3
-
 #define OMAP34XX_WDT3_BASE 		(L4_PER_34XX_BASE + 0x30000)
 
 static struct dsp_wdt_setting dsp_wdt;
@@ -84,7 +82,7 @@ int dsp_wdt_init(void)
 void dsp_wdt_sm_set(void *data)
 {
 	dsp_wdt.sm_wdt = data;
-	dsp_wdt.sm_wdt->wdt_overflow = CONFIG_TIDSPBRIDGE_WDT_TIMEOUT;
+	dsp_wdt.sm_wdt->wdt_overflow = 5;	/* in seconds */
 }
 
 
@@ -128,23 +126,3 @@ void dsp_wdt_enable(bool enable)
 		clk_disable(dsp_wdt.fclk);
 	}
 }
-
-#else
-void dsp_wdt_enable(bool enable)
-{
-}
-
-void dsp_wdt_sm_set(void *data)
-{
-}
-
-int dsp_wdt_init(void)
-{
-	return 0;
-}
-
-void dsp_wdt_exit(void)
-{
-}
-#endif
-
diff --git a/drivers/staging/tidspbridge/include/dspbridge/_chnl_sm.h b/drivers/staging/tidspbridge/include/dspbridge/_chnl_sm.h
index 6e7ab4f..cc95a18 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/_chnl_sm.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/_chnl_sm.h
@@ -99,14 +99,10 @@ struct shm {
 	struct opp_rqst_struct opp_request;
 	/* load monitor information structure */
 	struct load_mon_struct load_mon_info;
-#ifdef CONFIG_TIDSPBRIDGE_WDT3
 	/* Flag for WDT enable/disable F/I clocks */
 	u32 wdt_setclocks;
 	u32 wdt_overflow;	/* WDT overflow time */
 	char dummy[176];	/* padding to 256 byte boundary */
-#else
-	char dummy[184];	/* padding to 256 byte boundary */
-#endif
 	u32 shm_dbg_var[64];	/* shared memory debug variables */
 };
 
-- 
1.7.4.1

