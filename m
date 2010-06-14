From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: driver version 0.3
Date: Mon, 14 Jun 2010 17:27:04 -0500
Message-ID: <1276554424-5464-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55616 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027Ab0FNWeV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jun 2010 18:34:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Ernesto Ramos Falcon <ernesto@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

driver version 0.3

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index cdc7f1b..f0f089b 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -69,7 +69,7 @@
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
 #define DRIVER_NAME  "DspBridge"
-#define DSPBRIDGE_VERSION	"0.2"
+#define DSPBRIDGE_VERSION	"0.3"
 s32 dsp_debug;
 
 struct platform_device *omap_dspbridge_dev;
-- 
1.7.1

