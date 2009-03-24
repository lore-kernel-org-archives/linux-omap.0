From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP3: Add ADS7846 touchscreen support to
	Overo platform, v3
Date: Mon, 23 Mar 2009 20:54:04 -0700
Message-ID: <20090324035403.GS29546@atomide.com>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224610.8810.93492.stgit@localhost> <20090316203855.GM19229@atomide.com> <20090316215726.GA31250@gandalf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="m0vRWufqUC70IDnR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60472 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbZCXDyL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 23:54:11 -0400
Content-Disposition: inline
In-Reply-To: <20090316215726.GA31250@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Balbi <me@felipebalbi.com> [090316 14:57]:
> On Mon, Mar 16, 2009 at 01:38:55PM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [090313 15:46]:
> > > From: Steve Sakoman <sakoman@gmail.com>
> > > 
> > > An upcoming Overo expansion board includes an ADS7846 touchscreen controller.
> > > 
> > > This patch adds support via the ads7846 driver when enabled in the
> > > kernel config.
> > 
> > Here's this one refreshed to apply without the smsc911x patch.
> > 
> > Tony
> 
> > From b4b560d6323bd56a7c450b81263d09464d8c6e36 Mon Sep 17 00:00:00 2001
> > From: Steve Sakoman <sakoman@gmail.com>
> > Date: Mon, 16 Mar 2009 13:28:00 -0700
> > Subject: [PATCH] ARM: OMAP3: Add ADS7846 touchscreen support to Overo platform, v2
> > 
> > An upcoming Overo expansion board includes an ADS7846 touchscreen controller.
> > 
> > This patch adds support via the ads7846 driver when enabled in the
> > kernel config.
> > 
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> > index d785aa8..4d03b70 100644
> > --- a/arch/arm/mach-omap2/board-overo.c
> > +++ b/arch/arm/mach-omap2/board-overo.c
> > @@ -52,6 +52,66 @@
> >  #define GPMC_CS0_BASE  0x60
> >  #define GPMC_CS_SIZE   0x30
> >  
> > +#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> > +	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> 
> I'm wondering if this is really necessary since ...
> 
> > +#include <mach/mcspi.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/spi/ads7846.h>
> > +
> > +static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> 
> __initdata ??
> 
> > +	.turbo_mode	= 0,
> > +	.single_channel	= 1,	/* 0: slave, 1: master */
> > +};
> > +
> > +

To me it looks like turbo_mode and single_channel can get
cleaned away. I'll add that to my list of things todo for
all the boards.
 
> one blank line enough ?

Removed in this updated patch.
 
> > +static int ads7846_get_pendown_state(void)
> > +{
> > +	return !gpio_get_value(OVERO_GPIO_PENDOWN);
> > +}
> > +
> > +static struct ads7846_platform_data ads7846_config = {
> > +	.x_max			= 0x0fff,
> > +	.y_max			= 0x0fff,
> > +	.x_plate_ohms		= 180,
> > +	.pressure_max		= 255,
> > +	.debounce_max		= 10,
> > +	.debounce_tol		= 3,
> > +	.debounce_rep		= 1,
> > +	.get_pendown_state	= ads7846_get_pendown_state,
> > +	.keep_vref_on		= 1,
> > +};
> > +
> > +static struct spi_board_info overo_spi_board_info[] __initdata = {
> 
> ... this is initdata, meaning that this region will be freed anyways after
> __init even if the driver doesn't probe. So I guess we could remove the
> ifdeferry and mark the other ads7846-related stuff as either __init or
> __initdata.

Hmm I guess binary size is another consideration, so let's keep it as is
for now, and if we decide to do something, let's do it for all the
boards.

Tony

 
> > +	{
> > +		.modalias		= "ads7846",
> > +		.bus_num		= 1,
> > +		.chip_select		= 0,
> > +		.max_speed_hz		= 1500000,
> > +		.controller_data	= &ads7846_mcspi_config,
> > +		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
> > +		.platform_data		= &ads7846_config,
> > +	}
> > +};
> 
> -- 
> balbi

--m0vRWufqUC70IDnR
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="overo-ads7846-v3.patch"

>From c6a81316c721a20639871f08cf0cbff7e83889b4 Mon Sep 17 00:00:00 2001
From: Steve Sakoman <sakoman@gmail.com>
Date: Mon, 23 Mar 2009 18:38:16 -0700
Subject: [PATCH] ARM: OMAP3: Add ADS7846 touchscreen support to Overo platform, v3

An upcoming Overo expansion board includes an ADS7846 touchscreen controller.

This patch adds support via the ads7846 driver when enabled in the
kernel config.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d3ceed3..782268c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -57,6 +57,65 @@
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
 
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
+
+#include <mach/mcspi.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,	/* 0: slave, 1: master */
+};
+
+static int ads7846_get_pendown_state(void)
+{
+	return !gpio_get_value(OVERO_GPIO_PENDOWN);
+}
+
+static struct ads7846_platform_data ads7846_config = {
+	.x_max			= 0x0fff,
+	.y_max			= 0x0fff,
+	.x_plate_ohms		= 180,
+	.pressure_max		= 255,
+	.debounce_max		= 10,
+	.debounce_tol		= 3,
+	.debounce_rep		= 1,
+	.get_pendown_state	= ads7846_get_pendown_state,
+	.keep_vref_on		= 1,
+};
+
+static struct spi_board_info overo_spi_board_info[] __initdata = {
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &ads7846_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
+		.platform_data		= &ads7846_config,
+	}
+};
+
+static void __init overo_ads7846_init(void)
+{
+	if ((gpio_request(OVERO_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
+	    (gpio_direction_input(OVERO_GPIO_PENDOWN) == 0)) {
+		gpio_export(OVERO_GPIO_PENDOWN, 0);
+	} else {
+		printk(KERN_ERR "could not obtain gpio for ADS7846_PENDOWN\n");
+		return;
+	}
+
+	spi_register_board_info(overo_spi_board_info,
+			ARRAY_SIZE(overo_spi_board_info));
+}
+
+#else
+static inline void __init overo_ads7846_init(void) { return; }
+#endif
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -230,6 +289,7 @@ static void __init overo_init(void)
 	twl4030_mmc_init(mmc);
 	overo_flash_init();
 	usb_musb_init();
+	overo_ads7846_init();
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&

--m0vRWufqUC70IDnR--
