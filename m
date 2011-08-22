From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] OMAP: DSS2: Remove "EXPERIMENTAL" from Kconfig
Date: Mon, 22 Aug 2011 11:27:16 +0300
Message-ID: <1314001636-18036-5-git-send-email-tomi.valkeinen@ti.com>
References: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:32877 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755573Ab1HVI1i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:27:38 -0400
In-Reply-To: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS driver has not been "experimental" for many years now, so perhaps
it's time to remove the text from Kconfig titles.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig    |    2 +-
 drivers/video/omap2/omapfb/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 0d12524..7be7c06 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -1,5 +1,5 @@
 menuconfig OMAP2_DSS
-        tristate "OMAP2+ Display Subsystem support (EXPERIMENTAL)"
+        tristate "OMAP2+ Display Subsystem support"
         depends on ARCH_OMAP2PLUS
         help
 	  OMAP2+ Display Subsystem support.
diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index aa33386..83d3fe7 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -1,5 +1,5 @@
 menuconfig FB_OMAP2
-        tristate "OMAP2+ frame buffer support (EXPERIMENTAL)"
+        tristate "OMAP2+ frame buffer support"
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
-- 
1.7.4.1

