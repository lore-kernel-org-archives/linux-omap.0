From: <mythripk@ti.com>
Subject: [PATCH] OMAPDSS: HDMI: Register definition cleanup and  improvements
Date: Fri, 16 Sep 2011 11:32:21 +0530
Message-ID: <1316152941-20326-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398Ab1IPGK3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 02:10:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8G6APx8009616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 01:10:28 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8G6AOmc004119
	for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 11:40:25 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

1.Add some H/w indexable registers missed in definition.
2.Remove usage of struct hdmi_reg and use u16 instead.
3.Move the avi_infoframe parameters comments above the field.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   10 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |  296 ++++++++++++++---------------
 2 files changed, 151 insertions(+), 155 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index da7fe50..5f22d2e 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -32,15 +32,15 @@
 #include "dss.h"
 
 static inline void hdmi_write_reg(void __iomem *base_addr,
-				const struct hdmi_reg idx, u32 val)
+				const u16 idx, u32 val)
 {
-	__raw_writel(val, base_addr + idx.idx);
+	__raw_writel(val, base_addr + idx);
 }
 
 static inline u32 hdmi_read_reg(void __iomem *base_addr,
-				const struct hdmi_reg idx)
+				const u16 idx)
 {
-	return __raw_readl(base_addr + idx.idx);
+	return __raw_readl(base_addr + idx);
 }
 
 static inline void __iomem *hdmi_wp_base(struct hdmi_ip_data *ip_data)
