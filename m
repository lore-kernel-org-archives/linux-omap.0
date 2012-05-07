From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/2] OMAPDSS: HDMI: define and dump CORE registers in correct order
Date: Mon, 7 May 2012 18:50:28 +0530
Message-ID: <1336396828-29311-3-git-send-email-archit@ti.com>
References: <1336396828-29311-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58904 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639Ab2EGNVU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 09:21:20 -0400
In-Reply-To: <1336396828-29311-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The HDMI core register offset macros aren't defined in ascending order of their
values, some of the offset macros are also redefined. The same issues occur when
these core registers are dumped.

Clean up the ordering of HDMI core registers and remove repeated registers in
the definition in ti_hdmi_4xxx_ip.h and in ti_hdmi_4xxx_core_dump().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   65 +++++++++++++++--------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   57 +++++++++++--------------
 2 files changed, 59 insertions(+), 63 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index e266b8e..8fc09d4 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -900,6 +900,13 @@ void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPCORE(HDMI_CORE_SYS_SRST);
 	DUMPCORE(HDMI_CORE_CTRL1);
 	DUMPCORE(HDMI_CORE_SYS_SYS_STAT);
+	DUMPCORE(HDMI_CORE_SYS_DE_DLY);
+	DUMPCORE(HDMI_CORE_SYS_DE_CTRL);
+	DUMPCORE(HDMI_CORE_SYS_DE_TOP);
+	DUMPCORE(HDMI_CORE_SYS_DE_CNTL);
+	DUMPCORE(HDMI_CORE_SYS_DE_CNTH);
+	DUMPCORE(HDMI_CORE_SYS_DE_LINL);
+	DUMPCORE(HDMI_CORE_SYS_DE_LINH_1);
 	DUMPCORE(HDMI_CORE_SYS_VID_ACEN);
 	DUMPCORE(HDMI_CORE_SYS_VID_MODE);
 	DUMPCORE(HDMI_CORE_SYS_INTR_STATE);
@@ -909,49 +916,20 @@ void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPCORE(HDMI_CORE_SYS_INTR4);
 	DUMPCORE(HDMI_CORE_SYS_UMASK1);
 	DUMPCORE(HDMI_CORE_SYS_TMDS_CTRL);
-	DUMPCORE(HDMI_CORE_SYS_DE_DLY);
-	DUMPCORE(HDMI_CORE_SYS_DE_CTRL);
-	DUMPCORE(HDMI_CORE_SYS_DE_TOP);
-	DUMPCORE(HDMI_CORE_SYS_DE_CNTL);
-	DUMPCORE(HDMI_CORE_SYS_DE_CNTH);
-	DUMPCORE(HDMI_CORE_SYS_DE_LINL);
-	DUMPCORE(HDMI_CORE_SYS_DE_LINH_1);
 
-	DUMPCORE(HDMI_CORE_DDC_CMD);
-	DUMPCORE(HDMI_CORE_DDC_STATUS);
 	DUMPCORE(HDMI_CORE_DDC_ADDR);
+	DUMPCORE(HDMI_CORE_DDC_SEGM);
 	DUMPCORE(HDMI_CORE_DDC_OFFSET);
 	DUMPCORE(HDMI_CORE_DDC_COUNT1);
 	DUMPCORE(HDMI_CORE_DDC_COUNT2);
+	DUMPCORE(HDMI_CORE_DDC_STATUS);
+	DUMPCORE(HDMI_CORE_DDC_CMD);
 	DUMPCORE(HDMI_CORE_DDC_DATA);
-	DUMPCORE(HDMI_CORE_DDC_SEGM);
 
-	DUMPCOREAV(HDMI_CORE_AV_HDMI_CTRL);
-	DUMPCOREAV(HDMI_CORE_AV_DPD);
-	DUMPCOREAV(HDMI_CORE_AV_PB_CTRL1);
-	DUMPCOREAV(HDMI_CORE_AV_PB_CTRL2);
-	DUMPCOREAV(HDMI_CORE_AV_AVI_TYPE);
-	DUMPCOREAV(HDMI_CORE_AV_AVI_VERS);
-	DUMPCOREAV(HDMI_CORE_AV_AVI_LEN);
-	DUMPCOREAV(HDMI_CORE_AV_AVI_CHSUM);
 
-	for (i = 0; i < HDMI_CORE_AV_AVI_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_AVI_DBYTE);
 
-	for (i = 0; i < HDMI_CORE_AV_SPD_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_SPD_DBYTE);
 
-	for (i = 0; i < HDMI_CORE_AV_AUD_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_AUD_DBYTE);
-
-	for (i = 0; i < HDMI_CORE_AV_MPEG_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_MPEG_DBYTE);
 
-	for (i = 0; i < HDMI_CORE_AV_GEN_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_GEN_DBYTE);
-
-	for (i = 0; i < HDMI_CORE_AV_GEN2_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_GEN2_DBYTE);
 
 	DUMPCOREAV(HDMI_CORE_AV_ACR_CTRL);
 	DUMPCOREAV(HDMI_CORE_AV_FREQ_SVAL);
