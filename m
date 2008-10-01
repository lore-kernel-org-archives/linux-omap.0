From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Wed, 1 Oct 2008 09:13:24 -0700
Message-ID: <200810010913.25395.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809270804.16788.david-b@pacbell.net> <48E38745.8050800@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:24505 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752475AbYJAQN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 12:13:27 -0400
In-Reply-To: <48E38745.8050800@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wednesday 01 October 2008, Mikko Ylinen wrote:
> Hi,
> 
> David Brownell wrote:
> > A question that may well come up when this heads upstream:
> > why is this exporting a miscdev, for an ioctl, when this
> > could all be done using sysfs and hwmon rules?  That is,
> > was this the "appropriate" way to export ADC channels?
> 
> We could still do both, right?

Are you pointing out another question that may be raised?
Or asking me for an answer?  ;)

I *suspect* supporting both would be frowned on.  However,
the whole issue of how userspace sensor interaction should
work doesn't IMO have good answers yet.  It all depends on
polling -- no alert/alarm/interrupt framework, no streaming
of event data -- so apps newer than the stone age all need
to invent better interface models.


> > And a slightly more pragmatic question:  does Nokia have
> > tools that would break if this were switched to hwmon style?
> 
> We've used ioctl() mechanism to get ADC readings to user space quite
> some time already.
> 
> I believe this is still a better option compared with hwmon/sysfs
> approach (Reason: sometimes we do those readings very often and
> for many channels. Instead of doing all that fd magic and atoi(),
> we just call ioctl() to get raw ADC data available for further
> processing).

Sounds to me like that's a reason to expect the current
interface to stick around for a while ... and a use case
to push towards eventual "hwmon" improvements.

Although:  what's "very often"?  And why wouldn't library
code handle "all that fd magic"?

 
> >> How detailed information would you like to have here?
> > 
> > Enough to answer the question "what's a MADC?" for someone
> > who doesn't have TWL specs and hasn't read even any kind
> > of summary data sheet.  Three sentences would likely be
> > excessive; one good sentence might suffice.
> 
> Perhaps duplicate the comments we have in Kconfig to .c?

(Reads Kconfig comments.)  Yes, that'd be more than enough.
I think a number of those features aren't yet supported in
the driver though.  Maybe you should do that too.  ;)

- Dave
