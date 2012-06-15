From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Thu, 14 Jun 2012 18:18:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54616 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2FOASi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 20:18:38 -0400
In-Reply-To: <4FDA45F5.9090300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Thu, 14 Jun 2012, Cousson, Benoit wrote:

> On 6/14/2012 8:04 PM, Paul Walmsley wrote:
> > On Thu, 14 Jun 2012, Cousson, Benoit wrote:

(attribution lost)

> > > > Furthermore, the PRCM will never request target idle for this IP block
> > > > while the kernel is running, due to the sleep dependency that prevents
> > > > the WKUP clockdomain from idling while the CORE_L3 clockdomain is
> > > > active.  So we can safely leave the 32k sync timer in target-no-idle
> > > > mode, even while we continue to access it.
> > > 
> > > Do you mean force-idle? Because accessing a module in no-idle is always
> > > possible.
> > 
> > Thanks, that's indeed a description bug.
> 
> I'm not sure to follow you? My point was it should be: "So we can safely leave
> the 32k sync timer in force-idle mode, even while we continue to access it."
> This is what the WA is doing.

I am expressing appreciation to you for pointing out something incorrect 
in the patch description, which has been fixed in the current version of 
the patch.

> > SIDLE_NO is the option that makes more sense to me.
> > 
> > Consider an IP block with SIDLE_NO and SIDLE_FORCE but without
> > SIDLE_SMART.  When an initiator will access it, the default setting should
> > be SIDLE_NO, for the reason that you identified above: "because accessing
> > a module in no-idle is always possible."  On the other hand, we don't know
> > when it's safe to access a module in SIDLE_FORCE unless we have additional
> > information as to how the IP block handles the SIdleReq signal internally,
> > and the characteristics of the clock domain in which it's integrated.
> 

...

> This is the modulemode and clkdm static dependency / dynamic on OMAP3/4 that
> will guaranty that the OCP clock will be enabled upon any access to this
> L4_WKUP clock domain IPs. This has nothing to do with the SIDLE mode.

I want to implement a behavior that does not implicitly assume that an IP 
block without smart-idle will only exist inside clockdomains which are 
guaranteed to be active when the kernel is running.  That might be true 
for current WBU chips, but it seems unwise to make that assumption in 
general.

> > It might be reasonable to remove the HWMOD_SWSUP_SIDLE flag from the 32k
> > counter and just test again for HWMOD_ALWAYS_FORCE_SIDLE in the module
> > disable.  I'll take a look at this.
> 
> Both should be removed as explained before. There is clearly no need for
> HWMOD_ALWAYS_FORCE_SIDLE.
> 
> We are already explicitly listing the limitation through the idlemodes 
> attribute. Only SIDLE_FORCE and SIDLE_NO are supported, so we already 
> know that SIDLE_FORCE is the proper way to fix that limitation for the 
> current OMAPs. Since there is no other IP with such limitation, we know 
> as well that there will be no side effect. If, in the future, some more 
> IPs will have that limitation and will not work as expected, it will 
> mean that some other HW bugs will be there, and only these ones will 
> have to be flagged.
> 
> But my point is let's keep it simple and not try to anticipate future 
> bugs. This flag is not require today, let's not add it.

Which of these two behaviors do you feel is more "future-proof," in 
general:

1. Implementing a target idle policy that could break if a hardware 
   designer were to skip adding a target smart-idle mode to a module in 
   a clockdomain that might go idle while the kernel was active?

2. Implementing a target idle policy that is guaranteed to allow
   initiator accesses to succeed by definition?

considering that the implementation cost of either approach is identical?


- Paul
