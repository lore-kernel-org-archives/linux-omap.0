From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 08 Mar 2012 21:05:47 +0200
Message-ID: <1331233547.18015.74.camel@cumari>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
	  <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
	  <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
	  <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
	 <87sjhjaqyi.fsf@ti.com> <1331232433.18015.69.camel@cumari>
	 <alpine.DEB.2.00.1203081153540.9551@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42858 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238Ab2CHTFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 14:05:53 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so801290lag.3
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 11:05:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1203081153540.9551@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Thu, 2012-03-08 at 11:55 -0700, Paul Walmsley wrote: 
> On Thu, 8 Mar 2012, Luciano Coelho wrote:
> 
> > On Thu, 2012-03-08 at 10:27 -0800, Kevin Hilman wrote: 
> > 
> > > Are you enabling UART wakeups?
> > > 
> > > They are disabled by default, so you need to:
> > > 
> > > echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup
> > 
> > No, I was actually not enabling the UART wakeups.  But I tried it now
> > but it still doesn't work. :(
> 
> You definitely need that.
> 
> > I have no_console_suspend in bootargs.  Without it, it didn't work with
> > 3.2 either.
> 
> If you want to use no_console_suspend -- which is not recommended -- then 
> you'll need 
> 
> http://www.spinics.net/lists/linux-omap/msg65786.html
> 
> but best simply not to use no_console_suspend.

Thanks, Paul! I was just chatting with Kevin about this on IRC.  With
your patch and no_console_suspend, it works. :)

I needed no_console_suspend because it wouldn't work otherwise on
<3.3-rc1.

Now I tried a vanilla 3.3-rc5 without no_console_suspend and enabling
the UART wakeup and it works fine!

Thanks for your help, guys!

-- 
Cheers,
Luca.