@@ -991,19 +969,42 @@ void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPCOREAV(HDMI_CORE_AV_AVI_VERS);
 	DUMPCOREAV(HDMI_CORE_AV_AVI_LEN);
 	DUMPCOREAV(HDMI_CORE_AV_AVI_CHSUM);
+
+	for (i = 0; i < HDMI_CORE_AV_AVI_DBYTE_NELEMS; i++)
+		DUMPCOREAV2(i, HDMI_CORE_AV_AVI_DBYTE);
+
 	DUMPCOREAV(HDMI_CORE_AV_SPD_TYPE);
 	DUMPCOREAV(HDMI_CORE_AV_SPD_VERS);
 	DUMPCOREAV(HDMI_CORE_AV_SPD_LEN);
 	DUMPCOREAV(HDMI_CORE_AV_SPD_CHSUM);
+
+	for (i = 0; i < HDMI_CORE_AV_SPD_DBYTE_NELEMS; i++)
+		DUMPCOREAV2(i, HDMI_CORE_AV_SPD_DBYTE);
+
 	DUMPCOREAV(HDMI_CORE_AV_AUDIO_TYPE);
 	DUMPCOREAV(HDMI_CORE_AV_AUDIO_VERS);
 	DUMPCOREAV(HDMI_CORE_AV_AUDIO_LEN);
 	DUMPCOREAV(HDMI_CORE_AV_AUDIO_CHSUM);
+
+	for (i = 0; i < HDMI_CORE_AV_AUD_DBYTE_NELEMS; i++)
+		DUMPCOREAV2(i, HDMI_CORE_AV_AUD_DBYTE);
+
 	DUMPCOREAV(HDMI_CORE_AV_MPEG_TYPE);
 	DUMPCOREAV(HDMI_CORE_AV_MPEG_VERS);
 	DUMPCOREAV(HDMI_CORE_AV_MPEG_LEN);
 	DUMPCOREAV(HDMI_CORE_AV_MPEG_CHSUM);
+
+	for (i = 0; i < HDMI_CORE_AV_MPEG_DBYTE_NELEMS; i++)
+		DUMPCOREAV2(i, HDMI_CORE_AV_MPEG_DBYTE);
+
+	for (i = 0; i < HDMI_CORE_AV_GEN_DBYTE_NELEMS; i++)
+		DUMPCOREAV2(i, HDMI_CORE_AV_GEN_DBYTE);
+
 	DUMPCOREAV(HDMI_CORE_AV_CP_BYTE1);
+
+	for (i = 0; i < HDMI_CORE_AV_GEN2_DBYTE_NELEMS; i++)
+		DUMPCOREAV2(i, HDMI_CORE_AV_GEN2_DBYTE);
+
 	DUMPCOREAV(HDMI_CORE_AV_CEC_ADDR_ID);
 }
 
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index a14d1a0..b724bc6 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -57,6 +57,13 @@
 #define HDMI_CORE_SYS_SRST			0x14
 #define HDMI_CORE_CTRL1				0x20
 #define HDMI_CORE_SYS_SYS_STAT			0x24
+#define HDMI_CORE_SYS_DE_DLY			0xC8
+#define HDMI_CORE_SYS_DE_CTRL			0xCC
+#define HDMI_CORE_SYS_DE_TOP			0xD0
+#define HDMI_CORE_SYS_DE_CNTL			0xD8
+#define HDMI_CORE_SYS_DE_CNTH			0xDC
+#define HDMI_CORE_SYS_DE_LINL			0xE0
+#define HDMI_CORE_SYS_DE_LINH_1			0xE4
 #define HDMI_CORE_SYS_VID_ACEN			0x124
 #define HDMI_CORE_SYS_VID_MODE			0x128
 #define HDMI_CORE_SYS_INTR_STATE		0x1C0
@@ -66,50 +73,24 @@
 #define HDMI_CORE_SYS_INTR4			0x1D0
 #define HDMI_CORE_SYS_UMASK1			0x1D4
 #define HDMI_CORE_SYS_TMDS_CTRL			0x208
-#define HDMI_CORE_SYS_DE_DLY			0xC8
-#define HDMI_CORE_SYS_DE_CTRL			0xCC
-#define HDMI_CORE_SYS_DE_TOP			0xD0
-#define HDMI_CORE_SYS_DE_CNTL			0xD8
-#define HDMI_CORE_SYS_DE_CNTH			0xDC
-#define HDMI_CORE_SYS_DE_LINL			0xE0
-#define HDMI_CORE_SYS_DE_LINH_1			0xE4
+
 #define HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC	0x1
 #define HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC	0x1
-#define HDMI_CORE_CTRL1_BSEL_24BITBUS		0x1
+#define HDMI_CORE_CTRL1_BSEL_24BITBUS	0x1
 #define HDMI_CORE_CTRL1_EDGE_RISINGEDGE	0x1
 
 /* HDMI DDC E-DID */
-#define HDMI_CORE_DDC_CMD			0x3CC
-#define HDMI_CORE_DDC_STATUS			0x3C8
 #define HDMI_CORE_DDC_ADDR			0x3B4
