From: <mythripk@ti.com>
Subject: [PATCH 4/5] OMAPDSS: HDMI: Add support to dump registers through
Date: Tue, 20 Sep 2011 18:19:13 +0530
Message-ID: <1316522954-16594-5-git-send-email-mythripk@ti.com>
References: <1316522954-16594-1-git-send-email-mythripk@ti.com>
 <1316522954-16594-2-git-send-email-mythripk@ti.com>
 <1316522954-16594-3-git-send-email-mythripk@ti.com>
 <1316522954-16594-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53932 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab1ITM5U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 08:57:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8KCvHLg029549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 07:57:19 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8KCvGp3005709
	for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 18:27:16 +0530 (IST)
In-Reply-To: <1316522954-16594-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support to dump the HDMI core, PLL and PHY registers through debugfs

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/core.c            |    4 +
 drivers/video/omap2/dss/dss.h             |    1 +
 drivers/video/omap2/dss/dss_features.c    |    5 +
 drivers/video/omap2/dss/hdmi.c            |   16 +++
 drivers/video/omap2/dss/ti_hdmi.h         |   14 +++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  168 +++++++++++++++++++++++++++++
 6 files changed, 208 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 76821fe..86ec12e 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -145,6 +145,10 @@ static int dss_initialize_debugfs(void)
 	debugfs_create_file("venc", S_IRUGO, dss_debugfs_dir,
 			&venc_dump_regs, &dss_debug_fops);
 #endif
+#ifdef CONFIG_OMAP4_DSS_HDMI
+	debugfs_create_file("hdmi", S_IRUGO, dss_debugfs_dir,
+			&hdmi_dump_regs, &dss_debug_fops);
+#endif
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 47eebd8..8652007 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -472,6 +472,7 @@ int hdmi_init_platform_driver(void);
 void hdmi_uninit_platform_driver(void);
 int hdmi_init_display(struct omap_dss_device *dssdev);
 unsigned long hdmi_get_pixel_clock(void);
+void hdmi_dump_regs(struct seq_file *s);
 #else
 static inline int hdmi_init_display(struct omap_dss_device *dssdev)
 {
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 47e66d8..a2fc8e0 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -447,6 +447,11 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.pll_enable		=	ti_hdmi_4xxx_pll_enable,
 	.pll_disable		=	ti_hdmi_4xxx_pll_disable,
 	.video_enable		=	ti_hdmi_4xxx_wp_video_start,
+	.dump_wrapper		=	ti_hdmi_4xxx_wp_dump,
+	.dump_core		=	ti_hdmi_4xxx_core_dump,
+	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
+	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
+
 };
 
 void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data)
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2f554ae..3262f0f 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -438,6 +438,22 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	}
 }
 
+void hdmi_dump_regs(struct seq_file *s)
+{
+	mutex_lock(&hdmi.lock);
+
+	if (hdmi_runtime_get())
+		return;
+
+	hdmi.ip_data.ops->dump_wrapper(&hdmi.ip_data, s);
+	hdmi.ip_data.ops->dump_pll(&hdmi.ip_data, s);
+	hdmi.ip_data.ops->dump_phy(&hdmi.ip_data, s);
+	hdmi.ip_data.ops->dump_core(&hdmi.ip_data, s);
+
+	hdmi_runtime_put();
+	mutex_unlock(&hdmi.lock);
+}
+
 int omapdss_hdmi_read_edid(u8 *buf, int len)
 {
 	int r;
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index d48603c..2c3443d 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -101,6 +101,15 @@ struct ti_hdmi_ip_ops {
 	void (*pll_disable)(struct hdmi_ip_data *ip_data);
 
 	void (*video_enable)(struct hdmi_ip_data *ip_data, bool start);
+
+	void (*dump_wrapper)(struct hdmi_ip_data *ip_data, struct seq_file *s);
+
+	void (*dump_core)(struct hdmi_ip_data *ip_data, struct seq_file *s);
+
+	void (*dump_pll)(struct hdmi_ip_data *ip_data, struct seq_file *s);
+
+	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
+
 };
 
 struct hdmi_ip_data {
@@ -121,4 +130,9 @@ void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
 int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data);
+void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
+void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
+void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
+void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
+
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 5f22d2e..8355c4f 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/string.h>
+#include <linux/seq_file.h>
 
 #include "ti_hdmi_4xxx_ip.h"
 #include "dss.h"
@@ -805,6 +806,173 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 	hdmi_core_av_packet_config(ip_data, repeat_cfg);
 }
 
