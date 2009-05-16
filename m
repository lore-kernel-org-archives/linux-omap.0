From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
Date: Sun, 17 May 2009 02:51:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49042AA@dbde02.ent.ti.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
 <20090516102835.GO15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38014 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817AbZEPVVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 17:21:48 -0400
In-Reply-To: <20090516102835.GO15328@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Saturday, May 16, 2009 3:59 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
> 
> On Thu, May 07, 2009 at 12:59:24PM +0530, Santosh Shilimkar wrote:
> > +/*
> > + * OMAP4 specific entry point for secondary CPU to jump from ROM
> > + * code.  This routine also provides a holding flag into which
> > + * secondary core is held until we're ready for it to initialise.
> > + * The primary core will update the this flag using a hardware
> > + * register AuxCoreBoot1.
> 
> However, it's actually using the 'cpu_release' variable rather than
> the AuxCoreBoot1 register.  Maybe the comment needs updating, or the
> code needs fixing?
I planned update this bit later. AuxCoreBoot1 would be used instead of variable cpu_release
Will add couple of FIXME comments here.
> > + */
> > +ENTRY(omap_secondary_startup)
> > +	mrc	p15, 0, r0, c0, c0, 5
> > +	and	r0, r0, #15
> > +	adr	r4, 1f
> > +	ldmia	r4, {r5, r6}
> > +	sub	r4, r4, r5
> > +	add	r6, r6, r4
> > +hold:	ldr	r7, [r6]	 @ read from AuxCoreBoot1
> > +	cmp	r7, r0
> > +	bne	hold
> > +
> > +	/*
> > +	 * we've been released from the holding pen: secondary_stack
> > +	 * should now contain the SVC stack for this core
> > +	 */
> > +	b	secondary_startup
> > +
> > +1:	.long	.
> > +	.long	cpu_release
> > +
> > diff --git a/arch/arm/mach-omap2/omap-smp.c 
> b/arch/arm/mach-omap2/omap-smp.c
> > new file mode 100644
> > index 0000000..1d18acb
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap-smp.c
> > @@ -0,0 +1,238 @@
> > +int __cpuinit boot_secondary(unsigned int cpu, struct 
> task_struct *idle)
> > +{
> > +	unsigned long timeout;
> > +
> > +	/*
> > +	 * Set synchronisation state between this boot processor
> > +	 * and the secondary one
> > +	 */
> > +	spin_lock(&boot_lock);
> > +
> > +	/*
> > +	 * The secondary processor is waiting for an event to 
> come out of
> > +	 * wfe. Release it, then wait for it to flag that it has been
> > +	 * released by resetting cpu_release.
> > +	 *
> > +	 * Singal the ROM code that the secondary core can be released
> > +	 */
> > +	cpu_release = cpu;
> > +	__raw_writel(cpu, OMAP4_AUXCOREBOOT_REG1);
> > +	flush_cache_all();
> > +	/*
> > +	 * Send a 'sev' to wake the secondary core again because
> > +	 * ROM code will put core in WFE till the cpu_release
> > +	 * flag is set.
> 
> Not sure this comment is accurate.  Surely the ROM code doesn't know
> about our own cpu_release flag.
 Should be some thing like this-- >ROM code will put secondary core in WFE till we flag it using the AuxCoreBoot1 register to bring it up.
 
> > -- 
> > 1.5.4.7


Regards,
Santosh
 
