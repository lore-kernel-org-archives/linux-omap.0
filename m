From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/4] DSPBRIDGE: OSAL: Remove extra include directive
Date: Fri, 22 Jan 2010 21:23:15 -0600
Message-ID: <1264216995-7863-4-git-send-email-omar.ramirez@ti.com>
References: <1264216995-7863-1-git-send-email-omar.ramirez@ti.com>
 <1264216995-7863-2-git-send-email-omar.ramirez@ti.com>
 <1264216995-7863-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45510 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0AWDMx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 22:12:53 -0500
In-Reply-To: <1264216995-7863-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Including the list.h in some files looks redundant. So, remove those lines.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/pmgr/chnl.c         |    1 -
 drivers/dsp/bridge/pmgr/dmm.c          |    1 -
 drivers/dsp/bridge/pmgr/msg.c          |    1 -
 drivers/dsp/bridge/services/cfg.c      |    1 -
 drivers/dsp/bridge/services/services.c |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index fd487f0..e7c39b6 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -31,7 +31,6 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
 
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index cefb520..d5a7275 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -34,7 +34,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/sync.h>
 
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 355470a..5cfeb5b 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -29,7 +29,6 @@
 #include <dspbridge/gt.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 
 /*  ----------------------------------- Mini Driver */
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index ceddfe4..56d03a3 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -30,7 +30,6 @@
 
 /*  ----------------------------------- This */
 #include <dspbridge/cfg.h>
-#include <dspbridge/list.h>
 
 struct DRV_EXT {
 	struct list_head link;
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 1e01c21..c3e11b4 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -29,7 +29,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/dbg.h>
-#include <dspbridge/list.h>
 #include <dspbridge/mem.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/reg.h>
-- 
1.6.2.4

