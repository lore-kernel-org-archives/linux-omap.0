From: andy.shevchenko@gmail.com
Subject: [PATCH] dspbridge: minor clean up in memdefs.h
Date: Wed, 27 Jan 2010 14:39:11 +0200
Message-ID: <1264595951-11572-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17701 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab0A0MlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 07:41:09 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o0RCe9j2006597
	for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 06:41:07 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Remove useless macroses. They were doing nothing, so it's clear to just get rid
of them.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/memdefs.h |    3 ---
 drivers/dsp/bridge/wmd/tiomap_io.c             |    5 ++---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/memdefs.h b/arch/arm/plat-omap/include/dspbridge/memdefs.h
index e70225e..2e44f5c 100644
--- a/arch/arm/plat-omap/include/dspbridge/memdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/memdefs.h
@@ -34,7 +34,4 @@
 #define MEM_GETVIRTUALSEGID     0x20000000
 #define MEM_MASKVIRTUALSEGID    (MEM_SETVIRTUALSEGID | MEM_GETVIRTUALSEGID)
 
-#define TO_VIRTUAL_UNCACHED(x) x
-#define INTREG_TO_VIRTUAL_UNCACHED(x) x
-
 #endif				/* MEMDEFS_ */
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index f60b8db..4e85efd 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -366,9 +366,8 @@ DSP_STATUS WriteExtDspData(struct WMD_DEV_CONTEXT *pDevContext,
 				 dwExtProgVirtMem);
 
 			pDevContext->dwDspExtBaseAddr =
-				(u32)MEM_LinearAddress((void *)
-				TO_VIRTUAL_UNCACHED(dwExtProgVirtMem), ulExtEnd
-				- ulExtBase);
+				(u32)MEM_LinearAddress((void *)dwExtProgVirtMem,
+					ulExtEnd - ulExtBase);
 			dwBaseAddr += pDevContext->dwDspExtBaseAddr;
 			/* This dwDspExtBaseAddr will get cleared only when
 			 * the board is stopped.  */
-- 
1.5.6.5

