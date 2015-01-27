From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/14] OMAPDSS: PLL: add dss_pll_wait_reset_done()
Date: Tue, 27 Jan 2015 12:50:30 +0200
Message-ID: <1422355842-11234-3-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60757 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361AbbA0Ku6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:50:58 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a helper function to wait until the PLL's reset is done.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.h |  1 +
 drivers/video/fbdev/omap2/dss/pll.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 1826ee96265b..d6c9c3d3db14 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -453,5 +453,6 @@ int dss_pll_write_config_type_a(struct dss_pll *pll,
 		const struct dss_pll_clock_info *cinfo);
 int dss_pll_write_config_type_b(struct dss_pll *pll,
 		const struct dss_pll_clock_info *cinfo);
+int dss_pll_wait_reset_done(struct dss_pll *pll);
 
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/pll.c b/drivers/video/fbdev/omap2/dss/pll.c
index 335ffac224b9..f974ddcd3b6e 100644
--- a/drivers/video/fbdev/omap2/dss/pll.c
+++ b/drivers/video/fbdev/omap2/dss/pll.c
@@ -222,6 +222,16 @@ static int wait_for_bit_change(void __iomem *reg, int bitnum, int value)
 	return !value;
 }
 
+int dss_pll_wait_reset_done(struct dss_pll *pll)
+{
+	void __iomem *base = pll->base;
+
+	if (wait_for_bit_change(base + PLL_STATUS, 0, 1) != 1)
+		return -ETIMEDOUT;
+	else
+		return 0;
+}
+
 static int dss_wait_hsdiv_ack(struct dss_pll *pll, u32 hsdiv_ack_mask)
 {
 	int t = 100;
-- 
2.2.2

