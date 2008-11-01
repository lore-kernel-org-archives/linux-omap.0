From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/4] 34xx spurious interrupts unravelling
Date: Fri, 31 Oct 2008 23:08:36 -0700
Message-ID: <200810312308.36522.david-b@pacbell.net>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <200810311459.04687.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE89671620369885CC0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:36268 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750802AbYKAGIj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 02:08:39 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620369885CC0@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 31 October 2008, Woodruff, Richard wrote:
> 
> > owner@vger.kernel.org] On Behalf Of David Brownell
> > Sent: Friday, October 31, 2008 4:59 PM
> 
> > As in, issue those dma cache updates, then write to the
> > DMA or peripheral controller registers ... and the key data
> > was still in the write buffers when those writes completed!
> > That's quite unusual; possibly related to memory controller
> > bugs in that silicon revision.
> 
> For the next series of ARMv7 Cortex's this is all being projected
> to require much more strictness in access ordering and use of barriers.

Any particular kind of barriers?  barrier() is compiler advice,
and gets the most use in Linux ... but <asm/system.h> reminds
me that V7 has isb/dsb/dmb instructions, and V6 can do them too.
(Now I'll have to go look at what they do again...)

That case needed a dsb analogue (on armv5, flush write buffer).


> There have been some cautions about newer write buffer policies
> which try and keep data instead of flushing it. Today even if
> you miss some drain in a small amount of time it will happen.
> That may not be the case always.   

Yeah, I remember back when I had to work with SPARC the issue
of memory ordering models was problematic.  There's a tradeoff:
the more ordering guarantees the easier it is for software, at
cost of slowing down data transfers by excess serialization.

And at the other extreme, if you configured things for highly
unordered access, the hardware wouldn't have many roadblocks
but the software could get confused rather easily.


What this means for software developers -- especially folk
writing drivers and tweaking address spaces -- is needing to
pay a bunch more attention to some confusing issues that most
ARM folk have managed to avoid over the past many years.

- Dave


> 
> Regards,
> Richard W.
> 
> 


