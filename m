From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/13] tsl2563 ALS support for Nokia N900
Date: Fri, 9 Jul 2010 11:35:27 +0300
Message-ID: <20100709083526.GJ24913@atomide.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
 <20100707094432.2562.30773.stgit@baageli.muru.com>
 <1278594083.1955.3.camel@chotu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52893 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab0GIIfe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 04:35:34 -0400
Content-Disposition: inline
In-Reply-To: <1278594083.1955.3.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Ameya Palande <ameya.palande@nokia.com> [100708 15:55]:
> Hi Tony,
> 
> On Wed, 2010-07-07 at 11:44 +0200, ext Tony Lindgren wrote:
> > From: Ameya Palande <ameya.palande@nokia.com>
> > 
> > This commit will enable usage of tsl2563 ambient light sensor on Nokia N900.
> > 
> > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This patch is not correct, sorry for that. You can drop this one.
> Mathias Nyman will send a new one with correction.

Thanks, updated version from Mathias below.

Regards,

Tony

--BXVAT5kNtrzKuDFl
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="rx51-light-sensor.patch"

>From 7488ecd62fbb5c440823c28f120fdf52535a3d54 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@nokia.com>
Date: Tue, 6 Jul 2010 17:05:34 +0300
Subject: [PATCH] omap: tsl2563 ALS support for Nokia N900

This commit will enable usage of tsl2563 ambient light sensor on Nokia N900.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3c3f975..a3a396c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -35,6 +35,8 @@
 #include <sound/tlv320aic3x.h>
 #include <sound/tpa6130a2-plat.h>
 
+#include <../drivers/staging/iio/light/tsl2563.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -53,6 +55,12 @@ enum {
 
 static struct wl12xx_platform_data wl1251_pdata;
 
+#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
+static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
+	.cover_comp_gain = 16,
+};
+#endif
+
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,
@@ -714,6 +722,12 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 		.platform_data = &rx51_aic3x_data,
 	},
+#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
+	{
+		I2C_BOARD_INFO("tsl2563", 0x29),
+		.platform_data = &rx51_tsl2563_platform_data,
+	},
+#endif
 	{
 		I2C_BOARD_INFO("tpa6130a2", 0x60),
 		.platform_data = &rx51_tpa6130a2_data,

--BXVAT5kNtrzKuDFl--
