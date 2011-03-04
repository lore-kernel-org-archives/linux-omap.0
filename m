From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 2/2] OMAP: DSS2: Add DSS2 support for Overo
Date: Fri, 4 Mar 2011 07:25:15 -0800
Message-ID: <AANLkTikSq+9A_HVy0dk2coYb9AvVRgHZOG1q0RRCJtV1@mail.gmail.com>
References: <1299195980-17057-1-git-send-email-steve@sakoman.com>
	<1299195980-17057-3-git-send-email-steve@sakoman.com>
	<1299225648.2196.25.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35691 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759471Ab1CDPZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 10:25:15 -0500
Received: by vxi39 with SMTP id 39so2087788vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 07:25:15 -0800 (PST)
In-Reply-To: <1299225648.2196.25.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Fri, Mar 4, 2011 at 12:00 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> Why check for CONFIG_PANEL_LGPHILIPS_LB035Q02, but not for the lcd43?
>
> And is that even necessary? Of course it would make the kernel very
> slightly smaller if you leave some code out, but otherwise does that
> help? If you have the device definitions there, but the user doesn't
> load the driver, they wouldn't do anything, would they?
>
> For me the ifdefs just make the code harder to read, but I'm not sure if
> there's some standard custom to have these.

I agree that the size saving is minimal and the code is a bit more
difficult to read. My reason for the check was due to the fact that
the LG panel eats an SPI chip select.

SPI chip selects on Overo are a precious commodity.  I wanted to
provide Overo users who don't use the LG panel an easy way to reclaim
that chip select (i.e. just turn off CONFIG_PANEL_LGPHILIPS_LB035Q02)
.

There is a subsequent patch queued that allows users to use the spidev
driver if they disable the LG panel driver (and similarly free up
another chip select by disabling the touchscreen controller):

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 463feaa..7974b9d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -662,6 +662,14 @@ static struct spi_board_info
overo_spi_board_info[] __initdata = {
 		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
 		.platform_data		= &ads7846_config,
 	},
+#elif defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
+	{
+		.modalias		= "spidev",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 48000000,
+		.mode			= SPI_MODE_0,
+	},
 #endif
 #if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
 	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
@@ -672,6 +680,14 @@ static struct spi_board_info
overo_spi_board_info[] __initdata = {
 		.max_speed_hz		= 500000,
 		.mode			= SPI_MODE_3,
 	},
+#elif defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
+	{
+		.modalias		= "spidev",
+		.bus_num		= 1,
+		.chip_select		= 1,
+		.max_speed_hz		= 48000000,
+		.mode			= SPI_MODE_0,
+	},
 #endif
 };

The spidev driver turns out to be useful for a lot of embedded
applications, so I would prefer to leave the check in place if you
agree that this could be useful.

Regards,

Steve
