From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: driver version 0.2
Date: Fri,  5 Mar 2010 23:11:39 -0600
Message-ID: <1267852299-23337-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36594 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab0CFE5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 23:57:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

driver version 0.2

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index fa97caa..3f5af34 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -70,7 +70,7 @@
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
 #define DRIVER_NAME  "DspBridge"
-#define DSPBRIDGE_VERSION	"0.1"
+#define DSPBRIDGE_VERSION	"0.2"
 s32 dsp_debug;
 
 struct platform_device *omap_dspbridge_dev;
-- 
1.6.2.4

