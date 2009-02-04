From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: new PM branch available
Date: Wed, 4 Feb 2009 18:38:46 +0200
Message-ID: <20090204163846.GC22194@codecarver.research.nokia.com>
References: <87iqoij2me.fsf@deeprootsystems.com> <20090202174532.GJ4954@codecarver.research.nokia.com> <87wsc8bp79.fsf@deeprootsystems.com> <20090204005228.GA30147@codecarver.research.nokia.com> <87eiye89y1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16763 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbZBDQjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 11:39:08 -0500
Content-Disposition: inline
In-Reply-To: <87eiye89y1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

> 
> Did you happen to notice what was keeping PER out of retention before
> the u-boot upgrade?  Looks like we might still need some init-time
> reset code to compensate for bootloaders.
> 

No. I still have the old u-boot version though, so I can reproduce the
problem. After fosdem :)

> > The only way to get core to retention was to force idle USBOTG and
> > disable the USBOTG driver.
> 
> This is the same issue on 3430SDP.  The PM branch code does the
> force-idle, and I usually have USB built as modules and not loaded
> when I do the tests.
> 

Ok.

> I'm guessing this is a result of u-boot configuring/using USB.
> 
> > Dynamic retention seems to work only once the system has been in static
> > retention once.
> >
> > Static off mode seems to work, but resume from off kills the UART. The
> > system seems to run though, at least LED0 flickers as usual when the
> > system runs. Sometimes it hangs and I have seen one reboot.
> 
> I have noticed this as well.
> 
> I haven't looked at all at the T2 scripts being used on Beagle.  Do
> you think some of these issues may be related to those scripts?
> 

It might be. They are very basic compared to some others I have seen. I
will have a look at those tonight.

Cheers,

Peter.

-- 
goa is a state of mind
