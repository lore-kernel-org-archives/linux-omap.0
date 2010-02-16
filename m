From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Get rid of memset() from MEM_Calloc()
Date: Tue, 16 Feb 2010 17:40:23 +0200
Message-ID: <b487eb065323f57efcaea92d30f8cca5041589ee.1266334736.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48778 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588Ab0BPPlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:41:46 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1GFexwx006926
	for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 09:41:44 -0600
Received: from localhost.localdomain (esdhcp040168.research.nokia.com [172.21.40.168])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1GFf23D028515
	for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 17:41:02 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/services/mem.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 614396e..2501eee 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -227,16 +227,13 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 		case MEM_NONPAGED:
 		/* If non-paged memory required, see note at top of file. */
 		case MEM_PAGED:
-			pMem = kmalloc(cBytes,
+			pMem = kzalloc(cBytes,
 				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
-			if (pMem)
-				memset(pMem, 0, cBytes);
-
 			break;
 		case MEM_LARGEVIRTMEM:
-			pMem = vmalloc(cBytes);
-			if (pMem)
-				memset(pMem, 0, cBytes);
+			pMem = __vmalloc(cBytes,
+				GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO,
+				PAGE_KERNEL);
 			break;
 		default:
 			GT_1trace(MEM_debugMask, GT_6CLASS,
-- 
1.6.3.3

