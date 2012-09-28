From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/6] OMAPDSS: remove <plat/cpu.h> includes
Date: Fri, 28 Sep 2012 13:35:27 +0300
Message-ID: <1348828527-13309-7-git-send-email-tomi.valkeinen@ti.com>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35409 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757106Ab2I1KgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:36:00 -0400
Received: by lagh6 with SMTP id h6so966786lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:35:57 -0700 (PDT)
In-Reply-To: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <a0393947@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?UTF-8?q?Rapha=C3=ABl=20Ass=C3=A9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

cpu_is_* calls are no longer used in omapdss, so the includes for
<plat/cpu.h> can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c          |    2 --
 drivers/video/omap2/dss/dss_features.c |    1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2e74eef..363852a 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -35,8 +35,6 @@
 
 #include <video/omapdss.h>
 
-#include <plat/cpu.h>
-
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index e2c2e2b..3e8287c 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 
 #include "dss.h"
 #include "dss_features.h"
-- 
1.7.9.5

