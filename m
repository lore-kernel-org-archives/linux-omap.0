From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] BRIDGE: Clean up include file duplication
Date: Mon, 15 Sep 2008 06:03:30 +0300
Message-ID: <1221447810-2630-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48822 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbYIODDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Sep 2008 23:03:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, vikram.pandita@ti.com, x00omar@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/disp.c          |    1 -
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 --
 drivers/dsp/bridge/wmd/io_sm.c          |    1 -
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index a8b4e66..776be47 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -68,7 +68,6 @@
 #include <dspbridge/wmd.h>
 
 /*  ----------------------------------- Platform Manager */
-#include <dspbridge/dev.h>
 #include <dspbridge/chnldefs.h>
 
 /*  ----------------------------------- Resource Manager */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 7822b2a..06314a8 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -101,11 +101,9 @@
 #include <dspbridge/resourcecleanup.h>
 #include <dspbridge/chnl.h>
 #include <dspbridge/proc.h>
-#include <dspbridge/cfg.h>
 #include <dspbridge/dev.h>
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/drv.h>
-#include <dspbridge/dbreg.h>
 #endif
 
 #ifndef DISABLE_BRIDGE_PM
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 5970028..510ae2c 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -149,7 +149,6 @@
 #include <_tiomap.h>
 #include <tiomap_io.h>
 #include <_tiomap_pwr.h>
-#include <tiomap_io.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/cod.h>
-- 
1.5.5.1.357.g1af8b

