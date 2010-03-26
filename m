From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: Distinguish between read or write buffers
Date: Fri, 26 Mar 2010 15:02:28 -0600
Message-ID: <1269637348-20608-3-git-send-email-omar.ramirez@ti.com>
References: <1269637348-20608-1-git-send-email-omar.ramirez@ti.com>
 <1269637348-20608-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38332 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab0CZUqw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Mar 2010 16:46:52 -0400
In-Reply-To: <1269637348-20608-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch introduces the check to differentiate the buffers
coming to the dsp through bridgedriver. So far they can be
input (read) or output (write) or rw (which are treated the
same way as an output buffer), this distinctions are made from
dsp perspective.

Since this needs to be checked on map function, unused
bits (15, 14) of flags were used to check for this argument.

As 128 byte alignment limitation doesn't affect input buffers
only writable buffers are checked. Default value for read buffers
is set to be 1, this will enforce that users of bridge will fill
the flags with significant values otherwise (if enabled) check
will reject buffers not aligned to 128 bytes (even if they fall in
the input category).

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    7 ++++++-
 drivers/dsp/bridge/rmgr/proc.c                |   16 ++++++++++++----
 drivers/dsp/bridge/wmd/tiomap3430.c           |    4 ++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 7fcc4aa..d01d9ae 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -490,7 +490,10 @@ bit 3 - MMU element size = 8bit (valid only for non mixed page entries)
 bit 4 - MMU element size = 16bit (valid only for non mixed page entries)
 bit 5 - MMU element size = 32bit (valid only for non mixed page entries)
 bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
- */
+
+bit 14 - Input (read only) buffer
+bit 15 - Output (writeable) buffer
+*/
 
 /* Types of mapping attributes */
 
@@ -518,6 +521,8 @@ bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
 
 #define DSP_MAPDONOTLOCK	   0x00000100
 
+#define DSP_MAP_DIR_MASK		0x3FFF
+
 #define GEM_CACHE_LINE_SIZE     128
 #define GEM_L1P_PREFETCH_SIZE   128
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index ac141a8..64659ec 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -70,6 +70,12 @@
 
 #define DSP_CACHE_LINE 128
 
+#define BUFMODE_MASK	(3 << 14)
+
+/* Buffer modes from DSP perspective */
+#define RBUF		0x4000		/* Input buffer */
+#define WBUF		0x8000		/* Output Buffer */
+
 extern char *iva_img;
 
 /*  ----------------------------------- Globals */
@@ -1070,11 +1076,13 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	struct dmm_map_object *map_obj;
 
 #ifdef CONFIG_BRIDGE_CACHE_LINE_CHECK
-	if (!IS_ALIGNED((u32)pmpu_addr, DSP_CACHE_LINE) ||
-	    !IS_ALIGNED(ul_size, DSP_CACHE_LINE)) {
-		pr_err("%s: not aligned: 0x%x (%d)\n", __func__,
+	if ((ul_map_attr & BUFMODE_MASK) != RBUF) {
+		if (!IS_ALIGNED((u32)pmpu_addr, DSP_CACHE_LINE) ||
+		    !IS_ALIGNED(ul_size, DSP_CACHE_LINE)) {
+			pr_err("%s: not aligned: 0x%x (%d)\n", __func__,
 						(u32)pmpu_addr, ul_size);
-		return -EFAULT;
+			return -EFAULT;
+		}
 	}
 #endif
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a972ea2..cbf3203 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1308,11 +1308,11 @@ static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
 	if (ul_num_bytes == 0)
 		return DSP_EINVALIDARG;
 
-	if (ul_map_attr != 0) {
+	if (ul_map_attr & DSP_MAP_DIR_MASK) {
 		attrs = ul_map_attr;
 	} else {
 		/* Assign default attributes */
-		attrs = DSP_MAPVIRTUALADDR | DSP_MAPELEMSIZE16;
+		attrs = ul_map_attr | (DSP_MAPVIRTUALADDR | DSP_MAPELEMSIZE16);
 	}
 	/* Take mapping properties */
 	if (attrs & DSP_MAPBIGENDIAN)
-- 
1.6.2.4

