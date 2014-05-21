From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 09/10] DTS: ARM: OMAP3-N900: Add SSI support
Date: Wed, 21 May 2014 14:09:56 -0700
Message-ID: <20140521210956.GA14520@atomide.com>
References: <1399739870-13526-1-git-send-email-sre@kernel.org>
 <1399739870-13526-10-git-send-email-sre@kernel.org>
 <20140514215503.GM27426@atomide.com>
 <20140520003538.GD15793@atomide.com>
 <20140521182513.GA26285@earth.universe>
 <20140521184319.GL17417@atomide.com>
 <20140521200928.GA27602@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140521200928.GA27602@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [140521 13:10]:
> Hi,
> 
> On Wed, May 21, 2014 at 11:43:19AM -0700, Tony Lindgren wrote:
> > > > Just noticed that this patch seems to somehow break idle
> > > > modes on n900, so dropping both dts changes for now.
> > > > 
> > > > Basically the n900 debug LEDs won't ever go off with
> > > > these two dts patches enabled, even without the modem
> > > > drivers loaded. I did not dig deeper, but it's probably
> > > > something related to hwmod using this data for some
> > > > settings.
> > > 
> > > Is hwmod data interpreted at all without the DT entries?
> > 
> > Yes for autoidling unused devices. We parse that with
> > omap_device_build_from_dt().
> 
> That function seems to parse DT stuff. What I meant was
> not without the *driver*, but without the *DT entry*.
> 
> I think the hwmod entries are completly ignored until there
> is a DT device?

Yes for device tree based booting. They get initialized
based on the ti,hwmods property. Posted a suggested fix,
you've probably seen it by now :)

Tony
