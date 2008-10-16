From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Thu, 16 Oct 2008 15:07:38 -0700
Message-ID: <200810161507.38381.david-b@pacbell.net>
References: <20081010120427.GZ3044@atomide.com> <200810161243.41079.david-b@pacbell.net> <e5e6ade50810161442r103a298di669f44b594de2d72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:20929 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756459AbYJPWHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 18:07:40 -0400
In-Reply-To: <e5e6ade50810161442r103a298di669f44b594de2d72@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thursday 16 October 2008, Nathan Monson wrote:
> On Thu, Oct 16, 2008 at 12:43 PM, David Brownell <david-b@pacbell.net> wrote:
> > The MUSB transceiver-level issues I was aware of (mostly
> > on Overo, but minor glitches on Beagle) now seem to be
> > fixed by the combination of the IRQ patches I sent last
> > week, plus the twl4030-usb patch I just sent.
> 
> This is working great for me now.  Whether I boot plugged in, or later
> plug in the A side or B side, USB host mode is working again.  Thank
> you!

:)


> Of course, I still apply a stack of Ajay's patches to get MUSB host
> mode stable, but there's a different issue.

I hope Felipe is on top of all those, and has them queued
for the upcoming 2.6.28 mainline USB merge ...

- dave
