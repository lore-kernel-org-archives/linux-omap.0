From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass base_address
Date: Fri, 17 Jun 2011 13:47:10 +0530
Message-ID: <1308298637-29753-2-git-send-email-mythripk@ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36074 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757729Ab1FQIYS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 04:24:18 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5H8OEKe017441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 03:24:17 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5H8OCYh001732
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 13:54:14 +0530 (IST)
In-Reply-To: <1308298637-29753-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

As the base_address of the HDMI might differ across SoC's, offset of the HDMI
logical blocks and base address got from the platform data are passed
dynamically to the functions that modify HDMI IP registers.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |  518 ++++++++++++++++++++++++----------------
 drivers/video/omap2/dss/hdmi.h |  292 +++++++++++------------
 2 files changed, 452 insertions(+), 358 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 5e5b98b..1d16ee2 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -43,11 +43,17 @@
 #include "hdmi.h"
 #include "dss_features.h"
 
+#define HDMI_WP			0x0
+#define HDMI_CORE_SYS		0x400
+#define HDMI_CORE_AV		0x900
+#define HDMI_PLLCTRL		0x200
+#define HDMI_PHY		0x300
+
 static struct {
 	struct mutex lock;
 	struct omap_display_platform_data *pdata;
 	struct platform_device *pdev;
-	void __iomem *base_wp;	/* HDMI wrapper */
+	struct hdmi_ip_data hdmi_data;
 	int code;
 	int mode;
 	u8 edid[HDMI_EDID_MAX_LENGTH];
@@ -146,21 +152,51 @@ static const int code_vesa[85] = {
 
 static const u8 edid_header[8] = {0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0};
 
-static inline void hdmi_write_reg(const struct hdmi_reg idx, u32 val)
+static inline void hdmi_write_reg(void __iomem *base_addr,
+				const struct hdmi_reg idx, u32 val)
+{
+	__raw_writel(val, base_addr + idx.idx);
+}
+
+static inline u32 hdmi_read_reg(void __iomem *base_addr,
+				const struct hdmi_reg idx)
+{
+	return __raw_readl(base_addr + idx.idx);
+}
+
+static inline void __iomem *hdmi_wp_base(struct hdmi_ip_data *ip_data)
+{
+	return (void __iomem *) (ip_data->base_wp);
+}
+
+static inline void __iomem *hdmi_phy_base(struct hdmi_ip_data *ip_data)
 {
-	__raw_writel(val, hdmi.base_wp + idx.idx);
+	return (void __iomem *) (ip_data->base_wp + ip_data->hdmi_phy_offset);
 }
 
-static inline u32 hdmi_read_reg(const struct hdmi_reg idx)
+static inline void __iomem *hdmi_pll_base(struct hdmi_ip_data *ip_data)
 {
-	return __raw_readl(hdmi.base_wp + idx.idx);
+	return (void __iomem *)	(ip_data->base_wp + ip_data->hdmi_pll_offset);
 }
 
-static inline int hdmi_wait_for_bit_change(const struct hdmi_reg idx,
+static inline void __iomem *hdmi_av_base(struct hdmi_ip_data *ip_data)
+{
+	return (void __iomem *)
+			(ip_data->base_wp + ip_data->hdmi_core_av_offset);
+}
+
+static inline void __iomem *hdmi_core_sys_base(struct hdmi_ip_data *ip_data)
+{
+	return (void __iomem *)
+			(ip_data->base_wp + ip_data->hdmi_core_sys_offset);
+}
+
+static inline int hdmi_wait_for_bit_change(void __iomem *base_addr,
+				const struct hdmi_reg idx,
 				int b2, int b1, u32 val)
 {
 	u32 t = 0;
-	while (val != REG_GET(idx, b2, b1)) {
+	while (val != REG_GET(base_addr, idx, b2, b1)) {
 		udelay(1);
 		if (t++ > 10000)
 			return !val;
@@ -225,21 +261,22 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int hdmi_pll_init(enum hdmi_clk_refsel refsel, int dcofreq,
+static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
+		enum hdmi_clk_refsel refsel, int dcofreq,
 		struct hdmi_pll_info *fmt, u16 sd)
 {
 	u32 r;
 
 	/* PLL start always use manual mode */
-	REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
+	REG_FLD_MOD(hdmi_pll_base(ip_data), PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
 
-	r = hdmi_read_reg(PLLCTRL_CFG1);
+	r = hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1);
 	r = FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM */
 	r = FLD_MOD(r, fmt->regn, 8, 1);  /* CFG1_PLL_REGN */
 
-	hdmi_write_reg(PLLCTRL_CFG1, r);
+	hdmi_write_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1, r);
 
-	r = hdmi_read_reg(PLLCTRL_CFG2);
+	r = hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG2);
 
 	r = FLD_MOD(r, 0x0, 12, 12); /* PLL_HIGHFREQ divide by 2 */
 	r = FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
@@ -247,38 +284,40 @@ static int hdmi_pll_init(enum hdmi_clk_refsel refsel, int dcofreq,
 
 	if (dcofreq) {
 		/* divider programming for frequency beyond 1000Mhz */
-		REG_FLD_MOD(PLLCTRL_CFG3, sd, 17, 10);
+		REG_FLD_MOD(hdmi_pll_base(ip_data), PLLCTRL_CFG3, sd, 17, 10);
 		r = FLD_MOD(r, 0x4, 3, 1); /* 1000MHz and 2000MHz */
 	} else {
 		r = FLD_MOD(r, 0x2, 3, 1); /* 500MHz and 1000MHz */
 	}
 
-	hdmi_write_reg(PLLCTRL_CFG2, r);
+	hdmi_write_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG2, r);
 
-	r = hdmi_read_reg(PLLCTRL_CFG4);
+	r = hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG4);
 	r = FLD_MOD(r, fmt->regm2, 24, 18);
 	r = FLD_MOD(r, fmt->regmf, 17, 0);
 
-	hdmi_write_reg(PLLCTRL_CFG4, r);
+	hdmi_write_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG4, r);
 
 	/* go now */
-	REG_FLD_MOD(PLLCTRL_PLL_GO, 0x1, 0, 0);
+	REG_FLD_MOD(hdmi_pll_base(ip_data), PLLCTRL_PLL_GO, 0x1, 0, 0);
 
 	/* wait for bit change */
-	if (hdmi_wait_for_bit_change(PLLCTRL_PLL_GO, 0, 0, 1) != 1) {
+	if (hdmi_wait_for_bit_change(hdmi_pll_base(ip_data), PLLCTRL_PLL_GO,
+							0, 0, 1) != 1) {
 		DSSERR("PLL GO bit not set\n");
 		return -ETIMEDOUT;
 	}
 
 	/* Wait till the lock bit is set in PLL status */
-	if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 1, 1, 1) != 1) {
+	if (hdmi_wait_for_bit_change(hdmi_pll_base(ip_data),
+				PLLCTRL_PLL_STATUS, 1, 1, 1) != 1) {
 		DSSWARN("cannot lock PLL\n");
 		DSSWARN("CFG1 0x%x\n",
-			hdmi_read_reg(PLLCTRL_CFG1));
+			hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1));
 		DSSWARN("CFG2 0x%x\n",
-			hdmi_read_reg(PLLCTRL_CFG2));
+			hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG2));
 		DSSWARN("CFG4 0x%x\n",
-			hdmi_read_reg(PLLCTRL_CFG4));
+			hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG4));
 		return -ETIMEDOUT;
 	}
 
@@ -288,13 +327,14 @@ static int hdmi_pll_init(enum hdmi_clk_refsel refsel, int dcofreq,
 }
 
 /* PHY_PWR_CMD */
-static int hdmi_set_phy_pwr(enum hdmi_phy_pwr val)
+static int hdmi_set_phy_pwr(struct hdmi_ip_data *ip_data, enum hdmi_phy_pwr val)
 {
 	/* Command for power control of HDMI PHY */
-	REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 7, 6);
+	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, val, 7, 6);
 
 	/* Status of the power control of HDMI PHY */
-	if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 5, 4, val) != val) {
+	if (hdmi_wait_for_bit_change(hdmi_wp_base(ip_data),
+				HDMI_WP_PWR_CTRL, 5, 4, val) != val) {
 		DSSERR("Failed to set PHY power mode to %d\n", val);
 		return -ETIMEDOUT;
 	}
@@ -303,13 +343,14 @@ static int hdmi_set_phy_pwr(enum hdmi_phy_pwr val)
 }
 
 /* PLL_PWR_CMD */
-static int hdmi_set_pll_pwr(enum hdmi_pll_pwr val)
+int hdmi_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val)
 {
 	/* Command for power control of HDMI PLL */
-	REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 3, 2);
+	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, val, 3, 2);
 
 	/* wait till PHY_PWR_STATUS is set */
-	if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 1, 0, val) != val) {
+	if (hdmi_wait_for_bit_change(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL,
+						1, 0, val) != val) {
 		DSSERR("Failed to set PHY_PWR_STATUS\n");
 		return -ETIMEDOUT;
 	}
@@ -317,13 +358,14 @@ static int hdmi_set_pll_pwr(enum hdmi_pll_pwr val)
 	return 0;
 }
 
-static int hdmi_pll_reset(void)
+static int hdmi_pll_reset(struct hdmi_ip_data *ip_data)
 {
 	/* SYSRESET  controlled by power FSM */
-	REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 3, 3);
+	REG_FLD_MOD(hdmi_pll_base(ip_data), PLLCTRL_PLL_CONTROL, 0x0, 3, 3);
 
 	/* READ 0x0 reset is in progress */
-	if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 0, 0, 1) != 1) {
+	if (hdmi_wait_for_bit_change(hdmi_pll_base(ip_data),
+				PLLCTRL_PLL_STATUS, 0, 0, 1) != 1) {
 		DSSERR("Failed to sysreset PLL\n");
 		return -ETIMEDOUT;
 	}
@@ -331,15 +373,15 @@ static int hdmi_pll_reset(void)
 	return 0;
 }
 
