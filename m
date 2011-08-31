From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/12] OMAP: DSS2: HDMI: split hdmi_core_ddc_edid
Date: Wed, 31 Aug 2011 16:23:17 +0300
Message-ID: <1314797003-17638-7-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:45341 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755757Ab1HaNYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:24:00 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Split the DDC initialization off from hdmi_core_ddc_edid() into a
separate function hdmi_core_ddc_init().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   67 +++++++++++++++++++++++++++-------------
 1 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b5aca64..04ce105 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -366,12 +366,8 @@ static void hdmi_phy_off(void)
 	hdmi_set_phy_pwr(HDMI_PHYPWRCMD_OFF);
 }
 
-static int hdmi_core_ddc_edid(u8 *pedid, int ext)
+static int hdmi_core_ddc_init(void)
 {
-	u32 i, j;
-	char checksum = 0;
-	u32 offset = 0;
-
 	/* Turn on CLK for DDC */
 	REG_FLD_MOD(HDMI_CORE_AV_DPD, 0x7, 2, 0);
 
@@ -382,32 +378,55 @@ static int hdmi_core_ddc_edid(u8 *pedid, int ext)
 	 */
 	usleep_range(800, 1000);
 
-	if (!ext) {
-		/* Clk SCL Devices */
-		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3, 0);
+	/* IN_PROG */
+	if (REG_GET(HDMI_CORE_DDC_STATUS, 4, 4) == 1) {
+		/* Abort transaction */
+		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xf, 3, 0);
 
-		/* HDMI_CORE_DDC_STATUS_IN_PROG */
+		/* IN_PROG */
 		if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS,
-						4, 4, 0) != 0) {
-			DSSERR("Failed to program DDC\n");
+					4, 4, 0) != 0) {
+			DSSERR("Timeout aborting DDC transaction\n");
 			return -ETIMEDOUT;
 		}
+	}
 
-		/* Clear FIFO */
-		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
+	/* Clk SCL Devices */
+	REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3, 0);
 
-		/* HDMI_CORE_DDC_STATUS_IN_PROG */
-		if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS,
-						4, 4, 0) != 0) {
-			DSSERR("Failed to program DDC\n");
-			return -ETIMEDOUT;
-		}
+	/* HDMI_CORE_DDC_STATUS_IN_PROG */
+	if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS, 4, 4, 0) != 0) {
+		DSSERR("Timeout starting SCL clock\n");
+		return -ETIMEDOUT;
+	}
 
-	} else {
-		if (ext % 2 != 0)
-			offset = 0x80;
+	/* Clear FIFO */
+	REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
+
+	/* HDMI_CORE_DDC_STATUS_IN_PROG */
+	if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS, 4, 4, 0) != 0) {
+		DSSERR("Timeout clearing DDC fifo\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int hdmi_core_ddc_edid(u8 *pedid, int ext)
+{
+	u32 i, j;
+	char checksum = 0;
+	u32 offset = 0;
+
+	/* HDMI_CORE_DDC_STATUS_IN_PROG */
+	if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS, 4, 4, 0) != 0) {
+		DSSERR("Timeout waiting DDC to be ready\n");
+		return -ETIMEDOUT;
 	}
 
+	if (ext % 2 != 0)
+		offset = 0x80;
+
 	/* Load Segment Address Register */
 	REG_FLD_MOD(HDMI_CORE_DDC_SEGM, ext/2, 7, 0);
 
@@ -468,6 +487,10 @@ static int read_edid(u8 *pedid, u16 max_length)
 	int max_ext_blocks = (max_length / 128) - 1;
 	int len;
 
+	r = hdmi_core_ddc_init();
+	if (r)
+		return r;
+
 	r = hdmi_core_ddc_edid(pedid, 0);
 	if (r)
 		return r;
-- 
1.7.4.1

