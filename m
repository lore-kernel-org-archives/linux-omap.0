From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 6/13] DSPBRIDGE: Cleanup custom error code
 (DSP_ESTRMMODE -> -EPERM)
Date: Fri, 16 Apr 2010 02:47:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FDD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51948 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757215Ab0DOVRZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:25 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLHMgp008698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:17:24 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLHMYH011075
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:47:22 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 8d982475f18c66f7b1d5e4d3677d479a8ec81781 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 11:08:36 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ESTRMMODE -> -EPERM)

This patch replaces DSP_ESTRMMODE with -EPERM

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/node.c                 |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 46fa77e..06c6030 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -168,9 +168,6 @@
 /* Invalid segment ID */
 #define DSP_EBADSEGID               (DSP_EBASE + 0x38)
 
-/* Invalid stream mode */
-#define DSP_ESTRMMODE               (DSP_EBASE + 0x3a)
-
 /* Not shared memory */
 #define DSP_ENOTSHAREDMEM           (DSP_EBASE + 0x3c)
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 871cd13..7f35052 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -901,7 +901,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
 	 */
 	if (DSP_SUCCEEDED(status) && pattrs) {
 		if (pattrs->strm_mode != STRMMODE_PROCCOPY)
-			status = DSP_ESTRMMODE;	/* illegal stream mode */
+			status = -EPERM;	/* illegal stream mode */
 
 	}
 	if (DSP_FAILED(status))
-- 
1.6.0.4

