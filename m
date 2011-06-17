From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 7/8] HDMI: Move HDMI IP Library from OMAP DSS to common
Date: Fri, 17 Jun 2011 13:47:16 +0530
Message-ID: <1308298637-29753-8-git-send-email-mythripk@ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
 <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com>
 <1308298637-29753-5-git-send-email-mythripk@ti.com>
 <1308298637-29753-6-git-send-email-mythripk@ti.com>
 <1308298637-29753-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43640 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010Ab1FQIY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 04:24:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5H8OOZj019509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 03:24:26 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5H8ONFR001807
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 13:54:23 +0530 (IST)
In-Reply-To: <1308298637-29753-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Moving support of HDMI IP library from OMAP4 DSS directory to Video directory as
HDMI IP present in both TI OMAP4, TI81xx, TI38xx Processor,Thus the library in
DSS can be reused in TI81xx, TI38xx processors.

Although both these processors have different Display subsytem HDMI IP remains
the same , thus to promote the reuse of code across SoC's, IP library named
hdmi_4xxx_ip.c is moved from DSS to video directory.Also functions are renamed
as the module has to export and the function name would be global symbol table,
hence renaming to function name specific to the library module.

With this approach Independent of their(OMAP/TI81xx/TI38xx) respective DSS, generic IP
configurations will be done using this library.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/Kconfig                           |    7 ++++++
 drivers/video/Makefile                          |    1 +
 drivers/video/{omap2/dss => }/hdmi_ti_4xxx_ip.c |   24 ++++++++++++++++++++++-
 drivers/video/{omap2/dss => }/hdmi_ti_4xxx_ip.h |    5 ++++
 drivers/video/omap2/dss/Kconfig                 |    1 +
 drivers/video/omap2/dss/Makefile                |    1 -
 6 files changed, 37 insertions(+), 2 deletions(-)
 rename drivers/video/{omap2/dss => }/hdmi_ti_4xxx_ip.c (97%)
 rename drivers/video/{omap2/dss => }/hdmi_ti_4xxx_ip.h (98%)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e6a8d8c..2204fef 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2341,6 +2341,13 @@ config FB_PUV3_UNIGFX
 	  Choose this option if you want to use the Unigfx device as a
 	  framebuffer device. Without the support of PCI & AGP.
 
+config HDMI_TI_4XXX_IP
+	tristate
+	default n
+	help
+	  HDMI Library Interface , for TI OMAP4/Netra IP.
+	  See http://www.hdmi.org/ for HDMI specification.
+
 source "drivers/video/omap/Kconfig"
 source "drivers/video/omap2/Kconfig"
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 2ea44b6..3118055 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_FB_SH_MOBILE_HDMI)	  += sh_mobile_hdmi.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-y                             += omap2/
+obj-$(CONFIG_HDMI_TI_4XXX_IP)     += hdmi_ti_4xxx_ip.o
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
diff --git a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c b/drivers/video/hdmi_ti_4xxx_ip.c
similarity index 97%
rename from drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
rename to drivers/video/hdmi_ti_4xxx_ip.c
index 51dc2a8..c8ea145 100644
--- a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
+++ b/drivers/video/hdmi_ti_4xxx_ip.c
@@ -29,7 +29,6 @@
 #include <linux/string.h>
 
 #include "hdmi_ti_4xxx_ip.h"
-#include "dss.h"
 
 static inline void hdmi_write_reg(void __iomem *base_addr,
 				const struct hdmi_reg idx, u32 val)
@@ -179,6 +178,7 @@ if (hdmi_wait_for_bit_change(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL,
 
 	return 0;
 }
+EXPORT_SYMBOL(hdmi_ti_4xxx_set_pll_pwr);
 
 static int hdmi_pll_reset(struct hdmi_ip_data *ip_data)
 {
@@ -264,6 +264,8 @@ void hdmi_ti_4xxx_phy_off(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
+EXPORT_SYMBOL(hdmi_ti_4xxx_phy_init);
+EXPORT_SYMBOL(hdmi_ti_4xxx_phy_off);
 
 static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
 						u8 *pedid, int ext)
@@ -404,6 +406,7 @@ int read_ti_4xxx_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(read_ti_4xxx_edid);
 
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
 			struct hdmi_core_infoframe_avi *avi_cfg,
@@ -631,6 +634,7 @@ void hdmi_ti_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
 {
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
 }
+EXPORT_SYMBOL(hdmi_ti_4xxx_wp_video_start);
 
 static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
 	struct omap_video_timings *timings, struct hdmi_config *param)
@@ -779,3 +783,21 @@ void hdmi_ti_4xxx_basic_configure(struct hdmi_ip_data *ip_data,
 	repeat_cfg.audio_pkt_repeat = HDMI_PACKETREPEATON;
 	hdmi_core_av_packet_config(ip_data, repeat_cfg);
 }
+EXPORT_SYMBOL(hdmi_ti_4xxx_basic_configure);
+
+static int __init hdmi_ti_4xxx_init(void)
+{
+	return 0;
+}
+
+static void __exit hdmi_ti_4xxx_exit(void)
+{
+
+}
+
+module_init(hdmi_ti_4xxx_init);
+module_exit(hdmi_ti_4xxx_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("hdmi_ti_4xxx_ip module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.h b/drivers/video/hdmi_ti_4xxx_ip.h
similarity index 98%
rename from drivers/video/omap2/dss/hdmi_ti_4xxx_ip.h
rename to drivers/video/hdmi_ti_4xxx_ip.h
index 97e573c..b0b8c92 100644
--- a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.h
+++ b/drivers/video/hdmi_ti_4xxx_ip.h
@@ -183,6 +183,11 @@ struct hdmi_reg { u16 idx; };
 #define HDMI_TXPHY_POWER_CTRL			HDMI_REG(0x8)
 #define HDMI_TXPHY_PAD_CFG_CTRL			HDMI_REG(0xC)
 
+#define FLD_MASK(start, end)	(((1 << ((start) - (end) + 1)) - 1) << (end))
+#define FLD_VAL(val, start, end) (((val) << (end)) & FLD_MASK(start, end))
+#define FLD_GET(val, start, end) (((val) & FLD_MASK(start, end)) >> (end))
+#define FLD_MOD(orig, val, start, end) \
+	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
 #define REG_FLD_MOD(base, idx, val, start, end) \
 	hdmi_write_reg(base, idx, FLD_MOD(hdmi_read_reg(base, idx),\
 							val, start, end))
diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 0d12524..8f9420e 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -63,6 +63,7 @@ config OMAP2_DSS_VENC
 config OMAP4_DSS_HDMI
 	bool "HDMI support"
 	depends on ARCH_OMAP4
+	select HDMI_TI_4XXX_IP
         default y
 	help
 	  HDMI Interface. This adds the High Definition Multimedia Interface.
diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index cf967e0..10d9d3b 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -6,5 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
-				    hdmi_ti_4xxx_ip.o \
 				    hdmi_omap4_panel.o
-- 
1.7.5.4

