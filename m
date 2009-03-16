From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/12] ARM: OMAP3: mmc-twl4030 init passes device nodes
	back
Date: Mon, 16 Mar 2009 10:44:15 -0700
Message-ID: <20090316174414.GD19229@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210843.16425.46810.stgit@localhost> <20090315160208.GD10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/Gk0KcsbyUMelFU1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51255 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZCPRoT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 13:44:19 -0400
Content-Disposition: inline
In-Reply-To: <20090315160208.GD10786@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090315 09:02]:
> On Tue, Mar 10, 2009 at 02:08:43PM -0700, Tony Lindgren wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > When setting up HSMMC devices, pass pass the device nodes back so
> 
> Double pass?

Here's this one updated to fix the typo.

Tony

--/Gk0KcsbyUMelFU1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="hsmmc-pass-device-nodes-v2.patch"

>From 587cf51b738e653751516809c161d5e325342023 Mon Sep 17 00:00:00 2001
From: David Brownell <dbrownell@users.sourceforge.net>
Date: Mon, 16 Mar 2009 10:40:39 -0700
Subject: [PATCH] ARM: OMAP3: mmc-twl4030 init passes device nodes back, v2

When setting up HSMMC devices, pass the device nodes back so
board code can linking them to their power supply regulators.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index df1539e..c67078d 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <mach/control.h>
@@ -437,6 +438,15 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
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
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 380dde7..21d3572 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -13,6 +13,7 @@ struct twl4030_hsmmc_info {
 	bool	ext_clock;	/* use external pin for input clock */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
+	struct device *dev;	/* returned: pointer to mmc adapter */
 };
 
 #if	defined(CONFIG_TWL4030_CORE) && \
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 208dbb1..87fb7ff 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -228,6 +228,9 @@ int __init omap_mmc_add(const char *name, int id, unsigned long base,
 	ret = platform_device_add(pdev);
 	if (ret)
 		goto fail;
+
+	/* return device handle to board setup code */
+	data->dev = &pdev->dev;
 	return 0;
 
 fail:
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 73a9e15..4435bd4 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -37,6 +37,8 @@
 #define OMAP_MMC_MAX_SLOTS	2
 
 struct omap_mmc_platform_data {
+	/* back-link to device */
+	struct device *dev;
 
 	/* number of slots per controller */
 	unsigned nr_slots:2;

--/Gk0KcsbyUMelFU1--
