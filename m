From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 06/15] OMAP: DSS2: HDMI: split hdmi_core_ddc_edid
Date: Mon, 12 Sep 2011 12:13:29 +0300
Message-ID: <1315818818-18733-7-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:40683 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754346Ab1ILJOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:06 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

Split the DDC initialization off from hdmi_core_ddc_edid() into a
separate function hdmi_core_ddc_init(). This cleans up the
implementation.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  117 ++++++++++++++++------------
 1 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index d4cdfc2..ecf854e 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -264,92 +264,105 @@ void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
 
-static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
-						u8 *pedid, int ext)
+static int hdmi_core_ddc_init(struct hdmi_ip_data *ip_data)
 {
-	u32 i, j;
-	char checksum = 0;
-	u32 offset = 0;
-	void __iomem *core_sys_base = hdmi_core_sys_base(ip_data);
+	void __iomem *base = hdmi_core_sys_base(ip_data);
 
 	/* Turn on CLK for DDC */
-	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_DPD, 0x7, 2, 0);
+	REG_FLD_MOD(base, HDMI_CORE_AV_DPD, 0x7, 2, 0);
+
+	/* IN_PROG */
+	if (REG_GET(base, HDMI_CORE_DDC_STATUS, 4, 4) == 1) {
+		/* Abort transaction */
+		REG_FLD_MOD(base, HDMI_CORE_DDC_CMD, 0xf, 3, 0);
+		/* IN_PROG */
+		if (hdmi_wait_for_bit_change(base, HDMI_CORE_DDC_STATUS,
+					4, 4, 0) != 0) {
+			DSSERR("Timeout aborting DDC transaction\n");
+			return -ETIMEDOUT;
+		}
+	}
 
-	/*
-	 * SW HACK : Without the Delay DDC(i2c bus) reads 0 values /
-	 * right shifted values( The behavior is not consistent and seen only
-	 * with some TV's)
-	 */
-	usleep_range(800, 1000);
+	/* Clk SCL Devices */
+	REG_FLD_MOD(base, HDMI_CORE_DDC_CMD, 0xA, 3, 0);
+
+	/* HDMI_CORE_DDC_STATUS_IN_PROG */
+	if (hdmi_wait_for_bit_change(base, HDMI_CORE_DDC_STATUS,
+				4, 4, 0) != 0) {
+		DSSERR("Timeout starting SCL clock\n");
+		return -ETIMEDOUT;
+	}
 
-	if (!ext) {
-		/* Clk SCL Devices */
-		REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_CMD, 0xA, 3, 0);
+	/* Clear FIFO */
+	REG_FLD_MOD(base, HDMI_CORE_DDC_CMD, 0x9, 3, 0);
 
-		/* HDMI_CORE_DDC_STATUS_IN_PROG */
-		if (hdmi_wait_for_bit_change(core_sys_base,
-					HDMI_CORE_DDC_STATUS, 4, 4, 0) != 0) {
-			pr_err("Failed to program DDC\n");
-			return -ETIMEDOUT;
-		}
+	/* HDMI_CORE_DDC_STATUS_IN_PROG */
+	if (hdmi_wait_for_bit_change(base, HDMI_CORE_DDC_STATUS,
+				4, 4, 0) != 0) {
+		DSSERR("Timeout clearing DDC fifo\n");
+		return -ETIMEDOUT;
+	}
 
-		/* Clear FIFO */
-		REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_CMD, 0x9, 3, 0);
+	return 0;
+}
 
