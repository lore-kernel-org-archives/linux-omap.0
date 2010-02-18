From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC][PATCH 1/2] DSPBRIDGE: add checking 128 byte alignment for dsp cache line size
Date: Thu, 18 Feb 2010 16:33:48 -0600
Message-ID: <1266532429-30927-2-git-send-email-omar.ramirez@ti.com>
References: <1266532429-30927-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58155 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab0BRWVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 17:21:13 -0500
In-Reply-To: <1266532429-30927-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>

A buffer shared with MPU and DSP has to be aligned on both cache line
size to avoid memory corrupton with some DSP cache operations. Since
there's no way for dspbridge to know how the shared buffer will be
used like: "read-only", "write-only", "rw" through its life span, any
shared buffer passed to DSP should be on this alignment. This patch
adds checking those shared buffer alignement in bridgedriver cache
operations and prevents userland applications from causing the above
memory corruption.

Please refer to:
https://omapzoom.org/gf/download/docmanfileversion/52/985/DSP_cache.pdf

Signed-off-by: Hiroshi DOYU <hiroshi.doyu@nokia.com>
[orl: check into PROC_Map, created Kconfig option]
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/Kconfig     |   19 +++++++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c |   12 ++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index e494f02..646fdcb 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -35,6 +35,23 @@ config BRIDGE_DEBUG
 	help
 	  Say Y to enable Bridge debugging capabilities
 
+menu "Bridge Hacking"
+	depends on MPU_BRIDGE
+
+config BRIDGE_CACHE_LINE_CHECK
+	bool "Check buffers to be 128 byte aligned"
+	depends on MPU_BRIDGE
+	default n
+	help
+	  When the DSP processes data, the DSP cache controller loads 128-Byte
+	  chunks (lines) from SDRAM and writes the data back in 128-Byte chunks.
+	  If a DMM buffer does not start and end on a 128-Byte boundary, the data
+	  preceding the start address (SA) from the 128-Byte boundary to the SA
+	  and the data at addresses trailing the end address (EA) from the EA to
+	  the next 128-Byte boundary will be loaded and written back as well.
+	  This can lead to heap corruption. Say Y, to enforce the check for 128
+	  byte alignment, buffers failing this check will be rejected.
+
 comment "Bridge Notifications"
 	depends on MPU_BRIDGE
 
@@ -45,3 +62,5 @@ config BRIDGE_NTFY_PWRERR
 	  Enable notifications to registered clients on the event of power errror
 	  trying to suspend bridge driver. Say Y, to signal this event as a fatal
 	  error, this will require a bridge restart to recover.
+
+endmenu
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 6c0173a..78a31ef 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -69,6 +69,8 @@
 #define PWR_TIMEOUT	 500	/* Sleep/wake timout in msec */
 #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary */
 
+#define DSP_CACHE_LINE 128
+
 extern char *iva_img;
 
 /*  ----------------------------------- Globals */
@@ -1293,6 +1295,16 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 		 "hProcessor %x, pMpuAddr %x, ulSize %x, pReqAddr %x, "
 		 "ulMapAttr %x, ppMapAddr %x\n", hProcessor, pMpuAddr, ulSize,
 		 pReqAddr, ulMapAttr, ppMapAddr);
+
+#ifdef CONFIG_BRIDGE_CACHE_LINE_CHECK
+	if (!IS_ALIGNED((u32)pMpuAddr, DSP_CACHE_LINE) ||
+	    !IS_ALIGNED(size, DSP_CACHE_LINE)) {
+		pr_err("%s: not aligned: 0x%x (%d)\n", __func__,
+						(u32)pMpuAddr, ulSize);
+		return -EFAULT;
+	}
+#endif
+
 	/* Calculate the page-aligned PA, VA and size */
 	vaAlign = PG_ALIGN_LOW((u32) pReqAddr, PG_SIZE_4K);
 	paAlign = PG_ALIGN_LOW((u32) pMpuAddr, PG_SIZE_4K);
-- 
1.6.2.4

