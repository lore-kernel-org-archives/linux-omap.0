From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/5] OMAP4: DSS2: HDMI: Add DSS feature for CTS calculation
Date: Thu,  5 May 2011 02:01:31 -0500
Message-ID: <1304578894-23967-3-git-send-email-ricardo.neri@ti.com>
References: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40322 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab1EEHB0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 03:01:26 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4571QG0008164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 5 May 2011 02:01:26 -0500
In-Reply-To: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, mythripk@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

CTS and N parameters are used to regenerate the audio clock from
the TMDS clock at the HDMI sink. In  OMAP4430 ES1.0 version
the calculation of the CTS parameter is done by the HDMI IP
(hardware mode) while in others it must be done by the HDMI driver
(software mode). A DSS feature is used to indicate the HDMI
driver which mode is used.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    3 ++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 6c57af4..cfcc12b 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -308,7 +308,8 @@ static struct omap_dss_features omap4_dss_features = {
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
 		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
-		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC,
+		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
+		FEAT_HDMI_CTS_SWMODE,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 12e9c4e..a732c24 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -40,6 +40,7 @@ enum dss_feat_id {
 	/* Independent core clk divider */
 	FEAT_CORE_CLK_DIV	= 1 << 11,
 	FEAT_LCD_CLK_SRC	= 1 << 12,
+	FEAT_HDMI_CTS_SWMODE = 1 << 13,
 };
 
 /* DSS register field id */
-- 
1.7.1

