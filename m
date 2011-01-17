From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
 boot failure)
Date: Mon, 17 Jan 2011 09:35:26 +0100
Message-ID: <20110117083526.GA9598@pengutronix.de>
References: <20110113155152.GG4957@atomide.com>
 <20110113164957.GA28040@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com>
 <20110114212027.GD22505@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101141551140.28621@utopia.booyaka.com>
 <20110114235840.GE22505@n2100.arm.linux.org.uk>
 <20110115001254.GU4957@atomide.com>
 <20110115002531.GF22505@n2100.arm.linux.org.uk>
 <20110115003734.GV4957@atomide.com>
 <20110115170455.GG22505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45598 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab1AQIfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 03:35:31 -0500
Content-Disposition: inline
In-Reply-To: <20110115170455.GG22505@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>

On Sat, Jan 15, 2011 at 05:04:55PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 14, 2011 at 04:37:34PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110114 16:24]:
> > > On Fri, Jan 14, 2011 at 04:12:55PM -0800, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110114 15:58]:
> > > > > 
> > > > > # ARMv6k
> > > > > config CPU_32v6K
> > > > >         bool "Support ARM V6K processor extensions" if !SMP
> > > > >         depends on CPU_V6 || CPU_V7
> > > > >         default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> > > > > 
> > > > > OMAP2 prevents the selection of armv6k support.  This is probably a very
> > > > > bad idea if you want to run the resulting kernel on SMP hardware as it
> > > > > removes a barrier in the spinlock code and disables the SMP-safe bitops.
> > > > 
> > > > I have some ideas to fix this. Unfortunately it will be inefficient
> > > > as spinlock.h can be included from modules too :( I was thinking we can
> > > > implement dsb_sev in the proc-*.S functions for the unoptimized multi-arm
> > > > builds.
> > > 
> > > For spinlocks, the important thing is the barrier.  The wfe/sev are an
> > > optimization.  The barrier contained with the ifdef is a valid V6
> > > instruction.
> > 
> > OK, great it's just drain WB. Then we can do the ussual iffdeffery
> > on it for multi-arm builds as it does not depend on the 6K extensions.
> > I can do a patch for this on Monday, gotta run now.
> >  
> > > > > The original patch which started turning this off was from the MX3 stuff,
> > > > > but without explaination.
> > > > > 
> > > > > However, OMAP extended this to disabling the select statement for CPU_32v6K
> > > > > even if CPU_V7 is set:
> > > > > 
> > > > >  config CPU_V7
> > > > >         bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB |-       select CPU_32v6K
> > > > > +       select CPU_32v6K if !ARCH_OMAP2
> > > > > 
> > > > > Arguably, SMP _requires_ CPU_32v6K to be enabled for a safe kernel, and this
> > > > > patch should not have been merged.
> > > > 
> > > > The only way we can fix that is do smp_on_up style rewriting of the assembly
> > > > during init between CPUv6 and v6K. Want me to do a patch for that?
> > > 
> > > The bitops code is quite different between the two versions, and I doubt
> > > the smp_on_up rewriting will look at all pretty.  I think it needs an
> > > alternative idea - like not using the 'byte' operations at all.
> > > 
> > > Whether we have any code which passes non-word aligned pointers to bitops
> > > isn't particularly known - in theory they should all be unsigned long *'s,
> > > so should be word-aligned.  Who knows what filesystems do though... and
> > > such a change could be disasterous to peoples data if the block/inode
> > > bitmaps get corrupted.
> > 
> > Hmm, how about emulation of those instructions for non-v6K ARMv6 processors?
> > I guess we could do some address checking in the bitops functions too for
> > multi-arm builds..
> >  
> > > IOW, such a change needs testing on a box where a range of filesystems are
> > > used, and the filesystems can be thrown away if corrupted.
> > 
> > Or we could patch in the address checking first and only disable it
> > later if now warnings.
> 
> Right, this is what I'm going to do - and it's going to *intentionally*
> break omap2plus_defconfig.  Please see the commit comments for the
> reason why.  We need to address the V6 issue properly without risking
> users data.
> 
> To Sascha: this replaces the previous patch which I asked for your ack.

Ack for this one aswell:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> 
> 8<-----------
> Subject: [PATCH] ARM: Do not disable CPU_32v6K based on platform selection
> 
> CPU_32v6K controls whether we use the ARMv6K extension instructions in
> the kernel, and in some places whether we use SMP-safe code sequences
> (eg, bitops.)
> 
> Having this configuration option disabled on a SMP supporting kernel
> results in a problem: the SMP-unsafe code sequences will be used, and
> as such the resulting kernel is not SMP safe.
> 
> As the atomic bitops are used by filesystems (eg, ext2 - to manipulate
> the inode and block bitmaps) not having the SMP safe code sequences is
> fatal for filesystem data integrity.  So running an SMP kernel without
> CPU_32v6K set is dangerous.
> 
> MX3 prevents the selection of this option to ensure that it is not
> enabled for their CPU, which is ARMv6 only.  MX3 folk need to ensure
> that their kernel is properly configured.
> 
> OMAP prevents the selection of this option in an attempt to produce a
> kernel which runs on architectures from ARMv6 to ARMv7 MPCore.
> 
> Balancing between oopsing on boot and filesystem corruption, it is far
> more preferable to oops on boot until the code sequences are sorted out
> properly.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 49db8b3..d61af9c 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -405,7 +405,7 @@ config CPU_V6
>  config CPU_32v6K
>  	bool "Support ARM V6K processor extensions" if !SMP
>  	depends on CPU_V6 || CPU_V7
> -	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> +	default y if SMP
>  	help
>  	  Say Y here if your ARMv6 processor supports the 'K' extension.
>  	  This enables the kernel to use some instructions not present
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
