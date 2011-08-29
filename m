From: <mythripk@ti.com>
Subject: [PATCH v2 04/10] OMAP4: DSS: HDMI: Move the common header file
Date: Mon, 29 Aug 2011 11:44:54 +0530
Message-ID: <1314598500-24005-5-git-send-email-mythripk@ti.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com>
 <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44200 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab1H2GXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 02:23:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T6N9gG003001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 01:23:11 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T6N8bU021125
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:53:09 +0530 (IST)
In-Reply-To: <1314598500-24005-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Some of the header file definitions of HDMI IP are needed by audio driver thus
moving the common defintion to more generic Include/video.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.h  |   10 -----
 drivers/video/omap2/dss/hdmi.c |    1 +
 drivers/video/omap2/dss/hdmi.h |   53 ------------------------
 include/video/omaphdmi.h       |   86 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 63 deletions(-)
 create mode 100644 include/video/omaphdmi.h

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a095a62..7c9565f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -150,16 +150,6 @@ struct dsi_clock_info {
 	bool use_sys_clk;
 };
 
-/* HDMI PLL structure */
-struct hdmi_pll_info {
-	u16 regn;
-	u16 regm;
-	u32 regmf;
-	u16 regm2;
-	u16 regsd;
-	u16 dcofreq;
-};
-
 struct seq_file;
 struct platform_device;
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index ba1ad06..39d1a7e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -33,6 +33,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <video/omapdss.h>
+#include <video/omaphdmi.h>
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 #include <sound/soc.h>
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index 7046ff3..0a3342b 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -198,39 +198,12 @@ struct hdmi_reg { u16 idx; };
 #define REG_GET(base, idx, start, end) \
 	FLD_GET(hdmi_read_reg(base, idx), start, end)
 
-struct hdmi_video_timings {
-	u16 x_res;
-	u16 y_res;
-	/* Unit: KHz */
-	u32 pixel_clock;
-	u16 hsw;
-	u16 hfp;
-	u16 hbp;
-	u16 vsw;
-	u16 vfp;
-	u16 vbp;
-};
-
-/* HDMI timing structure */
-struct hdmi_timings {
-	struct hdmi_video_timings timings;
-	int vsync_pol;
-	int hsync_pol;
-};
-
 enum hdmi_phy_pwr {
 	HDMI_PHYPWRCMD_OFF = 0,
 	HDMI_PHYPWRCMD_LDOON = 1,
 	HDMI_PHYPWRCMD_TXON = 2
 };
 
-enum hdmi_pll_pwr {
-	HDMI_PLLPWRCMD_ALLOFF = 0,
-	HDMI_PLLPWRCMD_PLLONLY = 1,
-	HDMI_PLLPWRCMD_BOTHON_ALLCLKS = 2,
-	HDMI_PLLPWRCMD_BOTHON_NOPHYCLK = 3
-};
-
 enum hdmi_clk_refsel {
 	HDMI_REFSEL_PCLK = 0,
 	HDMI_REFSEL_REF1 = 1,
@@ -266,11 +239,6 @@ enum hdmi_core_packet_mode {
 	HDMI_PACKETMODE48BITPERPIXEL = 7
 };
 
-enum hdmi_core_hdmi_dvi {
-	HDMI_DVI = 0,
-	HDMI_HDMI = 1
-};
-
 enum hdmi_core_tclkselclkmult {
 	HDMI_FPLL05IDCK = 0,
 	HDMI_FPLL10IDCK = 1,
@@ -571,27 +539,6 @@ struct hdmi_video_interface {
 	int	tm;	/* Timing mode */
 };
 
-struct hdmi_cm {
-	int	code;
-	int	mode;
-};
-
-struct hdmi_config {
-	struct hdmi_timings timings;
-	u16	interlace;
-	struct hdmi_cm cm;
-};
-
-struct hdmi_ip_data {
-	void __iomem	*base_wp;	/* HDMI wrapper */
-	unsigned long	core_sys_offset;
-	unsigned long	core_av_offset;
-	unsigned long	pll_offset;
-	unsigned long	phy_offset;
-	struct hdmi_config cfg;
-	struct hdmi_pll_info pll_data;
-};
-
 struct hdmi_audio_format {
 	enum hdmi_stereo_channels		stereo_channels;
 	u8					active_chnnls_msk;
diff --git a/include/video/omaphdmi.h b/include/video/omaphdmi.h
new file mode 100644
index 0000000..bd51529
--- /dev/null
+++ b/include/video/omaphdmi.h
@@ -0,0 +1,86 @@
+/*
+ * omaphdmi.h
+ *
+ * HDMI driver definition for TI OMAP4, DM81xx, DM38xx  Processor.
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _OMAP_OMAPHDMI_H
+#define _OMAP_OMAPHDMI_H
+
+enum hdmi_pll_pwr {
+	HDMI_PLLPWRCMD_ALLOFF = 0,
+	HDMI_PLLPWRCMD_PLLONLY = 1,
+	HDMI_PLLPWRCMD_BOTHON_ALLCLKS = 2,
+	HDMI_PLLPWRCMD_BOTHON_NOPHYCLK = 3
+};
+
+enum hdmi_core_hdmi_dvi {
+	HDMI_DVI = 0,
+	HDMI_HDMI = 1
+};
+
+struct hdmi_video_timings {
+	u16 x_res;
+	u16 y_res;
+	/* Unit: KHz */
+	u32 pixel_clock;
+	u16 hsw;
+	u16 hfp;
+	u16 hbp;
+	u16 vsw;
+	u16 vfp;
+	u16 vbp;
+};
+
+/* HDMI timing structure */
+struct hdmi_timings {
+	struct hdmi_video_timings timings;
+	int vsync_pol;
+	int hsync_pol;
+};
+
+struct hdmi_cm {
+	int	code;
+	int	mode;
+};
+
+struct hdmi_config {
+	struct hdmi_timings timings;
+	u16	interlace;
+	struct hdmi_cm cm;
+};
+
+/* HDMI PLL structure */
+struct hdmi_pll_info {
+	u16 regn;
+	u16 regm;
+	u32 regmf;
+	u16 regm2;
+	u16 regsd;
+	u16 dcofreq;
+};
+
+struct hdmi_ip_data {
+	void __iomem	*base_wp;	/* HDMI wrapper */
+	unsigned long	core_sys_offset;
+	unsigned long	core_av_offset;
+	unsigned long	pll_offset;
+	unsigned long	phy_offset;
+	struct hdmi_config cfg;
+	struct hdmi_pll_info pll_data;
+};
+#endif
-- 
1.7.5.4

