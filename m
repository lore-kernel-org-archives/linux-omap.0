From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 20 Dec 2013 08:55:03 -0800
Message-ID: <20131220165456.GD27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com>
 <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
 <20131220114837.GH32243@n2100.arm.linux.org.uk>
 <52B44982.4020501@ti.com>
 <20131220160432.GZ27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29885 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab3LTQ4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 11:56:40 -0500
Content-Disposition: inline
In-Reply-To: <20131220160432.GZ27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131220 08:06]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131220 05:45]:
> > On 2013-12-20 13:48, Russell King - ARM Linux wrote:
> > 
> > > Or maybe this is getting buggered by the idiotic deferred probing...  It
> > > seems that the GPIOs for controlling the LCD and backlight aren't even
> > > getting claimed if the DSS modules are built in:
> > > 
> > > # cat /sys/kernel/debug/gpio
> > > ...
> > > GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
> > > # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/unbind
> > > # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/bind
> > > # cat /sys/kernel/debug/gpio
> > > ...
> > > GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
> > >  gpio-245 (panel enable        ) out lo
> > >  gpio-253 (panel backlight     ) out lo
> > 
> > This looks odd... Presuming the panel device was probed successfully, it
> > should always get the gpios or return an error. Only if gpio_is_valid()
> > returns false for the gpio, it skips it and continues. But in this case,
> > the gpio number comes from the platform data, so it should always be valid.
> > 
> > And if it wasn't probed successfully, then there shouldn't be a fb0.
> 
> I bet that's it though. If the display is probed before twl4030 GPIO
> is initialized, the GPIO numbers will be 0. I'm using omap2plus_defconfig
> which has DSS built as modules.

Yeah this seems to do the trick for me for the built-in DSS on LDP.

Tony

8< -----------------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 20 Dec 2013 08:53:27 -0800
Subject: [PATCH] ARM: OMAP2+: Fix LCD panel backlight regression for LDP legacy booting

Looks like the LCD panel on LDP has been broken quite a while, and
recently got fixed. However, there's still an issue where the panel
backlight does not come on if the LCD drivers are built into the
kernel.

Fix the issue by registering the DPI LCD panel only after the twl4030
GPIO has probed.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -248,7 +248,7 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 	/* Backlight enable GPIO */
 	ldp_lcd_pdata.backlight_gpio = gpio + 15;
 
-	return 0;
+	return platform_device_register(&ldp_lcd_device);
 }
 
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
@@ -346,7 +346,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
-	&ldp_lcd_device,
 };
 
 #ifdef CONFIG_OMAP_MUX
