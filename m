From: <mythripk@ti.com>
Subject: [PATCH 04/10] OMAP4: DSS: HDMI: Move HDMI IP independent generic header
Date: Thu, 8 Sep 2011 19:06:21 +0530
Message-ID: <1315488987-4546-5-git-send-email-mythripk@ti.com>
References: <1315488987-4546-1-git-send-email-mythripk@ti.com>
 <1315488987-4546-2-git-send-email-mythripk@ti.com>
 <1315488987-4546-3-git-send-email-mythripk@ti.com>
 <1315488987-4546-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59270 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932900Ab1IHNog (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 09:44:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p88DiWcY013881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 08:44:34 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p88DiVvc003391
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 19:14:31 +0530 (IST)
In-Reply-To: <1315488987-4546-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Some of the header file definitions that are there in the hdmi.h are generic
and can be used across OMAP's, Thus moving generic definition to new file.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.h     |   18 -------
 drivers/video/omap2/dss/hdmi.c    |    1 +
 drivers/video/omap2/dss/hdmi.h    |   53 ---------------------
 drivers/video/omap2/dss/ti_hdmi.h |   94 +++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 71 deletions(-)
 create mode 100644 drivers/video/omap2/dss/ti_hdmi.h

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4cb264e..7c9565f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -150,24 +150,6 @@ struct dsi_clock_info {
 	bool use_sys_clk;
 };
 
-enum hdmi_clk_refsel {
-	HDMI_REFSEL_PCLK = 0,
-	HDMI_REFSEL_REF1 = 1,
-	HDMI_REFSEL_REF2 = 2,
-	HDMI_REFSEL_SYSCLK = 3
-};
-
-/* HDMI PLL structure */
-struct hdmi_pll_info {
-	u16 regn;
-	u16 regm;
-	u32 regmf;
-	u16 regm2;
-	u16 regsd;
-	u16 dcofreq;
-	enum hdmi_clk_refsel refsel;
-};
-
 struct seq_file;
 struct platform_device;
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c387bf4..bf76c87 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -39,6 +39,7 @@
 #include <sound/pcm_params.h>
 #endif
 
+#include "ti_hdmi.h"
 #include "dss.h"
 #include "hdmi.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index 02342f6..cb50f6a 100644
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
 enum hdmi_core_inputbus_width {
 	HDMI_INPUT_8BIT = 0,
 	HDMI_INPUT_10BIT = 1,
@@ -259,11 +232,6 @@ enum hdmi_core_packet_mode {
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
@@ -564,27 +532,6 @@ struct hdmi_video_interface {
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
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
new file mode 100644
index 0000000..f0e508e
--- /dev/null
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -0,0 +1,94 @@
+/*
+ * ti_hdmi.h
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
+#ifndef _TI_HDMI_H
+#define _TI_HDMI_H
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
+enum hdmi_clk_refsel {
+	HDMI_REFSEL_PCLK = 0,
+	HDMI_REFSEL_REF1 = 1,
+	HDMI_REFSEL_REF2 = 2,
+	HDMI_REFSEL_SYSCLK = 3
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
+	enum hdmi_clk_refsel refsel;
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