-static int hdmi_phy_init(void)
+static int hdmi_phy_init(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 
-	r = hdmi_set_phy_pwr(HDMI_PHYPWRCMD_LDOON);
+	r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
 	if (r)
 		return r;
 
-	r = hdmi_set_phy_pwr(HDMI_PHYPWRCMD_TXON);
+	r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
 	if (r)
 		return r;
 
@@ -347,65 +389,69 @@ static int hdmi_phy_init(void)
 	 * Read address 0 in order to get the SCP reset done completed
 	 * Dummy access performed to make sure reset is done
 	 */
-	hdmi_read_reg(HDMI_TXPHY_TX_CTRL);
+	hdmi_read_reg(hdmi_phy_base(ip_data), HDMI_TXPHY_TX_CTRL);
 
 	/*
 	 * Write to phy address 0 to configure the clock
 	 * use HFBITCLK write HDMI_TXPHY_TX_CONTROL_FREQOUT field
 	 */
-	REG_FLD_MOD(HDMI_TXPHY_TX_CTRL, 0x1, 31, 30);
+	REG_FLD_MOD(hdmi_phy_base(ip_data), HDMI_TXPHY_TX_CTRL, 0x1, 31, 30);
 
 	/* Write to phy address 1 to start HDMI line (TXVALID and TMDSCLKEN) */
-	hdmi_write_reg(HDMI_TXPHY_DIGITAL_CTRL, 0xF0000000);
+	hdmi_write_reg(hdmi_phy_base(ip_data),
+					HDMI_TXPHY_DIGITAL_CTRL, 0xF0000000);
 
 	/* Setup max LDO voltage */
-	REG_FLD_MOD(HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
+	REG_FLD_MOD(hdmi_phy_base(ip_data), HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
 
 	/* Write to phy address 3 to change the polarity control */
-	REG_FLD_MOD(HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
+	REG_FLD_MOD(hdmi_phy_base(ip_data),
+					HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
 
 	return 0;
 }
 
-static int hdmi_pll_program(struct hdmi_pll_info *fmt)
+static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
+				struct hdmi_pll_info *fmt)
 {
 	u16 r = 0;
 	enum hdmi_clk_refsel refsel;
 
-	r = hdmi_set_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
+	r = hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
 	if (r)
 		return r;
 
-	r = hdmi_set_pll_pwr(HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
+	r = hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
 	if (r)
 		return r;
 
-	r = hdmi_pll_reset();
+	r = hdmi_pll_reset(ip_data);
 	if (r)
 		return r;
 
 	refsel = HDMI_REFSEL_SYSCLK;
 
-	r = hdmi_pll_init(refsel, fmt->dcofreq, fmt, fmt->regsd);
+	r = hdmi_pll_init(ip_data, refsel, fmt->dcofreq, fmt, fmt->regsd);
 	if (r)
 		return r;
 
 	return 0;
 }
 
-static void hdmi_phy_off(void)
+static void hdmi_phy_off(struct hdmi_ip_data *ip_data)
 {
-	hdmi_set_phy_pwr(HDMI_PHYPWRCMD_OFF);
+	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
 
-static int hdmi_core_ddc_edid(u8 *pedid, int ext)
+static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
+						u8 *pedid, int ext)
 {
 	u32 i, j;
 	char checksum = 0;
 	u32 offset = 0;
 
 	/* Turn on CLK for DDC */
-	REG_FLD_MOD(HDMI_CORE_AV_DPD, 0x7, 2, 0);
+	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_DPD, 0x7, 2, 0);
 
 	/*
 	 * SW HACK : Without the Delay DDC(i2c bus) reads 0 values /
@@ -416,21 +462,23 @@ static int hdmi_core_ddc_edid(u8 *pedid, int ext)
 
 	if (!ext) {
 		/* Clk SCL Devices */
-		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3, 0);
+		REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+						HDMI_CORE_DDC_CMD, 0xA, 3, 0);
 
 		/* HDMI_CORE_DDC_STATUS_IN_PROG */
-		if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS,
-						4, 4, 0) != 0) {
+		if (hdmi_wait_for_bit_change(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_STATUS, 4, 4, 0) != 0) {
 			DSSERR("Failed to program DDC\n");
 			return -ETIMEDOUT;
 		}
 
 		/* Clear FIFO */
-		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
+		REG_FLD_MOD(hdmi_core_sys_base(ip_data)
+						, HDMI_CORE_DDC_CMD, 0x9, 3, 0);
 
 		/* HDMI_CORE_DDC_STATUS_IN_PROG */
-		if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS,
-						4, 4, 0) != 0) {
+		if (hdmi_wait_for_bit_change(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_STATUS, 4, 4, 0) != 0) {
 			DSSERR("Failed to program DDC\n");
 			return -ETIMEDOUT;
 		}
@@ -441,44 +489,56 @@ static int hdmi_core_ddc_edid(u8 *pedid, int ext)
 	}
 
 	/* Load Segment Address Register */
-	REG_FLD_MOD(HDMI_CORE_DDC_SEGM, ext/2, 7, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_SEGM, ext/2, 7, 0);
 
 	/* Load Slave Address Register */
-	REG_FLD_MOD(HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
 
 	/* Load Offset Address Register */
-	REG_FLD_MOD(HDMI_CORE_DDC_OFFSET, offset, 7, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_OFFSET, offset, 7, 0);
 
 	/* Load Byte Count */
-	REG_FLD_MOD(HDMI_CORE_DDC_COUNT1, 0x80, 7, 0);
-	REG_FLD_MOD(HDMI_CORE_DDC_COUNT2, 0x0, 1, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_COUNT1, 0x80, 7, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_COUNT2, 0x0, 1, 0);
 
 	/* Set DDC_CMD */
 	if (ext)
-		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x4, 3, 0);
+		REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_CMD, 0x4, 3, 0);
 	else
-		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x2, 3, 0);
+		REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_CMD, 0x2, 3, 0);
 
 	/* HDMI_CORE_DDC_STATUS_BUS_LOW */
-	if (REG_GET(HDMI_CORE_DDC_STATUS, 6, 6) == 1) {
+	if (REG_GET(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_STATUS, 6, 6) == 1) {
 		DSSWARN("I2C Bus Low?\n");
 		return -EIO;
 	}
 	/* HDMI_CORE_DDC_STATUS_NO_ACK */
-	if (REG_GET(HDMI_CORE_DDC_STATUS, 5, 5) == 1) {
+	if (REG_GET(hdmi_core_sys_base(ip_data),
+					HDMI_CORE_DDC_STATUS, 5, 5) == 1) {
 		DSSWARN("I2C No Ack\n");
 		return -EIO;
 	}
 
 	i = ext * 128;
 	j = 0;
-	while (((REG_GET(HDMI_CORE_DDC_STATUS, 4, 4) == 1) ||
-			(REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) == 0)) &&
-			j < 128) {
+	while (((REG_GET(hdmi_core_sys_base(ip_data),
+			HDMI_CORE_DDC_STATUS, 4, 4) == 1) ||
+			(REG_GET(hdmi_core_sys_base(ip_data),
+			HDMI_CORE_DDC_STATUS, 2, 2) == 0)) && j < 128) {
 
-		if (REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) == 0) {
+		if (REG_GET(hdmi_core_sys_base(ip_data)
+					, HDMI_CORE_DDC_STATUS, 2, 2) == 0) {
 			/* FIFO not empty */
-			pedid[i++] = REG_GET(HDMI_CORE_DDC_DATA, 7, 0);
+			pedid[i++] = REG_GET(hdmi_core_sys_base(ip_data),
+						HDMI_CORE_DDC_DATA, 7, 0);
 			j++;
 		}
 	}
@@ -494,12 +554,12 @@ static int hdmi_core_ddc_edid(u8 *pedid, int ext)
 	return 0;
 }
 
-static int read_edid(u8 *pedid, u16 max_length)
+static int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
 {
 	int r = 0, n = 0, i = 0;
 	int max_ext_blocks = (max_length / 128) - 1;
 
-	r = hdmi_core_ddc_edid(pedid, 0);
+	r = hdmi_core_ddc_edid(ip_data, pedid, 0);
 	if (r) {
 		return r;
 	} else {
@@ -515,7 +575,7 @@ static int read_edid(u8 *pedid, u16 max_length)
 			n = max_ext_blocks;
 
 		for (i = 1; i <= n; i++) {
-			r = hdmi_core_ddc_edid(pedid, i);
+			r = hdmi_core_ddc_edid(ip_data, pedid, i);
 			if (r)
 				return r;
 		}
@@ -685,8 +745,8 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
 
 	if (!hdmi.edid_set)
-		ret = read_edid(hdmi.edid, HDMI_EDID_MAX_LENGTH);
-
+		ret = read_edid(&hdmi.hdmi_data, hdmi.edid,
+						HDMI_EDID_MAX_LENGTH);
 	if (!ret) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
 			/* search for timings of default resolution */
@@ -752,41 +812,43 @@ static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
 	repeat_cfg->generic_pkt_repeat = 0;
 }
 
-static void hdmi_core_powerdown_disable(void)
+static void hdmi_core_powerdown_disable(struct hdmi_ip_data *ip_data)
 {
 	DSSDBG("Enter hdmi_core_powerdown_disable\n");
-	REG_FLD_MOD(HDMI_CORE_CTRL1, 0x0, 0, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data), HDMI_CORE_CTRL1, 0x0, 0, 0);
 }
 
-static void hdmi_core_swreset_release(void)
+static void hdmi_core_swreset_release(struct hdmi_ip_data *ip_data)
 {
 	DSSDBG("Enter hdmi_core_swreset_release\n");
-	REG_FLD_MOD(HDMI_CORE_SYS_SRST, 0x0, 0, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data), HDMI_CORE_SYS_SRST, 0x0, 0, 0);
 }
 