+void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
+{
+#define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r,\
+		hdmi_read_reg(hdmi_wp_base(ip_data), r))
+	DUMPREG(HDMI_WP_REVISION);
+	DUMPREG(HDMI_WP_SYSCONFIG);
+	DUMPREG(HDMI_WP_IRQSTATUS_RAW);
+	DUMPREG(HDMI_WP_IRQSTATUS);
+	DUMPREG(HDMI_WP_PWR_CTRL);
+	DUMPREG(HDMI_WP_IRQENABLE_SET);
+	DUMPREG(HDMI_WP_VIDEO_CFG);
+	DUMPREG(HDMI_WP_VIDEO_SIZE);
+	DUMPREG(HDMI_WP_VIDEO_TIMING_H);
+	DUMPREG(HDMI_WP_VIDEO_TIMING_V);
+	DUMPREG(HDMI_WP_WP_CLK);
+	DUMPREG(HDMI_WP_AUDIO_CFG);
+	DUMPREG(HDMI_WP_AUDIO_CFG2);
+	DUMPREG(HDMI_WP_AUDIO_CTRL);
+	DUMPREG(HDMI_WP_AUDIO_DATA);
+}
+
+void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
+{
+#define DUMPPLL(r) seq_printf(s, "%-35s %08x\n", #r,\
+		hdmi_read_reg(hdmi_pll_base(ip_data), r))
+	DUMPPLL(PLLCTRL_PLL_CONTROL);
+	DUMPPLL(PLLCTRL_PLL_STATUS);
+	DUMPPLL(PLLCTRL_PLL_GO);
+	DUMPPLL(PLLCTRL_CFG1);
+	DUMPPLL(PLLCTRL_CFG2);
+	DUMPPLL(PLLCTRL_CFG3);
+	DUMPPLL(PLLCTRL_CFG4);
+}
+
+void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
+{
+	int i;
+#define DUMPCORE(r) seq_printf(s, "%-35s %08x\n", #r,\
+		hdmi_read_reg(hdmi_pll_base(ip_data), r))
+
+	DUMPCORE(HDMI_CORE_SYS_VND_IDL);
+	DUMPCORE(HDMI_CORE_SYS_DEV_IDL);
+	DUMPCORE(HDMI_CORE_SYS_DEV_IDH);
+	DUMPCORE(HDMI_CORE_SYS_DEV_REV);
+	DUMPCORE(HDMI_CORE_SYS_SRST);
+	DUMPCORE(HDMI_CORE_CTRL1);
+	DUMPCORE(HDMI_CORE_SYS_SYS_STAT);
+	DUMPCORE(HDMI_CORE_SYS_VID_ACEN);
+	DUMPCORE(HDMI_CORE_SYS_VID_MODE);
+	DUMPCORE(HDMI_CORE_SYS_INTR_STATE);
+	DUMPCORE(HDMI_CORE_SYS_INTR1);
+	DUMPCORE(HDMI_CORE_SYS_INTR2);
+	DUMPCORE(HDMI_CORE_SYS_INTR3);
+	DUMPCORE(HDMI_CORE_SYS_INTR4);
+	DUMPCORE(HDMI_CORE_SYS_UMASK1);
+	DUMPCORE(HDMI_CORE_SYS_TMDS_CTRL);
+	DUMPCORE(HDMI_CORE_SYS_DE_DLY);
+	DUMPCORE(HDMI_CORE_SYS_DE_CTRL);
+	DUMPCORE(HDMI_CORE_SYS_DE_TOP);
+	DUMPCORE(HDMI_CORE_SYS_DE_CNTL);
+	DUMPCORE(HDMI_CORE_SYS_DE_CNTH);
+	DUMPCORE(HDMI_CORE_SYS_DE_LINL);
+	DUMPCORE(HDMI_CORE_SYS_DE_LINH_1);
+
+	DUMPCORE(HDMI_CORE_DDC_CMD);
+	DUMPCORE(HDMI_CORE_DDC_STATUS);
+	DUMPCORE(HDMI_CORE_DDC_ADDR);
+	DUMPCORE(HDMI_CORE_DDC_OFFSET);
+	DUMPCORE(HDMI_CORE_DDC_COUNT1);
+	DUMPCORE(HDMI_CORE_DDC_COUNT2);
+	DUMPCORE(HDMI_CORE_DDC_DATA);
+	DUMPCORE(HDMI_CORE_DDC_SEGM);
+
+	DUMPCORE(HDMI_CORE_AV_HDMI_CTRL);
+	DUMPCORE(HDMI_CORE_AV_DPD);
+	DUMPCORE(HDMI_CORE_AV_PB_CTRL1);
+	DUMPCORE(HDMI_CORE_AV_PB_CTRL2);
+	DUMPCORE(HDMI_CORE_AV_AVI_TYPE);
+	DUMPCORE(HDMI_CORE_AV_AVI_VERS);
+	DUMPCORE(HDMI_CORE_AV_AVI_LEN);
+	DUMPCORE(HDMI_CORE_AV_AVI_CHSUM);
+
+	for (i = 0; i < HDMI_CORE_AV_AVI_DBYTE_NELEMS; i++)
+		DUMPCORE(HDMI_CORE_AV_AVI_DBYTE(i));
+
+	for (i = 0; i < HDMI_CORE_AV_SPD_DBYTE_NELEMS; i++)
+		DUMPCORE(HDMI_CORE_AV_SPD_DBYTE(i));
+
+	for (i = 0; i < HDMI_CORE_AV_AUD_DBYTE_NELEMS; i++)
+		DUMPCORE(HDMI_CORE_AV_AUD_DBYTE(i));
+
+	for (i = 0; i < HDMI_CORE_AV_MPEG_DBYTE_NELEMS; i++)
+		DUMPCORE(HDMI_CORE_AV_MPEG_DBYTE(i));
+
+	for (i = 0; i < HDMI_CORE_AV_GEN_DBYTE_NELEMS; i++)
+		DUMPCORE(HDMI_CORE_AV_GEN_DBYTE(i));
+
+	for (i = 0; i < HDMI_CORE_AV_GEN2_DBYTE_NELEMS; i++)
+		DUMPCORE(HDMI_CORE_AV_GEN2_DBYTE(i));
+
+	DUMPCORE(HDMI_CORE_AV_ACR_CTRL);
+	DUMPCORE(HDMI_CORE_AV_FREQ_SVAL);
+	DUMPCORE(HDMI_CORE_AV_N_SVAL1);
+	DUMPCORE(HDMI_CORE_AV_N_SVAL2);
+	DUMPCORE(HDMI_CORE_AV_N_SVAL3);
+	DUMPCORE(HDMI_CORE_AV_CTS_SVAL1);
+	DUMPCORE(HDMI_CORE_AV_CTS_SVAL2);
+	DUMPCORE(HDMI_CORE_AV_CTS_SVAL3);
+	DUMPCORE(HDMI_CORE_AV_CTS_HVAL1);
+	DUMPCORE(HDMI_CORE_AV_CTS_HVAL2);
+	DUMPCORE(HDMI_CORE_AV_CTS_HVAL3);
+	DUMPCORE(HDMI_CORE_AV_AUD_MODE);
+	DUMPCORE(HDMI_CORE_AV_SPDIF_CTRL);
+	DUMPCORE(HDMI_CORE_AV_HW_SPDIF_FS);
+	DUMPCORE(HDMI_CORE_AV_SWAP_I2S);
+	DUMPCORE(HDMI_CORE_AV_SPDIF_ERTH);
+	DUMPCORE(HDMI_CORE_AV_I2S_IN_MAP);
+	DUMPCORE(HDMI_CORE_AV_I2S_IN_CTRL);
+	DUMPCORE(HDMI_CORE_AV_I2S_CHST0);
+	DUMPCORE(HDMI_CORE_AV_I2S_CHST1);
+	DUMPCORE(HDMI_CORE_AV_I2S_CHST2);
+	DUMPCORE(HDMI_CORE_AV_I2S_CHST4);
+	DUMPCORE(HDMI_CORE_AV_I2S_CHST5);
+	DUMPCORE(HDMI_CORE_AV_ASRC);
+	DUMPCORE(HDMI_CORE_AV_I2S_IN_LEN);
+	DUMPCORE(HDMI_CORE_AV_HDMI_CTRL);
+	DUMPCORE(HDMI_CORE_AV_AUDO_TXSTAT);
+	DUMPCORE(HDMI_CORE_AV_AUD_PAR_BUSCLK_1);
+	DUMPCORE(HDMI_CORE_AV_AUD_PAR_BUSCLK_2);
+	DUMPCORE(HDMI_CORE_AV_AUD_PAR_BUSCLK_3);
+	DUMPCORE(HDMI_CORE_AV_TEST_TXCTRL);
+	DUMPCORE(HDMI_CORE_AV_DPD);
+	DUMPCORE(HDMI_CORE_AV_PB_CTRL1);
+	DUMPCORE(HDMI_CORE_AV_PB_CTRL2);
+	DUMPCORE(HDMI_CORE_AV_AVI_TYPE);
+	DUMPCORE(HDMI_CORE_AV_AVI_VERS);
+	DUMPCORE(HDMI_CORE_AV_AVI_LEN);
+	DUMPCORE(HDMI_CORE_AV_AVI_CHSUM);
+	DUMPCORE(HDMI_CORE_AV_SPD_TYPE);
+	DUMPCORE(HDMI_CORE_AV_SPD_VERS);
+	DUMPCORE(HDMI_CORE_AV_SPD_LEN);
+	DUMPCORE(HDMI_CORE_AV_SPD_CHSUM);
+	DUMPCORE(HDMI_CORE_AV_AUDIO_TYPE);
+	DUMPCORE(HDMI_CORE_AV_AUDIO_VERS);
+	DUMPCORE(HDMI_CORE_AV_AUDIO_LEN);
+	DUMPCORE(HDMI_CORE_AV_AUDIO_CHSUM);
+	DUMPCORE(HDMI_CORE_AV_MPEG_TYPE);
+	DUMPCORE(HDMI_CORE_AV_MPEG_VERS);
+	DUMPCORE(HDMI_CORE_AV_MPEG_LEN);
+	DUMPCORE(HDMI_CORE_AV_MPEG_CHSUM);
+	DUMPCORE(HDMI_CORE_AV_CP_BYTE1);
+	DUMPCORE(HDMI_CORE_AV_CEC_ADDR_ID);
+}
+
+void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
+{
+#define DUMPPHY(r) seq_printf(s, "%-35s %08x\n", #r,\
+		hdmi_read_reg(hdmi_pll_base(ip_data), r))
+	DUMPPHY(PLLCTRL_PLL_CONTROL);
+	DUMPPHY(PLLCTRL_PLL_STATUS);
+	DUMPPHY(PLLCTRL_PLL_GO);
+	DUMPPHY(PLLCTRL_CFG1);
+	DUMPPHY(PLLCTRL_CFG2);
+	DUMPPHY(PLLCTRL_CFG3);
+	DUMPPHY(PLLCTRL_CFG4);
+}
+
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
-- 
1.7.5.4

