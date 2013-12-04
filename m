From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC] ARM: omap3: Split the pinmux core device
Date: Wed, 4 Dec 2013 10:53:41 -0800
Message-ID: <20131204185341.GV26766@atomide.com>
References: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <2098999.THrpfnVM6o@avalon>
 <20131204182437.GU26766@atomide.com>
 <3374611.sGfCARW7Hu@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10836 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010Ab3LDSxp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 13:53:45 -0500
Content-Disposition: inline
In-Reply-To: <3374611.sGfCARW7Hu@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, sakari.ailus@iki.fi

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [131204 10:45]:
> On Wednesday 04 December 2013 10:24:37 Tony Lindgren wrote:
> > 
> > OK. I wonder if we should add something like this to make it easier to
> > use the padconf values from the TRM:
> > 
> > #define OMAP_IOPAD_OFFSET(pa, offset)	((pa) & 0xffff) - (offset))
> > 
> > #define OMAP2_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0030) (val))
> > #define OMAP3_CORE1_IOPAD(pa, val)	OMAP2_CORE_IOPAD((pa), (val))
> > #define OMAP3_CORE2_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x05a0) (val))
> > #define OMAP4_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0040) (val))
> > #define OMAP4_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xe040) (val))
> > #define OMAP5_CORE_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0x0840) (val))
> > #define OMAP5_WKUP_IOPAD(pa, val)	(OMAP_IOPAD_OFFSET((pa), 0xc850) (val))
> > ...
> > 
> > Then we would have entries like:
> > 
> > 	pinctrl-single,pins = <
> > 		OMAP3_CORE1_IOPAD(0x158, PIN_INPUT_PULLUP | MUX_MODE0)
> > 		...
> > 	>;
> > 
> > instead of:
> > 
> > 	pinctrl-single,pins = <
> > 		0x128 (PIN_INPUT_PULLUP | MUX_MODE0)
> > 		...
> > 	>;
> 
> That's a good idea, it would be much more readable. Would you like to submit a 
> patch ? Should I rebase my patch on top of that, or the other way around ?

OK I'll do a patch for that later on today, then you can use that. Might
cut down the churn a little that way.

Regards,

Tony
