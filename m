From: <mythripk@ti.com>
Subject: [PATCH v2 10/10] OMAP4: DSS: Rename hdmi_omap4_panel.c to hdmi_panel.c
Date: Mon, 29 Aug 2011 11:45:00 +0530
Message-ID: <1314598500-24005-11-git-send-email-mythripk@ti.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com>
 <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com>
 <1314598500-24005-5-git-send-email-mythripk@ti.com>
 <1314598500-24005-6-git-send-email-mythripk@ti.com>
 <1314598500-24005-7-git-send-email-mythripk@ti.com>
 <1314598500-24005-8-git-send-email-mythripk@ti.com>
 <1314598500-24005-9-git-send-email-mythripk@ti.com>
 <1314598500-24005-10-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44208 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1H2GXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 02:23:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T6NA6Y003010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 01:23:12 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T6NA3d021168
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:53:10 +0530 (IST)
In-Reply-To: <1314598500-24005-10-git-send-email-mythripk@ti.com>
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
 .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (100%)

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 3ffe98f..5fd9ed4 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -6,4 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
-				    hdmi_omap4_panel.o hdmi_ti_4xxx_ip.o
+				    hdmi_panel.o hdmi_ti_4xxx_ip.o
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
similarity index 100%
rename from drivers/video/omap2/dss/hdmi_omap4_panel.c
rename to drivers/video/omap2/dss/hdmi_panel.c
-- 
1.7.5.4

