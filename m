From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/6] OMAPDSS: add omapdss_version
Date: Fri, 28 Sep 2012 13:35:22 +0300
Message-ID: <1348828527-13309-2-git-send-email-tomi.valkeinen@ti.com>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:53510 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753250Ab2I1Kfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:35:51 -0400
Received: by lagh6 with SMTP id h6so966719lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:35:49 -0700 (PDT)
In-Reply-To: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <a0393947@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?UTF-8?q?Rapha=C3=ABl=20Ass=C3=A9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add new enum, omapdss_version, that is used to tell which DSS hardware
version the SoC has. This enum is initialized during platform init, and
passed in the platform data to omapdss driver.

Note that the versions are not "continuous", that is, you cannot check
if the version is less or greater than something, but you need to check
for exact version match. In other words, this is invalid:

/* test if DSS is 3630 or earlier */
if (ver <= OMAPDSS_VER_OMAP3630)
	...

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   38 ++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h       |   14 ++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index ee40739..33555da 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -284,6 +284,35 @@ err:
 	return ERR_PTR(r);
 }
 
+static enum omapdss_version omap_display_get_version(void)
+{
+	if (cpu_is_omap24xx())
+		return OMAPDSS_VER_OMAP24xx;
+	else if (cpu_is_omap3630())
+		return OMAPDSS_VER_OMAP3630;
+	else if (cpu_is_omap34xx()) {
+		if (soc_is_am35xx()) {
+			return OMAPDSS_VER_AM35xx;
+		} else {
+			if (omap_rev() < OMAP3430_REV_ES3_0)
+				return OMAPDSS_VER_OMAP34xx_ES1;
+			else
+				return OMAPDSS_VER_OMAP34xx_ES3;
+		}
+	} else if (omap_rev() == OMAP4430_REV_ES1_0)
+		return OMAPDSS_VER_OMAP4430_ES1;
+	else if (omap_rev() == OMAP4430_REV_ES2_0 ||
+			omap_rev() == OMAP4430_REV_ES2_1 ||
+			omap_rev() == OMAP4430_REV_ES2_2)
+		return OMAPDSS_VER_OMAP4430_ES2;
+	else if (cpu_is_omap44xx())
+		return OMAPDSS_VER_OMAP4;
+	else if (soc_is_omap54xx())
+		return OMAPDSS_VER_OMAP5;
+	else
+		return OMAPDSS_VER_UNKNOWN
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
@@ -291,9 +320,18 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	int i, oh_count;
 	const struct omap_dss_hwmod_data *curr_dss_hwmod;
 	struct platform_device *dss_pdev;
+	enum omapdss_version ver;
 
 	/* create omapdss device */
 
+	ver = omap_display_get_version();
+
+	if (ver == OMAPDSS_VER_UNKNOWN) {
+		pr_err("DSS not supported on this SoC\n");
+		return -ENODEV;
+	}
+
+	board_data->version = ver;
 	board_data->dsi_enable_pads = omap_dsi_enable_pads;
 	board_data->dsi_disable_pads = omap_dsi_disable_pads;
 	board_data->get_context_loss_count = omap_pm_get_dev_context_loss_count;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3729173..88c8294 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -314,6 +314,19 @@ int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel);
 int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel);
 void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel);
 
+enum omapdss_version {
+	OMAPDSS_VER_UNKNOWN = 0,
+	OMAPDSS_VER_OMAP24xx,
+	OMAPDSS_VER_OMAP34xx_ES1,	/* OMAP3430 ES1.0, 2.0 */
+	OMAPDSS_VER_OMAP34xx_ES3,	/* OMAP3430 ES3.0+ */
+	OMAPDSS_VER_OMAP3630,
+	OMAPDSS_VER_AM35xx,
+	OMAPDSS_VER_OMAP4430_ES1,	/* OMAP4430 ES1.0 */
+	OMAPDSS_VER_OMAP4430_ES2,	/* OMAP4430 ES2.0, 2.1, 2.2 */
+	OMAPDSS_VER_OMAP4,		/* All other OMAP4s */
+	OMAPDSS_VER_OMAP5,
+};
+
 /* Board specific data */
 struct omap_dss_board_info {
 	int (*get_context_loss_count)(struct device *dev);
@@ -323,6 +336,7 @@ struct omap_dss_board_info {
 	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
 	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
 	int (*set_min_bus_tput)(struct device *dev, unsigned long r);
+	enum omapdss_version version;
 };
 
 /* Init with the board info */
-- 
1.7.9.5

