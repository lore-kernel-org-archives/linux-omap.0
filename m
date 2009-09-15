From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv3.1 4/4] DSPBRIDGE: OSAL: Remove extra include directive
Date: Tue, 15 Sep 2009 10:28:35 +0300
Message-ID: <1252999715-19470-4-git-send-email-andy.shevchenko@gmail.com>
References: <1252411936-25722-1-git-send-email-andy.shevchenko@gmail.com>
 <1252999715-19470-1-git-send-email-andy.shevchenko@gmail.com>
 <1252999715-19470-2-git-send-email-andy.shevchenko@gmail.com>
 <1252999715-19470-3-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60846 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758160AbZIOH3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2009 03:29:05 -0400
In-Reply-To: <1252999715-19470-3-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, x0095840@ti.com, hiroshi.doyu@nokia.com, omar.ramirez@ti.com
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Including the list.h in some files looks redundant. So, remove those lines.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/pmgr/chnl.c         |    1 -
 drivers/dsp/bridge/pmgr/dmm.c          |    1 -
 drivers/dsp/bridge/pmgr/msg.c          |    1 -
 drivers/dsp/bridge/services/services.c |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 6b5a0d9..4c9bd2b 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -78,7 +78,6 @@
 #include <dspbridge/cfg.h>
 #include <dspbridge/csl.h>
 #include <dspbridge/dpc.h>
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
 
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index f878855..2cbe2e8 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -67,7 +67,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
 
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index d9e4fc6..732a91b 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -48,7 +48,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 
 /*  ----------------------------------- Mini Driver */
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index b68c165..218425c 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -48,7 +48,6 @@
 #include <dspbridge/dbg.h>
 #include <dspbridge/dpc.h>
 #include <dspbridge/kfile.h>
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/reg.h>
-- 
1.5.6.5

