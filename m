From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc6-omap] ASOC: quieter boot for non-Overo boards
Date: Thu, 25 Sep 2008 09:50:06 -0700
Message-ID: <200809250950.06409.david-b@pacbell.net>
References: <200809211414.42194.david-b@pacbell.net> <20080925124934.GR5222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:48428 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752555AbYIYQuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 12:50:09 -0400
In-Reply-To: <20080925124934.GR5222@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

On Thursday 25 September 2008, Tony Lindgren wrote:
> > Get rid of bogus ASOC boot messages on non-Overo boards.
> 
> I'm not touching this without an ack from alsa list :)

Has this driver even gone to that list yet?  ;)


I haven't really looked at initialization for this yet,
but my initial reaction to seeing the Beagle's version
of the overo.c file is that more sharing should exist.
(Wasn't the beagle ASOC init described as a clone?)

And then ... that, hey, this should hook into the same
MFD-style initialization as we're making the other
twl4030 code use.

And finally ... whoa, maybe someone else can split
out the board-specific bits so they can be put in
the arch/arm/mach-omap2/board-XYZ.c files, since I'd
surely lose a lot of time learning ASOC if I were
to start that!  (These messages are right at the
core of that bit.)

- Dave
