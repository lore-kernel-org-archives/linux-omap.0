From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] OMAPDSS: Fix SDI PLL locking
Date: Tue, 21 Aug 2012 09:09:47 +0300
Message-ID: <1345529388-3509-2-git-send-email-tomi.valkeinen@ti.com>
References: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:45744 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753469Ab2HUGKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:10:36 -0400
Received: by lbbgg6 with SMTP id gg6so4637997lbb.17
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 23:10:32 -0700 (PDT)
In-Reply-To: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Commit f476ae9dab3234532d41d36beb4ba7be838fa786 (OMAPDSS: APPLY: Remove
DISPC writes to manager's lcd parameters in interface) broke the SDI
output, as it causes the SDI PLL locking to fail.

LCLK and PCLK divisors are located in shadow registers, and we normally
write them to DISPC registers when enabling the output.  However, SDI
uses pck-free as source clock for its PLL, and pck-free is affected by
the divisors. And as we need the PLL before enabling the output, we need
to write the divisors early.

It seems just writing to the DISPC register is enough, and we don't need
to care about the shadow register mechanism for pck-free. The exact
reason for this is unknown.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap2/dss/sdi.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5d31699..f43bfe1 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -105,6 +105,20 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	sdi_config_lcd_manager(dssdev);
 
+	/*
+	 * LCLK and PCLK divisors are located in shadow registers, and we
+	 * normally write them to DISPC registers when enabling the output.
+	 * However, SDI uses pck-free as source clock for its PLL, and pck-free
+	 * is affected by the divisors. And as we need the PLL before enabling
+	 * the output, we need to write the divisors early.
+	 *
+	 * It seems just writing to the DISPC register is enough, and we don't
+	 * need to care about the shadow register mechanism for pck-free. The
+	 * exact reason for this is unknown.
+	 */
+	dispc_mgr_set_clock_div(dssdev->manager->id,
+			&sdi.mgr_config.clock_info);
+
 	dss_sdi_init(dssdev->phy.sdi.datapairs);
 	r = dss_sdi_enable();
 	if (r)
-- 
1.7.9.5

