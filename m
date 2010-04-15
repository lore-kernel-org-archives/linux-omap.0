From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 2/13] DSPBRIDGE: Cleanup custom error code
 (DSP_ESTREAMFULL -> -ENOSR)
Date: Fri, 16 Apr 2010 02:47:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FDA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40792 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0DOVRP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:15 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLHCXl030910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:17:14 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLHCJC011054
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:47:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 0e3d9c1ccc09389155202da25b856698195fb556 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 8 Apr 2010 17:34:59 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ESTREAMFULL -> -ENOSR)

This patch replaces DSP_ESTREAMFULL with -ENOSR.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    5 -----
 arch/arm/plat-omap/include/dspbridge/strm.h    |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                 |    2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 8a0e48c..28c4d7b 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -79,11 +79,6 @@
 /* A failure occurred during a delete operation */
 #define DSP_EDELETE                 (DSP_EBASE + 5)
 
-/* A stream has been issued the maximum number of buffers allowed in the
- * stream at once ;  buffers must be reclaimed from the stream before any
- * more can be issued. */
-#define DSP_ESTREAMFULL             (DSP_EBASE + 7)
-
 /* A general failure occurred */
 #define DSP_EFAIL                   (DSP_EBASE + 8)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index fd27da2..8770608 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -234,7 +234,7 @@ extern bool strm_init(void);
  *  Returns:
  *      DSP_SOK:            Success.
  *      -EFAULT:        Invalid hStrm.
- *      DSP_ESTREAMFULL:    The stream is full.
+ *      -ENOSR:    The stream is full.
  *      DSP_EFAIL:          Failure occurred, unable to issue buffer.
  *  Requires:
  *      strm_init(void) called.
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 10d86ca..5102422 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -459,7 +459,7 @@ dsp_status strm_issue(struct strm_object *hStrm, IN u8 *pbuf, u32 ul_bytes,
 			     (u32) tmp_buf, dw_arg);
 		}
 		if (status == CHNL_E_NOIORPS)
-			status = DSP_ESTREAMFULL;
+			status = -ENOSR;
 	}
 
 	dev_dbg(bridge, "%s: hStrm: %p pbuf: %p ul_bytes: 0x%x dw_arg: 0x%x "
-- 
1.6.0.4

