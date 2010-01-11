From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: driver version 0.1
Date: Mon, 11 Jan 2010 11:50:22 -0600
Message-ID: <1263232222-30599-2-git-send-email-omar.ramirez@ti.com>
References: <1263232222-30599-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52931 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab0AKRk7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 12:40:59 -0500
In-Reply-To: <1263232222-30599-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Nishant Menon <nm@ti.com>

This is the official 0.1 dspbridge version.

CC: Felipe Contreras <felipe.contreras@nokia.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Nishant Menon <nm@ti.com>

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index c853854..efce35d 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -101,6 +101,7 @@
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
 #define DRIVER_NAME  "DspBridge"
+#define DSPBRIDGE_VERSION	"0.1"
 s32 dsp_debug;
 
 struct platform_device *omap_dspbridge_dev;
@@ -177,6 +178,7 @@ MODULE_PARM_DESC(tc_wordswapon, "TC Word Swap Option. default = 0");
 
 MODULE_AUTHOR("Texas Instruments");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DSPBRIDGE_VERSION);
 
 static char *driver_name = DRIVER_NAME;
 
-- 
1.6.2.4

