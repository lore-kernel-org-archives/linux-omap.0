From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 16:47:31 -0800
Message-ID: <20120209004731.GA11343@kroah.com>
References: <87lioegtk9.fsf@ti.com>
 <87y5sei1qz.fsf@ti.com>
 <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
 <87k43xfee3.fsf@ti.com>
 <20120208170653.GA3492@kroah.com>
 <CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
 <20120208195327.GA5223@kroah.com>
 <871uq53p3c.fsf@ti.com>
 <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61668 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab2BIArk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:47:40 -0500
Received: by pbcun15 with SMTP id un15so1064091pbc.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 16:47:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 05:14:18PM -0700, Paul Walmsley wrote:
> Hi Greg
> 
> was just directed at this thread:
> 
> On Wed, 8 Feb 2012, Greg KH wrote:
> 
> > Don't send me anything, saying it needs to get into the -rc merge 
> > window, that you don't actually want to see merged.  Otherwise, how long 
> > am I supposed to know to wait?  That's just looney.
> 
> We did want to see it merged.  But then we came up with a better fix, 
> which is why I asked you to revert the original in favor of the new 
> version:
> 
> http://marc.info/?l=linux-arm-kernel&m=132760582332651&w=2
> 
> If we'd realized that the second version would be delayed until 3.4, we 
> wouldn't have wanted the first version to be reverted :-(

You said the first version was broken.

Anyway, moving on...

> > > The version you have currently queued is needed for v3.3 as they fix
> > > brokenness on v3.3.  Any chance they can be applied queued for 3.3?
> > > We'll have another set of enhancements on top of those that are
> > > targetted for v3.4, but those you have queued currently are defintely
> > > fixes.
> > 
> > At this point in the release cycle, I would prefer to wait.
> 
> It would be really great if this series could make it in for v3.3-rcX.  
> Without it, 3.3 will be unusable for any OMAP users that run the console 
> on the serial port.  That's pretty much every OMAP user that runs mainline 
> kernels, AFAIK.

Show me an OMAP user that actually runs a mainline kernel :)

What changeset(s) do you want me to take from my tty-next tree and put
it in the tty-linus tree to be merged for the 3.3-final timeframe?

thanks,

greg k-h
