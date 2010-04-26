From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: DSS: ensure clocks are disabled on failed init
Date: Mon, 26 Apr 2010 12:12:46 -0700
Message-ID: <1272309166-698-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49816 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab0DZTMt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 15:12:49 -0400
Received: by pvg2 with SMTP id 2so589875pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 12:12:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently, if init fails for whatever reason, various DSS related
clocks will be left enabled and prevent the chip from hitting
retention or off-mode.

This patch ensures the clocks are disabled on a failed init.

For this to work, a check had to be added to dispc_save_context()
to not save context if it has not yet been initialized.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Patch against v2.6.34-rc5.

Discovered when testing n900 with current PM branch + Roger's 
series for the LCC panel.  DPI init fails since it can't find
VDDS_DSI regulator, and as a result init fails out and leaves
clocks enabled.

 drivers/video/omap2/dss/core.c  |    1 +
 drivers/video/omap2/dss/dispc.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 7ebe50b..62f7ee2 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -584,6 +584,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	/* XXX fail correctly */
 fail0:
+	dss_clk_disable_all();
 	return r;
 }
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e777e35..4cc54ef 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -195,6 +195,9 @@ void dispc_save_context(void)
 	if (cpu_is_omap24xx())
 		return;
 
+	if (!dispc.base)
+		return;
+
 	SR(SYSCONFIG);
 	SR(IRQENABLE);
 	SR(CONTROL);
-- 
1.7.0.2

