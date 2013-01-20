From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH] ARM: OMAP2+: fix build break for omapdrm
Date: Sun, 20 Jan 2013 09:37:23 -0600
Message-ID: <1358696243-3604-1-git-send-email-robdclark@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49047 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab3ATPnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jan 2013 10:43:06 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so5249483obc.29
        for <linux-omap@vger.kernel.org>; Sun, 20 Jan 2013 07:43:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Tony Lindgren <tony@atomide.com>, Rob Clark <robdclark@gmail.com>

Fixes compile break with 3.8-rc4.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 arch/arm/mach-omap2/drm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 4c7566c..2a2cfa8 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/omap_drm.h>
 
+#include "soc.h"
 #include "omap_device.h"
 #include "omap_hwmod.h"
 
@@ -56,7 +57,7 @@ static int __init omap_init_drm(void)
 			oh->name);
 	}
 
-	platform_data.omaprev = GET_OMAP_REVISION();
+	platform_data.omaprev = GET_OMAP_TYPE;
 
 	return platform_device_register(&omap_drm_device);
 
-- 
1.8.1

