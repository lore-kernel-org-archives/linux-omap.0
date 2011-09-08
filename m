From: <mythripk@ti.com>
Subject: [PATCH 05/10] OMAP4 : DSS : HDMI : Move the EDID definition from HDMI
Date: Thu, 8 Sep 2011 19:06:22 +0530
Message-ID: <1315488987-4546-6-git-send-email-mythripk@ti.com>
References: <1315488987-4546-1-git-send-email-mythripk@ti.com>
 <1315488987-4546-2-git-send-email-mythripk@ti.com>
 <1315488987-4546-3-git-send-email-mythripk@ti.com>
 <1315488987-4546-4-git-send-email-mythripk@ti.com>
 <1315488987-4546-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59269 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932898Ab1IHNog (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 09:44:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p88DiWXV013882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 08:44:35 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p88DiWA4003399
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 19:14:32 +0530 (IST)
In-Reply-To: <1315488987-4546-5-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Clean up to move the EDID definition from the IP dependent header file to hdmi.c  

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   10 ++++++++++
 drivers/video/omap2/dss/hdmi.h |   10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index bf76c87..96a0ac9 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -50,6 +50,16 @@
 #define HDMI_PLLCTRL		0x200
 #define HDMI_PHY		0x300
 
+/* HDMI EDID Length move this */
+#define HDMI_EDID_MAX_LENGTH			256
+#define EDID_TIMING_DESCRIPTOR_SIZE		0x12
+#define EDID_DESCRIPTOR_BLOCK0_ADDRESS		0x36
+#define EDID_DESCRIPTOR_BLOCK1_ADDRESS		0x80
+#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
+#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
+
+#define OMAP_HDMI_TIMINGS_NB			34
+
 static struct {
 	struct mutex lock;
 	struct omap_display_platform_data *pdata;
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index cb50f6a..2d4a22e 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -182,16 +182,6 @@ struct hdmi_reg { u16 idx; };
 #define HDMI_TXPHY_POWER_CTRL			HDMI_REG(0x8)
 #define HDMI_TXPHY_PAD_CFG_CTRL			HDMI_REG(0xC)
 
-/* HDMI EDID Length  */
-#define HDMI_EDID_MAX_LENGTH			256
-#define EDID_TIMING_DESCRIPTOR_SIZE		0x12
-#define EDID_DESCRIPTOR_BLOCK0_ADDRESS		0x36
-#define EDID_DESCRIPTOR_BLOCK1_ADDRESS		0x80
-#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
-#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
-
-#define OMAP_HDMI_TIMINGS_NB			34
-
 #define REG_FLD_MOD(base, idx, val, start, end) \
 	hdmi_write_reg(base, idx, FLD_MOD(hdmi_read_reg(base, idx),\
 							val, start, end))
-- 
1.7.5.4

