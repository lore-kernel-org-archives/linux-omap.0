From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
Date: Wed, 14 Mar 2012 13:59:51 -0700
Message-ID: <87pqcegapk.fsf@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
	<1330707024-23730-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34570 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964831Ab2CNU7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 16:59:40 -0400
Received: by mail-pz0-f54.google.com with SMTP id d2so3416633dal.13
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 13:59:40 -0700 (PDT)
In-Reply-To: <1330707024-23730-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 2 Mar 2012 17:50:13 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Benoit Cousson <b-cousson@ti.com> writes:

> From: Felipe Balbi <balbi@ti.com>
>
> With sparse IRQs the driver shouldn't depend at all on
> any IRQ values coming from board-file.
>
> Remove every occurences of pdata->irq_base/end.

Well, not quite *every*. :)

If the driver isn't going to use those fields anymore, they should also
be removed from the pdata struct too[1].  Also, the remaining board/init
code that is initializing those fields should be removed as well[2], since
it obviously has no effect.

The first patch below should probably be folded into this one, and then
the 2nd patch removes all the users.

Kevin

[1]
>From 70a1833ca20142ef5b6b96dbc92a63c7f8ef9a04 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 14 Mar 2012 13:55:31 -0700
Subject: [PATCH 1/2] mfd: twl-core: remove pdata->irq_base/end

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 include/linux/i2c/twl.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 2463b61..fa76006 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -697,7 +697,6 @@ struct twl4030_audio_data {
 };
 
 struct twl4030_platform_data {
-	unsigned				irq_base, irq_end;
 	struct twl4030_clock_init_data		*clock;
 	struct twl4030_bci_platform_data	*bci;
 	struct twl4030_gpio_platform_data	*gpio;
-- 
1.7.9.2


[2]
>From d2b7b518b4c66beb99fccfcb898001c11a2f6dc9 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 14 Mar 2012 13:56:01 -0700
Subject: [PATCH 2/2] ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end

The driver has been converted to use SPARSE_IRQ and no longer needs to
be passed IRQ base/end.  The driver no longer uses these fields, so
remove them from the reamaining users.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c    |    3 ---
 arch/arm/mach-omap2/board-omap3logic.c |    3 ---
 arch/arm/mach-omap2/twl-common.c       |    9 ---------
 3 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index c8bda62..b8b3700 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -218,9 +218,6 @@ static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
 };
 
 static struct twl4030_platform_data sdp2430_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
-
 	/* platform_data for children goes here */
 	.gpio		= &sdp2430_gpio_data,
 	.vmmc1		= &sdp2430_vmmc1,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 4a7d8c8..f145935 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -85,9 +85,6 @@ static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
 };
 
 static struct twl4030_platform_data omap3logic_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
-
 	/* platform_data for children goes here */
 	.gpio		= &omap3logic_gpio_data,
 	.vmmc1		= &omap3logic_vmmc1,
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 1cddcb2..5c9aa3f 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -184,10 +184,6 @@ static struct twl_regulator_driver_data omap3_vdd2_drvdata = {
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
-	if (!pmic_data->irq_base)
-		pmic_data->irq_base = TWL4030_IRQ_BASE;
-	if (!pmic_data->irq_end)
-		pmic_data->irq_end = TWL4030_IRQ_END;
 	if (!pmic_data->vdd1) {
 		omap3_vdd1.driver_data = &omap3_vdd1_drvdata;
 		omap3_vdd1_drvdata.data = voltdm_lookup("mpu_iva");
@@ -415,11 +411,6 @@ static struct twl_regulator_driver_data omap4_vdd3_drvdata = {
 void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
-	if (!pmic_data->irq_base)
-		pmic_data->irq_base = TWL6030_IRQ_BASE;
-	if (!pmic_data->irq_end)
-		pmic_data->irq_end = TWL6030_IRQ_END;
-
 	if (!pmic_data->vdd1) {
 		omap4_vdd1.driver_data = &omap4_vdd1_drvdata;
 		omap4_vdd1_drvdata.data = voltdm_lookup("mpu");
-- 
1.7.9.2

