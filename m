From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 19:18:04 +0530
Message-ID: <1340372890-10091-6-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39398 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762150Ab2FVNs1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:48:27 -0400
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the omapdss clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
---
 drivers/video/omap2/dss/dsi.c  |    5 ++++-
 drivers/video/omap2/dss/hdmi.c |    5 ++++-
 drivers/video/omap2/dss/venc.c |    5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ca8382d..81b474d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4776,6 +4776,7 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 	}
 
 	dsi->sys_clk = clk;
+	clk_prepare(dsi->sys_clk);
 
 	return 0;
 }
@@ -4786,8 +4787,10 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 
 	if (dsi->dss_clk)
 		clk_put(dsi->dss_clk);
-	if (dsi->sys_clk)
+	if (dsi->sys_clk) {
+		clk_unprepare(dsi->sys_clk);
 		clk_put(dsi->sys_clk);
+	}
 }
 
 static void __init dsi_probe_pdata(struct platform_device *dsidev)
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8195c71..0b7ded3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -544,14 +544,17 @@ static int hdmi_get_clocks(struct platform_device *pdev)
 	}
 
 	hdmi.sys_clk = clk;
+	clk_prepare(hdmi.sys_clk);
 
 	return 0;
 }
 
 static void hdmi_put_clocks(void)
 {
-	if (hdmi.sys_clk)
+	if (hdmi.sys_clk) {
+		clk_unprepare(hdmi.sys_clk);
 		clk_put(hdmi.sys_clk);
+	}
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2b89739..62f395d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -818,14 +818,17 @@ static int venc_get_clocks(struct platform_device *pdev)
 	}
 
 	venc.tv_dac_clk = clk;
+	clk_prepare(venc.tv_dac_clk);
 
 	return 0;
 }
 
 static void venc_put_clocks(void)
 {
-	if (venc.tv_dac_clk)
+	if (venc.tv_dac_clk) {
+		clk_unprepare(venc.tv_dac_clk);
 		clk_put(venc.tv_dac_clk);
+	}
 }
 
 static void __init venc_probe_pdata(struct platform_device *pdev)
-- 
1.7.1

