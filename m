From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v5 08/10] OMAP4 : DSS : HDMI: Call to HDMI module init to register driver.
Date: Thu, 10 Mar 2011 16:14:16 +0530
Message-ID: <1299753858-12222-9-git-send-email-mythripk@ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299753858-12222-2-git-send-email-mythripk@ti.com>
 <1299753858-12222-3-git-send-email-mythripk@ti.com>
 <1299753858-12222-4-git-send-email-mythripk@ti.com>
 <1299753858-12222-5-git-send-email-mythripk@ti.com>
 <1299753858-12222-6-git-send-email-mythripk@ti.com>
 <1299753858-12222-7-git-send-email-mythripk@ti.com>
 <1299753858-12222-8-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59388 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab1CJKu5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:50:57 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AAosZQ029896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 04:50:56 -0600
In-Reply-To: <1299753858-12222-8-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

calling the platform registration of HDMI driver from core
during initialization.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index c2f930b..1aa2ed1 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -209,6 +209,12 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_dsi;
 	}
 
+	r = hdmi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize hdmi\n");
+		goto err_hdmi;
+	}
+
 	r = dss_initialize_debugfs();
 	if (r)
 		goto err_debugfs;
@@ -238,6 +244,8 @@ static int omap_dss_probe(struct platform_device *pdev)
 err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
+	hdmi_uninit_platform_driver();
+err_hdmi:
 	dsi_uninit_platform_driver();
 err_dsi:
 	venc_uninit_platform_driver();
@@ -263,6 +271,7 @@ static int omap_dss_remove(struct platform_device *pdev)
 	dispc_uninit_platform_driver();
 	rfbi_uninit_platform_driver();
 	dsi_uninit_platform_driver();
+	hdmi_uninit_platform_driver();
 	dss_uninit_platform_driver();
 
 	dss_uninit_overlays(pdev);
-- 
1.5.6.3

