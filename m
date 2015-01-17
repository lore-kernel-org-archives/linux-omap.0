From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Sat, 17 Jan 2015 10:14:04 -0800
Message-ID: <20150117181404.GW18552@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25748 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751597AbbAQSRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2015 13:17:40 -0500
Content-Disposition: inline
In-Reply-To: <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150117 09:54]:
> On 17 January 2015 at 17:47, Tony Lindgren <tony@atomide.com> wrote:
> > Also looks like the PULL_ENA bit is inverted on dm816x like on am33xx
> 
> Yes, ditto on dm814x but there things get even more interesting:
> 
> It has the same four config bits as am335x but moved them to bits
> 16-19, while bits 0-7 contains 1 << mode.  The benefit is that you can
> also select no mode at all (high-Z or just the pull if enabled) and
> this is in fact the default, though I'm curious what would happen if
> multiple bits are set (though not curious enough to risk my hardware
> :P ).

Oh OK. And looks like dm814x trm claims to have PINCNTL[7:0]
bits for MUXMODE instead of just bits [2:0]?
 
> It also means you can change mode with a byte-write to avoid touching
> the upper bits, which is nice especially since slew is preconfigured
> per pin to match I/O timings and you're supposed to never change it
> (after fixing the ones ROM messed up due to bugs).  Also on rev 2.x
> silicon you're not allowed to disable the receiver if using 3.3V I/O.

Maybe that's why some bits got shifted :) 
 
> > +#define DM816X_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
> > #define AM33XX_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
> > #define AM4372_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
> 
> The overall control module layout is actually compatible across the
> whole happy family; basically any register they have in common is at
> the same offset (with notable exception of ADC and eCAP event muxes on
> am335x versus c6a811x/dra62x, but the latter is a semi-mythical device
> anyway, not even a product brief in circulation). They often even have
> the same semantics, though padconf shows this isn't always true
> unfortunately.

Got any generic naming in mind for the helper macro we could use?
 
> A similar thing is true for the overall device memory map actually:
> https://docs.google.com/spreadsheets/d/1hRgpmJ-4Yeojyl8XPO9n3IoYSWKPkg6oRnEvdfV_RaM/view

Cool, that certainly helps. To me it looks dm814x needs it's own
clock driver for the source clocks, but after that the dividers
are similar to dm816x and am33xx. Have not looked at the am814x
beyond that though.

Regards,

Tony
