From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Thu, 14 Jun 2012 12:04:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60726 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab2FNSEH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 14:04:07 -0400
In-Reply-To: <4FDA15AA.6090704@ti.com>
Content-ID: <alpine.DEB.2.00.1206141154461.30212@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi

On Thu, 14 Jun 2012, Cousson, Benoit wrote:

> On 6/11/2012 2:45 AM, Paul Walmsley wrote:
> > Kuvin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
> 
> I guess you meant Kevin?

...

> > The IP block itself pbobably does not have any native idle
> 
> typo

Thanks for noticing these, but they are not in what was sent out by the 
list server:

http://www.spinics.net/lists/linux-omap/msg71503.html

Some software/hardware issue on your end, maybe?

> > handling at all, due to its simplicity.
> 
> I don't think this description is really accurate, due to the usual confusing
> definition of IDLE for the PRCM standpoint :-)
> The counter_32k will follow PRCM requirement toward SIdleReq/SIdleAck.
> It has to be "idle" for PRCM standpoint to allow the transition of the L4_WKUP
> to inactive (SIdleAck=IDLE). And it will be functional as soon as the L4_WKUP
> domain is active.
> 
> The fact that the smartidle mode is missing does not change anything in the
> way the PRCM handle the protocol. It is just an issue at IP level.
> 
> In that case force-idle = smart-idle, just because this module does not have
> anything to do to delay the SIdleAck upon SIdleReq request. The IP is probably
> connecting the SIdleAck to the SIdleReq signal.
> Please note that there are a bunch of IPs that are doing that even if they do
> support the smartidle mode.

Right, that's exactly my point -- perhaps made in an unclear way.

My point was that the 32k counter IP block doesn't do anything with the 
incoming IdleReq signal to determine whether or not to assert IdleAck back 
to the PRCM.  But rather than implementing smart-idle mode to handle this, 
like the other IP blocks do, the only two modes implemented were the 
debugging modes, force-idle and no-idle.

So depending on one's point of view, this patch is either:

1. a hardware bug workaround, because the hardware should have a 
smart-idle mode that acts the same way as the force-idle mode, just like 
the other IP blocks do; or

2. a software workaround, because we don't have a 32k counter device 
driver that implements runtime PM around counter reads.

Of course #2 would be rather pointless and the patch description tries to 
convey this too.

> > Furthermore, the PRCM will never request target idle for this IP block 
> > while the kernel is running, due to the sleep dependency that prevents 
> > the WKUP clockdomain from idling while the CORE_L3 clockdomain is 
> > active.  So we can safely leave the 32k sync timer in target-no-idle 
> > mode, even while we continue to access it.
> 
> Do you mean force-idle? Because accessing a module in no-idle is always 
> possible.

Thanks, that's indeed a description bug.

> > This workaround is implemented by defining a new hwmod flag,
> > HWMOD_ALWAYS_FORCE_SIDLE, that places the IP block into target
> > force-idle mode even when enabled.  The 32k sync timer hwmods are
> > marked with this flag for OMAP3 and OMAP4 SoCs.  (On OMAP2xxx, no OCP
> > header existed on the 32k sync timer.)
> 
> I still don't see the need for this flag. It looks to me that we are adding a
> redundant information and thus make things more complex than it should.
> 
> 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
> 
> It the real root cause of the problem. There is no need to re-encode that
> using an extra flag. Especially at hwmod level where the issue is at sysconfig
> level.
> 
> I did not really get the reason why you changed your mind on that point.
> 
> As soon as there is no SIDLE_SMART mode, what choice do we have but using the
> SIDLE_FORCE?

SIDLE_NO is the option that makes more sense to me.

Consider an IP block with SIDLE_NO and SIDLE_FORCE but without 
SIDLE_SMART.  When an initiator will access it, the default setting should 
be SIDLE_NO, for the reason that you identified above: "because accessing 
a module in no-idle is always possible."  On the other hand, we don't know 
when it's safe to access a module in SIDLE_FORCE unless we have additional 
information as to how the IP block handles the SIdleReq signal internally, 
and the characteristics of the clock domain in which it's integrated. For 
example, as mentioned earlier in the discussion on this patch, the AM335x 
documentation states "By definition, initiator may generate read/write 
transaction as long as it is out of IDLE state."

> BTW, I even think the HWMOD_SWSUP_SIDLE hwmod flag is useless now. It 
> was needed before probably because the idlemodes were wrongly populated.
> 
> In fact the hwmod flags is really there to *flag* some real HW bug we cannot
> figure out otherwise, but in that case, the sysc.idlemodes already contains
> all the information we need to set the proper mode during enable/disable.
> 
> Duplicating the information is always a source of confusion and might lead to
> nasty bugs due to the increase of complexity.

You may be misunderstanding the meaning of the HWMOD_SWSUP_SIDLE flag.  It 
was added to work around IP blocks that had broken smart-idle.  These 
modules definitely do exist; see for example the OMAP3 wdt2, usbhsotg, and 
usb_host_hs hwmods as some examples.

It might be reasonable to remove the HWMOD_SWSUP_SIDLE flag from the 32k 
counter and just test again for HWMOD_ALWAYS_FORCE_SIDLE in the module 
disable.  I'll take a look at this.

> > Another theoretically clean fix for this problem would be to implement
> > PM runtime-based control for 32k sync timer accesses.  These PM
> > runtime calls would need to located in a custom clocksource, since the
> > 32k sync timer is currently used as an MMIO clocksource.  But in
> > practice, there would be little benefit to doing so; and there would
> > be some cost, due to the addition of unnecessary lines of code and the
> > additional CPU overhead of the PM runtime and hwmod code - unnecessary
> > in this case.
> 
> I don't think that part is really relevant anymore.

Why?

> > Another possible fix would have been to modify the pm34xx.c code to
> > force the IP block idle before entering WFI.  But this would not have
> > been an acceptable approach: we are trying to remove this type of
> > centralized IP block idle control from the PM code.
> 
> Neither that one I guess. As soon as we consider force-idle to be equivalent
> to smart-idle, nothing more is needed.

But they are definitely not equivalent.


- Paul