-static void hdmi_core_swreset_assert(void)
+static void hdmi_core_swreset_assert(struct hdmi_ip_data *ip_data)
 {
 	DSSDBG("Enter hdmi_core_swreset_assert\n");
-	REG_FLD_MOD(HDMI_CORE_SYS_SRST, 0x1, 0, 0);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data), HDMI_CORE_SYS_SRST, 0x1, 0, 0);
 }
 
-/* DSS_HDMI_CORE_VIDEO_CONFIG */
-static void hdmi_core_video_config(struct hdmi_core_video_config *cfg)
+/* HDMI_CORE_VIDEO_CONFIG */
+static void hdmi_core_video_config(struct hdmi_ip_data *ip_data,
+				struct hdmi_core_video_config *cfg)
 {
 	u32 r = 0;
 
 	/* sys_ctrl1 default configuration not tunable */
-	r = hdmi_read_reg(HDMI_CORE_CTRL1);
+	r = hdmi_read_reg(hdmi_core_sys_base(ip_data), HDMI_CORE_CTRL1);
 	r = FLD_MOD(r, HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC, 5, 5);
 	r = FLD_MOD(r, HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC, 4, 4);
 	r = FLD_MOD(r, HDMI_CORE_CTRL1_BSEL_24BITBUS, 2, 2);
 	r = FLD_MOD(r, HDMI_CORE_CTRL1_EDGE_RISINGEDGE, 1, 1);
-	hdmi_write_reg(HDMI_CORE_CTRL1, r);
+	hdmi_write_reg(hdmi_core_sys_base(ip_data), HDMI_CORE_CTRL1, r);
 
-	REG_FLD_MOD(HDMI_CORE_SYS_VID_ACEN, cfg->ip_bus_width, 7, 6);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+			HDMI_CORE_SYS_VID_ACEN, cfg->ip_bus_width, 7, 6);
 
 	/* Vid_Mode */
-	r = hdmi_read_reg(HDMI_CORE_SYS_VID_MODE);
+	r = hdmi_read_reg(hdmi_core_sys_base(ip_data), HDMI_CORE_SYS_VID_MODE);
 
 	/* dither truncation configuration */
 	if (cfg->op_dither_truc > HDMI_OUTPUTTRUNCATION_12BIT) {
@@ -796,106 +858,107 @@ static void hdmi_core_video_config(struct hdmi_core_video_config *cfg)
 		r = FLD_MOD(r, cfg->op_dither_truc, 7, 6);
 		r = FLD_MOD(r, 0, 5, 5);
 	}
-	hdmi_write_reg(HDMI_CORE_SYS_VID_MODE, r);
+	hdmi_write_reg(hdmi_core_sys_base(ip_data), HDMI_CORE_SYS_VID_MODE, r);
 
 	/* HDMI_Ctrl */
-	r = hdmi_read_reg(HDMI_CORE_AV_HDMI_CTRL);
+	r = hdmi_read_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_HDMI_CTRL);
 	r = FLD_MOD(r, cfg->deep_color_pkt, 6, 6);
 	r = FLD_MOD(r, cfg->pkt_mode, 5, 3);
 	r = FLD_MOD(r, cfg->hdmi_dvi, 0, 0);
-	hdmi_write_reg(HDMI_CORE_AV_HDMI_CTRL, r);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_HDMI_CTRL, r);
 
 	/* TMDS_CTRL */
-	REG_FLD_MOD(HDMI_CORE_SYS_TMDS_CTRL,
-		cfg->tclk_sel_clkmult, 6, 5);
+	REG_FLD_MOD(hdmi_core_sys_base(ip_data),
+			HDMI_CORE_SYS_TMDS_CTRL, cfg->tclk_sel_clkmult, 6, 5);
 }
 
-static void hdmi_core_aux_infoframe_avi_config(
+static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_data,
 		struct hdmi_core_infoframe_avi info_avi)
 {
 	u32 val;
 	char sum = 0, checksum = 0;
 
 	sum += 0x82 + 0x002 + 0x00D;
-	hdmi_write_reg(HDMI_CORE_AV_AVI_TYPE, 0x082);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_VERS, 0x002);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_LEN, 0x00D);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_TYPE, 0x082);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_VERS, 0x002);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_LEN, 0x00D);
 
 	val = (info_avi.db1_format << 5) |
 		(info_avi.db1_active_info << 4) |
 		(info_avi.db1_bar_info_dv << 2) |
 		(info_avi.db1_scan_info);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(0), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(0), val);
 	sum += val;
 
 	val = (info_avi.db2_colorimetry << 6) |
 		(info_avi.db2_aspect_ratio << 4) |
 		(info_avi.db2_active_fmt_ar);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(1), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(1), val);
 	sum += val;
 
 	val = (info_avi.db3_itc << 7) |
 		(info_avi.db3_ec << 4) |
 		(info_avi.db3_q_range << 2) |
 		(info_avi.db3_nup_scaling);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(2), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(2), val);
 	sum += val;
 
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(3), info_avi.db4_videocode);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(3),
+					info_avi.db4_videocode);
 	sum += info_avi.db4_videocode;
 
 	val = info_avi.db5_pixel_repeat;
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(4), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(4), val);
 	sum += val;
 
 	val = info_avi.db6_7_line_eoftop & 0x00FF;
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(5), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(5), val);
 	sum += val;
 
 	val = ((info_avi.db6_7_line_eoftop >> 8) & 0x00FF);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(6), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(6), val);
 	sum += val;
 
 	val = info_avi.db8_9_line_sofbottom & 0x00FF;
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(7), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(7), val);
 	sum += val;
 
 	val = ((info_avi.db8_9_line_sofbottom >> 8) & 0x00FF);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(8), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(8), val);
 	sum += val;
 
 	val = info_avi.db10_11_pixel_eofleft & 0x00FF;
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(9), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(9), val);
 	sum += val;
 
 	val = ((info_avi.db10_11_pixel_eofleft >> 8) & 0x00FF);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(10), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(10), val);
 	sum += val;
 
 	val = info_avi.db12_13_pixel_sofright & 0x00FF;
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(11), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(11), val);
 	sum += val;
 
 	val = ((info_avi.db12_13_pixel_sofright >> 8) & 0x00FF);
-	hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(12), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_DBYTE(12), val);
 	sum += val;
 
 	checksum = 0x100 - sum;
-	hdmi_write_reg(HDMI_CORE_AV_AVI_CHSUM, checksum);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AVI_CHSUM, checksum);
 }
 
-static void hdmi_core_av_packet_config(
+static void hdmi_core_av_packet_config(struct hdmi_ip_data *ip_data,
 		struct hdmi_core_packet_enable_repeat repeat_cfg)
 {
 	/* enable/repeat the infoframe */
-	hdmi_write_reg(HDMI_CORE_AV_PB_CTRL1,
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_PB_CTRL1,
 		(repeat_cfg.audio_pkt << 5) |
 		(repeat_cfg.audio_pkt_repeat << 4) |
 		(repeat_cfg.avi_infoframe << 1) |
 		(repeat_cfg.avi_infoframe_repeat));
 
 	/* enable/repeat the packet */
-	hdmi_write_reg(HDMI_CORE_AV_PB_CTRL2,
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_PB_CTRL2,
 		(repeat_cfg.gen_cntrl_pkt << 3) |
 		(repeat_cfg.gen_cntrl_pkt_repeat << 2) |
 		(repeat_cfg.generic_pkt << 1) |
@@ -927,9 +990,9 @@ static void hdmi_wp_init(struct omap_video_timings *timings,
 
 }
 
-static void hdmi_wp_video_start(bool start)
+static void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
 {
-	REG_FLD_MOD(HDMI_WP_VIDEO_CFG, start, 31, 31);
+	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
 }
 
 static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
@@ -948,33 +1011,34 @@ static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
 	timings->vsw = param->timings.timings.vsw;
 }
 
-static void hdmi_wp_video_config_format(
+static void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
 		struct hdmi_video_format *video_fmt)
 {
 	u32 l = 0;
 
-	REG_FLD_MOD(HDMI_WP_VIDEO_CFG, video_fmt->packing_mode, 10, 8);
+	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG,
+			video_fmt->packing_mode, 10, 8);
 
 	l |= FLD_VAL(video_fmt->y_res, 31, 16);
 	l |= FLD_VAL(video_fmt->x_res, 15, 0);
-	hdmi_write_reg(HDMI_WP_VIDEO_SIZE, l);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_SIZE, l);
 }
 
-static void hdmi_wp_video_config_interface(
+static void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data,
 		struct hdmi_video_interface *video_int)
 {
 	u32 r;
 	DSSDBG("Enter hdmi_wp_video_config_interface\n");
 
-	r = hdmi_read_reg(HDMI_WP_VIDEO_CFG);
+	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG);
 	r = FLD_MOD(r, video_int->vsp, 7, 7);
 	r = FLD_MOD(r, video_int->hsp, 6, 6);
 	r = FLD_MOD(r, video_int->interlacing, 3, 3);
 	r = FLD_MOD(r, video_int->tm, 1, 0);
-	hdmi_write_reg(HDMI_WP_VIDEO_CFG, r);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, r);
 }
 
