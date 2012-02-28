From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 01/10] ARM: OMAP: mcbsp: Convert core driver to proper platform driver
Date: Tue, 28 Feb 2012 09:40:11 +0200
Message-ID: <1330414820-4641-2-git-send-email-peter.ujfalusi@ti.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57876 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754213Ab2B1Hkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:40:35 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so2730978lag.3
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:40:34 -0800 (PST)
In-Reply-To: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

Convert the plat-omap/mcbsp.c driver to be proper platform driver.
Remove the omap_mcbsp_init function call which was called from
mach-omap1/2/mcbsp.c to register the platform driver for the just
created platform device in the same function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
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

