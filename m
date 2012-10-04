From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: Fix wrong include for McPDM
Date: Thu,  4 Oct 2012 11:15:08 +0300
Message-ID: <1349338509-3440-2-git-send-email-peter.ujfalusi@ti.com>
References: <1349338509-3440-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:50791 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755363Ab2JDIOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 04:14:04 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so188314obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 01:14:02 -0700 (PDT)
In-Reply-To: <1349338509-3440-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

McPDM needs platt/cpu.h for omap_rev and not omap_hwmod.h.
Drivers must not include omap_hwmod.h at, it will be
private to mach-omap2 soon. Fix the problem before other
drivers will also start including omap_hwmod.h.

Note that also plat/cpu.h will be going away, so the
omap_rev check needs to be replaced with mcpdm-watchdog
flag from platform_data or DT.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/omap/omap-mcpdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 7755650..fdf655e 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -40,7 +40,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/omap_hwmod.h>
+#include <plat/cpu.h>
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
-- 
1.7.12

