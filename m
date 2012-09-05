From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/17] OMAPDSS: remove unnecessary includes
Date: Wed,  5 Sep 2012 11:25:42 +0300
Message-ID: <1346833555-31258-5-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:50258 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756598Ab2IEI0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:21 -0400
Received: by lbbgj3 with SMTP id gj3so189800lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:18 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove unnecessary includes from omapdss.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |    2 --
 drivers/video/omap2/dss/dpi.c     |    1 -
 drivers/video/omap2/dss/dsi.c     |    1 -
 drivers/video/omap2/dss/dss.c     |    1 -
 drivers/video/omap2/dss/overlay.c |    1 -
 drivers/video/omap2/dss/venc.c    |    1 -
 6 files changed, 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0de9a7e..e934abb 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -37,8 +37,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#include <plat/clock.h>
-
 #include <video/omapdss.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 25fb895..99b9851 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -31,7 +31,6 @@
 #include <linux/regulator/consumer.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 254666f..8d815e3 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -41,7 +41,6 @@
 
 #include <video/omapdss.h>
 #include <video/mipi_display.h>
-#include <plat/clock.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 31a553a..759dbee 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -36,7 +36,6 @@
 #include <video/omapdss.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 952c6fa..94e74be 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 4a6caf9..45252cf 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -36,7 +36,6 @@
 #include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 
 #include "dss.h"
 #include "dss_features.h"
-- 
1.7.9.5

