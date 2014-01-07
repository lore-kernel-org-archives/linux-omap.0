From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: Add omap specific pinctrl defines to
 use padconf addresses
Date: Tue, 7 Jan 2014 15:20:18 -0800
Message-ID: <20140107232018.GE5074@atomide.com>
References: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1387554677-21100-2-git-send-email-laurent.pinchart@ideasonboard.com>
 <20140107223021.GA5074@atomide.com>
 <1562680.iFW31kAxBU@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60868 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753999AbaAGXUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jan 2014 18:20:24 -0500
Content-Disposition: inline
In-Reply-To: <1562680.iFW31kAxBU@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@debian.org>, Sakari Ailus <sakari.ailus@iki.fi>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140107 15:10]:
> Hi Tony,
> 
> On Tuesday 07 January 2014 14:30:21 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [131220 07:52]:
> > > From: Tony Lindgren <tony@atomide.com>
> > > +/*
> > > + * Macros to allow using the absolute physical address instead of the
> > > + * padconf registers instead of the offset from padconf base.
> > > + */
> > > +#define OMAP_IOPAD_OFFSET(pa, offset)	(((pa) & 0xffff) - (offset))
> > > +
> > > +#define OMAP2420_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0030)
> > > (val)
> > > +#define OMAP2430_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030)
> > > (val)
> > > +#define OMAP3_CORE1_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
> > > +#define OMAP3_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25a0) (val)
> > 
> > Sorry for the delay on these, I'm only now getting back to looking
> > at all the emails since the holidays :)
> > 
> > After looking at Nishant's omap3 pinctrl core2 patch, looks like we need
> > to have separate OMAP3430_CORE2_IOPAD and OMAP3630_CORE2_IOPAD defines.
> 
> That was my first impression as well, but I think we actually don't need to. 
> The OMAP3430 just has no useful registers in the 0x25a0 - 0x25d7 area, so we 
> can make the CORE2 macro span that for both 3430 and 3630.

Hmm well I already did it :) In general my gut feeling is along the lines
what you're saying, I think the padconf registers are all there on all
omap3 SoCs, but only some of the padconf registers are used depending on
the SoC revision and package.

Anyways, it should not hurt to have the padconf registers defined the
same way as the documentation has them, at least we may get some extra
warnings if people try to configure unused registers for 3430.
 
Regards,

Tony
