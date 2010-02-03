From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Patch 3/8] DSPBRIDGE: typedef cleanup -PROCFAMILY
Date: Wed, 3 Feb 2010 06:13:54 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A6B9673@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38339 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926Ab0BCAoA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 19:44:00 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o130hve2003747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 18:43:59 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o130huhJ009227
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 06:13:56 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From 108329666e2bf829915c7de4a693fd83c00581a3 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 29 Jan 2010 15:03:02 -0600
Subject: [PATCH] DSPBRIDGE: Remove  typedef for PROCFAMILY and  Replace it
 	   with normal C type

This patch removes the typdef used for PROCFAMILY and replaces it with normal C type.
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    4 +---
 arch/arm/plat-omap/include/dspbridge/dispdefs.h |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 37ac1dd..36cd569 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -113,8 +113,6 @@
 	typedef HANDLE DSP_HPROCESSOR;	/* Handle to a Processor object */
 	typedef HANDLE DSP_HSTREAM;	/* Handle to a Stream object    */
 
-	typedef u32 DSP_PROCFAMILY;	/* Processor family             */
-
 /* Handy Macros */
 #define IsValidProcEvent(x) (((x) == 0) || (((x) & (DSP_PROCESSORSTATECHANGE | \
 				    DSP_PROCESSORATTACH | \
@@ -414,7 +412,7 @@
  */
 	struct DSP_PROCESSORINFO {
 		u32 cbStruct;
-		DSP_PROCFAMILY uProcessorFamily;
+		long uProcessorFamily;
 		long uProcessorType;
 		u32 uClockRate;
 		u32 ulInternalMemSize;
diff --git a/arch/arm/plat-omap/include/dspbridge/dispdefs.h b/arch/arm/plat-omap/include/dspbridge/dispdefs.h
index f60b351..a9a2961 100644
--- a/arch/arm/plat-omap/include/dspbridge/dispdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dispdefs.h
@@ -26,7 +26,7 @@
 		u32 ulChnlOffset; /* Offset of channel ids reserved for RMS */
 		/* Size of buffer for sending data to RMS */
 		u32 ulChnlBufSize;
-		DSP_PROCFAMILY procFamily;	/* eg, 5000 */
+		long procFamily;	/* eg, 5000 */
 		long procType;		/* eg, 5510 */
 		HANDLE hReserved1;	/* Reserved for future use. */
 		u32 hReserved2;	/* Reserved for future use. */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c index 92d51d1..4bc0435 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -152,7 +152,7 @@ struct NODE_MGR {
 	u32 ulNumChnls;	/* Total number of channels */
 	u32 ulChnlOffset;	/* Offset of chnl ids rsvd for RMS */
 	u32 ulChnlBufSize;	/* Buffer size for data to RMS */
-	DSP_PROCFAMILY procFamily;	/* eg, 5000 */
+	long procFamily;	/* eg, 5000 */
 	long procType;	/* eg, 5510 */
 	u32 uDSPWordSize;	/* Size of DSP word on host bytes */
 	u32 uDSPDataMauSize;	/* Size of DSP data MAU */
--
1.6.0.4

