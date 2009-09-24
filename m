From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] dspbridge: Remove duplicates
Date: Thu, 24 Sep 2009 14:47:52 +0300
Message-ID: <1253792872-32294-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25368 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbZIXLsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 07:48:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

includecheck found few duplicates. So, clean up them.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/disp.c          |    1 -
 drivers/dsp/bridge/rmgr/drv_interface.c |    1 -
 drivers/dsp/bridge/rmgr/proc.c          |    1 -
 drivers/dsp/bridge/wmd/io_sm.c          |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index d6ddf6e..0645398 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -59,7 +59,6 @@
 #include <dspbridge/dbc.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/dev.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
 
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index f68978a..0f70257 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -93,7 +93,6 @@
 #include <dspbridge/resourcecleanup.h>
 #include <dspbridge/chnl.h>
 #include <dspbridge/proc.h>
-#include <dspbridge/cfg.h>
 #include <dspbridge/dev.h>
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/drv.h>
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index c3add40..c720f79 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -138,7 +138,6 @@
 #include <dspbridge/dbdcd.h>
 #include <dspbridge/msg.h>
 #include <dspbridge/wmdioctl.h>
-#include <dspbridge/drv.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 1d478ad..fefa065 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -77,7 +77,6 @@
 #include <_tiomap.h>
 #include <tiomap_io.h>
 #include <_tiomap_pwr.h>
-#include <tiomap_io.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/cod.h>
-- 
1.5.6.5

