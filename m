From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] dsp-bridge: remove unused includes
Date: Fri, 18 Dec 2009 19:44:37 +0200
Message-ID: <1261158277-26402-3-git-send-email-felipe.contreras@gmail.com>
References: <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:37016 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbZLRRpD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:45:03 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so1736234ewy.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:45:03 -0800 (PST)
In-Reply-To: <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    3 ---
 drivers/dsp/bridge/rmgr/proc.c          |    1 -
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    1 -
 3 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 90d4bad..8c804af 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -59,8 +59,6 @@
 #include <linux/moduleparam.h>
 #include <linux/cdev.h>
 
-#include <mach/board-3430sdp.h>
-
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
@@ -97,7 +95,6 @@
 #endif
 
 #ifdef CONFIG_BRIDGE_DVFS
-#include <mach/omap-pm.h>
 #include <mach-omap2/omap3-opp.h>
 #endif
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1ab6181..267f29c 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -142,7 +142,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
 #include <dspbridge/pwr.h>
-#include <mach-omap2/omap3-opp.h>
 
 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 8a0cb02..fd6097d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -67,7 +67,6 @@
 #include <mach-omap2/cm-regbits-34xx.h>
 
 #ifdef CONFIG_PM
-#include <mach/board-3430sdp.h>
 extern s32 dsp_test_sleepstate;
 #endif
 extern struct MAILBOX_CONTEXT mboxsetting;
-- 
1.6.6.rc2.5.g49666

