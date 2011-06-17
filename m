From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 2/8] OMAP4 : DSS : HDMI : Move the EDID portion from HDMI IP
Date: Fri, 17 Jun 2011 13:47:11 +0530
Message-ID: <1308298637-29753-3-git-send-email-mythripk@ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39669 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757740Ab1FQIYT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 04:24:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5H8OGDJ028708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 03:24:18 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5H8OFfo001757
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 13:54:15 +0530 (IST)
In-Reply-To: <1308298637-29753-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Clean up to move the EDID definition to hdmi.c from the header file which is IP
dependent.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   10 ++++++++++
 drivers/video/omap2/dss/hdmi.h |   10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 1d16ee2..4ee879a 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -49,6 +49,16 @@
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
index 2281823..f57ef4a 100644
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

