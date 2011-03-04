From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v3 7/9] OMAP4 : DSS : HDMI: Call to HDMI module init to register driver.
Date: Fri,  4 Mar 2011 13:18:25 +0530
Message-ID: <1299224907-11354-8-git-send-email-mythripk@ti.com>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40214 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758960Ab1CDHss (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 02:48:48 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p247mjoa018855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 01:48:47 -0600
In-Reply-To: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

calling the platform registration of HDMI driver from core during initialization.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 3c4ad3a..e08bfef 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -229,6 +229,12 @@ static int omap_dss_probe(struct platform_device *pdev)
 		}
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
@@ -258,6 +264,8 @@ static int omap_dss_probe(struct platform_device *pdev)
 err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
+	hdmi_uninit_platform_driver();
+err_hdmi:
 	if (cpu_is_omap34xx())
 		dsi_uninit_platform_driver();
 err_dsi:
-- 
1.5.6.3

