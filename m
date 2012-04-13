From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 11/12] arm: omap3: am35x: Add do_wfi routine for EMIF4
 submodules
Date: Thu, 12 Apr 2012 17:12:27 -0700
Message-ID: <20120413001227.GP31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-12-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111623110.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:56458 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2DMAM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 20:12:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111623110.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ranjith Lohithakshan <ranjithl@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 04:36:25PM -0600, Paul Walmsley wrote:
> Hi
> 
> just a few comments based on a quick look
> 
> On Wed, 11 Apr 2012, Mark A. Greer wrote:

> > diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> > index 1f62f23..22aac4c 100644
> > --- a/arch/arm/mach-omap2/sleep34xx.S
> > +++ b/arch/arm/mach-omap2/sleep34xx.S

> > @@ -391,6 +401,52 @@ wait_dll_lock_counter:
> >  ENTRY(omap3_do_wfi_sz)
> >  	.word	. - omap3_do_wfi
> >  
> > +/*
> > + * Do WFI instruction (SDRC module has EMIF4 submodule)
> > + *
> > + * This code gets copied to internal SRAM and is accessible
> > + * from both SDRAM and SRAM:
> > + * - executed from SRAM for non-off modes (omap3_emif4_do_wfi_sram),
> > + * - executed from SDRAM for OFF mode (omap3_emif4_do_wfi).
> > + */
> > +	.align	3
> > +ENTRY(omap3_emif4_do_wfi)
> > +	/* Put EMIF in self-refresh */
> 
> Hmm, I guess this comment isn't quite right; it just tells it to go to 
> self-refresh when it's "idle" ? (see below)
> 
> > +	ldr     r4, pwr_mgmt_ctrl
> > +	ldr     r5, [r4]
> > +	orr     r5, r5, #0x200
> 
> Maybe use a macro here in place of the #0x200 to indicate what it's trying 
> to set...
> 
> Do you happen to know what "idle" means in the context of SPRUGR0B Section 
> 9.2.3.4.5.1 "SDRAM Self-Refresh Mode" ?  Is it referring to 
> target module-level idle, e.g. SIdleReq; or is it referring to 
> an internal definition of idle, e.g., something like "no reads or writes 
> from/to the SDRAM" ?  Am wondering if this should just be set once during 
> EMIF initialization.

I can't tell from tne manual.  I assumed it meant the latter of the choices
you listed.  I just tested a kernel with it set up during EMIF init (value
of 0x80000200) and removed the related bits from omap3_emif4_do_wfi() and
it booted and returned from suspend-to-RAM just fine.  So, it seems that
it can be moved to EMIF init.

[I swear I tested this some time ago and discovered that it was needed
in omap3_emif4_do_wfi().  Oh well...]

> 
> > +	str     r5, [r4]
> 
> Might be good to do a readback after this to ensure that the store has 
> made it to the EMIF.
> 
> Also, scanning SPRUGR0B, it looks like this setting is dependent partially 
> on the REG_PM_TIM field in the same register.  Might be good to set 
> REG_PM_TIM during EMIF init to avoid any bootloader dependency.

True but moot now since I'll move the code to EMIF init.

> > +
> > +	dsb
> > +	dmb
> > +
> > +	wfi
> > +
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> 
> Are these NOPs necessary?  Is the number of NOPs dependent on CPU or bus 
> speed or some ARM parameter?

After looking through the am35x errata, I don't think so.  AFAICT,
they are there to work around--from omap3535 errata (sprz278f.pdf)--
Advisory 3.1.1.75, "IVA2: CAM/SGX Dependencies (OMAP3530/25 only)".
I don't see that or any other errata that requires a nop in the
am35x errata so I'll get rid of them.

[As I went through the errata again, I noticed talk about the device
going into RET state.  Sigh...]

Mark
--
