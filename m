From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Sat, 27 Sep 2008 08:04:16 -0700
Message-ID: <200809270804.16788.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <20080926174643.GA9890@frodo> <48DDE2AD.1030202@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:20590 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752069AbYI0PET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Sep 2008 11:04:19 -0400
In-Reply-To: <48DDE2AD.1030202@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Saturday 27 September 2008, Mikko Ylinen wrote:
> Hi,
> 
> Felipe Balbi wrote:
> > On Fri, Sep 26, 2008 at 10:09:12AM -0700, David Brownell wrote:
> >> Passing those registers in platform data seems bizarre.
> >> Doesn't the MADC code know its own register offsets??
> > 
> > there two of them. i[ms]r[12].
> 
> twl4030 has two interrupt lines. For INT1 and INT2
> lines you should use I[MS]R1 and I[MS]R2, respectively.
> 
> This is board specific information. Beagleboard uses
> INT1.

So IMO it would make more sense to pass "1" or "2" in
the platform_data -- possibly for other sub-chips too --
and have the driver use that to figure out which set of
registers to use.  If both were wired up, it would be
a board policy which sub-chips used which IRQs, right?
(Haven't read the whole manual yet.)


> >> And no ADC lines are even hooked up on Beagle, so the right
> >> fix is just to not provide madc platform data on beagle.
> >> Probably the same is true on some other boards.
> > 
> > Yeah, i wasn't sure if beagle and overo were using them, so I put
> > anyways.
> 
> Not completely true. MADC has 16 channels out of which only 6
> are truly general purpose channels. Some channels are reserved
> for battery charger interface (BCI) and some for chip's internal
> purposes.
> 
> Boards having twl4030 should have at least VBAT (ch 12),
> V backup battery (ch 9), and VBUS (ch 8) measurement available.
> 
> On Beagleboard you can measure these three channels.

I stand not-completely-corrected, then!  No channels are wired
on the beagle; but some are wired internally to its T2 chip.  ;)


The first two being more or less fixed values (4.2V, GND);
no battery.  In general, I can imagine it would be good to
export those for hwmon usage (sysfs) or as part of the power
management infrastructure.

Without disentangling things I've not looked at before ...
is the USB support using that VBUS measurement?  Should it?
The MUSB interface exposes VBUS comparators, so I think that
it's not expected to need these additional values.

In short:  it doesn't seem like non-battery systems (like
Beagle and Overo) would need those channels.  Agree?


A question that may well come up when this heads upstream:
why is this exporting a miscdev, for an ioctl, when this
could all be done using sysfs and hwmon rules?  That is,
was this the "appropriate" way to export ADC channels?

And a slightly more pragmatic question:  does Nokia have
tools that would break if this were switched to hwmon style?


> >> Plus:  MADC is just a set of ADC channels, right?
> >> If so, the driver should have a comment saying that.
> > 
> > Mikko should comment on that as he wrote the driver.
> 
> How detailed information would you like to have here?

Enough to answer the question "what's a MADC?" for someone
who doesn't have TWL specs and hasn't read even any kind
of summary data sheet.  Three sentences would likely be
excessive; one good sentence might suffice.

- Dave

> 
> -- 
> Regards, Mikko
> 
> 


