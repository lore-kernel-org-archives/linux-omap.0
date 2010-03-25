From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 19/19] DSPBRIDGE: Cleanup custom error code
 (WMD_E_TIMEOUT -> ETIMEDOUT)
Date: Fri, 26 Mar 2010 01:37:13 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB2F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50165 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:41 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From a80fb3467de1367e4a7ce143d744abc807f7dc61 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 13:12:12 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code(WMD_E_TIMEOUT -> ETIMEDOUT)

This patch replaces WMD_E_TIMEOUT with ETIMEDOUT.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/wmd.h     |   12 ++++++------
 drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |    4 ++--
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 3524a33..a9ecb71 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -370,9 +370,6 @@
 /* One or more configuration parameters violated WMD hardware assumptions. */
 #define WMD_E_BADCONFIG             (WMD_EBASE + 0x01)
 
-/* Timeout occurred waiting for a response from the hardware. */
-#define WMD_E_TIMEOUT               (WMD_EBASE + 0x02)
-
 /* FAILURE Codes : REG */
 #define REG_EBASE                   (DSP_COMP_EBASE + 0x800)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 7f339dd..ba98da8 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -59,7 +59,7 @@ struct wmd_dev_context;
  *  Returns:
  *      DSP_SOK:        Success.
  *      WMD_E_HARDWARE: A test of hardware assumptions/integrity failed.
- *      WMD_E_TIMEOUT:  Timeout occured waiting for a response from hardware.
+ *      ETIMEOUT:  Timeout occured waiting for a response from hardware.
  *      DSP_EFAIL:      Other, unspecified error.
  *  Requires:
  *      hDevContext != NULL
@@ -98,7 +98,7 @@ typedef dsp_status(*fxn_brd_setstate) (struct wmd_dev_context
  *      dwDSPAddr:      DSP address at which to start execution.
  *  Returns:
  *      DSP_SOK:        Success.
- *      WMD_E_TIMEOUT:  Timeout occured waiting for a response from hardware.
+ *      ETIMEOUT:  Timeout occured waiting for a response from hardware.
  *      DSP_EFAIL:      Other, unspecified error.
  *  Requires:
  *      hDevContext != NULL
@@ -149,7 +149,7 @@ typedef dsp_status(*fxn_brd_memcopy) (struct wmd_dev_context
  *      ulMemType:      Memory space on DSP to which to transfer.
  *  Returns:
  *      DSP_SOK:        Success.
- *      WMD_E_TIMEOUT:  Timeout occured waiting for a response from hardware.
+ *      ETIMEOUT:  Timeout occured waiting for a response from hardware.
  *      DSP_EFAIL:      Other, unspecified error.
  *  Requires:
  *      hDevContext != NULL;
@@ -211,7 +211,7 @@ typedef dsp_status(*fxn_brd_memunmap) (struct wmd_dev_context
  *      hDevContext:    Handle to mini-driver defined device context.
  *  Returns:
  *      DSP_SOK:        Success.
- *      WMD_E_TIMEOUT:  Timeout occured waiting for a response from hardware.
+ *      ETIMEOUT:  Timeout occured waiting for a response from hardware.
  *      DSP_EFAIL:      Other, unspecified error.
  *  Requires:
  *      hDevContext != NULL
@@ -253,7 +253,7 @@ typedef dsp_status(*fxn_brd_status) (struct wmd_dev_context *hDevContext,
  *      ulMemType:      Memory space on DSP from which to transfer.
  *  Returns:
  *      DSP_SOK:        Success.
- *      WMD_E_TIMEOUT:  Timeout occured waiting for a response from hardware.
+ *      ETIMEOUT:  Timeout occured waiting for a response from hardware.
  *      DSP_EFAIL:      Other, unspecified error.
  *  Requires:
  *      hDevContext != NULL;
@@ -279,7 +279,7 @@ typedef dsp_status(*fxn_brd_read) (struct wmd_dev_context *hDevContext,
  *      ulMemType:      Memory space on DSP to which to transfer.
  *  Returns:
  *      DSP_SOK:        Success.
- *      WMD_E_TIMEOUT:  Timeout occured waiting for a response from hardware.
+ *      ETIMEOUT:  Timeout occured waiting for a response from hardware.
  *      DSP_EFAIL:      Other, unspecified error.
  *  Requires:
  *      hDevContext != NULL;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 647643d..899df1a 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -722,7 +722,7 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 		/* Wait for DSP to clear word in shared memory */
 		/* Read the Location */
 		if (!wait_for_start(dev_context, dw_sync_addr))
-			status = WMD_E_TIMEOUT;
+			status = ETIMEDOUT;
 
 		status = dev_get_io_mgr(dev_context->hdev_obj, &hio_mgr);
 		if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 48dbeae..f515cae 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -115,7 +115,7 @@ dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
 	}
 	if (timeout == 0) {
 		pr_err("%s: Timed out waiting for DSP off mode\n", __func__);
-		status = WMD_E_TIMEOUT;
+		status = ETIMEDOUT;
 		return status;
 	} else {
 
@@ -231,7 +231,7 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
 		dev_get_deh_mgr(dev_context->hdev_obj, &hdeh_mgr);
 		bridge_deh_notify(hdeh_mgr, DSP_PWRERROR, 0);
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
-		return WMD_E_TIMEOUT;
+		return ETIMEDOUT;
 	} else {
 		/* Update the Bridger Driver state */
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF)
-- 
1.6.0.4

