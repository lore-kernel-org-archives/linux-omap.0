From: Peter Barada <peterb@logicpd.com>
Subject: Re: MMC3 Overo
Date: Thu, 06 Aug 2009 12:09:50 -0400
Message-ID: <1249574990.10885.43.camel@blitz>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
	 <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>
	 <873a866xdo.fsf@deeprootsystems.com>
	 <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>
	 <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
	 <4A79C83E.9040603@deeprootsystems.com>
	 <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>
	 <4A79D104.60607@deeprootsystems.com>
	 <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>
	 <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
	 <871vnp8170.fsf@deeprootsystems.com>  <4A7AF213.6040301@balister.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:54625 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751521AbZHFQbX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 12:31:23 -0400
In-Reply-To: <4A7AF213.6040301@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-08-06 at 11:09 -0400, Philip Balister wrote:
> Kevin Hilman wrote:
> > John Sarman <johnsarman@gmail.com> writes:
> > 
> >> On Wed, Aug 5, 2009 at 2:35 PM, Kevin Hilman<khilman@deeprootsystems.com> wrote:
> >>> Steve Sakoman wrote:
> >>>> On Wed, Aug 5, 2009 at 10:58 AM, Kevin
> >>>> Hilman<khilman@deeprootsystems.com> wrote:
> >>>>> Steve Sakoman wrote:
> >>>>>> And up to now in each case I shrug and say "no time to do that now,
> >>>>>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
> >>>>> I agree there are lots of shortcomings in the current mux code and we've
> >>>>> been hitting them regularily lately.
> >>>>>
> >>>>> That being said, for mux settings that done one-time only at boot, what
> >>>>> are
> >>>>> the problems you're running into?
> >>>> It's been a few months since I last encountered this, so the exact
> >>>> details are a bit fuzzy.
> >>>>
> >>>> I seem to recall that there were some basic issues with enabling
> >>>> kernel pinmuxing in that some of the setup that was done for all
> >>>> machines was just wrong for my particular machine.  IIRC, it was due
> >>>> to assumptions about which pad was used for a particular function (for
> >>>> those functions which can be steered to multiple GPIO pads).
> >>>>
> >>>> So I faced having to undo that change in my board file as well as any
> >>>> issues that may have arisen from glitches on the GPIO pins during the
> >>>> process.  And since there were several of these I gave up and turned
> >>>> off kernel pinmuxing.
> >>>>
> >>>> I'd be happy if we cleaned up the "one size fits all" pinmuxing to
> >>>> just that subset that truly does fit all boards, and leave the rest to
> >>>> the board files.  I'd also be content to have it all done in the board
> >>>> file for each machine.
> >>> Indeed, any assumptions about common muxing that are not indeed common are
> >>> bugs and should be fixed.
> >>>
> >>> The "right" solution is to have everything in the kernel, and split across
> >>> SoC "common" init and board specific init.  Of course u-boot
> >>> will still have to do some early muxing, but it should be redone in
> >>> the kernel so it's trivial to change bootloaders.
> >>>
> >>> So the real missing piece is someone to step up and rework the mux code.
> >>> The bigger problem is that the vast majority of folks don't care about the
> >>> common case and only care about getting thing working for a specific
> >>> platform.
> >>>
> >>> Kevin
> >>>
> >> I  like the idea of having the board file configure the mux.  First of
> >> all lets address the shortcomings of mux.h.  The Pin values are
> >> labeled as so:
> >> <snip from mux.h>
> >> * NOTE: Please use the following naming style for new pin entries.
> >>  *       For example, W8_1610_MMC2_DAT0, where:
> >>  *       - W8        = ball
> >>  *       - 1610      = 1510 or 1610, none if common for both 1510 and 1610
> >>  *       - MMC2_DAT0 = function
> >>
> >> But lets take the 3530 as an example.
> >>  The 3530 has three separate packages.  CBB, CBC, and CUS.  Now lets
> >> look at MMC3_clk (the root of my original problem that started this
> >> thread)
> >>                        CBB              CBC            CUS
> >> mmc3_clk         AB1 / AF10    R9 / AB2     AC1
> >>
> >> So to properly add these to mux.h we need to add 5 entries for mmc3_clk
> >>       AB1_35XXCBB_MMC3_CLK
> >>       AF10_35XXCBB_MMC3_CLK
> >>       R9_35XXCBC_MMC3_CLK
> >>       AB2_35XXCBC_MMC3_CLK
> >>       AC1_35XXCUS_MMC3_CLK
> >> We would then have to update mux.c making sure the position matches
> >> and add the proper settings.
> >>
> >> So this is obviously a maintenance nightmare.
> > 
> > So why don't we drop the ball (pun intended.) ;)
> > 
> > This is what I proposed to Phillip Ballister for his SPI changes for Beagle.
> > 
> > Though I haven't looked at the details for each package, I have a hard
> > time imagining that the reg offsets and functionality for each package
> > is different.  In fact, I'm pretty sure they're even the same between
> > 34xx and 35xx.  
> > 
> > IOW, why not just name it OMAP3_MMC3_CLK and have a single entry.
> > 
> > Then each board file that cares simply has to call omap_cfg_reg() on
> > that name and not care about the package.
> 
> They first problem I see is the MMC3_CLK is available on multiple balls, 
> so the mux files need to list them all.
> 
> Unless you are proposing custom mux files for each board? Is this is 
> good idea (just had this thought). In other words, instead of trying to 
> come up with one set of mux files, make them board specific.

Here's an idea:

1) Replace index with enum search in pin table - this breaks the
requirement that the enum list and table align - a good thing as
misalingment has bitten me multiple times when adding pins to the
current mux table.  Also, pinmux setup is done infrequently, so the
search doesn't add much overall execution time.

2) Break up mux table into two parts, the "common" mux list, and a
"custom" mux list - the latter in the board file, and add a function to
add the custom mux list to mux lists searched by omap_cfg_reg().

3) Search the custom mux list first (if specified - allows replacing an
entry in the common table if hardware required differences in
termination, custom pins for GPIO, etc).

For example, on the OMAP3530, balls H18-H21 can be associated with
either UART3, or GPIOs 163-166. In the common mux list (where multiple
boards use those pins for UART3, the common mux file can have the
entries:

H18_35XX_UART3_CTS
H19_35XX_UART3_RTS
H20_35XX_UART3_RX
H21_35XX_UART_TX

that sets up the mux for those pines as a UART.  If a board wants to use
those pins instead for GPIO, then in the board file it can have a custom
mux list with:

H18_35XX_GPIO_163
H19_35XX_GPIO_164
H20_35XX_GPIO_165
H21_35XX_GPIO_166

and call into the mux code to add the custom mux list to be searched
first.

Thoughts?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
