From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v2 6/8] OMAP4 : DSS : HDMI: Call to HDMI module init to register driver.
Date: Tue,  1 Mar 2011 19:46:26 +0530
Message-ID: <1298988988-28429-7-git-send-email-mythripk@ti.com>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54311 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab1CANtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 08:49:53 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21Dnrf8008026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 07:49:53 -0600
In-Reply-To: <1298988988-28429-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

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

