From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Mon, 4 Feb 2013 09:32:52 -0800
Message-ID: <20130204173252.GN22517@atomide.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
 <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
 <CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com>
 <510F8F49.9020800@epfl.ch>
 <CABxcv==7KiBbkTyr7VLVw82F=9vVWRftpbyZWub_CVp3pQW0tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:46858 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753593Ab3BDRc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Feb 2013 12:32:58 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv==7KiBbkTyr7VLVw82F=9vVWRftpbyZWub_CVp3pQW0tQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: florian.vaussard@epfl.ch, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [130204 04:00]:
> On Mon, Feb 4, 2013 at 11:36 AM, Florian Vaussard
> > Great, the smsc911x was on my TODO list, I can cross it out :) BTW,
> > do you have a public git for this, so I can test your work on my setup?
> >
> 
> Yes, it is the gpmc-smsc911x-wip branch on my github linux tree [1]
> 
> That branch is Linus master tree + linux-omap/omap-for-v3.9/gpmc +
> linux-omap-dt/for_3.9/dts
> 
> plus these patches:
> 
> Javier Martinez Canillas (4):
>       ARM: OMAP: gpmc-smsc911x: add DT dev node init function
>       ARM: OMAP: gpmc: add support for gpmc-smsc911x child nodes
>       ARM: dts: OMAP: Add an GPMC node for OMAP3
>       ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support
> 
> You can browse these patches here [2].
> 
> With these patches I have ethernet working on my IGEPv2 but this board
> uses an OMAP GPIO pin as the smsc911x IRQ line, so it needs to set a
> mux pin (mcspi1_cs2.gpio_176 INPUT | MODE4) or it will fallback on
> poll mode.

Great, that's good news :)

> For some reasons I still couldn't figure out (I'm still learning about
> Device Trees) adding:
> 
>        pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> 
> to the gpmc-smsc911x child node parse function (gpmc_smsc911x_init_dt)
> didn't have a functional effect and I had to initialize the defined
> pinctrl-single pins for the smsc911x in the omap3_pmx_core device node
> instead of pmc_smsc911x@0 as I do for other devices (mmc, uarts, etc).

Maybe this is related to the initcall ordering..
 
> So I just removed the devm_pinctrl_get_select_default() call in
> gpmc_smsc911x_init_dt() in for this RFC.
> 
> I don't know if this is because arch/arm/mach-omap2/gpmc-smsc911x.c is
> not a real platform driver (is just a wrapper/helper function) and
> doesn't have a probe function.

..that function just initializes the pdata for smsc911x driver, and
should not be a driver. You need to add devm_pinctrl_get_select_default()
to the probe of smsc911x or the GPMC probe.
 
> Which brings me to the question if my approach of adding a binding for
> gpmc-smsc911x is correct or if we should extend/use the binding that
> already exist for smsc911x
> (Documentation/devicetree/bindings/net/smsc911x.txt).

We should use the existing smsc911x binding, then have a separate GPMC
binding for the GPMC driver.

Regards,

Tony 
 
> [1]: git://github.com/martinezjavier/linux.git
> [2]: https://github.com/martinezjavier/linux/commits/gpmc-smsc911x-wip
> [3]: http://omappedia.org/wiki/Bootloader_Project#SYSBOOT_Pins
