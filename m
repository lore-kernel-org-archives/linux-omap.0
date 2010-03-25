From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 16/19] DSPBRIDGE: Cleanup custom error code
 (DSP_ENOTCONNECTED -> ENOTCONN)
Date: Fri, 26 Mar 2010 01:37:03 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB2C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37035 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUHM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 7b23fee1223c374a4b69669bc597caac341beb51 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 12:53:06 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code(DSP_ENOTCONNECTED -> ENOTCONN)

This patch replaces DSP_ENOTCONNECTED with ENOTCONN.

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
index 7903342..46481b6 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1206,7 +1206,7 @@ dsp_status node_create(struct node_object *hnode)
 	     hnode->num_inputs - 1) ||
 	    (hnode->num_outputs && hnode->max_output_index >
 	     hnode->num_outputs - 1))
-		status = DSP_ENOTCONNECTED;
+		status = ENOTCONN;
 
 	if (DSP_SUCCEEDED(status)) {
 		/* If node's create function is not loaded, load it */
-- 
1.6.0.4