-static void hdmi_wp_video_config_timing(
+static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 		struct omap_video_timings *timings)
 {
 	u32 timing_h = 0;
@@ -985,15 +1049,16 @@ static void hdmi_wp_video_config_timing(
 	timing_h |= FLD_VAL(timings->hbp, 31, 20);
 	timing_h |= FLD_VAL(timings->hfp, 19, 8);
 	timing_h |= FLD_VAL(timings->hsw, 7, 0);
-	hdmi_write_reg(HDMI_WP_VIDEO_TIMING_H, timing_h);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_H, timing_h);
 
 	timing_v |= FLD_VAL(timings->vbp, 31, 20);
 	timing_v |= FLD_VAL(timings->vfp, 19, 8);
 	timing_v |= FLD_VAL(timings->vsw, 7, 0);
-	hdmi_write_reg(HDMI_WP_VIDEO_TIMING_V, timing_v);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_TIMING_V, timing_v);
 }
 
-static void hdmi_basic_configure(struct hdmi_config *cfg)
+static void hdmi_basic_configure(struct hdmi_ip_data *ip_data,
+			struct hdmi_config *cfg)
 {
 	/* HDMI */
 	struct omap_video_timings video_timing;
@@ -1014,36 +1079,36 @@ static void hdmi_basic_configure(struct hdmi_config *cfg)
 	hdmi_wp_video_init_format(&video_format,
 			&video_timing, cfg);
 
-	hdmi_wp_video_config_timing(&video_timing);
+	hdmi_wp_video_config_timing(ip_data, &video_timing);
 
 	/* video config */
 	video_format.packing_mode = HDMI_PACK_24b_RGB_YUV444_YUV422;
 
-	hdmi_wp_video_config_format(&video_format);
+	hdmi_wp_video_config_format(ip_data, &video_format);
 
 	video_interface.vsp = cfg->timings.vsync_pol;
 	video_interface.hsp = cfg->timings.hsync_pol;
 	video_interface.interlacing = cfg->interlace;
 	video_interface.tm = 1 ; /* HDMI_TIMING_MASTER_24BIT */
 
-	hdmi_wp_video_config_interface(&video_interface);
+	hdmi_wp_video_config_interface(ip_data, &video_interface);
 
 	/*
 	 * configure core video part
 	 * set software reset in the core
 	 */
-	hdmi_core_swreset_assert();
+	hdmi_core_swreset_assert(ip_data);
 
 	/* power down off */
-	hdmi_core_powerdown_disable();
+	hdmi_core_powerdown_disable(ip_data);
 
 	v_core_cfg.pkt_mode = HDMI_PACKETMODE24BITPERPIXEL;
 	v_core_cfg.hdmi_dvi = cfg->cm.mode;
 
-	hdmi_core_video_config(&v_core_cfg);
+	hdmi_core_video_config(ip_data, &v_core_cfg);
 
 	/* release software reset in the core */
-	hdmi_core_swreset_release();
+	hdmi_core_swreset_release(ip_data);
 
 	/*
 	 * configure packet
@@ -1068,7 +1133,7 @@ static void hdmi_basic_configure(struct hdmi_config *cfg)
 	avi_cfg.db10_11_pixel_eofleft = 0;
 	avi_cfg.db12_13_pixel_sofright = 0;
 
-	hdmi_core_aux_infoframe_avi_config(avi_cfg);
+	hdmi_core_aux_infoframe_avi_config(ip_data, avi_cfg);
 
 	/* enable/repeat the infoframe */
 	repeat_cfg.avi_infoframe = HDMI_PACKETENABLE;
@@ -1076,7 +1141,7 @@ static void hdmi_basic_configure(struct hdmi_config *cfg)
 	/* wakeup */
 	repeat_cfg.audio_pkt = HDMI_PACKETENABLE;
 	repeat_cfg.audio_pkt_repeat = HDMI_PACKETREPEATON;
-	hdmi_core_av_packet_config(repeat_cfg);
+	hdmi_core_av_packet_config(ip_data, repeat_cfg);
 }
 
 static void update_hdmi_timings(struct hdmi_config *cfg,
@@ -1166,16 +1231,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi_compute_pll(dssdev, phy, &pll_data);
 
-	hdmi_wp_video_start(0);
+	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
 
-	/* config the PLL and PHY first */
-	r = hdmi_pll_program(&pll_data);
+	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
+	r = hdmi_pll_program(&hdmi.hdmi_data, &pll_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = hdmi_phy_init();
+	r = hdmi_phy_init(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -1183,7 +1248,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.cfg.cm.mode = hdmi.mode;
 	hdmi.cfg.cm.code = hdmi.code;
-	hdmi_basic_configure(&hdmi.cfg);
+	hdmi_basic_configure(&hdmi.hdmi_data, &hdmi.cfg);
 
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
@@ -1205,7 +1270,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 1);
 
-	hdmi_wp_video_start(1);
+	hdmi_wp_video_start(&hdmi.hdmi_data, 1);
 
 	return 0;
 err:
@@ -1217,9 +1282,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
 	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
 
-	hdmi_wp_video_start(0);
-	hdmi_phy_off();
-	hdmi_set_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
+	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
+	hdmi_phy_off(&hdmi.hdmi_data);
+	hdmi_set_pll_pwr(&hdmi.hdmi_data, HDMI_PLLPWRCMD_ALLOFF);
 	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
@@ -1311,14 +1376,14 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-static void hdmi_wp_audio_config_format(
-		struct hdmi_audio_format *aud_fmt)
+static void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_format *aud_fmt)
 {
 	u32 r;
 
 	DSSDBG("Enter hdmi_wp_audio_config_format\n");
 
-	r = hdmi_read_reg(HDMI_WP_AUDIO_CFG);
+	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG);
 	r = FLD_MOD(r, aud_fmt->stereo_channels, 26, 24);
 	r = FLD_MOD(r, aud_fmt->active_chnnls_msk, 23, 16);
 	r = FLD_MOD(r, aud_fmt->en_sig_blk_strt_end, 5, 5);
@@ -1327,68 +1392,81 @@ static void hdmi_wp_audio_config_format(
 	r = FLD_MOD(r, aud_fmt->sample_order, 2, 2);
 	r = FLD_MOD(r, aud_fmt->samples_per_word, 1, 1);
 	r = FLD_MOD(r, aud_fmt->sample_size, 0, 0);
-	hdmi_write_reg(HDMI_WP_AUDIO_CFG, r);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG, r);
 }
 
-static void hdmi_wp_audio_config_dma(struct hdmi_audio_dma *aud_dma)
+static void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_dma *aud_dma)
 {
 	u32 r;
 
 	DSSDBG("Enter hdmi_wp_audio_config_dma\n");
 
-	r = hdmi_read_reg(HDMI_WP_AUDIO_CFG2);
+	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG2);
 	r = FLD_MOD(r, aud_dma->transfer_size, 15, 8);
 	r = FLD_MOD(r, aud_dma->block_size, 7, 0);
-	hdmi_write_reg(HDMI_WP_AUDIO_CFG2, r);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG2, r);
 
-	r = hdmi_read_reg(HDMI_WP_AUDIO_CTRL);
+	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL);
 	r = FLD_MOD(r, aud_dma->mode, 9, 9);
 	r = FLD_MOD(r, aud_dma->fifo_threshold, 8, 0);
-	hdmi_write_reg(HDMI_WP_AUDIO_CTRL, r);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL, r);
 }
 
-static void hdmi_core_audio_config(struct hdmi_core_audio_config *cfg)
+static void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
+					struct hdmi_core_audio_config *cfg)
 {
 	u32 r;
 
 	/* audio clock recovery parameters */
-	r = hdmi_read_reg(HDMI_CORE_AV_ACR_CTRL);
+	r = hdmi_read_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_ACR_CTRL);
 	r = FLD_MOD(r, cfg->use_mclk, 2, 2);
 	r = FLD_MOD(r, cfg->en_acr_pkt, 1, 1);
 	r = FLD_MOD(r, cfg->cts_mode, 0, 0);
-	hdmi_write_reg(HDMI_CORE_AV_ACR_CTRL, r);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_ACR_CTRL, r);
 
-	REG_FLD_MOD(HDMI_CORE_AV_N_SVAL1, cfg->n, 7, 0);
-	REG_FLD_MOD(HDMI_CORE_AV_N_SVAL2, cfg->n >> 8, 7, 0);
-	REG_FLD_MOD(HDMI_CORE_AV_N_SVAL3, cfg->n >> 16, 7, 0);
+	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_N_SVAL1, cfg->n, 7, 0);
+	REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_N_SVAL2, cfg->n >> 8, 7, 0);
+	REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_N_SVAL3, cfg->n >> 16, 7, 0);
 
 	if (cfg->cts_mode == HDMI_AUDIO_CTS_MODE_SW) {
-		REG_FLD_MOD(HDMI_CORE_AV_CTS_SVAL1, cfg->cts, 7, 0);
-		REG_FLD_MOD(HDMI_CORE_AV_CTS_SVAL2, cfg->cts >> 8, 7, 0);
-		REG_FLD_MOD(HDMI_CORE_AV_CTS_SVAL3, cfg->cts >> 16, 7, 0);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_CTS_SVAL1, cfg->cts, 7, 0);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_CTS_SVAL2, cfg->cts >> 8, 7, 0);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_CTS_SVAL3, cfg->cts >> 16, 7, 0);
 	} else {
 		/*
 		 * HDMI IP uses this configuration to divide the MCLK to
 		 * update CTS value.
 		 */
-		REG_FLD_MOD(HDMI_CORE_AV_FREQ_SVAL, cfg->mclk_mode, 2, 0);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_FREQ_SVAL, cfg->mclk_mode, 2, 0);
 
 		/* Configure clock for audio packets */
-		REG_FLD_MOD(HDMI_CORE_AV_AUD_PAR_BUSCLK_1,
-			cfg->aud_par_busclk, 7, 0);
-		REG_FLD_MOD(HDMI_CORE_AV_AUD_PAR_BUSCLK_2,
-			(cfg->aud_par_busclk >> 8), 7, 0);
-		REG_FLD_MOD(HDMI_CORE_AV_AUD_PAR_BUSCLK_3,
-			(cfg->aud_par_busclk >> 16), 7, 0);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_AUD_PAR_BUSCLK_1,
+				cfg->aud_par_busclk, 7, 0);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_AUD_PAR_BUSCLK_2,
+				(cfg->aud_par_busclk >> 8), 7, 0);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_AUD_PAR_BUSCLK_3,
+				(cfg->aud_par_busclk >> 16), 7, 0);
 	}
 
 	/* Override of SPDIF sample frequency with value in I2S_CHST4 */
