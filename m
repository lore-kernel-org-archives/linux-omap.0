From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Wed, 1 Feb 2012 11:41:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202011138400.10541@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com> <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
 <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com> <alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com> <CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com> <CANOLnOMzkNSr5hFbASCWaT6PkBSYQhqMxXmjBfU0tm0GTv=yYA@mail.gmail.com>
 <alpine.DEB.2.00.1201312254150.10061@utopia.booyaka.com> <alpine.DEB.2.00.1201312305190.10061@utopia.booyaka.com> <CANOLnOMmcztNH+fUzrQxjK5nVVEaAtLi=7ww+dPm0AXEv09qUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab2BASlc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 13:41:32 -0500
In-Reply-To: <CANOLnOMmcztNH+fUzrQxjK5nVVEaAtLi=7ww+dPm0AXEv09qUA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Wed, 1 Feb 2012, Grazvydas Ignotas wrote:

> On Wed, Feb 1, 2012 at 8:06 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 31 Jan 2012, Paul Walmsley wrote:
> >
> >> Well, whether it's in or out of idle, I'll bet the DEBOUNCENABLE
> >> bits are still set to 1 while the debounce clock is off :-(
> >
> > Along these lines, you might try patching omap2_gpio_prepare_for_idle() to
> > turn off the DEBOUNCENABLE bits?
> 
> Yes that helps. I guess I'll carry this in pandora tree, at least
> we'll have debounce while more demanding programs/games are running.

Yep definitely.  When only I/O wakeups can occur on those GPIO lines (when 
CORE/PER is in a low-power state), they are intrinsically debounced :-)  
So it should be fine.  You are re-enabling the DEBOUNCENABLE bits in 
omap2_gpio_resume_after_idle() I assume?  If so, that should be a good 
workaround for mainline too.


- Paul
