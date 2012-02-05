From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 18:41:39 +0000
Message-ID: <20120205184139.GI17309@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205172528.GA17029@n2100.arm.linux.org.uk> <20120205174700.GU20333@atomide.com> <20120205180812.GH17309@n2100.arm.linux.org.uk> <20120205183316.GL1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50394 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab2BESlw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 13:41:52 -0500
Content-Disposition: inline
In-Reply-To: <20120205183316.GL1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sun, Feb 05, 2012 at 10:33:16AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 09:37]:
> > So in the meantime, people should put up with the kernel reporting an
> > "Error" at error-message level at boot time because they didn't configure
> > something?
> > 
> > No, it needs fixing, because it doesn't justify being an error.  It's
> > wrong, plain and simple.  Again, if you don't want to send it during
> > -rc, I'll send it to Linus as a patch for him to decide whether he wants
> > to take it as -rc material.
> 
> Hmm, maybe I misunderstood you.
> 
> Certainly fixing the "Error" makes sense for -rc, but are also thinking
> about adding error checking to all platform_device_register() calls?

I do think they're valid for -rc, because should it fail, things won't
work as one desires.

I did stop short of fixing it properly - and by "properly" I mean that
if we fail to register the platform data for the device, then we should
not register the device itself.  That involves a change of behaviour in
the setup of the system which _might_ cause a regression.

Whereas, merely printing an error for a failure to register a device
wouldn't be a regression (it might uncover another error, but that's
arguably a good thing.)

The last bit of "properly" which needs discussion is concerning whether
we should even be trying to register this devices platform data and
device structure if WL12XX_PLATFORM_DATA is not enabled - if this is
not enabled the platform data won't be stored, and presumably the
wireless driver will be missing some vital platform data.

It seems silly to have the device registered without the platform data,
so that if the module is built for the kernel, it could be inserted and
bound to that device...

So even for this apparantly simple looking issue, there's some searching
questions that need answering.
