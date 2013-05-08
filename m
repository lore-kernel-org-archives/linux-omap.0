From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/3] ARM: omap3: add Seagate Wireless Plus board
Date: Wed, 8 May 2013 15:30:27 -0700
Message-ID: <20130508223027.GN32546@atomide.com>
References: <cover.1368038129.git.jason@lakedaemon.net>
 <20130508195152.GE32546@atomide.com>
 <20130508215853.GD31290@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21134 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab3EHWab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 18:30:31 -0400
Content-Disposition: inline
In-Reply-To: <20130508215853.GD31290@titan.lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jason Cooper <jason@lakedaemon.net> [130508 15:04]:
> On Wed, May 08, 2013 at 12:51:53PM -0700, Tony Lindgren wrote:
> > * Jason Cooper <jason@lakedaemon.net> [130508 12:29]:
> > > 
> > > Current Problem:
> > > 
> > > There are several gaps in my understanding of how far along TI's conversion to
> > > DT is.  Should I be doing a separate board file for initializing the legacy
> > > items?  I was hoping to do it all with DT.
> > 
> > Sorry forgot to reply to this.. No seprate board file should be needed,
> > some devices may still need to be initialized with pdata based on the
> > compatible flag.
> 
> ti,hwmod, right?

Yes.. see mach-omap2/devices.c for the list that's still not initialized
via DT.
 
> > > Obviously, I don't expect anybody to run out and buy one of these, take it
> > > apart, and try to boot this code.  But if the omap guys could take a look at
> > > this and give me a few pointers, I'd appreciate it.  I'm kind of spinning my
> > > wheels at the moment.
> > > 
> > > Primarily, I'd like to get nand and usb working, so that I can read/write,
> > > mount a rootfs and do better testing.
> > 
> > The USB should be doable with device tree. At least both echi and
> > musb are working properly on pandaboard. I think people have been
> > using NAND with the gpmc DT patches, but I don't know the current
> > status for sure.
> 
> I'll try your suggestion in your other email for ToT and see if I can
> get gpmc going.
> 
> > Is the hard drive on the EHCI bus or how is it connected to omap?
> 
> via ehci.  They brutalized the tps driver to detect if the goflex cable
> was attached or not.  Once I get something stable, I'll probably write a
> separate driver for that code.  Or, push it out to userspace.

OK. I guess you need to disconnect the drive from EHCI if the goflex
is attached to avoid disk corruption?

Regards,

Tony
