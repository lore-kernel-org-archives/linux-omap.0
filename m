From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Wed, 3 Oct 2012 08:53:27 -0700
Message-ID: <20121003155327.GZ4840@atomide.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
 <20121001154451.GI4840@atomide.com>
 <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57439 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932427Ab2JCPxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 11:53:37 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>, "dong.aisheng@linaro.org" <dong.aisheng@linaro.org>

* AnilKumar, Chimata <anilkumar@ti.com> [121003 03:53]:
> On Tue, Oct 02, 2012 at 01:29:37, Linus Walleij wrote:
> > On Mon, Oct 1, 2012 at 5:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> > 
> > >> OK that is typical pinctrl driver implementation work.
> > >> I hope Tony can advice on this?
> > >
> > > I think we're best off to just stick to alternative named modes
> > > passed from device tree. For example, for GPIO wake-ups you can
> > > have named modes such as "default", "enabled" and "idle" where
> > > "idle" muxes things for GPIO wake-ups for the duration of idle.
> > >
> 
> In this case we need to add three different values according
> to three modes (default, enabled, idle) and for each node.

Yes those make sense from the generic leds-gpio point of view
for the platforms that implement pinctrl.
 
> > > It seems that should also work for leds-gpio. And you can
> > > define more named modes as needed.
> 
> If we want to implement pinctrl_gpio functionality we have to
> separate "function-mask" bits to
> 
> 1. pinmux-mask
> 2. pinconf-mask, to make it generic we need following bit masks
> 	a. receiver enable/disable bit
> 	b. slew rate fast/slow bit
> 	c. pull-up/down bit
> 	....

Yes those can be implemented, but the problem will always be
that the driver will not know if the board is using external
pulls. If you implement the board specific settings in the .dts
file for default, enabled and idle, the leds-gpio does not need
to care if the pull is internal or external. So that seems like
a more generic way to do it.
 
> I have gone through nvidia pinctrl dt data (tegra20-seaboard.dts,
> node drive_sdio1) which has different pinconfig values, those
> are mapping to pinconf values.
> 
> With the above bit masks and function-mask we can identify
> pull-up/down, slow/high speed slew rate and direction in/out.
> 
> (or)
> 
> Named modes:-
> 
> Are you saying named modes like this?
> default-input-up
> default-input-down
> default-output-up
> default-output-down

Hmm no, you want to implement named modes that make sense
from the client driver point of view. It seems that default,
enabled and idle should do here? Then for the enabled mode
you can set the LED specific pins to whatever pull mode
you want for the board, and then leds-gpio does the rest
using the gpio framework.
 
> This 1, 2 and 2.a or named modes are required to implement
> pinctrl_gpio_direction_input/output and
> pinctrl_request/free_gpio.

I would just add the named modes to leds-gpio because 2a
does not work for the case where you use external pulls.

Regards,

Tony 
