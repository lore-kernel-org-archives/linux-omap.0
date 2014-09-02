From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Tue, 2 Sep 2014 13:15:37 -0700
Message-ID: <20140902201536.GC11766@atomide.com>
References: <53FE3779.5090908@linutronix.de>
 <20140827202313.GF16006@atomide.com>
 <20140828082348.GA5413@linutronix.de>
 <20140828164645.GG16006@atomide.com>
 <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de>
 <54060EDA.6060204@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61128 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751302AbaIBUPp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 16:15:45 -0400
Content-Disposition: inline
In-Reply-To: <54060EDA.6060204@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140902 11:40]:
> On 09/01/2014 07:47 PM, Sebastian Andrzej Siewior wrote:
> > Comparing it with serial-omap I see the same thing: I takes approx the
> > same amount of data until the first one is displayed. After a lot of
> > "long" writes which wake the chip up from idle I manage to freeze both,
> > the serial-omap driver and mine driver.
> 
> So after some testing:
> - it happens with omap-serial as well. Especially after disabling the
>   LED trigger for both LEDs.
> 
> - it seemed that disabling the MDR1 check whether or not we lost
>   context made the problem appear less often but it was a trick. Even
>   with restoring the context each time I see the same problem.
> 
> - it seems to be easier to trigger with the LED trigger switched off.
>   However sometimes it works for 10 minutes, sometimes it triggers
>   after one.
> 
> - I see to face two kind of "deaths":
>   - the LED still goes on and off and the uart just does not respond
>     even if I tell the button print something on the screen (the button
>     also changes the frequency of the LED so I know that the button is
>     doing something).
>     Also from dumping the content of /proc/interrupts it seems that a
>     wake up is made, the uart should have restored the registers.

OK yeah this is the case I was seeing too. So do you just set the
LED triggers to none in sysfs to make it easier to reproduce?

>   - one where the system is dead and the LED does not blink anymore.
>     Also my button is dead.

This I don't think I've seen. This could also be the errata issue on
your earlier rev beagleboard-xm with off-idle.
 
> - disabling DMA makes the problem not go away.

OK
 
> - mdelay(25) in omap8250_lost_context() is long enough to drop the 403
>   bytes I send in my testcase. That means I see only "good" characters.
>   With this the box remained alive for 2h. However the uart died anyway.

I wonder if doing some TX on the uart restores it? So maybe try

$ while [ 1 ]; do date; sleep 10 done &

To have it occasionally print something in the background.

Regards,

Tony

