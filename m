From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes for
 v3.4 merge window
Date: Thu, 16 Feb 2012 17:30:59 +0530
Message-ID: <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:50891 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981Ab2BPMBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 07:01:01 -0500
Received: by werm1 with SMTP id m1so1527232wer.29
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 04:00:59 -0800 (PST)
In-Reply-To: <20120215182355.18884.18682.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

> One more patch is needed to sort out the remaining issue with
> omap4 that has yet another luck based initialization for the
> same issue..
>

I did this patch on top of your series which should fix the
issue on all omap4 boards too. Tested on omap4panda and
omap4sdp boards.

>From 5a4bbd64fd1e791b922b76ea8f12dac4216c0a0f Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Thu, 16 Feb 2012 17:24:13 +0530
Subject: [PATCH] ARM: OMAP2+: Fix sequencing issues with
omap4_twl6030_hsmmc_late_init

omap4_twl6030_hsmmc_late_init() relies on twl initialization
to happen before the mmc device is probed, which seems to work
today just by luck. Now that we have support for deferred
mmc init using omap_hsmmc_late_init(), make omap4_twl6030_hsmmc_late_init()
to be called only after twl initialization and use omap_hsmmc_late_init()
for deferred mmc init.

This also fixes mmc card detect on omap4panda, which seems to be broken
as card_detect_irq was never passed from omap4panda board file.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   39 +++++-----------------------
 arch/arm/mach-omap2/board-omap4panda.c |   44 ++++++--------------------------
 arch/arm/mach-omap2/hsmmc.c            |    7 +++++
 drivers/mfd/twl-core.c                 |    7 +++++
 include/linux/i2c/twl.h                |    1 +
 5 files changed, 30 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c
b/arch/arm/mach-omap2/board-4430sdp.c
index ece9e3a..966ea8d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -407,6 +407,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.deferred	= true,
 	},
 	{
 		.mmc		= 5,
@@ -455,46 +456,19 @@ static struct platform_device omap_vwlan_device = {
 	},
 };

-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
+static int omap4_twl6030_hsmmc_late_init(void)
 {
 	int ret = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		if (ret)
-			pr_err("Failed configuring MMC1 card detect\n");
-		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
-						MMCDETECT_INTR_OFFSET;
-		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
+	ret = twl6030_mmc_card_detect_config();
+	if (ret)
+		pr_err("Failed configuring MMC1 card detect\n");
+	omap_hsmmc_late_init(mmc);
 	return ret;
 }

-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed %s\n", __func__);
-		return;
-	}
-	pdata = dev->platform_data;
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
 static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info
*controllers)
 {
-	struct omap2_hsmmc_info *c;
-
 	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-
 	return 0;
 }

@@ -583,6 +557,7 @@ static int __init omap4_i2c_init(void)
 			TWL_COMMON_REGULATOR_VCXIO |
 			TWL_COMMON_REGULATOR_VUSB |
 			TWL_COMMON_REGULATOR_CLK32KG);
+	sdp4430_twldata.setup = omap4_twl6030_hsmmc_late_init;
 	omap4_pmic_init("twl6030", &sdp4430_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c
b/arch/arm/mach-omap2/board-omap4panda.c
index 7ca7a5c..493aa0a 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -155,6 +155,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
+		.deferred	= true,
 	},
 	{
 		.name		= "wl1271",
@@ -204,51 +205,21 @@ struct wl12xx_platform_data omap_panda_wlan_data
 __initdata = {
 	.board_ref_clock = 2,
 };

-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
+static int omap4_twl6030_hsmmc_late_init(void)
 {
 	int ret = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;

-	if (!pdata) {
-		dev_err(dev, "%s: NULL platform data\n", __func__);
-		return -EINVAL;
-	}
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		 if (ret)
-			dev_err(dev, "%s: Error card detect config(%d)\n",
-				__func__, ret);
-		 else
-			pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
+	ret = twl6030_mmc_card_detect_config();
+	if (ret)
+		pr_err("%s: Error MMC card detect config(%d)\n",
+			__func__, ret);
+	omap_hsmmc_late_init(mmc);
 	return ret;
 }

-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
-		return;
-	}
-	pdata = dev->platform_data;
-
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
 static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info
*controllers)
 {
-	struct omap2_hsmmc_info *c;
-
 	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-
 	return 0;
 }

@@ -277,6 +248,7 @@ static int __init omap4_panda_i2c_init(void)
 			TWL_COMMON_REGULATOR_VCXIO |
 			TWL_COMMON_REGULATOR_VUSB |
 			TWL_COMMON_REGULATOR_CLK32KG);
+	omap4_panda_twldata.setup = omap4_twl6030_hsmmc_late_init;
 	omap4_pmic_init("twl6030", &omap4_panda_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	/*
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 59c3ee4..ca9192a 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/i2c/twl.h>
 #include <mach/hardware.h>
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
@@ -390,6 +391,12 @@ static int __init omap_hsmmc_pdata_init(struct
omap2_hsmmc_info *c,
 		if (cpu_is_omap3517() || cpu_is_omap3505())
 			mmc->slots[0].set_power = nop_mmc_set_power;

+		if (cpu_is_omap44xx()) {
+			mmc->slots[0].card_detect = twl6030_mmc_card_detect;
+			mmc->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
+						MMCDETECT_INTR_OFFSET;
+		}
+
 		/* OMAP3630 HSMMC1 supports only 4-bit */
 		if (cpu_is_omap3630() &&
 				(c->caps & MMC_CAP_8_BIT_DATA)) {
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 8ce3959..753a829 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1322,6 +1322,13 @@ twl_probe(struct i2c_client *client, const
struct i2c_device_id *id)
 #endif
 		status = add_children(pdata, id->driver_data);

+	if (pdata->setup) {
+		int status;
+		status = pdata->setup();
+		if (status)
+			dev_dbg(&client->dev, "setup --> %d\n", status);
+	}
+
 fail:
 	if (status < 0)
 		twl_remove(client);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 78d3465..e2d23bc 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -747,6 +747,7 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*smps3;
 	struct regulator_init_data		*smps4;
 	struct regulator_init_data		*vio6025;
+	int					(*setup)(void);
 };

 /*----------------------------------------------------------------------*/
-- 
1.7.1
