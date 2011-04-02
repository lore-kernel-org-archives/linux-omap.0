From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/7] OMAP2+: powerdomain: add voltage domain lookup during
 register
Date: Fri, 1 Apr 2011 19:17:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104011842540.27897@utopia.booyaka.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-5-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1103221313460.11798@utopia.booyaka.com> <4D890D9E.804@ti.com> <alpine.DEB.2.00.1103221502180.11798@utopia.booyaka.com>
 <4D892B08.7000805@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45684 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab1DBBR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 21:17:59 -0400
In-Reply-To: <4D892B08.7000805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 23 Mar 2011, Cousson, Benoit wrote:

> On 3/22/2011 11:08 PM, Paul Walmsley wrote:
> > On Tue, 22 Mar 2011, Cousson, Benoit wrote:
> > 
> > > On the other hand not every clock belong to a clockdomain, that's why we
> > > have clock without clockdomain on OMAP. A clockdomain is a just group of
> > > IPs that share the same interface clock.
> > 
> > PRCM clockdomains also include functional clocks.  See for example the
> > OMAP4 Public TRM Rev. O Section 3.1.1.1.3 "Clock Domain" ('The clockdomain
> > of CM_B is composed of two clocks: a functional clock (FCLK2) and an
> > interface clock (ICLK1)', and also later, 'The PRCM module lets software
> > check the status of the clock domain functional clocks').
> 
> True, but that does not change the definition of the clock domain (same
> paragraph):
> "A clock domain is a group of modules fed by clock signals controlled by the
> same clock manager in the PRCM module (see Figure 3-2)."
> 
> My point was that a clock domain is related to modules that share some clocks.
> So yes, a clock domain will contains modules and their related iclk and fclk.
> But that does not means that every clocks will belong to a clockdomain.
> All the non leaf clocks will not have any clock domain since they will not be
> attached to any module directly.

In the OMAP Linux code, we use clockdomains for three purposes:

1. as a way to control the PRCM clockdomain hardware
2. as a way to associate clocks with powerdomains
3. as a way to group clocks that have similar idle behavior

So yes.  All non-leaf clocks should be associated with OMAP Linux 
clockdomains also, since those clocks will be associated with powerdomains 
and also will be grouped by idle behavior.

> > Both the TRM and the OMAP4 functional specification clearly link PRCM
> > clockdomain idle management to the state of the clockdomain's functional
> > clocks.  See for example OMAP4 Public TRM Rev. O Table 3-11 "Clock Domain
> > Clock States" ('INACTIVE: ... Every optional functional clock in the clock
> > domain is gated.')
> 
> That just means that each clock that supplies a module must be idled in order
> to allow the clock domain to transition.
> The clock domain FSM is using both iclk and fclk state to trigger the domain
> transition, but that same clock could be used in another clock domain too.

When the same clock is used in another clockdomain, another struct clk is 
created for that clock with a different clockdomain.  We already have this 
situation with OMAP3's 54MHz clock, for example.

> > Beyond the PRCM, the Linux-OMAP clockdomain code is not only concerned
> > with PRCM-controllable clockdomains.  It is intended to be a generically
> > useful way to connect clocks to the powerdomain and voltagedomain that the
> > clock exists in, even if there are no explicit PRCM registers associated
> > with the clockdomain.  These "powerdomains" and "voltagedomains" also may
> > not be directly PRCM controllable.
> 
> In that case, you cannot call that clockdomain anymore since this is not the
> proper definition used by the PRCM. If you do not have a module, you cannot
> have a clockdomain.

That may be the way that TI considers it in the AutoPRCM data or the 
system PRCM, but the OMAP Linux clockdomain code uses a superset 
definition and has done so for a few years now.

> OMAP4 partitioning is following this hierarchy: module < clockdomain < 
> powerdomain < voltagedomain < device. The clocks are not part of the 
> hierarchy and for a good reason, the can be shared across the whole 
> device.

As mentioned before, each instance of a clock in a different clockdomain 
should have a different struct clk associated with it.

> > Every clock that is in the Linux-OMAP clock tree should have a clockdomain
> > associated with it.
> 
> Mmm... What domain will you use for sys_clk

sys_clk and related clocks should go into a sys_clkdm or hf_sys_clkdm

> or 32k_clk?

The external 32KiHZ oscillator should be associated with wkup_clkdm.

> or for any DPLL or HS divider?

Those go into separate DPLL clockdomains.  This is already there in OMAP3.

> And what for?

2. as a way to associate clocks with powerdomains
3. as a way to group clocks that have similar idle behavior

Also, the original idea was to put autoidle control for the DPLLs and the 
external HF clock LDO into the clockdomain layer, since it already had a 
convenient concept for hardware automatic idle, vs. software controlled 
idle.  That part may not be needed any longer, now that we've added 
autoidle support back into the clock code.

> I know that the clockdomain name is confusing, but why do you want to change
> its definition?


- Paul
