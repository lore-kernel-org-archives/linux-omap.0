From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH RESEND] ARM: OMAP4: hwmod data: add HWMOD_SWSUP_SIDLE to dss_hdmi to data
Date: Wed, 20 Jun 2012 18:10:10 -0500
Message-ID: <1340233810-1087-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45101 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab2FTXKw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 19:10:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, mythripk@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

As per the OMAP4 documentation, audio over HDMI should be transmitted in
no-idle mode. This patch adds the HWMOD_SWSUP_SIDLE so that omap_hwmode uses
no-idle/force-idle settings instead of smart-idle mode.

This is required as the DSS interface clock is used as functional clock
for the HDMI wrapper audio FIFO. If no-idle mode is not used, audio could
be choppy, have bad quality or not be audible at all.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..0cd6ee1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -865,6 +865,11 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	/*
+	 * HDMI audio requires to use no-idle mode. Hence,
+	 * set idle mode by software.
+	 */
+	.flags          = HWMOD_SWSUP_SIDLE,
 };
 
 /*
-- 
1.7.5.4

