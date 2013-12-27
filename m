From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 27 Dec 2013 10:11:56 -0800
Message-ID: <20131227181156.GA5116@atomide.com>
References: <52B1A922.6020901@ti.com>
 <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
 <20131220114837.GH32243@n2100.arm.linux.org.uk>
 <52B44982.4020501@ti.com>
 <20131220160432.GZ27438@atomide.com>
 <20131220165456.GD27438@atomide.com>
 <52B7EC09.8080206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64625 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab3L0SMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Dec 2013 13:12:03 -0500
Content-Disposition: inline
In-Reply-To: <52B7EC09.8080206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131222 23:55]:
> On 2013-12-20 18:55, Tony Lindgren wrote:
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -248,7 +248,7 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
> >  	/* Backlight enable GPIO */
> >  	ldp_lcd_pdata.backlight_gpio = gpio + 15;
> >  
> > -	return 0;
> > +	return platform_device_register(&ldp_lcd_device);
> 
> If the panel device registration fails, does the whole TWL probe fail?
> If so, that sounds a bit harsh to me.

OK I've applied the updated version below which does not make the
TWL GPIO probe to fail on errors.
 
> Looks right to me:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Rather ugly, though, but there's probably no point in trying to do it in
> a cleaner way (the new GPIO API, I think?), as we'll move to DT soon.

Yes we should not need the callbacks just to set TWL GPIO numbers
when booted with DT so this problem will disappear.

Updated patch below for reference, I kept your ack hope that's OK with
you.

Regards,

Tony

8< --------------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 27 Dec 2013 09:33:27 -0800
Subject: [PATCH] ARM: OMAP2+: Fix LCD panel backlight regression for LDP legacy booting

Looks like the LCD panel on LDP has been broken quite a while, and
recently got fixed by commit 0b2aa8bed3e1 (gpio: twl4030: Fix regression
for twl gpio output). However, there's still an issue left where the panel
backlight does not come on if the LCD drivers are built into the
kernel.

Fix the issue by registering the DPI LCD panel only after the twl4030
GPIO has probed.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[tony@atomide.com: updated per Tomi's comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -242,12 +242,18 @@ static void __init ldp_display_init(void)
 
 static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 {
+	int res;
+
 	/* LCD enable GPIO */
 	ldp_lcd_pdata.enable_gpio = gpio + 7;
 
 	/* Backlight enable GPIO */
 	ldp_lcd_pdata.backlight_gpio = gpio + 15;
 
+	res = platform_device_register(&ldp_lcd_device);
+	if (res)
+		pr_err("Unable to register LCD: %d\n", res);
+
 	return 0;
 }
 
@@ -346,7 +352,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
-	&ldp_lcd_device,
 };
 
 #ifdef CONFIG_OMAP_MUX
