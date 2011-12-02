From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] OMAP4: devices: Do not create dmic device if the dtb has been provided
Date: Fri,  2 Dec 2011 11:52:58 +0200
Message-ID: <1322819580-7424-4-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42168 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753616Ab1LBJx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 04:53:27 -0500
Received: by wgbdr11 with SMTP id dr11so560435wgb.7
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 01:53:21 -0800 (PST)
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

If dtb is provided of will create the needed devices dynamically so there
is no need to create the platform device for DMIC here.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 35d5dff..d7ca473 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -344,6 +344,10 @@ static void omap_init_dmic(void)
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return;
+
 	oh = omap_hwmod_lookup("dmic");
 	if (!oh) {
 		printk(KERN_ERR "Could not look up mcpdm hw_mod\n");
-- 
1.7.8.rc4

