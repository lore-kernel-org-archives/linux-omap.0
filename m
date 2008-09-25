From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [patch 2.6.27-rc6-omap] ASOC: quieter boot for non-Overo boards
Date: Thu, 25 Sep 2008 10:07:31 -0700
Message-ID: <1222362451.24304.59.camel@tera.sakoman.net>
References: <200809211414.42194.david-b@pacbell.net>
	 <20080925124934.GR5222@atomide.com>
	 <200809250950.06409.david-b@pacbell.net>
Reply-To: steve@sakoman.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx09.roch.ny.frontiernet.net ([66.133.183.226]:24547 "EHLO
	mx09.roch.ny.frontiernet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752792AbYIYRRO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 13:17:14 -0400
In-Reply-To: <200809250950.06409.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, 2008-09-25 at 09:50 -0700, David Brownell wrote:
> On Thursday 25 September 2008, Tony Lindgren wrote:
> > > Get rid of bogus ASOC boot messages on non-Overo boards.
> > 
> > I'm not touching this without an ack from alsa list :)
> 
> Has this driver even gone to that list yet?  ;)

Yes, the initial submission was reviewed and acked by folks on
alsa-devel.

And now that I think of it, this code should never execute on non-overo
boards since they will have their own machine ASoC driver!  So this
patch isn't really necessary.

> I haven't really looked at initialization for this yet,
> but my initial reaction to seeing the Beagle's version
> of the overo.c file is that more sharing should exist.
> (Wasn't the beagle ASOC init described as a clone?)

This was discussed, but since the overo has some additional
functionality that will be added to the machine portion of the driver it
was decided to have separate machine files for overo and beagle.  I'm
waiting for an overo "buddy" board that brings out the additional
microphone inputs before I can add and test this functionality.

> And then ... that, hey, this should hook into the same
> MFD-style initialization as we're making the other
> twl4030 code use.
> 
> And finally ... whoa, maybe someone else can split
> out the board-specific bits so they can be put in
> the arch/arm/mach-omap2/board-XYZ.c files, since I'd
> surely lose a lot of time learning ASOC if I were
> to start that!  (These messages are right at the
> core of that bit.)

Putting the board specific bits in the arch/arm/mach-omap2/board-XYZ.c
file has been discussed a number of times on alsa-devel and the folks
there insist that for now (i.e. ASoC V1) this is the proper way to do
things.

Steve


