From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Mon, 4 May 2015 07:24:13 -0700
Message-ID: <20150504142413.GE24469@atomide.com>
References: <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth>
 <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth>
 <20150420234032.GM18048@atomide.com>
 <20150423102542.GZ4027@n2100.arm.linux.org.uk>
 <20150423141727.GQ18048@atomide.com>
 <20150428181300.GB4027@n2100.arm.linux.org.uk>
 <20150429144011.GB24469@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48937 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbbEDOYQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 10:24:16 -0400
Content-Disposition: inline
In-Reply-To: <20150429144011.GB24469@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [150429 07:42]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150428 11:14]:
> > On Thu, Apr 23, 2015 at 07:17:28AM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150423 03:26]:
> > > > However, I don't think anyone is willing to say that they have a
> > > > solution to this problem - obviously, you can't build OMAP as a
> > > > non-multiplatform kernel anymore, so in effect you can never have
> > > > the kernel enable this errata.  And you can't detect whether you're
> > > > running in secure mode or not.
> > > > 
> > > > We could do the "only write the bit if it was originally clear" but
> > > > we still have the problem that doing so may cause other people
> > > > regressions.
> > > 
> > > How about we keep the bit writing part !multiplatform conditional
> > > (or even remove it) but always do the flush for ca-8?
> > > 
> > > Then we could also do a warning for a misconfigured ca-8 later on.
> > 
> > Yes, we could do this - we'll have to rely on the boot loader doing
> > the right thing and setting this bit appropriately.  For those
> > platforms where this doesn't apply, I don't see any solution as (iirc)
> > OMAP now requires MULTIPLATFORM to be enabled.
> 
> OK, here's an updated patch. I've kept Sebastian's Tested-by as we know
> the init part is a nop on n900 that he tested with.

I've posted this updated version into Russell's patch system:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8353/1

Regards,

Tony
 
> 8< ---------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 27 Apr 2015 10:18:14 -0700
> Subject: [PATCH] ARM: mm: Fix Cortex-A8 erratum 430973 segfaults for bootloaders and multiarch
> 
> Looks like apps can be made to segfault easily on armhf distros
> just by running cpuburn-a8 in the background, then starting apt
> get update unless erratum 430973 workaround is enabled. This happens
> on r3p2 also, which has 430973 fixed in hardware.
> 
> Turns out the reason for this is some bootloaders incorrectly
> setting the auxilary register IBE bit, which probably causes us
> to hit erratum 687067 on Cortex-A8 later than r1p2.
> 
> If the bootloader incorrectly sets the IBE bit in the auxilary control
> register for Cortex-A8 revisions with 430973 fixed in hardware, we
> need to call flush BTAC/BTB to avoid segfaults probably caused by
> erratum 687067. So let's flush BTAC/BTB unconditionally for Cortex-A8.
> It won't do anything unless the IBE bit is set.
> 
> Note that we keep the erratum 430973 Kconfig option still around and
> disabled for multiarch as it may be unsafe to enable for some secure
> SoC. It is known safe to be enabled for n900, but won't do anything
> on n900 as the IBE bit needs to be set with SMC.
> 
> Also note that SoCs probably should also add checks and print warnings
> for the misconfigured IBE bit depending on the Cortex-A8 revision
> so the bootloaders can be fixed Cortex-A8 revisions later than
> r1p2 to not set the IBE bit.
> 
> Tested-By: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mm/proc-v7-2level.S
> +++ b/arch/arm/mm/proc-v7-2level.S
> @@ -36,14 +36,16 @@
>   *
>   *	It is assumed that:
>   *	- we are not using split page tables
> + *
> + *	Note that we always need to flush BTAC/BTB if IBE is set
> + *	even on Cortex-A8 revisions not affected by 430973.
> + *	If IBE is not set, the flush BTAC/BTB won't do anything.
>   */
>  ENTRY(cpu_ca8_switch_mm)
>  #ifdef CONFIG_MMU
>  	mov	r2, #0
> -#ifdef CONFIG_ARM_ERRATA_430973
>  	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
>  #endif
> -#endif
>  ENTRY(cpu_v7_switch_mm)
>  #ifdef CONFIG_MMU
>  	mmid	r1, r1				@ get mm->context.id
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
