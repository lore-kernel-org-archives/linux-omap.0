From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 4/8] OMAP4: DSS: HDMI: Move the common header file definition
Date: Fri, 17 Jun 2011 13:47:13 +0530
Message-ID: <1308298637-29753-5-git-send-email-mythripk@ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
 <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43631 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757964Ab1FQIYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 04:24:22 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5H8OJDk019494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 03:24:21 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5H8OIpY001777
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 13:54:19 +0530 (IST)
In-Reply-To: <1308298637-29753-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Some of the header file definitions of HDMI IP are needed by audio driver thus
moving the common defintion to more generic Include/video.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.h   |   10 -----
 drivers/video/omap2/dss/hdmi.c  |    1 +
 drivers/video/omap2/dss/hdmi.h  |   51 -----------------------
 include/video/hdmi_ti_4xxx_ip.h |   84 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 61 deletions(-)
 create mode 100644 include/video/hdmi_ti_4xxx_ip.h

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ce17a61..324e982 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -156,16 +156,6 @@ struct dsi_clock_info {
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
index c24d573..1f34f63 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -33,6 +33,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <video/omapdss.h>
+#include <video/hdmi_ti_4xxx_ip.h>
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 #include <sound/soc.h>
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index dcc30b7..4b0fab3 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -188,39 +188,12 @@ struct hdmi_reg { u16 idx; };
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
@@ -256,11 +229,6 @@ enum hdmi_core_packet_mode {
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
@@ -561,25 +529,6 @@ struct hdmi_video_interface {
 	int	tm;	/* Timing mode */
 };
 
-struct hdmi_ip_data {
-	void __iomem	*base_wp;	/* HDMI wrapper */
-	unsigned long	hdmi_core_sys_offset;
-	unsigned long	hdmi_core_av_offset;
-	unsigned long	hdmi_pll_offset;
-	unsigned long	hdmi_phy_offset;
-};
-
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
 struct hdmi_audio_format {
 	enum hdmi_stereo_channels		stereo_channels;
 	u8					active_chnnls_msk;
diff --git a/include/video/hdmi_ti_4xxx_ip.h b/include/video/hdmi_ti_4xxx_ip.h
new file mode 100644
index 0000000..49640cd
--- /dev/null
+++ b/include/video/hdmi_ti_4xxx_ip.h
@@ -0,0 +1,84 @@
+/*
+ * hdmi_ti_4xxx_ip.h
+ *
+ * HDMI driver definition for TI OMAP4, TI81xx, TI38xx  Processor.
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
+#ifndef _HDMI_TI_4xxx_
+#define _HDMI_TI_4xxx_
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
+struct hdmi_ip_data {
+	void __iomem	*base_wp;	/* HDMI wrapper */
+	unsigned long	hdmi_core_sys_offset;
+	unsigned long	hdmi_core_av_offset;
+	unsigned long	hdmi_pll_offset;
+	unsigned long	hdmi_phy_offset;
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
+#endif
-- 
1.7.5.4

