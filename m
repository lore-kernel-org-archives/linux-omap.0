From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 board code in 3.14
Date: Sat, 16 Nov 2013 06:12:26 -0800
Message-ID: <20131116141226.GD10317@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <20131116120508.GA22335@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62095 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab3KPOMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 09:12:30 -0500
Content-Disposition: inline
In-Reply-To: <20131116120508.GA22335@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [131116 04:06]:
> Hi Tony,
> 
> On Fri, Nov 15, 2013 at 04:36:02PM -0800, Tony Lindgren wrote:
> > Here are few patches to deal with the mix of legacy platform data
> > and device tree that we still need to do at least until DSS has
> > device tree bindings. These patches should allow the remaining
> > omap3 boards to be made device tree only so we can remove the
> > board-*.c files.
> 
> Do you plan to remove the Nokia N900 board code in 3.14, too?

Probably not completely, we should still keep the pieces that are
needed to initialize things in legacy mode. Then those can be dealt
with using the auxdata hooks in pdata-quirks.c.

But we do want to boot everything in in DT mode for mach-omap2 for
v3.14 as that leaves out huge amounts of old duplicate code.
 
> I see two big issues with that:
>  a) Using DT boot the display is currently not working.

OK

>  b) I could not get the 32GB eMMC working. For me the chip is not found
>     and I don't know how to debug it.

OK the eMMC issue might be related to the control module PBIAS
register support missing. If so, that should be fixable with the
auxdata until we have a minimal control module device driver to
deal with the PBIAS and expose those features as regulators to
the omap-hsmmc driver.
 
> There are two reasons for broken display:
> 
> 1. omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OUTPUT) fails.
>    This can be fixed by simply not calling it in DT mode. DT data
>    contains pinmux information for this from 3.13 onwards [0].

OK yeah makes sense. The pins should be set up using pinctrl-single
for DT.

> 2. The spi panel driver is not probed.
> 
> I have a local hack to probe the panel driver via DT. I changed the
> display node to look as follows:
> 
> &mcspi1 {
>     /* ... tsc2005 ... */
> 
>     mipid@2 {
>         compatible = "sony,acx565akm";
>         spi-max-frequency = <6000000>;
>         reg = <2>;
>         vdds_sdi-supply = <&vaux1>;
>         label = "lcd";
>         reset-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
>         ti,sdi-datapairs = <2>;
>         ti,dss-source = "sdi.0";
>         pinctrl-names = "default";
>         pinctrl-0 = <&display_pins>;
>     };
> };
> 
> Then I changed the acx565akm panel driver to get data from DT
> and the DSS to get SDI regulator from the panel. This is
> obviously not the way to got, so I wonder how to proceed.
> omapdss DT seems not to be ready for the next kernel releases.
> 
> My suggestion would be:
>  1. Find a better workaround for omapdss to acquire the SDI
>     regulator. My current hack is obviously not acceptable.
>  2. Load the panel driver via DT as seen above and reference
>     the omapdss interface with something like the above
>     "ti,dss-source".

To me it seems that we should be able to add minimal panel entries to DT
if we stick to existing standard bindings. Then the timings etc can be
set up based on the compatible flag. So I would leave out the properties
for ti,sdi-datapairs and ti,dss-source for now, and just set those in
the driver based on the sony,acx565akm compatible flag. Or maybe it should
be sony,acx565akm-n900 if there's some board specific configuration info.
 
> This is obviously not a stable DT interface, but that's also the case if
> everything is done via platform quirks: An old DT file without any display
> stuff in it would not work with a newer kernel without the quirks.

Right, naturally we cannot support missing properties in the old DT files.
But the standard properties are stable, so those should be OK to use.
But let's see what Tomi says, he may have some good ideas :)

Regards,

Tony
 
> [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d1e6f51646f2bed16826fd8e4fc1b5f4188d086e


