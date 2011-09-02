From: <mythripk@ti.com>
Subject: [PATCH v3 08/10] OMAP4: DSS: HDMI: Move the common HDMI header file
Date: Fri, 2 Sep 2011 16:17:48 +0530
Message-ID: <1314960470-2616-9-git-send-email-mythripk@ti.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com>
 <1314960470-2616-3-git-send-email-mythripk@ti.com>
 <1314960470-2616-4-git-send-email-mythripk@ti.com>
 <1314960470-2616-5-git-send-email-mythripk@ti.com>
 <1314960470-2616-6-git-send-email-mythripk@ti.com>
 <1314960470-2616-7-git-send-email-mythripk@ti.com>
 <1314960470-2616-8-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55351 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933410Ab1IBK4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 06:56:01 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p82AtvtU027241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 05:56:00 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p82AturM016844
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 16:25:57 +0530 (IST)
In-Reply-To: <1314960470-2616-8-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Some of the header file definitions of HDMI IP are needed by audio driver thus
moving the common defintion to more generic location Include/video.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c                     |    2 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h          |    2 +-
 .../video/omap2/dss => include/video}/ti_hdmi.h    |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {drivers/video/omap2/dss => include/video}/ti_hdmi.h (100%)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b6ec4d7..1b989b3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -33,13 +33,13 @@
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <video/omapdss.h>
+#include <video/ti_hdmi.h>
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #endif
 
-#include "ti_hdmi.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 7feead1..d988c10 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -23,7 +23,7 @@
 
 #include <linux/string.h>
 #include <video/omapdss.h>
-#include "ti_hdmi.h"
+#include <video/ti_hdmi.h>
 
 struct hdmi_reg { u16 idx; };
 
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/include/video/ti_hdmi.h
similarity index 100%
rename from drivers/video/omap2/dss/ti_hdmi.h
rename to include/video/ti_hdmi.h
-- 
1.7.5.4

