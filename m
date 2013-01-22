From: Archit Taneja <archit@ti.com>
Subject: [PATCH] arm: omap: Fix build break in drm.c
Date: Tue, 22 Jan 2013 13:58:47 +0530
Message-ID: <1358843328-8178-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56644 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab3AVI3V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 03:29:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

Building omapdrm leads to a build break because of a missing include needed
for the macro GET_OMAP_REVISION(). Add the missing inlclude.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/drm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 4c7566c..6b1a8df 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/omap_drm.h>
 
+#include "soc.h"
 #include "omap_device.h"
 #include "omap_hwmod.h"
 
-- 
1.7.9.5

