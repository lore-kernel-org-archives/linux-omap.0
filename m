From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/27] OMAP: DSS2: Reset LANEx_ULPS_SIG2 bits after use
Date: Fri,  3 Jun 2011 13:00:13 +0300
Message-ID: <1307095237-14805-4-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41473 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752215Ab1FCKBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:07 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

LANEx_ULPS_SIG2 bits are left on after entering ULPS. This doesn't cause
any problems currently, as DSI HW is reset when it is enabled. However,
if the reset is not done, operation fails if the bits are still set.

So reset the bits after entering ULPS to ensure operation even without
HW reset.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 69c2d4f..4496d09 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3395,6 +3395,10 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	dsi_unregister_isr_cio(dsidev, dsi_completion_handler, &completion,
 			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
 
+	/* Reset LANEx_ULPS_SIG2 */
+	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (0 << 0) | (0 << 1) | (0 << 2),
+		7, 5);
+
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ULPS);
 
 	dsi_if_enable(dsidev, false);
-- 
1.7.4.1

