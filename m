From: Archit Taneja <archit@ti.com>
Subject: [PATCH 5/7] OMAPDSS: HDMI: OMAP4: Rename the HDMI_CORE_CTRL1 register
Date: Fri, 13 Sep 2013 15:59:36 +0530
Message-ID: <1379068178-17312-6-git-send-email-archit@ti.com>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57027 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab3IMKar (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Sep 2013 06:30:47 -0400
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>, Archit Taneja <archit@ti.com>

From: Ricardo Neri <ricardo.neri@ti.com>

Rename the register to be aligned with the HDMI_CORE_SYS naming convention.
Also, update the naming of the #defines used for its fields.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | 16 ++++++++--------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 11 ++++++-----
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 46af726..ad5b820 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -527,7 +527,7 @@ static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
 static void hdmi_core_powerdown_disable(struct hdmi_ip_data *ip_data)
 {
 	pr_debug("Enter hdmi_core_powerdown_disable\n");
-	REG_FLD_MOD(hdmi_core_sys_base(ip_data), HDMI_CORE_CTRL1, 0x0, 0, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data), HDMI_CORE_SYS_SYS_CTRL1, 0x0, 0, 0);
 }
 
 static void hdmi_core_swreset_release(struct hdmi_ip_data *ip_data)
@@ -550,12 +550,12 @@ static void hdmi_core_video_config(struct hdmi_ip_data *ip_data,
 	void __iomem *core_sys_base = hdmi_core_sys_base(ip_data);
 
 	/* sys_ctrl1 default configuration not tunable */
-	r = hdmi_read_reg(core_sys_base, HDMI_CORE_CTRL1);
-	r = FLD_MOD(r, HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC, 5, 5);
-	r = FLD_MOD(r, HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC, 4, 4);
-	r = FLD_MOD(r, HDMI_CORE_CTRL1_BSEL_24BITBUS, 2, 2);
-	r = FLD_MOD(r, HDMI_CORE_CTRL1_EDGE_RISINGEDGE, 1, 1);
-	hdmi_write_reg(core_sys_base, HDMI_CORE_CTRL1, r);
+	r = hdmi_read_reg(core_sys_base, HDMI_CORE_SYS_SYS_CTRL1);
+	r = FLD_MOD(r, HDMI_CORE_SYS_SYS_CTRL1_VEN_FOLLOWVSYNC, 5, 5);
+	r = FLD_MOD(r, HDMI_CORE_SYS_SYS_CTRL1_HEN_FOLLOWHSYNC, 4, 4);
+	r = FLD_MOD(r, HDMI_CORE_SYS_SYS_CTRL1_BSEL_24BITBUS, 2, 2);
+	r = FLD_MOD(r, HDMI_CORE_SYS_SYS_CTRL1_EDGE_RISINGEDGE, 1, 1);
+	hdmi_write_reg(core_sys_base, HDMI_CORE_SYS_SYS_CTRL1, r);
 
 	REG_FLD_MOD(core_sys_base,
 			HDMI_CORE_SYS_VID_ACEN, cfg->ip_bus_width, 7, 6);
@@ -909,7 +909,7 @@ void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPCORE(HDMI_CORE_SYS_DEV_IDH);
 	DUMPCORE(HDMI_CORE_SYS_DEV_REV);
 	DUMPCORE(HDMI_CORE_SYS_SRST);
-	DUMPCORE(HDMI_CORE_CTRL1);
+	DUMPCORE(HDMI_CORE_SYS_SYS_CTRL1);
 	DUMPCORE(HDMI_CORE_SYS_SYS_STAT);
 	DUMPCORE(HDMI_CORE_SYS_DE_DLY);
 	DUMPCORE(HDMI_CORE_SYS_DE_CTRL);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index d1a2315..149abd8 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -53,7 +53,7 @@
 #define HDMI_CORE_SYS_DEV_IDH			0xC
 #define HDMI_CORE_SYS_DEV_REV			0x10
 #define HDMI_CORE_SYS_SRST			0x14
-#define HDMI_CORE_CTRL1				0x20
+#define HDMI_CORE_SYS_SYS_CTRL1			0x20
 #define HDMI_CORE_SYS_SYS_STAT			0x24
 #define HDMI_CORE_SYS_DE_DLY			0xC8
 #define HDMI_CORE_SYS_DE_CTRL			0xCC
@@ -72,10 +72,11 @@
 #define HDMI_CORE_SYS_UMASK1			0x1D4
 #define HDMI_CORE_SYS_TMDS_CTRL			0x208
 
-#define HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC	0x1
-#define HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC	0x1
-#define HDMI_CORE_CTRL1_BSEL_24BITBUS	0x1
-#define HDMI_CORE_CTRL1_EDGE_RISINGEDGE	0x1
+/* value definitions for HDMI_CORE_SYS_SYS_CTRL1 fields */
+#define HDMI_CORE_SYS_SYS_CTRL1_VEN_FOLLOWVSYNC	0x1
+#define HDMI_CORE_SYS_SYS_CTRL1_HEN_FOLLOWHSYNC	0x1
+#define HDMI_CORE_SYS_SYS_CTRL1_BSEL_24BITBUS	0x1
+#define HDMI_CORE_SYS_SYS_CTRL1_EDGE_RISINGEDGE	0x1
 
 /* HDMI DDC E-DID */
 #define HDMI_CORE_DDC_ADDR			0x3B4
-- 
1.8.1.2

