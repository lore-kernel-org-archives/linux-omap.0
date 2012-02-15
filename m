From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 01/11] ARM: OMAP: mcbsp: Convert core driver to proper platform driver
Date: Wed, 15 Feb 2012 17:37:50 +0200
Message-ID: <1329320280-1621-2-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44277 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179Ab2BOPiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:04 -0500
Received: by mail-ee0-f49.google.com with SMTP id e50so437905eek.22
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:38:01 -0800 (PST)
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

Convert the plat-omap/mcbsp.c driver to be proper platform driver.
Remove the omap_mcbsp_init function call which was called from
mach-omap1/2/mcbsp.c to register the platform driver for the just
created platform device in the same function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap1/mcbsp.c             |    2 +-
 arch/arm/mach-omap2/mcbsp.c             |    2 +-
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 -
 arch/arm/plat-omap/mcbsp.c              |   11 ++++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 91f9abb..fe11e13 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -449,7 +449,7 @@ static int __init omap1_mcbsp_init(void)
 					omap16xx_mcbsp_pdata,
 					OMAP16XX_MCBSP_COUNT);
 
-	return omap_mcbsp_init();
+	return 0;
 }
 
 arch_initcall(omap1_mcbsp_init);
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index fb4bcf8..b36d443 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -193,6 +193,6 @@ static int __init omap2_mcbsp_init(void)
 	if (!mcbsp_ptr)
 		return -ENOMEM;
 
-	return omap_mcbsp_init();
+	return 0;
 }
 arch_initcall(omap2_mcbsp_init);
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 8fa74e2..7e4f893 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -360,7 +360,6 @@ struct omap_mcbsp_dev_attr {
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
 
-int omap_mcbsp_init(void);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 4b15cd7..3c704f3 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1354,8 +1354,9 @@ static struct platform_driver omap_mcbsp_driver = {
 	},
 };
 
-int __init omap_mcbsp_init(void)
-{
-	/* Register the McBSP driver */
-	return platform_driver_register(&omap_mcbsp_driver);
-}
+module_platform_driver(omap_mcbsp_driver);
+
+MODULE_AUTHOR("Samuel Ortiz <samuel.ortiz@nokia.com>");
+MODULE_DESCRIPTION("OMAP McBSP core driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-mcbsp");
-- 
1.7.8.4