-	REG_FLD_MOD(HDMI_CORE_AV_SPDIF_CTRL, cfg->fs_override, 1, 1);
+	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_SPDIF_CTRL,
+						cfg->fs_override, 1, 1);
 
 	/* I2S parameters */
-	REG_FLD_MOD(HDMI_CORE_AV_I2S_CHST4, cfg->freq_sample, 3, 0);
+	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_I2S_CHST4,
+						cfg->freq_sample, 3, 0);
 
-	r = hdmi_read_reg(HDMI_CORE_AV_I2S_IN_CTRL);
+	r = hdmi_read_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_I2S_IN_CTRL);
 	r = FLD_MOD(r, cfg->i2s_cfg.en_high_bitrate_aud, 7, 7);
 	r = FLD_MOD(r, cfg->i2s_cfg.sck_edge_mode, 6, 6);
 	r = FLD_MOD(r, cfg->i2s_cfg.cbit_order, 5, 5);
@@ -1397,27 +1475,29 @@ static void hdmi_core_audio_config(struct hdmi_core_audio_config *cfg)
 	r = FLD_MOD(r, cfg->i2s_cfg.justification, 2, 2);
 	r = FLD_MOD(r, cfg->i2s_cfg.direction, 1, 1);
 	r = FLD_MOD(r, cfg->i2s_cfg.shift, 0, 0);
-	hdmi_write_reg(HDMI_CORE_AV_I2S_IN_CTRL, r);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_I2S_IN_CTRL, r);
 
-	r = hdmi_read_reg(HDMI_CORE_AV_I2S_CHST5);
+	r = hdmi_read_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_I2S_CHST5);
 	r = FLD_MOD(r, cfg->freq_sample, 7, 4);
 	r = FLD_MOD(r, cfg->i2s_cfg.word_length, 3, 1);
 	r = FLD_MOD(r, cfg->i2s_cfg.word_max_length, 0, 0);
-	hdmi_write_reg(HDMI_CORE_AV_I2S_CHST5, r);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_I2S_CHST5, r);
 
-	REG_FLD_MOD(HDMI_CORE_AV_I2S_IN_LEN, cfg->i2s_cfg.in_length_bits, 3, 0);
+	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_I2S_IN_LEN,
+					cfg->i2s_cfg.in_length_bits, 3, 0);
 
 	/* Audio channels and mode parameters */
-	REG_FLD_MOD(HDMI_CORE_AV_HDMI_CTRL, cfg->layout, 2, 1);
-	r = hdmi_read_reg(HDMI_CORE_AV_AUD_MODE);
+	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_HDMI_CTRL,
+							cfg->layout, 2, 1);
+	r = hdmi_read_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_MODE);
 	r = FLD_MOD(r, cfg->i2s_cfg.active_sds, 7, 4);
 	r = FLD_MOD(r, cfg->en_dsd_audio, 3, 3);
 	r = FLD_MOD(r, cfg->en_parallel_aud_input, 2, 2);
 	r = FLD_MOD(r, cfg->en_spdif, 1, 1);
-	hdmi_write_reg(HDMI_CORE_AV_AUD_MODE, r);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_MODE, r);
 }
 
-static void hdmi_core_audio_infoframe_config(
+static void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
 		struct hdmi_core_infoframe_audio *info_aud)
 {
 	u8 val;
@@ -1428,38 +1508,39 @@ static void hdmi_core_audio_infoframe_config(
 	 * described in HDMI 1.4a Section 8.2.2 specification.
 	 * Checksum calculation is defined in Section 5.3.5.
 	 */
-	hdmi_write_reg(HDMI_CORE_AV_AUDIO_TYPE, 0x84);
-	hdmi_write_reg(HDMI_CORE_AV_AUDIO_VERS, 0x01);
-	hdmi_write_reg(HDMI_CORE_AV_AUDIO_LEN, 0x0a);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUDIO_TYPE, 0x84);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUDIO_VERS, 0x01);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUDIO_LEN, 0x0a);
 	sum += 0x84 + 0x001 + 0x00a;
 
 	val = (info_aud->db1_coding_type << 4)
 			| (info_aud->db1_channel_count - 1);
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(0), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(0), val);
 	sum += val;
 
 	val = (info_aud->db2_sample_freq << 2) | info_aud->db2_sample_size;
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(1), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(1), val);
 	sum += val;
 
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(2), 0x00);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(2), 0x00);
 
 	val = info_aud->db4_channel_alloc;
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(3), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(3), val);
 	sum += val;
 
 	val = (info_aud->db5_downmix_inh << 7) | (info_aud->db5_lsv << 3);
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(4), val);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(4), val);
 	sum += val;
 
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(5), 0x00);
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(6), 0x00);
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(7), 0x00);
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(8), 0x00);
-	hdmi_write_reg(HDMI_CORE_AV_AUD_DBYTE(9), 0x00);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(5), 0x00);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(6), 0x00);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(7), 0x00);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(8), 0x00);
+	hdmi_write_reg(hdmi_av_base(ip_data), HDMI_CORE_AV_AUD_DBYTE(9), 0x00);
 
 	checksum = 0x100 - sum;
-	hdmi_write_reg(HDMI_CORE_AV_AUDIO_CHSUM, checksum);
+	hdmi_write_reg(hdmi_av_base(ip_data),
+					HDMI_CORE_AV_AUDIO_CHSUM, checksum);
 
 	/*
 	 * TODO: Add MPEG and SPD enable and repeat cfg when EDID parsing
@@ -1467,7 +1548,8 @@ static void hdmi_core_audio_infoframe_config(
 	 */
 }
 
-static int hdmi_config_audio_acr(u32 sample_freq, u32 *n, u32 *cts)
+static int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
+				u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 r;
 	u32 deep_color = 0;
@@ -1479,7 +1561,7 @@ static int hdmi_config_audio_acr(u32 sample_freq, u32 *n, u32 *cts)
 	 * Obtain current deep color configuration. This needed
 	 * to calculate the TMDS clock based on the pixel clock.
 	 */
-	r = REG_GET(HDMI_WP_VIDEO_CFG, 1, 0);
+	r = REG_GET(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, 1, 0);
 	switch (r) {
 	case 1: /* No deep color selected */
 		deep_color = 100;
@@ -1523,7 +1605,8 @@ static int hdmi_config_audio_acr(u32 sample_freq, u32 *n, u32 *cts)
 	return 0;
 }
 
