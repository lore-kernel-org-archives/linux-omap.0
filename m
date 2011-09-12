From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 07/15] OMAP: DSS2: HDMI: clean up edid reading & fix checksum
Date: Mon, 12 Sep 2011 12:13:30 +0300
Message-ID: <1315818818-18733-8-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:53525 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754414Ab1ILJOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:09 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

Clean up reading of EDID by passing direct address to the block being
read, instead of start address of the whole EDID memory area. Rewrite
the loop which reads the EDID.

This also fixes the checksum calculation, which used to calculate the
checksum only for the first block.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    6 +--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   67 +++++++++++++++--------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index acf1022..390cd85b 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -92,8 +92,7 @@ struct ti_hdmi_ip_ops {
 
 	void (*phy_disable)(struct hdmi_ip_data *ip_data);
 
-	int (*read_edid)(struct hdmi_ip_data *ip_data,
-			u8 *pedid, u16 max_length);
+	int (*read_edid)(struct hdmi_ip_data *ip_data, u8 *edid, int len);
 
 	int (*pll_enable)(struct hdmi_ip_data *ip_data);
 
@@ -114,8 +113,7 @@ struct hdmi_ip_data {
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
-int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
-					u8 *pedid, u16 max_length);
+int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data, u8 *edid, int len);
 void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
 int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index ecf854e..e9885dc 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -310,8 +310,8 @@ static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 		u8 *pedid, int ext)
 {
 	void __iomem *base = hdmi_core_sys_base(ip_data);
-	u32 i, j;
-	char checksum = 0;
+	u32 i;
+	char checksum;
 	u32 offset = 0;
 
 	/* HDMI_CORE_DDC_STATUS_IN_PROG */
@@ -354,21 +354,31 @@ static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 		return -EIO;
 	}
 
-	i = ext * 128;
-	j = 0;
-	while (((REG_GET(base, HDMI_CORE_DDC_STATUS, 4, 4) == 1) ||
-		(REG_GET(base, HDMI_CORE_DDC_STATUS, 2, 2) == 0)) &&
-			j < 128) {
+	for (i = 0; i < 0x80; ++i) {
+		int t;
 
-		if (REG_GET(base, HDMI_CORE_DDC_STATUS, 2, 2) == 0) {
-			/* FIFO not empty */
-			pedid[i++] = REG_GET(base, HDMI_CORE_DDC_DATA, 7, 0);
-			j++;
+		/* IN_PROG */
+		if (REG_GET(base, HDMI_CORE_DDC_STATUS, 4, 4) == 0) {
+			DSSERR("operation stopped when reading edid\n");
+			return -EIO;
+		}
+
+		t = 0;
+		/* FIFO_EMPTY */
+		while (REG_GET(base, HDMI_CORE_DDC_STATUS, 2, 2) == 1) {
+			if (t++ > 10000) {
+				DSSERR("timeout reading edid\n");
+				return -ETIMEDOUT;
+			}
+			udelay(1);
 		}
+
+		pedid[i] = REG_GET(base, HDMI_CORE_DDC_DATA, 7, 0);
 	}
 
-	for (j = 0; j < 128; j++)
-		checksum += pedid[j];
+	checksum = 0;
+	for (i = 0; i < 0x80; ++i)
+		checksum += pedid[i];
 
 	if (checksum != 0) {
 		pr_err("E-EDID checksum failed!!\n");
@@ -379,40 +389,31 @@ static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 }
 
 int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
-				u8 *pedid, u16 max_length)
+				u8 *edid, int len)
 {
-	int r = 0, n = 0, i = 0;
-	int max_ext_blocks = (max_length / 128) - 1;
-	int len;
+	int r, l;
+
+	if (len < 128)
+		return -EINVAL;
 
 	r = hdmi_core_ddc_init(ip_data);
 	if (r)
 		return r;
 
-	r = hdmi_core_ddc_edid(ip_data, pedid, 0);
+	r = hdmi_core_ddc_edid(ip_data, edid, 0);
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
-		r = hdmi_core_ddc_edid(ip_data, pedid, i);
+	if (len >= 128 * 2 && edid[0x7e] > 0) {
+		r = hdmi_core_ddc_edid(ip_data, edid + 0x80, 1);
 		if (r)
 			return r;
-		len += 128;
+		l += 128;
 	}
 
-	return len;
+	return l;
 }
 
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
-- 
1.7.4.1

