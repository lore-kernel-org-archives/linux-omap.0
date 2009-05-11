From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp cache line size
Date: Mon, 11 May 2009 07:55:13 +0300
Message-ID: <1242017713-25795-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32342 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbZEKEzY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 00:55:24 -0400
In-Reply-To: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

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

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 59073dd..437c3fe 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -159,6 +159,8 @@
 #define PWR_TIMEOUT	 500	/* Sleep/wake timout in msec */
 #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary */
 
+#define DSP_CACHE_SIZE 128 /* DSP cacheline size */
+
 extern char *iva_img;
 /* The PROC_OBJECT structure.   */
 struct PROC_OBJECT {
@@ -722,6 +724,13 @@ DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 	enum DSP_FLUSHTYPE FlushMemType = PROC_WRITEBACK_INVALIDATE_MEM;
 	DBC_Require(cRefs > 0);
 
+	if (!IS_ALIGNED((u32)pMpuAddr, DSP_CACHE_SIZE) ||
+	    !IS_ALIGNED(ulSize, DSP_CACHE_SIZE)) {
+		pr_err("%s: Invalid alignment %p %x\n",
+		       __func__, pMpuAddr, ulSize);
+		return DSP_EALIGNMENT;
+	}
+
 	GT_4trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_FlushMemory, args:\n\t"
 		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x, ulFlags 0x%x\n",
@@ -753,6 +762,14 @@ DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 		 "Entered PROC_InvalidateMemory, args:\n\t"
 		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x\n", hProcessor,
 		 pMpuAddr, ulSize);
+
+	if (!IS_ALIGNED((u32)pMpuAddr, DSP_CACHE_SIZE) ||
+	    !IS_ALIGNED(ulSize, DSP_CACHE_SIZE)) {
+		pr_err("%s: Invalid alignment %p %x\n",
+		       __func__, pMpuAddr, ulSize);
+		return DSP_EALIGNMENT;
+	}
+
 	(void)SYNC_EnterCS(hProcLock);
 	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
 	(void)SYNC_LeaveCS(hProcLock);
-- 
1.6.0.4

