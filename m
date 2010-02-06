From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Patch 1/8] DSPBRIDGE: typedef cleanup -DSP RTOS
Date: Sat, 6 Feb 2010 06:51:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A776232@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51430 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223Ab0BFBVg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 20:21:36 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o161LX9I005001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 19:21:35 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o161LWhT001394
	for <linux-omap@vger.kernel.org>; Sat, 6 Feb 2010 06:51:33 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From 5855acc38e699f9abfcdd11f1dbd5d648feecb74 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 28 Jan 2010 18:57:02 -0600
Subject: [PATCH] DSPBRIDGE: typedef cleanup -DSPRTOS

This patch removes the typdef used for DSPRTOS type
and replaces it with normal C type.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index fc9fdc8..049fcee 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -115,7 +115,6 @@
 
 	typedef u32 DSP_PROCFAMILY;	/* Processor family             */
 	typedef u32 DSP_PROCTYPE;	/* Processor type (w/in family) */
-	typedef u32 DSP_RTOSTYPE;	/* Type of DSP RTOS             */
 
 /* Handy Macros */
 #define IsValidProcEvent(x) (((x) == 0) || (((x) & (DSP_PROCESSORSTATECHANGE | \
@@ -422,7 +421,7 @@
 		u32 ulInternalMemSize;
 		u32 ulExternalMemSize;
 		u32 uProcessorID;
-		DSP_RTOSTYPE tyRunningRTOS;
+		int tyRunningRTOS;
 		s32 nNodeMinPriority;
 		s32 nNodeMaxPriority;
 	} ;
-- 
1.6.0.4

