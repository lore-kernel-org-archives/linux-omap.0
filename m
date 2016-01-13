From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Wed, 13 Jan 2016 10:00:07 -0800
Message-ID: <20160113180006.GJ12777@atomide.com>
References: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com>
 <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com>
 <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com>
 <5696896F.4090309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5696896F.4090309@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160113 09:30]:
> On 01/13/2016 10:48 AM, Tony Lindgren wrote:
> > 
> > So if we start changing things to GPIO mode, we really need some
> > further explanations and neeed to handle the GPIO pin properly in
> > the TWL driver. And it should be done in a separate patch for all
> > of the TWL SoCs.
> 
> That does not make sense to me. The original intent of MSECURE is to use
> PMIC control (in specific certain usecases - which are no longer
> relevant) in trustzone or equivalent secure processor modes. when such a
> mode is not planned on being used, you just tell PMIC that it is always
> in secure mode. In fact, there was discussion internally that MSECURE
> should never even have been connected to SoC if the SoC was GP SoC - but
> ofcourse, the want to have a consistent reference schematics for evms
> (since EVMs have HS/Non-HS parts) trumped such talk.
> 
> trying to split this up into further steps adds 0 additional
> functionality - what is the pmic driver supposed to do with the GPIO even?
> 
> in *real* HS product devices, in fact, the register space is really
> firewalled out

Right, OK here we are finally getting some answers to the "why" part :)

And I also have few more "why" question in mind. If this change from
msecure to GPIO muxing is so important.

Why it was never fixed in the mainline kernel for omap4 and omap5 and
it was just sitting in various TI trees?

And it sounds like any kind of muxing on HS devices here for this
pin will oops the device?

> The last TI product kernel tree that seriously focussed on OMAP5/OMAP4
> was
> http://git.omapzoom.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/p-linux-omap-3.4
> things changed definitions (in terms of descope) since then.. but
> anyways.. thought I'd just pitch it out here.
> 
> sevm: - this board got scrapped
> http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5evm.c;h=bd8d71d75cc3da921856bb2004230e4cd6505328;hb=refs/heads/p-linux-omap-3.4#l1097
> 
> omap5-panda is the omap5uevm/evm now:
> http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5panda.c;h=6113bc0e04625a1bd794b3f169581c67ad3b42ff;hb=refs/heads/p-linux-omap-3.4#l816

OK

> > I don't have anything against adding GPIO handling to the TWL driver
> > so it can be optionally specified. But that's clearly a separate patch
> 
> TWL/TPS driver will need no change in the proposal I made with "gpio
> hog" mechanism (Documentation/devicetree/bindings/gpio/gpio.txt -
> gpio-hog property) - just a dt change for the right configuration.

OK. So are we sure the TWL driver will never have to toggle this pin?

Again, that's another "why" that I have no clue about and that is not
documented anywhere.

> > and should be done by somebody who knows more about the issue and has
> > a test case needing the GPIO logic for this pin.
> 
> Since my explanation does not seem to suffice, alright - we can wait for
> the right person, then.

Sorry don't take it personally. I'm just trying to make sense of the
"why do we need to do this change?" part. Especially if I need to make
the change and write the commit log.

Regards,

Tony