@@ -69,7 +69,7 @@ static inline void __iomem *hdmi_core_sys_base(struct hdmi_ip_data *ip_data)
 }
 
 static inline int hdmi_wait_for_bit_change(void __iomem *base_addr,
-				const struct hdmi_reg idx,
+				const u16 idx,
 				int b2, int b1, u32 val)
 {
 	u32 t = 0;
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 929de88..2040956 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -30,142 +30,138 @@
 #include <sound/pcm_params.h>
 #endif
 
-struct hdmi_reg { u16 idx; };
-
-#define HDMI_REG(idx)			((const struct hdmi_reg) { idx })
-
 /* HDMI Wrapper */
 
-#define HDMI_WP_REVISION			HDMI_REG(0x0)
-#define HDMI_WP_SYSCONFIG			HDMI_REG(0x10)
-#define HDMI_WP_IRQSTATUS_RAW			HDMI_REG(0x24)
-#define HDMI_WP_IRQSTATUS			HDMI_REG(0x28)
-#define HDMI_WP_PWR_CTRL			HDMI_REG(0x40)
-#define HDMI_WP_IRQENABLE_SET			HDMI_REG(0x2C)
-#define HDMI_WP_VIDEO_CFG			HDMI_REG(0x50)
-#define HDMI_WP_VIDEO_SIZE			HDMI_REG(0x60)
-#define HDMI_WP_VIDEO_TIMING_H			HDMI_REG(0x68)
-#define HDMI_WP_VIDEO_TIMING_V			HDMI_REG(0x6C)
-#define HDMI_WP_WP_CLK				HDMI_REG(0x70)
-#define HDMI_WP_AUDIO_CFG			HDMI_REG(0x80)
-#define HDMI_WP_AUDIO_CFG2			HDMI_REG(0x84)
-#define HDMI_WP_AUDIO_CTRL			HDMI_REG(0x88)
-#define HDMI_WP_AUDIO_DATA			HDMI_REG(0x8C)
+#define HDMI_WP_REVISION			0x0
+#define HDMI_WP_SYSCONFIG			0x10
+#define HDMI_WP_IRQSTATUS_RAW			0x24
+#define HDMI_WP_IRQSTATUS			0x28
+#define HDMI_WP_PWR_CTRL			0x40
+#define HDMI_WP_IRQENABLE_SET			0x2C
+#define HDMI_WP_VIDEO_CFG			0x50
+#define HDMI_WP_VIDEO_SIZE			0x60
+#define HDMI_WP_VIDEO_TIMING_H			0x68
+#define HDMI_WP_VIDEO_TIMING_V			0x6C
+#define HDMI_WP_WP_CLK				0x70
+#define HDMI_WP_AUDIO_CFG			0x80
+#define HDMI_WP_AUDIO_CFG2			0x84
+#define HDMI_WP_AUDIO_CTRL			0x88
+#define HDMI_WP_AUDIO_DATA			0x8C
 
 /* HDMI IP Core System */
 
-#define HDMI_CORE_SYS_VND_IDL			HDMI_REG(0x0)
-#define HDMI_CORE_SYS_DEV_IDL			HDMI_REG(0x8)
-#define HDMI_CORE_SYS_DEV_IDH			HDMI_REG(0xC)
-#define HDMI_CORE_SYS_DEV_REV			HDMI_REG(0x10)
-#define HDMI_CORE_SYS_SRST			HDMI_REG(0x14)
-#define HDMI_CORE_CTRL1				HDMI_REG(0x20)
-#define HDMI_CORE_SYS_SYS_STAT			HDMI_REG(0x24)
-#define HDMI_CORE_SYS_VID_ACEN			HDMI_REG(0x124)
-#define HDMI_CORE_SYS_VID_MODE			HDMI_REG(0x128)
-#define HDMI_CORE_SYS_INTR_STATE		HDMI_REG(0x1C0)
-#define HDMI_CORE_SYS_INTR1			HDMI_REG(0x1C4)
-#define HDMI_CORE_SYS_INTR2			HDMI_REG(0x1C8)
-#define HDMI_CORE_SYS_INTR3			HDMI_REG(0x1CC)
-#define HDMI_CORE_SYS_INTR4			HDMI_REG(0x1D0)
-#define HDMI_CORE_SYS_UMASK1			HDMI_REG(0x1D4)
-#define HDMI_CORE_SYS_TMDS_CTRL			HDMI_REG(0x208)
-#define HDMI_CORE_SYS_DE_DLY			HDMI_REG(0xC8)
-#define HDMI_CORE_SYS_DE_CTRL			HDMI_REG(0xCC)
-#define HDMI_CORE_SYS_DE_TOP			HDMI_REG(0xD0)
-#define HDMI_CORE_SYS_DE_CNTL			HDMI_REG(0xD8)
-#define HDMI_CORE_SYS_DE_CNTH			HDMI_REG(0xDC)
-#define HDMI_CORE_SYS_DE_LINL			HDMI_REG(0xE0)
-#define HDMI_CORE_SYS_DE_LINH_1			HDMI_REG(0xE4)
+#define HDMI_CORE_SYS_VND_IDL			0x0
+#define HDMI_CORE_SYS_DEV_IDL			0x8
+#define HDMI_CORE_SYS_DEV_IDH			0xC
+#define HDMI_CORE_SYS_DEV_REV			0x10
+#define HDMI_CORE_SYS_SRST			0x14
+#define HDMI_CORE_CTRL1				0x20
+#define HDMI_CORE_SYS_SYS_STAT			0x24
+#define HDMI_CORE_SYS_VID_ACEN			0x124
+#define HDMI_CORE_SYS_VID_MODE			0x128
+#define HDMI_CORE_SYS_INTR_STATE		0x1C0
+#define HDMI_CORE_SYS_INTR1			0x1C4
+#define HDMI_CORE_SYS_INTR2			0x1C8
+#define HDMI_CORE_SYS_INTR3			0x1CC
+#define HDMI_CORE_SYS_INTR4			0x1D0
+#define HDMI_CORE_SYS_UMASK1			0x1D4
+#define HDMI_CORE_SYS_TMDS_CTRL			0x208
+#define HDMI_CORE_SYS_DE_DLY			0xC8
+#define HDMI_CORE_SYS_DE_CTRL			0xCC
+#define HDMI_CORE_SYS_DE_TOP			0xD0
+#define HDMI_CORE_SYS_DE_CNTL			0xD8
+#define HDMI_CORE_SYS_DE_CNTH			0xDC
+#define HDMI_CORE_SYS_DE_LINL			0xE0
+#define HDMI_CORE_SYS_DE_LINH_1			0xE4
 #define HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC	0x1
 #define HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC	0x1
 #define HDMI_CORE_CTRL1_BSEL_24BITBUS		0x1
 #define HDMI_CORE_CTRL1_EDGE_RISINGEDGE	0x1
 
 /* HDMI DDC E-DID */
-#define HDMI_CORE_DDC_CMD			HDMI_REG(0x3CC)
-#define HDMI_CORE_DDC_STATUS			HDMI_REG(0x3C8)
-#define HDMI_CORE_DDC_ADDR			HDMI_REG(0x3B4)
-#define HDMI_CORE_DDC_OFFSET			HDMI_REG(0x3BC)
-#define HDMI_CORE_DDC_COUNT1			HDMI_REG(0x3C0)
-#define HDMI_CORE_DDC_COUNT2			HDMI_REG(0x3C4)
-#define HDMI_CORE_DDC_DATA			HDMI_REG(0x3D0)
-#define HDMI_CORE_DDC_SEGM			HDMI_REG(0x3B8)
+#define HDMI_CORE_DDC_CMD			0x3CC
+#define HDMI_CORE_DDC_STATUS			0x3C8
+#define HDMI_CORE_DDC_ADDR			0x3B4
+#define HDMI_CORE_DDC_OFFSET			0x3BC
+#define HDMI_CORE_DDC_COUNT1			0x3C0
+#define HDMI_CORE_DDC_COUNT2			0x3C4
+#define HDMI_CORE_DDC_DATA			0x3D0
+#define HDMI_CORE_DDC_SEGM			0x3B8
 
 /* HDMI IP Core Audio Video */
 
-#define HDMI_CORE_AV_HDMI_CTRL			HDMI_REG(0xBC)
-#define HDMI_CORE_AV_DPD			HDMI_REG(0xF4)
-#define HDMI_CORE_AV_PB_CTRL1			HDMI_REG(0xF8)
-#define HDMI_CORE_AV_PB_CTRL2			HDMI_REG(0xFC)
-#define HDMI_CORE_AV_AVI_TYPE			HDMI_REG(0x100)
-#define HDMI_CORE_AV_AVI_VERS			HDMI_REG(0x104)
-#define HDMI_CORE_AV_AVI_LEN			HDMI_REG(0x108)
-#define HDMI_CORE_AV_AVI_CHSUM			HDMI_REG(0x10C)
-#define HDMI_CORE_AV_AVI_DBYTE(n)		HDMI_REG(n * 4 + 0x110)
-#define HDMI_CORE_AV_AVI_DBYTE_NELEMS		HDMI_REG(15)
-#define HDMI_CORE_AV_SPD_DBYTE			HDMI_REG(0x190)
-#define HDMI_CORE_AV_SPD_DBYTE_NELEMS		HDMI_REG(27)
-#define HDMI_CORE_AV_AUD_DBYTE(n)		HDMI_REG(n * 4 + 0x210)
-#define HDMI_CORE_AV_AUD_DBYTE_NELEMS		HDMI_REG(10)
-#define HDMI_CORE_AV_MPEG_DBYTE			HDMI_REG(0x290)
-#define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		HDMI_REG(27)
-#define HDMI_CORE_AV_GEN_DBYTE			HDMI_REG(0x300)
-#define HDMI_CORE_AV_GEN_DBYTE_NELEMS		HDMI_REG(31)
-#define HDMI_CORE_AV_GEN2_DBYTE			HDMI_REG(0x380)
-#define HDMI_CORE_AV_GEN2_DBYTE_NELEMS		HDMI_REG(31)
-#define HDMI_CORE_AV_ACR_CTRL			HDMI_REG(0x4)
-#define HDMI_CORE_AV_FREQ_SVAL			HDMI_REG(0x8)
-#define HDMI_CORE_AV_N_SVAL1			HDMI_REG(0xC)
-#define HDMI_CORE_AV_N_SVAL2			HDMI_REG(0x10)
-#define HDMI_CORE_AV_N_SVAL3			HDMI_REG(0x14)
-#define HDMI_CORE_AV_CTS_SVAL1			HDMI_REG(0x18)
-#define HDMI_CORE_AV_CTS_SVAL2			HDMI_REG(0x1C)
-#define HDMI_CORE_AV_CTS_SVAL3			HDMI_REG(0x20)
-#define HDMI_CORE_AV_CTS_HVAL1			HDMI_REG(0x24)
-#define HDMI_CORE_AV_CTS_HVAL2			HDMI_REG(0x28)
-#define HDMI_CORE_AV_CTS_HVAL3			HDMI_REG(0x2C)
-#define HDMI_CORE_AV_AUD_MODE			HDMI_REG(0x50)
-#define HDMI_CORE_AV_SPDIF_CTRL			HDMI_REG(0x54)
-#define HDMI_CORE_AV_HW_SPDIF_FS		HDMI_REG(0x60)
-#define HDMI_CORE_AV_SWAP_I2S			HDMI_REG(0x64)
-#define HDMI_CORE_AV_SPDIF_ERTH			HDMI_REG(0x6C)
-#define HDMI_CORE_AV_I2S_IN_MAP			HDMI_REG(0x70)
-#define HDMI_CORE_AV_I2S_IN_CTRL		HDMI_REG(0x74)
-#define HDMI_CORE_AV_I2S_CHST0			HDMI_REG(0x78)
-#define HDMI_CORE_AV_I2S_CHST1			HDMI_REG(0x7C)
-#define HDMI_CORE_AV_I2S_CHST2			HDMI_REG(0x80)
-#define HDMI_CORE_AV_I2S_CHST4			HDMI_REG(0x84)
-#define HDMI_CORE_AV_I2S_CHST5			HDMI_REG(0x88)
-#define HDMI_CORE_AV_ASRC			HDMI_REG(0x8C)
-#define HDMI_CORE_AV_I2S_IN_LEN			HDMI_REG(0x90)
-#define HDMI_CORE_AV_HDMI_CTRL			HDMI_REG(0xBC)
-#define HDMI_CORE_AV_AUDO_TXSTAT		HDMI_REG(0xC0)
-#define HDMI_CORE_AV_AUD_PAR_BUSCLK_1		HDMI_REG(0xCC)
-#define HDMI_CORE_AV_AUD_PAR_BUSCLK_2		HDMI_REG(0xD0)
-#define HDMI_CORE_AV_AUD_PAR_BUSCLK_3		HDMI_REG(0xD4)
-#define HDMI_CORE_AV_TEST_TXCTRL		HDMI_REG(0xF0)
-#define HDMI_CORE_AV_DPD			HDMI_REG(0xF4)
-#define HDMI_CORE_AV_PB_CTRL1			HDMI_REG(0xF8)
-#define HDMI_CORE_AV_PB_CTRL2			HDMI_REG(0xFC)
-#define HDMI_CORE_AV_AVI_TYPE			HDMI_REG(0x100)
-#define HDMI_CORE_AV_AVI_VERS			HDMI_REG(0x104)
-#define HDMI_CORE_AV_AVI_LEN			HDMI_REG(0x108)
-#define HDMI_CORE_AV_AVI_CHSUM			HDMI_REG(0x10C)
-#define HDMI_CORE_AV_SPD_TYPE			HDMI_REG(0x180)
-#define HDMI_CORE_AV_SPD_VERS			HDMI_REG(0x184)
-#define HDMI_CORE_AV_SPD_LEN			HDMI_REG(0x188)
-#define HDMI_CORE_AV_SPD_CHSUM			HDMI_REG(0x18C)
-#define HDMI_CORE_AV_AUDIO_TYPE			HDMI_REG(0x200)
-#define HDMI_CORE_AV_AUDIO_VERS			HDMI_REG(0x204)
-#define HDMI_CORE_AV_AUDIO_LEN			HDMI_REG(0x208)
-#define HDMI_CORE_AV_AUDIO_CHSUM		HDMI_REG(0x20C)
-#define HDMI_CORE_AV_MPEG_TYPE			HDMI_REG(0x280)
-#define HDMI_CORE_AV_MPEG_VERS			HDMI_REG(0x284)
-#define HDMI_CORE_AV_MPEG_LEN			HDMI_REG(0x288)
-#define HDMI_CORE_AV_MPEG_CHSUM			HDMI_REG(0x28C)
-#define HDMI_CORE_AV_CP_BYTE1			HDMI_REG(0x37C)
-#define HDMI_CORE_AV_CEC_ADDR_ID		HDMI_REG(0x3FC)
+#define HDMI_CORE_AV_HDMI_CTRL			0xBC
+#define HDMI_CORE_AV_DPD			0xF4
+#define HDMI_CORE_AV_PB_CTRL1			0xF8
+#define HDMI_CORE_AV_PB_CTRL2			0xFC
+#define HDMI_CORE_AV_AVI_TYPE			0x100
+#define HDMI_CORE_AV_AVI_VERS			0x104
+#define HDMI_CORE_AV_AVI_LEN			0x108
+#define HDMI_CORE_AV_AVI_CHSUM			0x10C
+#define HDMI_CORE_AV_AVI_DBYTE(n)		(n * 4 + 0x110)
+#define HDMI_CORE_AV_AVI_DBYTE_NELEMS		15
+#define HDMI_CORE_AV_SPD_DBYTE(n)		(n * 4 + 0x190)
+#define HDMI_CORE_AV_SPD_DBYTE_NELEMS		27
+#define HDMI_CORE_AV_AUD_DBYTE(n)		(n * 4 + 0x210)
+#define HDMI_CORE_AV_AUD_DBYTE_NELEMS		10
+#define HDMI_CORE_AV_MPEG_DBYTE(n)		(n * 4 + 0x290)
+#define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		27
+#define HDMI_CORE_AV_GEN_DBYTE(n)		(n * 4 + 0x300)
+#define HDMI_CORE_AV_GEN_DBYTE_NELEMS		31
+#define HDMI_CORE_AV_GEN2_DBYTE(n)		(n * 4 + 0x380)
+#define HDMI_CORE_AV_GEN2_DBYTE_NELEMS		31
+#define HDMI_CORE_AV_ACR_CTRL			0x4
+#define HDMI_CORE_AV_FREQ_SVAL			0x8
+#define HDMI_CORE_AV_N_SVAL1			0xC
+#define HDMI_CORE_AV_N_SVAL2			0x10
+#define HDMI_CORE_AV_N_SVAL3			0x14
+#define HDMI_CORE_AV_CTS_SVAL1			0x18
+#define HDMI_CORE_AV_CTS_SVAL2			0x1C
+#define HDMI_CORE_AV_CTS_SVAL3			0x20
+#define HDMI_CORE_AV_CTS_HVAL1			0x24
+#define HDMI_CORE_AV_CTS_HVAL2			0x28
+#define HDMI_CORE_AV_CTS_HVAL3			0x2C
+#define HDMI_CORE_AV_AUD_MODE			0x50
+#define HDMI_CORE_AV_SPDIF_CTRL			0x54
+#define HDMI_CORE_AV_HW_SPDIF_FS		0x60
+#define HDMI_CORE_AV_SWAP_I2S			0x64
+#define HDMI_CORE_AV_SPDIF_ERTH			0x6C
+#define HDMI_CORE_AV_I2S_IN_MAP			0x70
+#define HDMI_CORE_AV_I2S_IN_CTRL		0x74
+#define HDMI_CORE_AV_I2S_CHST0			0x78
+#define HDMI_CORE_AV_I2S_CHST1			0x7C
+#define HDMI_CORE_AV_I2S_CHST2			0x80
+#define HDMI_CORE_AV_I2S_CHST4			0x84
+#define HDMI_CORE_AV_I2S_CHST5			0x88
+#define HDMI_CORE_AV_ASRC			0x8C
+#define HDMI_CORE_AV_I2S_IN_LEN			0x90
+#define HDMI_CORE_AV_HDMI_CTRL			0xBC
+#define HDMI_CORE_AV_AUDO_TXSTAT		0xC0
+#define HDMI_CORE_AV_AUD_PAR_BUSCLK_1		0xCC
+#define HDMI_CORE_AV_AUD_PAR_BUSCLK_2		0xD0
+#define HDMI_CORE_AV_AUD_PAR_BUSCLK_3		0xD4
+#define HDMI_CORE_AV_TEST_TXCTRL		0xF0
+#define HDMI_CORE_AV_DPD			0xF4
+#define HDMI_CORE_AV_PB_CTRL1			0xF8
+#define HDMI_CORE_AV_PB_CTRL2			0xFC
+#define HDMI_CORE_AV_AVI_TYPE			0x100
+#define HDMI_CORE_AV_AVI_VERS			0x104
+#define HDMI_CORE_AV_AVI_LEN			0x108
+#define HDMI_CORE_AV_AVI_CHSUM			0x10C
+#define HDMI_CORE_AV_SPD_TYPE			0x180
+#define HDMI_CORE_AV_SPD_VERS			0x184
+#define HDMI_CORE_AV_SPD_LEN			0x188
+#define HDMI_CORE_AV_SPD_CHSUM			0x18C
+#define HDMI_CORE_AV_AUDIO_TYPE			0x200
+#define HDMI_CORE_AV_AUDIO_VERS			0x204
+#define HDMI_CORE_AV_AUDIO_LEN			0x208
+#define HDMI_CORE_AV_AUDIO_CHSUM		0x20C
+#define HDMI_CORE_AV_MPEG_TYPE			0x280
+#define HDMI_CORE_AV_MPEG_VERS			0x284
+#define HDMI_CORE_AV_MPEG_LEN			0x288
+#define HDMI_CORE_AV_MPEG_CHSUM			0x28C
+#define HDMI_CORE_AV_CP_BYTE1			0x37C
+#define HDMI_CORE_AV_CEC_ADDR_ID		0x3FC
 #define HDMI_CORE_AV_SPD_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_GEN2_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_MPEG_DBYTE_ELSIZE		0x4
@@ -173,20 +169,20 @@ struct hdmi_reg { u16 idx; };
 
 /* PLL */
 
-#define PLLCTRL_PLL_CONTROL			HDMI_REG(0x0)
-#define PLLCTRL_PLL_STATUS			HDMI_REG(0x4)
-#define PLLCTRL_PLL_GO				HDMI_REG(0x8)
-#define PLLCTRL_CFG1				HDMI_REG(0xC)
-#define PLLCTRL_CFG2				HDMI_REG(0x10)
-#define PLLCTRL_CFG3				HDMI_REG(0x14)
-#define PLLCTRL_CFG4				HDMI_REG(0x20)
+#define PLLCTRL_PLL_CONTROL			0x0
+#define PLLCTRL_PLL_STATUS			0x4
+#define PLLCTRL_PLL_GO				0x8
+#define PLLCTRL_CFG1				0xC
+#define PLLCTRL_CFG2				0x10
+#define PLLCTRL_CFG3				0x14
+#define PLLCTRL_CFG4				0x20
 
 /* HDMI PHY */
 
-#define HDMI_TXPHY_TX_CTRL			HDMI_REG(0x0)
-#define HDMI_TXPHY_DIGITAL_CTRL			HDMI_REG(0x4)
-#define HDMI_TXPHY_POWER_CTRL			HDMI_REG(0x8)
-#define HDMI_TXPHY_PAD_CFG_CTRL			HDMI_REG(0xC)
+#define HDMI_TXPHY_TX_CTRL			0x0
+#define HDMI_TXPHY_DIGITAL_CTRL			0x4
+#define HDMI_TXPHY_POWER_CTRL			0x8
+#define HDMI_TXPHY_PAD_CFG_CTRL			0xC
 
 #define REG_FLD_MOD(base, idx, val, start, end) \
 	hdmi_write_reg(base, idx, FLD_MOD(hdmi_read_reg(base, idx),\
@@ -455,40 +451,40 @@ struct hdmi_core_video_config {
  * details about infoframe databytes
  */
 struct hdmi_core_infoframe_avi {
+	/* Y0, Y1 rgb,yCbCr */
 	u8	db1_format;
-		/* Y0, Y1 rgb,yCbCr */
+	/* A0  Active information Present */
 	u8	db1_active_info;
-		/* A0  Active information Present */
+	/* B0, B1 Bar info data valid */
 	u8	db1_bar_info_dv;
-		/* B0, B1 Bar info data valid */
+	/* S0, S1 scan information */
 	u8	db1_scan_info;
-		/* S0, S1 scan information */
+	/* C0, C1 colorimetry */
 	u8	db2_colorimetry;
-		/* C0, C1 colorimetry */
+	/* M0, M1 Aspect ratio (4:3, 16:9) */
 	u8	db2_aspect_ratio;
-		/* M0, M1 Aspect ratio (4:3, 16:9) */
+	/* R0...R3 Active format aspect ratio */
 	u8	db2_active_fmt_ar;
-		/* R0...R3 Active format aspect ratio */
+	/* ITC IT content. */
 	u8	db3_itc;
-		/* ITC IT content. */
+	/* EC0, EC1, EC2 Extended colorimetry */
 	u8	db3_ec;
-		/* EC0, EC1, EC2 Extended colorimetry */
+	/* Q1, Q0 Quantization range */
 	u8	db3_q_range;
-		/* Q1, Q0 Quantization range */
+	/* SC1, SC0 Non-uniform picture scaling */
 	u8	db3_nup_scaling;
-		/* SC1, SC0 Non-uniform picture scaling */
+	/* VIC0..6 Video format identification */
 	u8	db4_videocode;
-		/* VIC0..6 Video format identification */
+	/* PR0..PR3 Pixel repetition factor */
 	u8	db5_pixel_repeat;
-		/* PR0..PR3 Pixel repetition factor */
+	/* Line number end of top bar */
 	u16	db6_7_line_eoftop;
-		/* Line number end of top bar */
+	/* Line number start of bottom bar */
 	u16	db8_9_line_sofbottom;
-		/* Line number start of bottom bar */
+	/* Pixel number end of left bar */
 	u16	db10_11_pixel_eofleft;
-		/* Pixel number end of left bar */
+	/* Pixel number start of right bar */
 	u16	db12_13_pixel_sofright;
-		/* Pixel number start of right bar */
 };
 /*
  * Refer to section 8.2 in HDMI 1.3 specification for
-- 
1.7.5.4

