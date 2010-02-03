From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Patch 2/8] DSPBRIDGE: typedef cleanup -PROCTYPE
Date: Wed, 3 Feb 2010 06:13:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A6B9672@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38338 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926Ab0BCAn5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 19:43:57 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o130hsGY003740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 18:43:56 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o130hrQ1009216
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 06:13:53 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From 40939eb42f476a0ef7b4f67ebcb412b562daed81 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 28 Jan 2010 19:14:21 -0600
Subject: [PATCH] DSPBRIDGE: Remove typedef used for PROCTYPE and replace
 	   it with the normal C type

    This patch removes the typedef used for PROCTYPE
    and replace it with the normal C type.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    3 +--
 arch/arm/plat-omap/include/dspbridge/dispdefs.h |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 049fcee..37ac1dd 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -114,7 +114,6 @@
 	typedef HANDLE DSP_HSTREAM;	/* Handle to a Stream object    */
 
 	typedef u32 DSP_PROCFAMILY;	/* Processor family             */
-	typedef u32 DSP_PROCTYPE;	/* Processor type (w/in family) */
 
 /* Handy Macros */
 #define IsValidProcEvent(x) (((x) == 0) || (((x) & (DSP_PROCESSORSTATECHANGE | \ @@ -416,7 +415,7 @@
 	struct DSP_PROCESSORINFO {
 		u32 cbStruct;
 		DSP_PROCFAMILY uProcessorFamily;
-		DSP_PROCTYPE uProcessorType;
+		long uProcessorType;
 		u32 uClockRate;
 		u32 ulInternalMemSize;
 		u32 ulExternalMemSize;
diff --git a/arch/arm/plat-omap/include/dspbridge/dispdefs.h b/arch/arm/plat-omap/include/dspbridge/dispdefs.h
index 9633bbc..f60b351 100644
--- a/arch/arm/plat-omap/include/dspbridge/dispdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dispdefs.h
@@ -27,7 +27,7 @@
 		/* Size of buffer for sending data to RMS */
 		u32 ulChnlBufSize;
 		DSP_PROCFAMILY procFamily;	/* eg, 5000 */
-		DSP_PROCTYPE procType;	/* eg, 5510 */
+		long procType;		/* eg, 5510 */
 		HANDLE hReserved1;	/* Reserved for future use. */
 		u32 hReserved2;	/* Reserved for future use. */
 	} ;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c index 336abea..92d51d1 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -153,7 +153,7 @@ struct NODE_MGR {
 	u32 ulChnlOffset;	/* Offset of chnl ids rsvd for RMS */
 	u32 ulChnlBufSize;	/* Buffer size for data to RMS */
 	DSP_PROCFAMILY procFamily;	/* eg, 5000 */
-	DSP_PROCTYPE procType;	/* eg, 5510 */
+	long procType;	/* eg, 5510 */
 	u32 uDSPWordSize;	/* Size of DSP word on host bytes */
 	u32 uDSPDataMauSize;	/* Size of DSP data MAU */
 	u32 uDSPMauSize;	/* Size of MAU */
--
1.6.0.4

