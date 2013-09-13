From: Archit Taneja <archit@ti.com>
Subject: [PATCH 6/7] OMAPDSS: HDMI: OMAP4: Complete register definitions for core
Date: Fri, 13 Sep 2013 15:59:37 +0530
Message-ID: <1379068178-17312-7-git-send-email-archit@ti.com>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43421 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab3IMKau (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Sep 2013 06:30:50 -0400
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>, Archit Taneja <archit@ti.com>

From: Ricardo Neri <ricardo.neri@ti.com>

Add missing register definitions; mainly for colorspace conversion, video
timing and interrupt handling.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 48 ++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 149abd8..b25269c 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -55,6 +55,8 @@
 #define HDMI_CORE_SYS_SRST			0x14
 #define HDMI_CORE_SYS_SYS_CTRL1			0x20
 #define HDMI_CORE_SYS_SYS_STAT			0x24
+#define HDMI_CORE_SYS_SYS_CTRL3			0x28
+#define HDMI_CORE_SYS_DCTL			0x34
 #define HDMI_CORE_SYS_DE_DLY			0xC8
 #define HDMI_CORE_SYS_DE_CTRL			0xCC
 #define HDMI_CORE_SYS_DE_TOP			0xD0
@@ -62,14 +64,58 @@
 #define HDMI_CORE_SYS_DE_CNTH			0xDC
 #define HDMI_CORE_SYS_DE_LINL			0xE0
 #define HDMI_CORE_SYS_DE_LINH_1			0xE4
+#define HDMI_CORE_SYS_HRES_L			0xE8
+#define HDMI_CORE_SYS_HRES_H			0xEC
+#define HDMI_CORE_SYS_VRES_L			0xF0
+#define HDMI_CORE_SYS_VRES_H			0xF4
+#define HDMI_CORE_SYS_IADJUST			0xF8
+#define HDMI_CORE_SYS_POLDETECT			0xFC
+#define HDMI_CORE_SYS_HWIDTH1			0x110
+#define HDMI_CORE_SYS_HWIDTH2			0x114
+#define HDMI_CORE_SYS_VWIDTH			0x11C
+#define HDMI_CORE_SYS_VID_CTRL			0x120
 #define HDMI_CORE_SYS_VID_ACEN			0x124
 #define HDMI_CORE_SYS_VID_MODE			0x128
+#define HDMI_CORE_SYS_VID_BLANK1		0x12C
+#define HDMI_CORE_SYS_VID_BLANK2		0x130
+#define HDMI_CORE_SYS_VID_BLANK3		0x134
+#define HDMI_CORE_SYS_DC_HEADER			0x138
+#define HDMI_CORE_SYS_VID_DITHER		0x13C
+#define HDMI_CORE_SYS_RGB2XVYCC_CT		0x140
+#define HDMI_CORE_SYS_R2Y_COEFF_LOW		0x144
+#define HDMI_CORE_SYS_R2Y_COEFF_UP		0x148
+#define HDMI_CORE_SYS_G2Y_COEFF_LOW		0x14C
+#define HDMI_CORE_SYS_G2Y_COEFF_UP		0x150
+#define HDMI_CORE_SYS_B2Y_COEFF_LOW		0x154
+#define HDMI_CORE_SYS_B2Y_COEFF_UP		0x158
+#define HDMI_CORE_SYS_R2CB_COEFF_LOW		0x15C
+#define HDMI_CORE_SYS_R2CB_COEFF_UP		0x160
+#define HDMI_CORE_SYS_G2CB_COEFF_LOW		0x164
+#define HDMI_CORE_SYS_G2CB_COEFF_UP		0x168
+#define HDMI_CORE_SYS_B2CB_COEFF_LOW		0x16C
+#define HDMI_CORE_SYS_B2CB_COEFF_UP		0x170
+#define HDMI_CORE_SYS_R2CR_COEFF_LOW		0x174
+#define HDMI_CORE_SYS_R2CR_COEFF_UP		0x178
+#define HDMI_CORE_SYS_G2CR_COEFF_LOW		0x17C
+#define HDMI_CORE_SYS_G2CR_COEFF_UP		0x180
+#define HDMI_CORE_SYS_B2CR_COEFF_LOW		0x184
+#define HDMI_CORE_SYS_B2CR_COEFF_UP		0x188
+#define HDMI_CORE_SYS_RGB_OFFSET_LOW		0x18C
+#define HDMI_CORE_SYS_RGB_OFFSET_UP		0x190
+#define HDMI_CORE_SYS_Y_OFFSET_LOW		0x194
+#define HDMI_CORE_SYS_Y_OFFSET_UP		0x198
+#define HDMI_CORE_SYS_CBCR_OFFSET_LOW		0x19C
+#define HDMI_CORE_SYS_CBCR_OFFSET_UP		0x1A0
 #define HDMI_CORE_SYS_INTR_STATE		0x1C0
 #define HDMI_CORE_SYS_INTR1			0x1C4
 #define HDMI_CORE_SYS_INTR2			0x1C8
 #define HDMI_CORE_SYS_INTR3			0x1CC
 #define HDMI_CORE_SYS_INTR4			0x1D0
-#define HDMI_CORE_SYS_UMASK1			0x1D4
+#define HDMI_CORE_SYS_INTR_UNMASK1		0x1D4
+#define HDMI_CORE_SYS_INTR_UNMASK2		0x1D8
+#define HDMI_CORE_SYS_INTR_UNMASK3		0x1DC
+#define HDMI_CORE_SYS_INTR_UNMASK4		0x1E0
+#define HDMI_CORE_SYS_INTR_CTRL			0x1E4
 #define HDMI_CORE_SYS_TMDS_CTRL			0x208
 
 /* value definitions for HDMI_CORE_SYS_SYS_CTRL1 fields */
-- 
1.8.1.2

