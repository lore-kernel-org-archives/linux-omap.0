From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 8 Mar 2012 11:55:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203081153540.9551@utopia.booyaka.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>  <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>  <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>  <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
  <87sjhjaqyi.fsf@ti.com> <1331232433.18015.69.camel@cumari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47153 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401Ab2CHSz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 13:55:27 -0500
In-Reply-To: <1331232433.18015.69.camel@cumari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Thu, 8 Mar 2012, Luciano Coelho wrote:

> On Thu, 2012-03-08 at 10:27 -0800, Kevin Hilman wrote: 
> 
> > Are you enabling UART wakeups?
> > 
> > They are disabled by default, so you need to:
> > 
> > echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup
> 
> No, I was actually not enabling the UART wakeups.  But I tried it now
> but it still doesn't work. :(

You definitely need that.

> I have no_console_suspend in bootargs.  Without it, it didn't work with
> 3.2 either.

If you want to use no_console_suspend -- which is not recommended -- then 
you'll need 

http://www.spinics.net/lists/linux-omap/msg65786.html

but best simply not to use no_console_suspend.


- Paul
