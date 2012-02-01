From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Wed, 1 Feb 2012 11:36:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202011013240.8579@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <20120113222045.37f9b4ec@notabene.brown> <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com> <20120114100915.01c96727@notabene.brown> <20120118082410.48262777@notabene.brown> <alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
 <20120124213705.49f042bf@notabene.brown> <alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com> <20120128093530.0a0a370a@notabene.brown> <alpine.DEB.2.00.1201271541110.13783@utopia.booyaka.com> <20120128114012.1bd76ca5@notabene.brown>
 <alpine.DEB.2.00.1201271813260.13783@utopia.booyaka.com> <20120201185152.08336b18@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36920 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2BASg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 13:36:27 -0500
In-Reply-To: <20120201185152.08336b18@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Wed, 1 Feb 2012, NeilBrown wrote:

> On Fri, 27 Jan 2012 23:02:51 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> > Since the HDQ module doesn't support the idle protocol, the target clock 
> > FSM in the CM is what should determine whether the module is considered 
> > idle or not.  And as long as the bit in the CM_FCLKEN register 
> > corresponding to HDQ_FCLK is set, the FSM should consider the module as 
> > active, and the clockdomain should not be allowed to go inactive.
> > 
> > I write "should."  Given that big caution at the bottom of section 20.4.5 
> > "System Power Management and Wakeup", this appears to have not been 
> > correctly implemented.
> 
> Can you help me understand why you say "should" there.
> You seem to be implying that a down-stream clock gate should cause an
> upstream clock to stay active, but that doesn't make sense to me given the
> presence of the much richer SIDLE framework.  Also I cannot find it in the
> TRM (though there a lots of words in there and I might have missed some).

Functional clocks are almost never auto-idled by the hardware[*].  So 
when the kernel sets a CM_FCLKEN* bit in a register for a clockdomain, 
that clockdomain should never go inactive.

As I understand it, main functional clocks on I/O IP blocks aren't 
automatically idled for a few basic reasons.  One is that the main 
functional clock has to be running in order for register accesses to 
succeed, so initiators have to have some way of preventing it from going 
off while they are interacting with it.  The PRCM doesn't snoop the 
interconnect :-)  Another is that some of the I/O IP blocks can continue 
to operate after they've idle-acked.  They idle-ack, which could allow 
clocks to be gated to interconnects, but the module can still continue to 
fill or drain FIFOs, which obviously requires a clock.  This was what is 
not working correctly with the UARTs... some events that generate 
interrupts can't generate SWAKEUPs :-(  And there are a few other lesser 
reasons that I am aware of that are not worth going into at this point.

Even interface clock auto-idle works in a different way than what one 
might expect.  Even if a module idle-acks, the interface clock will stay 
on until the interface clockdomain can go idle.  So suppose that you have 
an interface clockdomain with 20 modules and 19 of them idle-ack.  The 
interface clock stays supplied to those 19 modules until the 20th 
idle-acks.  This ensures that an initiator access to a target module will 
succeed.  (This is true for OMAP2/3; OMAP4 does something more clever.) In 
general, setting ICLKEN/FCLKEN bits to zero doesn't shut down clocks 
directly; it simply indicates that the clocks may be shut down once other 
users of that clock also indicate that they don't need the clocks.

> Most modules use SIDLE to keep the upstream clock active.

It's the other way around.  The device driver uses the FCLKEN bits to keep 
the upstream clock active :-)

> > Disabling AUTO_HDQ is probably a reasonable workaround.  It would prevent 
> > the CORE_L4 clockdomain from going inactive, and that happens to be where 
> > the functional clock originates from, also.
> > 
> > We have a partial facility to handle this type of bug in the existing 
> > code.  Could you please try the patch enclosed at the bottom of this 
> > E-mail and see if it helps?
> 
> Yes, that patch fixes my problem too - the HDQ keeps working.

Great; thanks for the test.  We'll implement a variant of that for 
mainline.

Please also let me know if you wind up having wakeup problems with HDQ, 
especially with MPU off-mode.  If you don't, obviously that's good; but I 
suspect you might want it at some point.

> (it's a bit smoke-and-mirrors though .. I want fclk to stay on, so let's make
> sure iclk doesn't autoidle, because we *know* they have the same source :-)

A theoretically clearer workaround would be to place the main functional 
clock's clockdomain into software-supervised wakeup as long as the hwmod 
code thinks that the HDQ IP block is active.  But that is not so easy to 
implement with our current codebase.  We'd need to implement usecounting 
for our clockdomain control operations, and the other PM code assumes that 
it can force clockdomain states directly.  So I'm not too eager to do that 
rewrite at the moment given all the other stuff that's going on...  
Meanwhile, this fix targets the target clock FSM, and that's where the bug 
is, albeit on a slightly different path.  It's also functionally 
equivalent, given that the HDQ apparently can't send wakeups.


- Paul


*. Main functional clocks can be autoidled if they are 
interface+functional clocks.  This is the case for some purely 
computational, non-I/O IP blocks such as MAILBOXES.  Those combined 
interface+functional clocks are controlled via ICLKEN registers, not 
FCLKEN registers.


