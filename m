From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Mon, 13 Aug 2012 17:22:41 +0300
Message-ID: <1344867768-26335-3-git-send-email-peter.ujfalusi@ti.com>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41758 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752013Ab2HMOWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 10:22:41 -0400
Received: by obbwc18 with SMTP id wc18so4915240obb.15
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 07:22:40 -0700 (PDT)
In-Reply-To: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
the FIFO for the audio stack.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/mcbsp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index ebc801e..6e046e1 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -151,7 +151,10 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	if (id == 4 && oh->class->rev == MCBSP_CONFIG_TYPE4)
 		pdata->mux_signal = omap4_mcbsp4_mux_rx_clk;
 
-	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
+	if (oh->class->rev == MCBSP_CONFIG_TYPE2) {
+		/* The FIFO has 128 locations */
+		pdata->buffer_size = 0x80;
+	} else if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
 		if (id == 2)
 			/* The FIFO has 1024 + 256 locations */
 			pdata->buffer_size = 0x500;
-- 
1.7.8.6

