From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 23:02:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201312254150.10061@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com> <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
 <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com> <alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com> <CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
 <CANOLnOMzkNSr5hFbASCWaT6PkBSYQhqMxXmjBfU0tm0GTv=yYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57894 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab2BAGCG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 01:02:06 -0500
In-Reply-To: <CANOLnOMzkNSr5hFbASCWaT6PkBSYQhqMxXmjBfU0tm0GTv=yYA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, 31 Jan 2012, Grazvydas Ignotas wrote:

> On Tue, Jan 31, 2012 at 1:39 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> > So when does all wakeup stuff come into effect, when CORE+PER go to
> > low power state? I'm using 3.2 and CORE seems to always be ON
> > (regardless of cpuidle option) except when I suspend I guess. I can
> > get PER state to change if I set serial timeouts, but that doesn't
> > help the GPIO problem.
> 
> There is a strange thing in pm34xx.c, omap_sram_idle() function:
> I've added logging of per_next_state, and it's always 1
> (PWRDM_POWER_RET) for me, however if I check /debug/pm_debug/count ,
> core_pwrdm and per_pwrdm only has 1 for ON and zeros for all other
> states. That function calls gpio debounce clock disable if
> per_next_state < PWRDM_POWER_ON.
> 
> Does that mean this code is preparing for RET but never enters it? 

Probably.  I think what's going on here is that you're hitting the 
hardwired sleep dependency between PER and CORE_L3.   This is documented 
briefly in the 34xx TRM Rev. ZT in Section 4.8.5.1 "Sleep Dependencies".
The PER clockdomain isn't allowed to go to sleep until the CORE_L3 
clockdomain goes to sleep.

Sounds like we may not be handling this correctly in the pm34xx.c code.  
As an aside, I've often thought that we should program the hardcoded sleep 
dependencies into the clockdomain data...

> Maybe GPIO module ends up active but with debounce clock disabled?

Well, whether it's in or out of idle, I'll bet the DEBOUNCENABLE 
bits are still set to 1 while the debounce clock is off :-(  


- Paul