-		/* HDMI_CORE_DDC_STATUS_IN_PROG */
-		if (hdmi_wait_for_bit_change(core_sys_base,
-					HDMI_CORE_DDC_STATUS, 4, 4, 0) != 0) {
-			pr_err("Failed to program DDC\n");
-			return -ETIMEDOUT;
-		}
+static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
+		u8 *pedid, int ext)
+{
+	void __iomem *base = hdmi_core_sys_base(ip_data);
+	u32 i, j;
+	char checksum = 0;
+	u32 offset = 0;
 
-	} else {
-		if (ext % 2 != 0)
-			offset = 0x80;
+	/* HDMI_CORE_DDC_STATUS_IN_PROG */
+	if (hdmi_wait_for_bit_change(base, HDMI_CORE_DDC_STATUS,
+				4, 4, 0) != 0) {
+		DSSERR("Timeout waiting DDC to be ready\n");
+		return -ETIMEDOUT;
 	}
 
+	if (ext % 2 != 0)
+		offset = 0x80;
+
 	/* Load Segment Address Register */
-	REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_SEGM, ext/2, 7, 0);
+	REG_FLD_MOD(base, HDMI_CORE_DDC_SEGM, ext / 2, 7, 0);
 
 	/* Load Slave Address Register */
-	REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
+	REG_FLD_MOD(base, HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
 
 	/* Load Offset Address Register */
-	REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_OFFSET, offset, 7, 0);
+	REG_FLD_MOD(base, HDMI_CORE_DDC_OFFSET, offset, 7, 0);
 
 	/* Load Byte Count */
-	REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_COUNT1, 0x80, 7, 0);
-	REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_COUNT2, 0x0, 1, 0);
+	REG_FLD_MOD(base, HDMI_CORE_DDC_COUNT1, 0x80, 7, 0);
+	REG_FLD_MOD(base, HDMI_CORE_DDC_COUNT2, 0x0, 1, 0);
 
 	/* Set DDC_CMD */
 	if (ext)
-		REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_CMD, 0x4, 3, 0);
+		REG_FLD_MOD(base, HDMI_CORE_DDC_CMD, 0x4, 3, 0);
 	else
-		REG_FLD_MOD(core_sys_base, HDMI_CORE_DDC_CMD, 0x2, 3, 0);
+		REG_FLD_MOD(base, HDMI_CORE_DDC_CMD, 0x2, 3, 0);
 
 	/* HDMI_CORE_DDC_STATUS_BUS_LOW */
-	if (REG_GET(core_sys_base,
-					HDMI_CORE_DDC_STATUS, 6, 6) == 1) {
+	if (REG_GET(base, HDMI_CORE_DDC_STATUS, 6, 6) == 1) {
 		pr_err("I2C Bus Low?\n");
 		return -EIO;
 	}
 	/* HDMI_CORE_DDC_STATUS_NO_ACK */
-	if (REG_GET(core_sys_base,
-					HDMI_CORE_DDC_STATUS, 5, 5) == 1) {
+	if (REG_GET(base, HDMI_CORE_DDC_STATUS, 5, 5) == 1) {
 		pr_err("I2C No Ack\n");
 		return -EIO;
 	}
 
 	i = ext * 128;
 	j = 0;
-	while (((REG_GET(core_sys_base, HDMI_CORE_DDC_STATUS, 4, 4) == 1) ||
-			(REG_GET(core_sys_base,
-			HDMI_CORE_DDC_STATUS, 2, 2) == 0)) && j < 128) {
+	while (((REG_GET(base, HDMI_CORE_DDC_STATUS, 4, 4) == 1) ||
+		(REG_GET(base, HDMI_CORE_DDC_STATUS, 2, 2) == 0)) &&
+			j < 128) {
 
-		if (REG_GET(core_sys_base, HDMI_CORE_DDC_STATUS, 2, 2) == 0) {
+		if (REG_GET(base, HDMI_CORE_DDC_STATUS, 2, 2) == 0) {
 			/* FIFO not empty */
-			pedid[i++] = REG_GET(core_sys_base,
-						HDMI_CORE_DDC_DATA, 7, 0);
+			pedid[i++] = REG_GET(base, HDMI_CORE_DDC_DATA, 7, 0);
 			j++;
 		}
 	}
@@ -372,6 +385,10 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
 	int max_ext_blocks = (max_length / 128) - 1;
 	int len;
 
+	r = hdmi_core_ddc_init(ip_data);
+	if (r)
+		return r;
+
 	r = hdmi_core_ddc_edid(ip_data, pedid, 0);
 	if (r)
 		return r;
-- 
1.7.4.1

