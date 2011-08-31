From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/12] OMAP: DSS2: HDMI: clean up edid reading & fix checksum
Date: Wed, 31 Aug 2011 16:23:18 +0300
Message-ID: <1314797003-17638-8-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:38267 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755753Ab1HaNXs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:48 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Clean up reading of EDID by passing direct address to the block being
read, instead of start address of the whole EDID memory area. Rewrite
the loop which reads the EDID.

This also fixes the checksum calculation, which used to calculate the
checksum only for the first block.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   67 ++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 04ce105..34e05ee 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -414,8 +414,8 @@ static int hdmi_core_ddc_init(void)
 
 static int hdmi_core_ddc_edid(u8 *pedid, int ext)
 {
-	u32 i, j;
-	char checksum = 0;
+	u32 i;
+	char checksum;
 	u32 offset = 0;
 
 	/* HDMI_CORE_DDC_STATUS_IN_PROG */
@@ -457,21 +457,31 @@ static int hdmi_core_ddc_edid(u8 *pedid, int ext)
 		return -EIO;
 	}
 
-	i = ext * 128;
-	j = 0;
-	while (((REG_GET(HDMI_CORE_DDC_STATUS, 4, 4) == 1) ||
-			(REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) == 0)) &&
-			j < 128) {
+	for (i = 0; i < 0x80; ++i) {
+		int t;
 
-		if (REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) == 0) {
-			/* FIFO not empty */
-			pedid[i++] = REG_GET(HDMI_CORE_DDC_DATA, 7, 0);
-			j++;
+		/* IN_PROG */
+		if (REG_GET(HDMI_CORE_DDC_STATUS, 4, 4) == 0) {
+			DSSERR("operation stopped when reading edid\n");
+			return -EIO;
+		}
+
+		t = 0;
+		/* FIFO_EMPTY */
+		while (REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) == 1) {
+			if (t++ > 10000) {
+				DSSERR("timeout reading edid\n");
+				return -ETIMEDOUT;
+			}
+			udelay(1);
 		}
+
+		pedid[i] = REG_GET(HDMI_CORE_DDC_DATA, 7, 0);
 	}
 
-	for (j = 0; j < 128; j++)
-		checksum += pedid[j];
+	checksum = 0;
+	for (i = 0; i < 0x80; ++i)
+		checksum += pedid[i];
 
 	if (checksum != 0) {
 		DSSERR("E-EDID checksum failed!!\n");
@@ -481,40 +491,31 @@ static int hdmi_core_ddc_edid(u8 *pedid, int ext)
 	return 0;
 }
 
-static int read_edid(u8 *pedid, u16 max_length)
+static int read_edid(u8 *edid, int len)
 {
-	int r = 0, n = 0, i = 0;
-	int max_ext_blocks = (max_length / 128) - 1;
-	int len;
+	int r, l;
+
+	if (len < 128)
+		return -EINVAL;
 
 	r = hdmi_core_ddc_init();
 	if (r)
 		return r;
 
-	r = hdmi_core_ddc_edid(pedid, 0);
+	r = hdmi_core_ddc_edid(edid, 0);
 	if (r)
 		return r;
 
-	len = 128;
-	n = pedid[0x7e];
-
-	/*
-	 * README: need to comply with max_length set by the caller.
-	 * Better implementation should be to allocate necessary
-	 * memory to store EDID according to nb_block field found
-	 * in first block
-	 */
-	if (n > max_ext_blocks)
-		n = max_ext_blocks;
+	l = 128;
 
-	for (i = 1; i <= n; i++) {
-		r = hdmi_core_ddc_edid(pedid, i);
+	if (len >= 128 * 2 && edid[0x7e] > 0) {
+		r = hdmi_core_ddc_edid(edid + 0x80, 1);
 		if (r)
 			return r;
-		len += 128;
+		l += 128;
 	}
 
-	return len;
+	return l;
 }
 
 static int get_timings_index(void)
-- 
1.7.4.1

