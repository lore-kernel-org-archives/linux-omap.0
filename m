From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 03/15] tidspbridge: remove unused stuff
Date: Wed, 18 Mar 2009 03:22:59 +0200
Message-ID: <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56149 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524AbZCRBYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:08 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so321490bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:06 -0700 (PDT)
In-Reply-To: <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 6755944..58234d2 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -12,42 +12,22 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#include <dspbridge/host_os.h>
-#include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
 
-#include <dspbridge/dbg.h>
-
 #include <dspbridge/cfg.h>
 #include <dspbridge/drv.h>
-#include <dspbridge/util.h>
-
-#include <dspbridge/wmd.h>
-
-#include <dspbridge/wcd.h>
 #include <dspbridge/dev.h>
 
-#include <hw_defs.h>
-#include <hw_mbox.h>
+#include <dspbridge/dbg.h>
 
 #include "_tiomap.h"
-#include <dspbridge/chnl_sm.h>
 #include "_tiomap_pwr.h"
 
 #ifdef CONFIG_BRIDGE_DVFS
 extern struct platform_device omap_dspbridge_dev;
 #endif
 
-#ifndef DEBUG
-#define TIHELEN_INT_TIMEOUT     1
-#define LOOP_COUNT              1000000
-#endif
-
-extern struct MAILBOX_CONTEXT mboxsetting;
-extern DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT
-					     *pDevContext, IN void *pArgs);
-
 DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
-- 
1.6.2.1.287.g9a8be

