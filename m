From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC] ARM: omap3: Split the pinmux core device
Date: Wed, 04 Dec 2013 19:44:21 +0100
Message-ID: <3374611.sGfCARW7Hu@avalon>
References: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com> <2098999.THrpfnVM6o@avalon> <20131204182437.GU26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:49782 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867Ab3LDSoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 13:44:16 -0500
In-Reply-To: <20131204182437.GU26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, sakari.ailus@iki.fi

Hi Tony,

On Wednesday 04 December 2013 10:24:37 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [131204 09:59]:
> > Hi Tony,
> > 
> > On Wednesday 04 December 2013 09:28:53 Tony Lindgren wrote:
> > > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [131204 09:12]:
> > > > The omap3_pmx_core pinmux device in the device tree handles the system
> > > > controller module (SCM) PADCONFS fonction. Its control registers are
> > > > split in two distinct areas, with other SCM registers in-between.
> > > > Those other registers can't thus be requested by other drivers as the
> > > > memory region gets reserved by the pinmux driver.
> > > > 
> > > > Split the omap3_pmx_core device tree node in two for the two memory
> > > > regions.
> > > > 
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > ---
> > > > 
> > > >  arch/arm/boot/dts/omap3-beagle-xm.dts | 45 ++++++++++++++++++++------
> > > >  arch/arm/boot/dts/omap3-beagle.dts    | 28 +++++++++++++++-------
> > > >  arch/arm/boot/dts/omap3-igep0020.dts  | 26 ++++++++++----------
> > > >  arch/arm/boot/dts/omap3-zoom3.dts     | 19 ++++++++++-----
> > > >  arch/arm/boot/dts/omap3.dtsi          | 13 +++++++++-
> > > >  5 files changed, 95 insertions(+), 36 deletions(-)
> > > > 
> > > > While working on the OMAP3 ISP driver I've run into a failure to
> > > > request a memory region already requested by the pinctrl-single
> > > > driver. This patch is an attempt to fix the problem. An alternative
> > > > approach would be to support multiple reg values in the pinctrl-single
> > > > driver, but that might not be much cleaner. I'm open to suggestions.
> > > 
> > > Makes sense to me to split it into two, we can save some memory that way
> > > too.
> > > 
> > > It should not cause problems with the wake-up interrupts either as we're
> > > already using a single chained wake-up interrupt between core and wkup
> > > pins.
> > > 
> > > Do you have some perl or sed script to look for and convert the core2
> > > registers? Or do we just not have that many of them defined yet?
> > 
> > This patch should cover all the ones we have in mainline. As this is an
> > RFC I've performed the conversion manually.
> 
> OK. I wonder if we should add something like this to make it easier to
> use the padconf values from the TRM:
> 
> #define OMAP_IOPAD_OFFSET(pa, offset)	((pa) & 0xffff) - (offset))
> 
> #define OMAP2_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0030) (val))
> #define OMAP3_CORE1_IOPAD(pa, val)	OMAP2_CORE_IOPAD((pa), (val))
> #define OMAP3_CORE2_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x05a0) (val))
> #define OMAP4_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0040) (val))
> #define OMAP4_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xe040) (val))
> #define OMAP5_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0840) (val))
> #define OMAP5_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xc850) (val))
> ...
> 
> Then we would have entries like:
> 
> 	pinctrl-single,pins = <
> 		OMAP3_CORE1_IOPAD(0x158, PIN_INPUT_PULLUP | MUX_MODE0)
> 		...
> 	>;
> 
> instead of:
> 
> 	pinctrl-single,pins = <
> 		0x128 (PIN_INPUT_PULLUP | MUX_MODE0)
> 		...
> 	>;

That's a good idea, it would be much more readable. Would you like to submit a 
patch ? Should I rebase my patch on top of that, or the other way around ?

-- 
Regards,

Laurent Pinchart

