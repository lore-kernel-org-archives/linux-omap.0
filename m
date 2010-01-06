From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/3] [OMAP] Add spi100k configuration to OMAP1
Date: Wed, 6 Jan 2010 11:19:47 -0800
Message-ID: <20100106191946.GB11511@atomide.com>
References: <1260668088-27555-1-git-send-email-darkstar6262@gmail.com>
 <1260668088-27555-3-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63100 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730Ab0AFTTs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 14:19:48 -0500
Content-Disposition: inline
In-Reply-To: <1260668088-27555-3-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Cory Maccarrone <darkstar6262@gmail.com> [091212 17:35]:
> This change implements the clocks, platform driver, and register
> information necessary to use the spi100k bus with OMAP 7xx systems.
> 
> The clocks added are dummy clocks because, although we're pretty
> sure there are clocks used for SPI, all current booting methods result
> in proper operation without the enabling of any other clocks.

Looks like the driver is in mainline, so let's try to make it working..

> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -196,6 +198,37 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
>  
>  /*-------------------------------------------------------------------------*/
>  
> +/* OMAP7xx SPI support */
> +#if defined(CONFIG_SPI_OMAP_100K) || defined(CONFIG_SPI_OMAP_100K_MODULE)
> +
> +struct platform_device omap_spi1 = {
> +	.name           = "omap1_spi100k",
> +	.id             = 1,
> +};
> +
> +struct platform_device omap_spi2 = {
> +	.name           = "omap1_spi100k",
> +	.id             = 2,
> +};
> +
> +static void omap_init_spi100k(void)
> +{
> +	omap_spi1.dev.platform_data = ioremap(OMAP7XX_SPI1_BASE, 0x7ff);
> +	BUG_ON(!omap_spi1.dev.platform_data);
> +
> +	omap_spi2.dev.platform_data = ioremap(OMAP7XX_SPI2_BASE, 0x7ff);
> +	BUG_ON(!omap_spi2.dev.platform_data);
> +
> +	platform_device_register(&omap_spi1);
> +	platform_device_register(&omap_spi2);
> +}

I've updated your patch to just check the return value of ioremap instead
of BUG_ON. I've also merged it with the mux patch, see below. Can you
please try it out and make sure everything is OK?

Regards,

Tony

--RASg3xLB4tUQ4RcS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="7xx-spi.patch"

>From b6e8076018f8a492c225114d517b2d4a0408ea4c Mon Sep 17 00:00:00 2001
From: Cory Maccarrone <darkstar6262@gmail.com>
Date: Sun, 13 Dec 2009 01:34:48 +0000
Subject: [PATCH] omap1: Add 7xx clocks and pin muxes for SPI

Commit 35c9049b27040d09461bc90928ad770be7ddf661 added
drivers/spi/omap_spi_100k.c.

This patch add the related clocks and pin muxing
entries to make the driver work on omap7xx platforms.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 31fba07..2ac5796 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -658,6 +658,10 @@ static struct omap_clk omap_clks[] = {
 	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
 	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310 | CK_7XX),
+	CLK("omap1_spi100k.1", "fck",	&dummy_ck,	CK_7XX),
+	CLK("omap1_spi100k.1", "ick",	&dummy_ck,	CK_7XX),
+	CLK("omap1_spi100k.2", "fck",	&dummy_ck,	CK_7XX),
+	CLK("omap1_spi100k.2", "ick",	&dummy_ck,	CK_7XX),
 	CLK("omap_uwire", "fck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
 	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 23ded2d..17ebb47 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
@@ -23,6 +24,7 @@
 #include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
+#include <plat/omap7xx.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -196,6 +198,38 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 
 /*-------------------------------------------------------------------------*/
 
+/* OMAP7xx SPI support */
+#if defined(CONFIG_SPI_OMAP_100K) || defined(CONFIG_SPI_OMAP_100K_MODULE)
+
+struct platform_device omap_spi1 = {
+	.name           = "omap1_spi100k",
+	.id             = 1,
+};
+
+struct platform_device omap_spi2 = {
+	.name           = "omap1_spi100k",
+	.id             = 2,
+};
+
+static void omap_init_spi100k(void)
+{
+	omap_spi1.dev.platform_data = ioremap(OMAP7XX_SPI1_BASE, 0x7ff);
+	if (omap_spi1.dev.platform_data)
+		platform_device_register(&omap_spi1);
+
+	omap_spi2.dev.platform_data = ioremap(OMAP7XX_SPI2_BASE, 0x7ff);
+	ifi (omap_spi2.dev.platform_data)
+		platform_device_register(&omap_spi2);
+}
+
+#else
+static inline void omap_init_spi100k(void)
+{
+}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_OMAP_STI)
 
 #define OMAP1_STI_BASE		0xfffea000
@@ -263,6 +297,7 @@ static int __init omap1_init_devices(void)
 
 	omap_init_mbox();
 	omap_init_rtc();
+	omap_init_spi100k();
 	omap_init_sti();
 
 	return 0;
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 07212cc..8434137 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -62,6 +62,14 @@ MUX_CFG_7XX("MMC_7XX_DAT0",        2,   17,    0,   16,   1, 0)
 /* I2C interface */
 MUX_CFG_7XX("I2C_7XX_SCL",         5,    1,    0,    0,   1, 0)
 MUX_CFG_7XX("I2C_7XX_SDA",         5,    5,    0,    0,   1, 0)
+
+/* SPI pins */
+MUX_CFG_7XX("SPI_7XX_1",           6,    5,    4,    4,   1, 0)
+MUX_CFG_7XX("SPI_7XX_2",           6,    9,    4,    8,   1, 0)
+MUX_CFG_7XX("SPI_7XX_3",           6,   13,    4,   12,   1, 0)
+MUX_CFG_7XX("SPI_7XX_4",           6,   17,    4,   16,   1, 0)
+MUX_CFG_7XX("SPI_7XX_5",           8,   25,    0,   24,   0, 0)
+MUX_CFG_7XX("SPI_7XX_6",           9,    5,    0,    4,   0, 0)
 };
 #define OMAP7XX_PINS_SZ		ARRAY_SIZE(omap7xx_pins)
 #else
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index 8f069cc..692c90e 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -183,6 +183,14 @@ enum omap7xx_index {
 	/* I2C */
 	I2C_7XX_SCL,
 	I2C_7XX_SDA,
+
+	/* SPI */
+	SPI_7XX_1,
+	SPI_7XX_2,
+	SPI_7XX_3,
+	SPI_7XX_4,
+	SPI_7XX_5,
+	SPI_7XX_6,
 };
 
 enum omap1xxx_index {
diff --git a/arch/arm/plat-omap/include/plat/omap7xx.h b/arch/arm/plat-omap/include/plat/omap7xx.h
index 53f5241..48e4757 100644
--- a/arch/arm/plat-omap/include/plat/omap7xx.h
+++ b/arch/arm/plat-omap/include/plat/omap7xx.h
@@ -46,6 +46,9 @@
 #define OMAP7XX_DSPREG_SIZE	SZ_128K
 #define OMAP7XX_DSPREG_START	0xE1000000
 
+#define OMAP7XX_SPI1_BASE	0xfffc0800
+#define OMAP7XX_SPI2_BASE	0xfffc1000
+
 /*
  * ----------------------------------------------------------------------------
  * OMAP7XX specific configuration registers

--RASg3xLB4tUQ4RcS--
