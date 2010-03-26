From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: add checking 128 byte alignment for dsp cache line size
Date: Fri, 26 Mar 2010 15:02:27 -0600
Message-ID: <1269637348-20608-2-git-send-email-omar.ramirez@ti.com>
References: <1269637348-20608-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57833 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab0CZUqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 16:46:52 -0400
In-Reply-To: <1269637348-20608-1-git-send-email-omar.ramirez@ti.com>
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
 drivers/dsp/bridge/Kconfig     |   14 ++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c |   11 +++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index a3251c3..a973695 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -38,6 +38,20 @@ config BRIDGE_DEBUG
 	help
 	  Say Y to enable Bridge debugging capabilities
 
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
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index e100d31..ac141a8 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -68,6 +68,8 @@
 #define PWR_TIMEOUT	 500	/* Sleep/wake timout in msec */
 #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary */
 
+#define DSP_CACHE_LINE 128
+
 extern char *iva_img;
 
 /*  ----------------------------------- Globals */
@@ -1067,6 +1069,15 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
 	struct dmm_map_object *map_obj;
 
+#ifdef CONFIG_BRIDGE_CACHE_LINE_CHECK
+	if (!IS_ALIGNED((u32)pmpu_addr, DSP_CACHE_LINE) ||
+	    !IS_ALIGNED(ul_size, DSP_CACHE_LINE)) {
+		pr_err("%s: not aligned: 0x%x (%d)\n", __func__,
+						(u32)pmpu_addr, ul_size);
+		return -EFAULT;
+	}
+#endif
+
 	/* Calculate the page-aligned PA, VA and size */
 	va_align = PG_ALIGN_LOW((u32) req_addr, PG_SIZE4K);
 	pa_align = PG_ALIGN_LOW((u32) pmpu_addr, PG_SIZE4K);
-- 
1.6.2.4

