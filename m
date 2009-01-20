From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 5/7] hsmmc init passes device nodes back
Date: Tue, 20 Jan 2009 02:52:02 -0800
Message-ID: <200901200252.02581.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44270 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756904AbZATLBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:21 -0500
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

When setting up HSMMC devices, pass pass the device nodes back so
board code can linking them to their power supply regulators.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Kind of ugly, but minimally invasive.  A cleaner approach might
have board code initialize one controller at a time, with that
call returning the relevant device node.

 arch/arm/mach-omap2/mmc-twl4030.c     |   10 ++++++++++
 arch/arm/mach-omap2/mmc-twl4030.h     |    1 +
 arch/arm/plat-omap/devices.c          |    3 +++
 arch/arm/plat-omap/include/mach/mmc.h |    2 ++
 4 files changed, 16 insertions(+)

--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <mach/control.h>
@@ -436,6 +437,15 @@ void __init twl4030_mmc_init(struct twl4
 	}
 
 	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
+
+	/* pass the device nodes back to board setup code */
+	for (c = controllers; c->mmc; c++) {
+		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
+
+		if (!c->mmc || c->mmc > nr_hsmmc)
+			continue;
+		c->dev = mmc->dev;
+	}
 }
 
 #endif
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -13,6 +13,7 @@ struct twl4030_hsmmc_info {
 	bool	ext_clock;	/* use external pin for input clock */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
+	struct device *dev;	/* returned: pointer to mmc adapter */
 };
 
 #if	defined(CONFIG_TWL4030_CORE) && \
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -232,6 +232,9 @@ int __init omap_mmc_add(int id, unsigned
 	ret = platform_device_add(pdev);
 	if (ret)
 		goto fail;
+
+	/* return device handle to board setup code */
+	data->dev = &pdev->dev;
 	return 0;
 
 fail:
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -37,6 +37,8 @@
 #define OMAP_MMC_MAX_SLOTS	2
 
 struct omap_mmc_platform_data {
+	/* back-link to device */
+	struct device *dev;
 
 	/* number of slots per controller */
 	unsigned nr_slots:2;
