From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: RFC] [PATCH 5/13] DSPBRIDGE: Cleanup custom error code
 (DSP_EALIGNMENT -> -EPERM)
Date: Fri, 16 Apr 2010 02:47:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FDC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40312 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757185Ab0DOVRV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:21 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLHIKZ032107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:17:20 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLHI61011068
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:47:18 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 045a98ee10ecfd8ef28dccb23918af92cbeb1bf3 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 11:03:16 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EALIGNMENT -> -EPERM)

This patch replaces DSP_ALIGNMENT with -EPERM.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/node.c                 |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index c9316ac..46fa77e 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -168,9 +168,6 @@
 /* Invalid segment ID */
 #define DSP_EBADSEGID               (DSP_EBASE + 0x38)
 
-/* Invalid alignment */
-#define DSP_EALIGNMENT               (DSP_EBASE + 0x39)
-
 /* Invalid stream mode */
 #define DSP_ESTRMMODE               (DSP_EBASE + 0x3a)
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index c50ac1b..871cd13 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -741,7 +741,7 @@ DBAPI node_alloc_msg_buf(struct node_object *hnode, u32 usize,
 			break;
 		default:
 			/* alignment value not suportted */
-			status = DSP_EALIGNMENT;
+			status = -EPERM;
 			break;
 		}
 		if (DSP_SUCCEEDED(status)) {
-- 
1.6.0.4

