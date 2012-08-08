From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 03/11] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Wed,  8 Aug 2012 12:11:33 +0300
Message-ID: <1344417101-5015-4-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:48375 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964895Ab2HHJMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:12:09 -0400
Received: by obbuo13 with SMTP id uo13so854626obb.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:12:08 -0700 (PDT)
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
the FIFO for the audio stack.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 57bd7ef..43899b6 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -152,7 +152,10 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
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

