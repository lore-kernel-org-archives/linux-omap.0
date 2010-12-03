From: Paul Walmsley <paul@pwsan.com>
Subject: Re: UART RX wakeup from sleep not working
Date: Fri, 3 Dec 2010 16:48:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012031607380.17078@utopia.booyaka.com>
References: <E1PObOH-0005EB-5j@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49730 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab0LCXsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 18:48:53 -0500
In-Reply-To: <E1PObOH-0005EB-5j@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

Hi Rick

On Fri, 3 Dec 2010, Rick Bronson wrote:

> > This may be a stupid question, but are you using serial flow control?  If
> > not, enabling wakeup on the RTS line isn't going to help.
> 
>   Not a stupid question at all.  We are very pin constrained so we
> only have RX and TX, so no modem lines at all.  I was hoping to get
> the wakeup mechanism to be fired off of in incoming "polling"
> character on the RX line.  The first character gets lost but wakes us
> up, then we respond to the next polling character to let the other
> side know we're awake, then he sends the packet.

So then setting WAKEUPENABLE on the RTS line won't help, since you're not 
using that line as an input line.  (According to Figure 17-1 "UART Module" 
that's a transmit line anyway, so the appropriate flow control line would 
need to be CTS for incoming data, not RTS.  But you're not using flow 
control so that won't help either.)

You might want to try setting WAKEUPENABLE on the pad that is muxed to 
your RX line, which is where you're receiving bits.  Note that there are 
multiple mux pad targets for that signal, so you need to know which pad 
your board is actually using to figure out what register to write to.

(By the way, all the documentation references in this and the previous 
E-mails are to the 34xx public TRM rev ZJ, downloadable from the TI web 
site, should also apply to OMAP3730, maybe with some padconf differences)

> > Just out of curiosity, which kernel are you using?
> 
>   It's the Arago (we need the low power management stuff),

Am not familiar with the Arago kernel at all, but full chip retention-idle 
-- which appears to be what you're trying to use -- should work on 
mainline Linux 2.6.36.  I wouldn't try .37-rc yet, there seems to be 
something wrong with power management and the serial driver in those, at 
least on my BeagleBoard.

If you need to use the Arago kernel, you'll probably need to contact TI 
for support.  Might be worth suggesting to them that they patch the 
top-level Makefile to add an EXTRAVERSION of -arago1 or something like 
that, since this uname:

> Linux omap 2.6.32 #32 Fri Dec 3 10:49:55 PST 2010 armv7l GNU/Linux

... makes it look like it's just stock 2.6.32, when 'git diff 
v2.6.32..arago-omap3/master | diffstat' returns:

 7380 files changed, 762778 insertions(+), 406769 deletions(-)

>   I'm still not getting an interrupt but I decided to shift my focus
> and I found that this change
> 
> http://www.efn.org/~rick/pub/serial.patch
> 
>   seems to really improve the variablity in serial timeout when it's
> taken low.  

If SCR_REG.RX_CTS_WU_EN is not set, then that would indeed prevent the 
UART from waking up.  Hmm, wonder if we've got that same problem in 
mainline...

>   Thanks again for the help.

You're welcome.  Good luck,


- Paul
