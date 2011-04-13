From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/5] OMAP: DSS2: DSI: fix use_sys_clk & highfreq
Date: Wed, 13 Apr 2011 09:50:16 +0300
Message-ID: <1302677417-4590-5-git-send-email-tomi.valkeinen@ti.com>
References: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39665 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755295Ab1DMGum (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 02:50:42 -0400
Received: by ewy19 with SMTP id 19so126283ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 23:50:39 -0700 (PDT)
In-Reply-To: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

use_sys_clk and highfreq fields in dsi.current_cinfo were never set.
Luckily they weren't used anywhere so it didn't cause any problems.

This patch fixes those fields and they are now set at the same time as
the rest of the fields.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1cc4f37..9690bea 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1276,6 +1276,9 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 
 	DSSDBGF();
 
+	dsi.current_cinfo.use_sys_clk = cinfo->use_sys_clk;
+	dsi.current_cinfo.highfreq = cinfo->highfreq;
+
 	dsi.current_cinfo.fint = cinfo->fint;
 	dsi.current_cinfo.clkin4ddr = cinfo->clkin4ddr;
 	dsi.current_cinfo.dsi_pll_hsdiv_dispc_clk =
-- 
1.7.1