+#define HDMI_CORE_DDC_SEGM			0x3B8
 #define HDMI_CORE_DDC_OFFSET			0x3BC
 #define HDMI_CORE_DDC_COUNT1			0x3C0
 #define HDMI_CORE_DDC_COUNT2			0x3C4
+#define HDMI_CORE_DDC_STATUS			0x3C8
+#define HDMI_CORE_DDC_CMD			0x3CC
 #define HDMI_CORE_DDC_DATA			0x3D0
-#define HDMI_CORE_DDC_SEGM			0x3B8
 
 /* HDMI IP Core Audio Video */
 
-#define HDMI_CORE_AV_HDMI_CTRL			0xBC
-#define HDMI_CORE_AV_DPD			0xF4
-#define HDMI_CORE_AV_PB_CTRL1			0xF8
-#define HDMI_CORE_AV_PB_CTRL2			0xFC
-#define HDMI_CORE_AV_AVI_TYPE			0x100
-#define HDMI_CORE_AV_AVI_VERS			0x104
-#define HDMI_CORE_AV_AVI_LEN			0x108
-#define HDMI_CORE_AV_AVI_CHSUM			0x10C
-#define HDMI_CORE_AV_AVI_DBYTE(n)		(n * 4 + 0x110)
-#define HDMI_CORE_AV_AVI_DBYTE_NELEMS		15
-#define HDMI_CORE_AV_SPD_DBYTE(n)		(n * 4 + 0x190)
-#define HDMI_CORE_AV_SPD_DBYTE_NELEMS		27
-#define HDMI_CORE_AV_AUD_DBYTE(n)		(n * 4 + 0x210)
-#define HDMI_CORE_AV_AUD_DBYTE_NELEMS		10
-#define HDMI_CORE_AV_MPEG_DBYTE(n)		(n * 4 + 0x290)
-#define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		27
-#define HDMI_CORE_AV_GEN_DBYTE(n)		(n * 4 + 0x300)
-#define HDMI_CORE_AV_GEN_DBYTE_NELEMS		31
-#define HDMI_CORE_AV_GEN2_DBYTE(n)		(n * 4 + 0x380)
-#define HDMI_CORE_AV_GEN2_DBYTE_NELEMS		31
 #define HDMI_CORE_AV_ACR_CTRL			0x4
 #define HDMI_CORE_AV_FREQ_SVAL			0x8
 #define HDMI_CORE_AV_N_SVAL1			0xC
@@ -148,25 +129,39 @@
 #define HDMI_CORE_AV_AVI_VERS			0x104
 #define HDMI_CORE_AV_AVI_LEN			0x108
 #define HDMI_CORE_AV_AVI_CHSUM			0x10C
+#define HDMI_CORE_AV_AVI_DBYTE(n)		(n * 4 + 0x110)
 #define HDMI_CORE_AV_SPD_TYPE			0x180
 #define HDMI_CORE_AV_SPD_VERS			0x184
 #define HDMI_CORE_AV_SPD_LEN			0x188
 #define HDMI_CORE_AV_SPD_CHSUM			0x18C
+#define HDMI_CORE_AV_SPD_DBYTE(n)		(n * 4 + 0x190)
 #define HDMI_CORE_AV_AUDIO_TYPE			0x200
 #define HDMI_CORE_AV_AUDIO_VERS			0x204
 #define HDMI_CORE_AV_AUDIO_LEN			0x208
 #define HDMI_CORE_AV_AUDIO_CHSUM		0x20C
+#define HDMI_CORE_AV_AUD_DBYTE(n)		(n * 4 + 0x210)
 #define HDMI_CORE_AV_MPEG_TYPE			0x280
 #define HDMI_CORE_AV_MPEG_VERS			0x284
 #define HDMI_CORE_AV_MPEG_LEN			0x288
 #define HDMI_CORE_AV_MPEG_CHSUM			0x28C
+#define HDMI_CORE_AV_MPEG_DBYTE(n)		(n * 4 + 0x290)
+#define HDMI_CORE_AV_GEN_DBYTE(n)		(n * 4 + 0x300)
 #define HDMI_CORE_AV_CP_BYTE1			0x37C
+#define HDMI_CORE_AV_GEN2_DBYTE(n)		(n * 4 + 0x380)
 #define HDMI_CORE_AV_CEC_ADDR_ID		0x3FC
+
 #define HDMI_CORE_AV_SPD_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_GEN2_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_MPEG_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_GEN_DBYTE_ELSIZE		0x4
 
+#define HDMI_CORE_AV_AVI_DBYTE_NELEMS		15
+#define HDMI_CORE_AV_SPD_DBYTE_NELEMS		27
+#define HDMI_CORE_AV_AUD_DBYTE_NELEMS		10
+#define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		27
+#define HDMI_CORE_AV_GEN_DBYTE_NELEMS		31
+#define HDMI_CORE_AV_GEN2_DBYTE_NELEMS		31
+
 /* PLL */
 
 #define PLLCTRL_PLL_CONTROL			0x0
-- 
1.7.5.4

