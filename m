From: <mythripk@ti.com>
Subject: [PATCH v3 10/10] OMAP4: DSS: Rename hdmi_omap4_panel.c to hdmi_panel.c
Date: Fri, 2 Sep 2011 16:17:50 +0530
Message-ID: <1314960470-2616-11-git-send-email-mythripk@ti.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com>
 <1314960470-2616-3-git-send-email-mythripk@ti.com>
 <1314960470-2616-4-git-send-email-mythripk@ti.com>
 <1314960470-2616-5-git-send-email-mythripk@ti.com>
 <1314960470-2616-6-git-send-email-mythripk@ti.com>
 <1314960470-2616-7-git-send-email-mythripk@ti.com>
 <1314960470-2616-8-git-send-email-mythripk@ti.com>
 <1314960470-2616-9-git-send-email-mythripk@ti.com>
 <1314960470-2616-10-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55367 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933427Ab1IBK4C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 06:56:02 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p82Atwvo008247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 05:56:00 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p82AtvnU016876
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 16:25:58 +0530 (IST)
In-Reply-To: <1314960470-2616-10-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

As the panel driver will remain generic across OMAP's renaming it to
hdmi_panel.c

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/Makefile                   |    2 +-
 .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (99%)

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 9627829..bd34ac5 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -6,4 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
-				    hdmi_omap4_panel.o ti_hdmi_4xxx_ip.o
+				    hdmi_panel.o ti_hdmi_4xxx_ip.o
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
similarity index 99%
rename from drivers/video/omap2/dss/hdmi_omap4_panel.c
rename to drivers/video/omap2/dss/hdmi_panel.c
index 7d4f2bd..e30182f 100644
--- a/drivers/video/omap2/dss/hdmi_omap4_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -1,5 +1,5 @@
 /*
- * hdmi_omap4_panel.c
+ * hdmi_panel.c
  *
  * HDMI library support functions for TI OMAP4 processors.
  *
-- 
1.7.5.4