-static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
+static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
+					struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
 {
@@ -1577,7 +1660,7 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	err = hdmi_config_audio_acr(params_rate(params), &n, &cts);
+	err = hdmi_config_audio_acr(ip_data, params_rate(params), &n, &cts);
 	if (err < 0)
 		return err;
 
@@ -1593,8 +1676,8 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	audio_dma.mode = HDMI_AUDIO_TRANSF_DMA;
 	audio_dma.fifo_threshold = 0x20; /* in number of samples */
 
-	hdmi_wp_audio_config_dma(&audio_dma);
-	hdmi_wp_audio_config_format(&audio_format);
+	hdmi_wp_audio_config_dma(ip_data, &audio_dma);
+	hdmi_wp_audio_config_format(ip_data, &audio_format);
 
 	/*
 	 * I2S config
@@ -1638,7 +1721,7 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	/* Use parallel audio interface */
 	core_cfg.en_parallel_aud_input = true;
 
-	hdmi_core_audio_config(&core_cfg);
+	hdmi_core_audio_config(ip_data, &core_cfg);
 
 	/*
 	 * Configure packet
@@ -1652,29 +1735,36 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	aud_if_cfg.db5_downmix_inh = false;
 	aud_if_cfg.db5_lsv = 0;
 
-	hdmi_core_audio_infoframe_config(&aud_if_cfg);
+	hdmi_core_audio_infoframe_config(ip_data, &aud_if_cfg);
 	return 0;
 }
 
-static int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
-				  struct snd_soc_dai *dai)
+static int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
+				struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
 {
 	int err = 0;
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		REG_FLD_MOD(HDMI_CORE_AV_AUD_MODE, 1, 0, 0);
-		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 1, 31, 31);
-		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 1, 30, 30);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+					HDMI_CORE_AV_AUD_MODE, 1, 0, 0);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 1, 31, 31);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 1, 30, 30);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		REG_FLD_MOD(HDMI_CORE_AV_AUD_MODE, 0, 0, 0);
-		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 0, 30, 30);
-		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 0, 31, 31);
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+					HDMI_CORE_AV_AUD_MODE, 0, 0, 0);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 0, 30, 30);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 0, 31, 31);
 		break;
 	default:
 		err = -EINVAL;
@@ -1765,20 +1855,26 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	}
 
 	/* Base address taken from platform */
-	hdmi.base_wp = ioremap(hdmi_mem->start, resource_size(hdmi_mem));
-	if (!hdmi.base_wp) {
+	hdmi.hdmi_data.base_wp = ioremap(hdmi_mem->start,
+						resource_size(hdmi_mem));
+	if (!hdmi.hdmi_data.base_wp) {
 		DSSERR("can't ioremap WP\n");
 		return -ENOMEM;
 	}
 
 	r = hdmi_get_clocks(pdev);
 	if (r) {
-		iounmap(hdmi.base_wp);
+		iounmap(hdmi.hdmi_data.base_wp);
 		return r;
 	}
 
 	pm_runtime_enable(&pdev->dev);
 
+	hdmi.hdmi_data.hdmi_core_sys_offset = HDMI_CORE_SYS;
+	hdmi.hdmi_data.hdmi_core_av_offset = HDMI_CORE_AV;
+	hdmi.hdmi_data.hdmi_pll_offset = HDMI_PLLCTRL;
+	hdmi.hdmi_data.hdmi_phy_offset = HDMI_PHY;
+
 	hdmi_panel_init();
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
@@ -1808,7 +1904,7 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 
 	hdmi_put_clocks();
 
-	iounmap(hdmi.base_wp);
+	iounmap(hdmi.hdmi_data.base_wp);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index c885f9c..2281823 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -24,174 +24,163 @@
 #include <linux/string.h>
 #include <video/omapdss.h>
 
-#define HDMI_WP		0x0
-#define HDMI_CORE_SYS		0x400
-#define HDMI_CORE_AV		0x900
-#define HDMI_PLLCTRL		0x200
-#define HDMI_PHY		0x300
-
 struct hdmi_reg { u16 idx; };
 
 #define HDMI_REG(idx)			((const struct hdmi_reg) { idx })
 
 /* HDMI Wrapper */
-#define HDMI_WP_REG(idx)			HDMI_REG(HDMI_WP + idx)
-
-#define HDMI_WP_REVISION			HDMI_WP_REG(0x0)
-#define HDMI_WP_SYSCONFIG			HDMI_WP_REG(0x10)
-#define HDMI_WP_IRQSTATUS_RAW			HDMI_WP_REG(0x24)
-#define HDMI_WP_IRQSTATUS			HDMI_WP_REG(0x28)
-#define HDMI_WP_PWR_CTRL			HDMI_WP_REG(0x40)
-#define HDMI_WP_IRQENABLE_SET			HDMI_WP_REG(0x2C)
-#define HDMI_WP_VIDEO_CFG			HDMI_WP_REG(0x50)
-#define HDMI_WP_VIDEO_SIZE			HDMI_WP_REG(0x60)
-#define HDMI_WP_VIDEO_TIMING_H			HDMI_WP_REG(0x68)
-#define HDMI_WP_VIDEO_TIMING_V			HDMI_WP_REG(0x6C)
-#define HDMI_WP_WP_CLK				HDMI_WP_REG(0x70)
-#define HDMI_WP_AUDIO_CFG			HDMI_WP_REG(0x80)
-#define HDMI_WP_AUDIO_CFG2			HDMI_WP_REG(0x84)
-#define HDMI_WP_AUDIO_CTRL			HDMI_WP_REG(0x88)
-#define HDMI_WP_AUDIO_DATA			HDMI_WP_REG(0x8C)
+
+#define HDMI_WP_REVISION			HDMI_REG(0x0)
+#define HDMI_WP_SYSCONFIG			HDMI_REG(0x10)
+#define HDMI_WP_IRQSTATUS_RAW			HDMI_REG(0x24)
+#define HDMI_WP_IRQSTATUS			HDMI_REG(0x28)
+#define HDMI_WP_PWR_CTRL			HDMI_REG(0x40)
+#define HDMI_WP_IRQENABLE_SET			HDMI_REG(0x2C)
+#define HDMI_WP_VIDEO_CFG			HDMI_REG(0x50)
+#define HDMI_WP_VIDEO_SIZE			HDMI_REG(0x60)
+#define HDMI_WP_VIDEO_TIMING_H			HDMI_REG(0x68)
+#define HDMI_WP_VIDEO_TIMING_V			HDMI_REG(0x6C)
+#define HDMI_WP_WP_CLK				HDMI_REG(0x70)
+#define HDMI_WP_AUDIO_CFG			HDMI_REG(0x80)
+#define HDMI_WP_AUDIO_CFG2			HDMI_REG(0x84)
+#define HDMI_WP_AUDIO_CTRL			HDMI_REG(0x88)
+#define HDMI_WP_AUDIO_DATA			HDMI_REG(0x8C)
 
 /* HDMI IP Core System */
-#define HDMI_CORE_SYS_REG(idx)			HDMI_REG(HDMI_CORE_SYS + idx)
-
-#define HDMI_CORE_SYS_VND_IDL			HDMI_CORE_SYS_REG(0x0)
-#define HDMI_CORE_SYS_DEV_IDL			HDMI_CORE_SYS_REG(0x8)
-#define HDMI_CORE_SYS_DEV_IDH			HDMI_CORE_SYS_REG(0xC)
-#define HDMI_CORE_SYS_DEV_REV			HDMI_CORE_SYS_REG(0x10)
-#define HDMI_CORE_SYS_SRST			HDMI_CORE_SYS_REG(0x14)
-#define HDMI_CORE_CTRL1			HDMI_CORE_SYS_REG(0x20)
-#define HDMI_CORE_SYS_SYS_STAT			HDMI_CORE_SYS_REG(0x24)
-#define HDMI_CORE_SYS_VID_ACEN			HDMI_CORE_SYS_REG(0x124)
-#define HDMI_CORE_SYS_VID_MODE			HDMI_CORE_SYS_REG(0x128)
-#define HDMI_CORE_SYS_INTR_STATE		HDMI_CORE_SYS_REG(0x1C0)
-#define HDMI_CORE_SYS_INTR1			HDMI_CORE_SYS_REG(0x1C4)
-#define HDMI_CORE_SYS_INTR2			HDMI_CORE_SYS_REG(0x1C8)
-#define HDMI_CORE_SYS_INTR3			HDMI_CORE_SYS_REG(0x1CC)
-#define HDMI_CORE_SYS_INTR4			HDMI_CORE_SYS_REG(0x1D0)
-#define HDMI_CORE_SYS_UMASK1			HDMI_CORE_SYS_REG(0x1D4)
-#define HDMI_CORE_SYS_TMDS_CTRL		HDMI_CORE_SYS_REG(0x208)
-#define HDMI_CORE_SYS_DE_DLY			HDMI_CORE_SYS_REG(0xC8)
-#define HDMI_CORE_SYS_DE_CTRL			HDMI_CORE_SYS_REG(0xCC)
-#define HDMI_CORE_SYS_DE_TOP			HDMI_CORE_SYS_REG(0xD0)
-#define HDMI_CORE_SYS_DE_CNTL			HDMI_CORE_SYS_REG(0xD8)
-#define HDMI_CORE_SYS_DE_CNTH			HDMI_CORE_SYS_REG(0xDC)
-#define HDMI_CORE_SYS_DE_LINL			HDMI_CORE_SYS_REG(0xE0)
-#define HDMI_CORE_SYS_DE_LINH_1		HDMI_CORE_SYS_REG(0xE4)
+
+#define HDMI_CORE_SYS_VND_IDL			HDMI_REG(0x0)
+#define HDMI_CORE_SYS_DEV_IDL			HDMI_REG(0x8)
+#define HDMI_CORE_SYS_DEV_IDH			HDMI_REG(0xC)
+#define HDMI_CORE_SYS_DEV_REV			HDMI_REG(0x10)
+#define HDMI_CORE_SYS_SRST			HDMI_REG(0x14)
+#define HDMI_CORE_CTRL1				HDMI_REG(0x20)
+#define HDMI_CORE_SYS_SYS_STAT			HDMI_REG(0x24)
+#define HDMI_CORE_SYS_VID_ACEN			HDMI_REG(0x124)
+#define HDMI_CORE_SYS_VID_MODE			HDMI_REG(0x128)
+#define HDMI_CORE_SYS_INTR_STATE		HDMI_REG(0x1C0)
+#define HDMI_CORE_SYS_INTR1			HDMI_REG(0x1C4)
+#define HDMI_CORE_SYS_INTR2			HDMI_REG(0x1C8)
+#define HDMI_CORE_SYS_INTR3			HDMI_REG(0x1CC)
+#define HDMI_CORE_SYS_INTR4			HDMI_REG(0x1D0)
+#define HDMI_CORE_SYS_UMASK1			HDMI_REG(0x1D4)
+#define HDMI_CORE_SYS_TMDS_CTRL			HDMI_REG(0x208)
+#define HDMI_CORE_SYS_DE_DLY			HDMI_REG(0xC8)
+#define HDMI_CORE_SYS_DE_CTRL			HDMI_REG(0xCC)
+#define HDMI_CORE_SYS_DE_TOP			HDMI_REG(0xD0)
+#define HDMI_CORE_SYS_DE_CNTL			HDMI_REG(0xD8)
+#define HDMI_CORE_SYS_DE_CNTH			HDMI_REG(0xDC)
+#define HDMI_CORE_SYS_DE_LINL			HDMI_REG(0xE0)
+#define HDMI_CORE_SYS_DE_LINH_1			HDMI_REG(0xE4)
 #define HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC	0x1
 #define HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC	0x1
 #define HDMI_CORE_CTRL1_BSEL_24BITBUS		0x1
 #define HDMI_CORE_CTRL1_EDGE_RISINGEDGE	0x1
 
 /* HDMI DDC E-DID */
-#define HDMI_CORE_DDC_CMD			HDMI_CORE_SYS_REG(0x3CC)
-#define HDMI_CORE_DDC_STATUS			HDMI_CORE_SYS_REG(0x3C8)
-#define HDMI_CORE_DDC_ADDR			HDMI_CORE_SYS_REG(0x3B4)
-#define HDMI_CORE_DDC_OFFSET			HDMI_CORE_SYS_REG(0x3BC)
-#define HDMI_CORE_DDC_COUNT1			HDMI_CORE_SYS_REG(0x3C0)
-#define HDMI_CORE_DDC_COUNT2			HDMI_CORE_SYS_REG(0x3C4)
-#define HDMI_CORE_DDC_DATA			HDMI_CORE_SYS_REG(0x3D0)
-#define HDMI_CORE_DDC_SEGM			HDMI_CORE_SYS_REG(0x3B8)
+#define HDMI_CORE_DDC_CMD			HDMI_REG(0x3CC)
+#define HDMI_CORE_DDC_STATUS			HDMI_REG(0x3C8)
+#define HDMI_CORE_DDC_ADDR			HDMI_REG(0x3B4)
+#define HDMI_CORE_DDC_OFFSET			HDMI_REG(0x3BC)
+#define HDMI_CORE_DDC_COUNT1			HDMI_REG(0x3C0)
+#define HDMI_CORE_DDC_COUNT2			HDMI_REG(0x3C4)
+#define HDMI_CORE_DDC_DATA			HDMI_REG(0x3D0)
+#define HDMI_CORE_DDC_SEGM			HDMI_REG(0x3B8)
 
 /* HDMI IP Core Audio Video */
-#define HDMI_CORE_AV_REG(idx)			HDMI_REG(HDMI_CORE_AV + idx)
-
-#define HDMI_CORE_AV_HDMI_CTRL			HDMI_CORE_AV_REG(0xBC)
-#define HDMI_CORE_AV_DPD			HDMI_CORE_AV_REG(0xF4)
-#define HDMI_CORE_AV_PB_CTRL1			HDMI_CORE_AV_REG(0xF8)
-#define HDMI_CORE_AV_PB_CTRL2			HDMI_CORE_AV_REG(0xFC)
-#define HDMI_CORE_AV_AVI_TYPE			HDMI_CORE_AV_REG(0x100)
-#define HDMI_CORE_AV_AVI_VERS			HDMI_CORE_AV_REG(0x104)
-#define HDMI_CORE_AV_AVI_LEN			HDMI_CORE_AV_REG(0x108)
-#define HDMI_CORE_AV_AVI_CHSUM			HDMI_CORE_AV_REG(0x10C)
-#define HDMI_CORE_AV_AVI_DBYTE(n)		HDMI_CORE_AV_REG(n * 4 + 0x110)
-#define HDMI_CORE_AV_AVI_DBYTE_NELEMS		HDMI_CORE_AV_REG(15)
-#define HDMI_CORE_AV_SPD_DBYTE			HDMI_CORE_AV_REG(0x190)
-#define HDMI_CORE_AV_SPD_DBYTE_NELEMS		HDMI_CORE_AV_REG(27)
-#define HDMI_CORE_AV_AUD_DBYTE(n)		HDMI_CORE_AV_REG(n * 4 + 0x210)
-#define HDMI_CORE_AV_AUD_DBYTE_NELEMS		HDMI_CORE_AV_REG(10)
-#define HDMI_CORE_AV_MPEG_DBYTE		HDMI_CORE_AV_REG(0x290)
-#define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		HDMI_CORE_AV_REG(27)
-#define HDMI_CORE_AV_GEN_DBYTE			HDMI_CORE_AV_REG(0x300)
-#define HDMI_CORE_AV_GEN_DBYTE_NELEMS		HDMI_CORE_AV_REG(31)
-#define HDMI_CORE_AV_GEN2_DBYTE		HDMI_CORE_AV_REG(0x380)
-#define HDMI_CORE_AV_GEN2_DBYTE_NELEMS		HDMI_CORE_AV_REG(31)
-#define HDMI_CORE_AV_ACR_CTRL			HDMI_CORE_AV_REG(0x4)
-#define HDMI_CORE_AV_FREQ_SVAL			HDMI_CORE_AV_REG(0x8)
-#define HDMI_CORE_AV_N_SVAL1			HDMI_CORE_AV_REG(0xC)
-#define HDMI_CORE_AV_N_SVAL2			HDMI_CORE_AV_REG(0x10)
-#define HDMI_CORE_AV_N_SVAL3			HDMI_CORE_AV_REG(0x14)
-#define HDMI_CORE_AV_CTS_SVAL1			HDMI_CORE_AV_REG(0x18)
-#define HDMI_CORE_AV_CTS_SVAL2			HDMI_CORE_AV_REG(0x1C)
-#define HDMI_CORE_AV_CTS_SVAL3			HDMI_CORE_AV_REG(0x20)
-#define HDMI_CORE_AV_CTS_HVAL1			HDMI_CORE_AV_REG(0x24)
-#define HDMI_CORE_AV_CTS_HVAL2			HDMI_CORE_AV_REG(0x28)
-#define HDMI_CORE_AV_CTS_HVAL3			HDMI_CORE_AV_REG(0x2C)
-#define HDMI_CORE_AV_AUD_MODE			HDMI_CORE_AV_REG(0x50)
-#define HDMI_CORE_AV_SPDIF_CTRL		HDMI_CORE_AV_REG(0x54)
-#define HDMI_CORE_AV_HW_SPDIF_FS		HDMI_CORE_AV_REG(0x60)
-#define HDMI_CORE_AV_SWAP_I2S			HDMI_CORE_AV_REG(0x64)
-#define HDMI_CORE_AV_SPDIF_ERTH		HDMI_CORE_AV_REG(0x6C)
-#define HDMI_CORE_AV_I2S_IN_MAP		HDMI_CORE_AV_REG(0x70)
-#define HDMI_CORE_AV_I2S_IN_CTRL		HDMI_CORE_AV_REG(0x74)
-#define HDMI_CORE_AV_I2S_CHST0			HDMI_CORE_AV_REG(0x78)
-#define HDMI_CORE_AV_I2S_CHST1			HDMI_CORE_AV_REG(0x7C)
-#define HDMI_CORE_AV_I2S_CHST2			HDMI_CORE_AV_REG(0x80)
-#define HDMI_CORE_AV_I2S_CHST4			HDMI_CORE_AV_REG(0x84)
-#define HDMI_CORE_AV_I2S_CHST5			HDMI_CORE_AV_REG(0x88)
-#define HDMI_CORE_AV_ASRC			HDMI_CORE_AV_REG(0x8C)
-#define HDMI_CORE_AV_I2S_IN_LEN		HDMI_CORE_AV_REG(0x90)
-#define HDMI_CORE_AV_HDMI_CTRL			HDMI_CORE_AV_REG(0xBC)
-#define HDMI_CORE_AV_AUDO_TXSTAT		HDMI_CORE_AV_REG(0xC0)
-#define HDMI_CORE_AV_AUD_PAR_BUSCLK_1		HDMI_CORE_AV_REG(0xCC)
-#define HDMI_CORE_AV_AUD_PAR_BUSCLK_2		HDMI_CORE_AV_REG(0xD0)
-#define HDMI_CORE_AV_AUD_PAR_BUSCLK_3		HDMI_CORE_AV_REG(0xD4)
-#define HDMI_CORE_AV_TEST_TXCTRL		HDMI_CORE_AV_REG(0xF0)
-#define HDMI_CORE_AV_DPD			HDMI_CORE_AV_REG(0xF4)
-#define HDMI_CORE_AV_PB_CTRL1			HDMI_CORE_AV_REG(0xF8)
-#define HDMI_CORE_AV_PB_CTRL2			HDMI_CORE_AV_REG(0xFC)
-#define HDMI_CORE_AV_AVI_TYPE			HDMI_CORE_AV_REG(0x100)
-#define HDMI_CORE_AV_AVI_VERS			HDMI_CORE_AV_REG(0x104)
-#define HDMI_CORE_AV_AVI_LEN			HDMI_CORE_AV_REG(0x108)
-#define HDMI_CORE_AV_AVI_CHSUM			HDMI_CORE_AV_REG(0x10C)
-#define HDMI_CORE_AV_SPD_TYPE			HDMI_CORE_AV_REG(0x180)
-#define HDMI_CORE_AV_SPD_VERS			HDMI_CORE_AV_REG(0x184)
-#define HDMI_CORE_AV_SPD_LEN			HDMI_CORE_AV_REG(0x188)
-#define HDMI_CORE_AV_SPD_CHSUM			HDMI_CORE_AV_REG(0x18C)
-#define HDMI_CORE_AV_AUDIO_TYPE		HDMI_CORE_AV_REG(0x200)
-#define HDMI_CORE_AV_AUDIO_VERS		HDMI_CORE_AV_REG(0x204)
-#define HDMI_CORE_AV_AUDIO_LEN			HDMI_CORE_AV_REG(0x208)
-#define HDMI_CORE_AV_AUDIO_CHSUM		HDMI_CORE_AV_REG(0x20C)
-#define HDMI_CORE_AV_MPEG_TYPE			HDMI_CORE_AV_REG(0x280)
-#define HDMI_CORE_AV_MPEG_VERS			HDMI_CORE_AV_REG(0x284)
-#define HDMI_CORE_AV_MPEG_LEN			HDMI_CORE_AV_REG(0x288)
-#define HDMI_CORE_AV_MPEG_CHSUM		HDMI_CORE_AV_REG(0x28C)
-#define HDMI_CORE_AV_CP_BYTE1			HDMI_CORE_AV_REG(0x37C)
-#define HDMI_CORE_AV_CEC_ADDR_ID		HDMI_CORE_AV_REG(0x3FC)
+
+#define HDMI_CORE_AV_HDMI_CTRL			HDMI_REG(0xBC)
+#define HDMI_CORE_AV_DPD			HDMI_REG(0xF4)
+#define HDMI_CORE_AV_PB_CTRL1			HDMI_REG(0xF8)
+#define HDMI_CORE_AV_PB_CTRL2			HDMI_REG(0xFC)
+#define HDMI_CORE_AV_AVI_TYPE			HDMI_REG(0x100)
+#define HDMI_CORE_AV_AVI_VERS			HDMI_REG(0x104)
+#define HDMI_CORE_AV_AVI_LEN			HDMI_REG(0x108)
+#define HDMI_CORE_AV_AVI_CHSUM			HDMI_REG(0x10C)
+#define HDMI_CORE_AV_AVI_DBYTE(n)		HDMI_REG(n * 4 + 0x110)
+#define HDMI_CORE_AV_AVI_DBYTE_NELEMS		HDMI_REG(15)
+#define HDMI_CORE_AV_SPD_DBYTE			HDMI_REG(0x190)
+#define HDMI_CORE_AV_SPD_DBYTE_NELEMS		HDMI_REG(27)
+#define HDMI_CORE_AV_AUD_DBYTE(n)		HDMI_REG(n * 4 + 0x210)
+#define HDMI_CORE_AV_AUD_DBYTE_NELEMS		HDMI_REG(10)
+#define HDMI_CORE_AV_MPEG_DBYTE			HDMI_REG(0x290)
+#define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		HDMI_REG(27)
+#define HDMI_CORE_AV_GEN_DBYTE			HDMI_REG(0x300)
+#define HDMI_CORE_AV_GEN_DBYTE_NELEMS		HDMI_REG(31)
+#define HDMI_CORE_AV_GEN2_DBYTE			HDMI_REG(0x380)
+#define HDMI_CORE_AV_GEN2_DBYTE_NELEMS		HDMI_REG(31)
+#define HDMI_CORE_AV_ACR_CTRL			HDMI_REG(0x4)
+#define HDMI_CORE_AV_FREQ_SVAL			HDMI_REG(0x8)
+#define HDMI_CORE_AV_N_SVAL1			HDMI_REG(0xC)
+#define HDMI_CORE_AV_N_SVAL2			HDMI_REG(0x10)
+#define HDMI_CORE_AV_N_SVAL3			HDMI_REG(0x14)
+#define HDMI_CORE_AV_CTS_SVAL1			HDMI_REG(0x18)
+#define HDMI_CORE_AV_CTS_SVAL2			HDMI_REG(0x1C)
+#define HDMI_CORE_AV_CTS_SVAL3			HDMI_REG(0x20)
+#define HDMI_CORE_AV_CTS_HVAL1			HDMI_REG(0x24)
+#define HDMI_CORE_AV_CTS_HVAL2			HDMI_REG(0x28)
+#define HDMI_CORE_AV_CTS_HVAL3			HDMI_REG(0x2C)
+#define HDMI_CORE_AV_AUD_MODE			HDMI_REG(0x50)
+#define HDMI_CORE_AV_SPDIF_CTRL			HDMI_REG(0x54)
+#define HDMI_CORE_AV_HW_SPDIF_FS		HDMI_REG(0x60)
+#define HDMI_CORE_AV_SWAP_I2S			HDMI_REG(0x64)
+#define HDMI_CORE_AV_SPDIF_ERTH			HDMI_REG(0x6C)
+#define HDMI_CORE_AV_I2S_IN_MAP			HDMI_REG(0x70)
+#define HDMI_CORE_AV_I2S_IN_CTRL		HDMI_REG(0x74)
+#define HDMI_CORE_AV_I2S_CHST0			HDMI_REG(0x78)
+#define HDMI_CORE_AV_I2S_CHST1			HDMI_REG(0x7C)
+#define HDMI_CORE_AV_I2S_CHST2			HDMI_REG(0x80)
+#define HDMI_CORE_AV_I2S_CHST4			HDMI_REG(0x84)
+#define HDMI_CORE_AV_I2S_CHST5			HDMI_REG(0x88)
+#define HDMI_CORE_AV_ASRC			HDMI_REG(0x8C)
+#define HDMI_CORE_AV_I2S_IN_LEN			HDMI_REG(0x90)
+#define HDMI_CORE_AV_HDMI_CTRL			HDMI_REG(0xBC)
+#define HDMI_CORE_AV_AUDO_TXSTAT		HDMI_REG(0xC0)
+#define HDMI_CORE_AV_AUD_PAR_BUSCLK_1		HDMI_REG(0xCC)
+#define HDMI_CORE_AV_AUD_PAR_BUSCLK_2		HDMI_REG(0xD0)
+#define HDMI_CORE_AV_AUD_PAR_BUSCLK_3		HDMI_REG(0xD4)
+#define HDMI_CORE_AV_TEST_TXCTRL		HDMI_REG(0xF0)
+#define HDMI_CORE_AV_DPD			HDMI_REG(0xF4)
+#define HDMI_CORE_AV_PB_CTRL1			HDMI_REG(0xF8)
+#define HDMI_CORE_AV_PB_CTRL2			HDMI_REG(0xFC)
+#define HDMI_CORE_AV_AVI_TYPE			HDMI_REG(0x100)
+#define HDMI_CORE_AV_AVI_VERS			HDMI_REG(0x104)
+#define HDMI_CORE_AV_AVI_LEN			HDMI_REG(0x108)
+#define HDMI_CORE_AV_AVI_CHSUM			HDMI_REG(0x10C)
+#define HDMI_CORE_AV_SPD_TYPE			HDMI_REG(0x180)
+#define HDMI_CORE_AV_SPD_VERS			HDMI_REG(0x184)
+#define HDMI_CORE_AV_SPD_LEN			HDMI_REG(0x188)
+#define HDMI_CORE_AV_SPD_CHSUM			HDMI_REG(0x18C)
+#define HDMI_CORE_AV_AUDIO_TYPE			HDMI_REG(0x200)
+#define HDMI_CORE_AV_AUDIO_VERS			HDMI_REG(0x204)
+#define HDMI_CORE_AV_AUDIO_LEN			HDMI_REG(0x208)
+#define HDMI_CORE_AV_AUDIO_CHSUM		HDMI_REG(0x20C)
+#define HDMI_CORE_AV_MPEG_TYPE			HDMI_REG(0x280)
+#define HDMI_CORE_AV_MPEG_VERS			HDMI_REG(0x284)
+#define HDMI_CORE_AV_MPEG_LEN			HDMI_REG(0x288)
+#define HDMI_CORE_AV_MPEG_CHSUM			HDMI_REG(0x28C)
+#define HDMI_CORE_AV_CP_BYTE1			HDMI_REG(0x37C)
+#define HDMI_CORE_AV_CEC_ADDR_ID		HDMI_REG(0x3FC)
 #define HDMI_CORE_AV_SPD_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_GEN2_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_MPEG_DBYTE_ELSIZE		0x4
 #define HDMI_CORE_AV_GEN_DBYTE_ELSIZE		0x4
 
 /* PLL */
-#define HDMI_PLL_REG(idx)			HDMI_REG(HDMI_PLLCTRL + idx)
 
-#define PLLCTRL_PLL_CONTROL			HDMI_PLL_REG(0x0)
-#define PLLCTRL_PLL_STATUS			HDMI_PLL_REG(0x4)
-#define PLLCTRL_PLL_GO				HDMI_PLL_REG(0x8)
-#define PLLCTRL_CFG1				HDMI_PLL_REG(0xC)
-#define PLLCTRL_CFG2				HDMI_PLL_REG(0x10)
-#define PLLCTRL_CFG3				HDMI_PLL_REG(0x14)
-#define PLLCTRL_CFG4				HDMI_PLL_REG(0x20)
+#define PLLCTRL_PLL_CONTROL			HDMI_REG(0x0)
+#define PLLCTRL_PLL_STATUS			HDMI_REG(0x4)
+#define PLLCTRL_PLL_GO				HDMI_REG(0x8)
+#define PLLCTRL_CFG1				HDMI_REG(0xC)
+#define PLLCTRL_CFG2				HDMI_REG(0x10)
+#define PLLCTRL_CFG3				HDMI_REG(0x14)
+#define PLLCTRL_CFG4				HDMI_REG(0x20)
 
 /* HDMI PHY */
-#define HDMI_PHY_REG(idx)			HDMI_REG(HDMI_PHY + idx)
 
-#define HDMI_TXPHY_TX_CTRL			HDMI_PHY_REG(0x0)
-#define HDMI_TXPHY_DIGITAL_CTRL		HDMI_PHY_REG(0x4)
-#define HDMI_TXPHY_POWER_CTRL			HDMI_PHY_REG(0x8)
-#define HDMI_TXPHY_PAD_CFG_CTRL		HDMI_PHY_REG(0xC)
+#define HDMI_TXPHY_TX_CTRL			HDMI_REG(0x0)
+#define HDMI_TXPHY_DIGITAL_CTRL			HDMI_REG(0x4)
+#define HDMI_TXPHY_POWER_CTRL			HDMI_REG(0x8)
+#define HDMI_TXPHY_PAD_CFG_CTRL			HDMI_REG(0xC)
 
 /* HDMI EDID Length  */
 #define HDMI_EDID_MAX_LENGTH			256
@@ -203,10 +192,11 @@ struct hdmi_reg { u16 idx; };
 
 #define OMAP_HDMI_TIMINGS_NB			34
 
-#define REG_FLD_MOD(idx, val, start, end) \
-	hdmi_write_reg(idx, FLD_MOD(hdmi_read_reg(idx), val, start, end))
-#define REG_GET(idx, start, end) \
-	FLD_GET(hdmi_read_reg(idx), start, end)
+#define REG_FLD_MOD(base, idx, val, start, end) \
+	hdmi_write_reg(base, idx, FLD_MOD(hdmi_read_reg(base, idx),\
+							val, start, end))
+#define REG_GET(base, idx, start, end) \
+	FLD_GET(hdmi_read_reg(base, idx), start, end)
 
 /* HDMI timing structure */
 struct hdmi_timings {
@@ -568,6 +558,14 @@ struct hdmi_video_interface {
 	int	tm;	/* Timing mode */
 };
 
+struct hdmi_ip_data {
+	void __iomem	*base_wp;	/* HDMI wrapper */
+	unsigned long	hdmi_core_sys_offset;
+	unsigned long	hdmi_core_av_offset;
+	unsigned long	hdmi_pll_offset;
+	unsigned long	hdmi_phy_offset;
+};
+
 struct hdmi_cm {
 	int	code;
 	int	mode;
-- 
1.7.5.4

