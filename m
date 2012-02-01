From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 22:47:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201312237410.10061@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com> <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
 <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com> <alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com> <CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58724 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab2BAFrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 00:47:33 -0500
In-Reply-To: <CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, 31 Jan 2012, Grazvydas Ignotas wrote:

> On Tue, Jan 31, 2012 at 3:48 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > If the DEBOUNCENABLE bit is set and the debounce clock is off and the GPIO
> > IP block is idle, then yeah, I'd assume that GPIO wakeups would not
> > work.
> >
> > But it sounds like they are working for you when DEBOUNCENABLE is set and
> > the debounce clock is on and the GPIO IP block is idle and CORE & PER are
> > ON?
> 
> I think so. It works with DEBOUNCENABLE set when cpuidle is disabled
> or CPU is spinning. CORE & PER are ON according to pm_debug/count, I
> think debounce clock is enabled too but I don't know if GPIO is idle
> then (how do I check?).

Maybe try reading the appropriate CM_IDLEST bit?  I can't remember at the 
moment if this represents the PRCM's SIdleReq signal or the module's 
SIdleAck, but it's worth a quick look.

> > And when DEBOUNCENABLE is clear and the debounce clock is off and the GPIO
> > IP block is idle and CORE & PER are still ON, then they work?
> 
> Yes.
> 
> > If the answer to those two latter questions are true, then it sounds like
> > the hardware is working more or less as expected...
> 
> So when does all wakeup stuff come into effect, when CORE+PER go to
> low power state?

>From the perspective of the GPIO IP block, it comes into effect when the 
GPIO module has IdleAcked ("is idle").  At that point the module needs to 
assert its SWAKEUP signal when it wants to have its clocks re-enabled, 
wake up other parts of the system, etc.  Maybe try searching the 34xx TRM 
for SWAKEUP; there are a few bits and pieces scattered around that might 
help build a larger mosaic :-)  As far as CORE & PER powerstates go, the 
CORE & PER still might be ON while the module is idle; that's a separate 
thing.

Let me also answer the question from the MPU's perspective.  Suppose the 
MPU powerdomain has entered a low power state.  That means that the MPU 
INTC -- part of the MPU powerdomain -- is also in a low power state.  So 
neither the MPU nor the MPU INTC are working: clocks are disabled, the 
voltage may be scaled down, etc.  So even if an IP block elsewhere on the 
chip asserts an MPU interrupt, the MPU INTC won't notice it; it's 
non-functional at this point.  So for the MPU to notice the interrupt, it 
has to first come out of its low-power state.  That happens when some IP 
block asserts that SWAKEUP signal to the PRCM, which, if it's programmed 
correctly, will then bring the MPU powerdomain out of its low-power state, 
re-enable clocks, etc.  At that point, the MPU INTC should notice the 
interrupt, and the kernel should take it from there.


- Paul
