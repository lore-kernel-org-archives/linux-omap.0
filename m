From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v5 07/10] OMAP4 : DSS2 : HDMI: Add makefile and kconfig changes to enable HDMI in OMAP4
Date: Thu, 10 Mar 2011 16:14:15 +0530
Message-ID: <1299753858-12222-8-git-send-email-mythripk@ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299753858-12222-2-git-send-email-mythripk@ti.com>
 <1299753858-12222-3-git-send-email-mythripk@ti.com>
 <1299753858-12222-4-git-send-email-mythripk@ti.com>
 <1299753858-12222-5-git-send-email-mythripk@ti.com>
 <1299753858-12222-6-git-send-email-mythripk@ti.com>
 <1299753858-12222-7-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59386 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab1CJKu5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:50:57 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AAosNw029894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 04:50:56 -0600
In-Reply-To: <1299753858-12222-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>


Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/Kconfig  |    8 ++++++++
 drivers/video/omap2/dss/Makefile |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index db01473..bfc5da0 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -60,6 +60,14 @@ config OMAP2_DSS_VENC
 	help
 	  OMAP Video Encoder support for S-Video and composite TV-out.
 
+config OMAP4_DSS_HDMI
+	bool "HDMI support"
+	depends on ARCH_OMAP4
+        default y
+	help
+	  HDMI Interface. This adds the High Definition Multimedia Interface.
+	  See http://www.hdmi.org/ for HDMI specification.
+
 config OMAP2_DSS_SDI
 	bool "SDI support"
 	depends on ARCH_OMAP3
diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 7db17b5..10d9d3b 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -5,3 +5,5 @@ omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
+omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
+				    hdmi_omap4_panel.o
-- 
1.5.6.3

