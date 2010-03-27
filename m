From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 16/19] DSPBRIDGE: Cleanup custom error code
 (DSP_ENOTCONNECTED -> ENOTCONN)
Date: Sat, 27 Mar 2010 07:58:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE16@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39555 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab0C0C3D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:29:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2T00h006282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:29:03 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2T0Vo026686
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:59:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 350cddf447f12ce5123cb5d14260c61593132a53 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 12:53:06 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ENOTCONNECTED -> ENOTCONN)

This patch replaces DSP_ENOTCONNECTED with -ENOTCONN.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/node.c                 |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 7e2f0b6..e564284 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -188,9 +188,6 @@
 /* Invalid stream mode */
 #define DSP_ESTRMMODE               (DSP_EBASE + 0x3a)
 
-/* Nodes not connected */
-#define DSP_ENOTCONNECTED           (DSP_EBASE + 0x3b)
-
 /* Not shared memory */
 #define DSP_ENOTSHAREDMEM           (DSP_EBASE + 0x3c)
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index b26052c..d4949dc 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1206,7 +1206,7 @@ dsp_status node_create(struct node_object *hnode)
 	     hnode->num_inputs - 1) ||
 	    (hnode->num_outputs && hnode->max_output_index >
 	     hnode->num_outputs - 1))
-		status = DSP_ENOTCONNECTED;
+		status = -ENOTCONN;
 
 	if (DSP_SUCCEEDED(status)) {
 		/* If node's create function is not loaded, load it */
-- 
1.6.0.4

