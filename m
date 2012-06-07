From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/11] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
Date: Thu, 7 Jun 2012 04:08:44 -0700
Message-ID: <20120607110843.GD12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061306.25532.59488.stgit@dusk>
 <20120607071900.GW12766@atomide.com>
 <alpine.DEB.2.00.1206070121150.6684@utopia.booyaka.com>
 <20120607074831.GY12766@atomide.com>
 <alpine.DEB.2.00.1206070225430.6684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48455 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab2FGLIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 07:08:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206070225430.6684@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

* Paul Walmsley <paul@pwsan.com> [120607 03:49]:
> On Thu, 7 Jun 2012, Tony Lindgren wrote:
> 
> > OK so that's not too bad then. But there's also the 
> > omap2_wd_timer_disable pre_shutdown too. And there's also the sysconfig 
> > autoidle bit for each driver that we're tweaking in the bus level code?
> 
> I think I lost your point here.  The ioremap() issue is separate from the 
> reset functions, etc., in my view.  Moving the reset functions out to 
> drivers/ seems potentially more reasonable than dropping the ioremap().
> 
> > If we can remove the ioremapping and accessing driver registers in the 
> > bus level code things get much simpler for the bus level code.
> 
> That's like saying if PCI Configuration Header handling were to be moved 
> into the driver code, then the PCI bus-level code would be much simpler 
> :-)
> 
> The hwmod code ioremaps the device registers to handle the 
> integration-level registers at the beginning of the device's address 
> space.  These registers can be thought of as part of the PRCM, not part of 
> the IP block.  It would have been better if TI had put these integration 
> registers in a separate address space like PCI does.  But we are stuck 
> with the existing hardware design.  The integration registers also differ 
> from chip to chip even with the same underlying IP block, see for example 
> the 32k sync timer.

Yes having these registers in the device address space sucks.
 
> The main reasons why these integration registers are handled now in common 
> code are:
> 
> 1. to avoid duplicating integration code between lots of different drivers 
>    that is unrelated to the driver itself, such as bus-level reset
> 
> 2. to ensure consistency of the OCP registers with the rest of the PM
>    state
> 
> 3. to avoid callbacks into drivers that might otherwise be needed for 
>    bitfields like CLOCKACTIVITY 
> 
> 4. to make it easier to debug integration problems with drivers

Sure that all makes sense.
 
> If we don't handle those registers in common code, the number of SoC 
> integration workarounds that need to be placed into the drivers will 
> increase.  For example, when OMAP4 added the smart-idle-with-wakeup and 
> smart-standby-with-wakeup OCP idle modes, only a couple of files needed to 
> be changed.  If those integration-level details were still in the drivers, 
> a large number of files would need to be changed.  And $DEITY help us if 
> the code sequence for dealing with those bits were to ever change in the 
> future - we'd need to change a bunch of drivers, rather than just one or 
> two files.  Also some people are going to need to audit the driver code 
> from an integration level pretty carefully for PM to work consistently.
> 
> I suppose one option, if we were to have a real omap_device, would be to 
> define callbacks for each driver to implement that would read and write 
> the OCP header registers.  Then the omap_bus code could call those 
> callbacks to handle the OCP register accesses, when called from the 
> driver's PM runtime calls.  Adds another layer of indirection, but would 
> localize IP block register accesses to the IP block's driver.

Yes there may be some way to deal with this cleanly while keeping the
driver registers in the drivers. Maybe inline functions in the driver
headers that hwmod code could include would be enough here.
 
> ...
> 
> As far as the reset and preconfiguration aspects of the hwmod code go, 
> they just happen to be possible since we're doing the ioremap anyway.  It 
> can be ensured that no matter what drivers are present, or what the 
> bootloader or previous OS did or didn't do, a minimal kernel should behave 
> predictably.
> 
> It seems like it might be reasonable to move these to some built-in driver 
> shim layer as you suggest in your other E-mail.  But that is assuming that 
> it can be made to work without needless layers of indirection.  I don't 
> know of any driver that does this now.  Maybe you know of one?

Yes good point, see the suggestion on the driver header inline functions
in the other email I just sent.

Regards,

Tony
