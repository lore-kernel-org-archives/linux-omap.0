From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
Date: Mon, 17 Jan 2011 12:09:32 +0000
Message-ID: <1295266172.21557.10.camel@e102109-lin.cambridge.arm.com>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk>
	 <AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
	 <20110117103739.GA18626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:47486 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751090Ab1AQMJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 07:09:39 -0500
In-Reply-To: <20110117103739.GA18626@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2011-01-17 at 10:37 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 17, 2011 at 10:15:25AM +0000, Catalin Marinas wrote:
> > On 15 January 2011 16:11, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > SMP requires at least the ARMv6K extensions to be present, so if we're
> > > running on SMP, the WFE and SEV instructions must be available.
> > >
> > > However, when we run on UP, the v6K extensions may not be available,
> > > and so we don't want WFE/SEV to be in the instruction stream.  Use the
> > > SMP alternatives infrastructure to replace these instructions with NOPs
> > > if we build for SMP but run on UP.
> > [...]
> > > --- a/arch/arm/include/asm/spinlock.h
> > > +++ b/arch/arm/include/asm/spinlock.h
> > > @@ -5,17 +5,36 @@
> > >  #error SMP not supported on pre-ARMv6 CPUs
> > >  #endif
> > >
> > > +/*
> > > + * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
> > > + * extensions, so when running on UP, we have to patch these instructions away.
> > > + */
> > > +#define ALT_SMP(smp, up)                                       \
> > > +       "9998:  " smp "\n"                                      \
> > > +       "       .pushsection \".alt.smp.init\", \"a\"\n"        \
> > > +       "       .long   9998b\n"                                \
> > > +       "       " up "\n"                                       \
> > > +       "       .popsection\n"
> > > +
> > > +#ifdef CONFIG_THUMB2_KERNEL
> > > +#define SEV            ALT_SMP("sev.w", "nop.w")
> > > +#define WFE(cond)      ALT_SMP("wfe" cond ".w", "nop.w")
> > > +#else
> > > +#define SEV            ALT_SMP("sev", "nop")
> > > +#define WFE(cond)      ALT_SMP("wfe" cond, "nop")
> > > +#endif
> >
> > In the SEV macro definition, can you also include the dsb?
> 
> No, you can't do preprocessor conditionals in the middle of a macro
> definition, and I don't want to have 4 versions of the SEV stuff.
> 
> > This barrier is only there because of sev, otherwise we don't need it
> > (we have a dmb prior to releasing the lock).
> 
> 1. Does it make sense to have sev and wfe instructions in non-SMP kernels?
> We now have in asm/system.h:
> #if __LINUX_ARM_ARCH__ >= 7 ||          \
>         (__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
> #define sev()   __asm__ __volatile__ ("sev" : : : "memory")
> #define wfe()   __asm__ __volatile__ ("wfe" : : : "memory")
> #define wfi()   __asm__ __volatile__ ("wfi" : : : "memory")
> #endif

The whole spinlock code doesn't make much sense. But the wfe/sev are
usually no-ops if SMP isn't supported in hardware (though you still need
ARMv6K not to undef).

> 2. Should we have a smp_dsb() which makes the dsb conditional elsewhere?

We could do but I'm not sure how confusing it would be (yet another
ARM-specific barrier).

> 3. Do we always need a dsb prior to a sev?  Maybe the SPEAR patches need
> another review to determine how they're using sev()?

We need a dsb to ensure that the prior STR completed before the sev,
otherwise we notify the other CPU but the LDREX reads the locked value
and goes into WFE again.

The SPEAR code seems ok, though I would have used a dsb() to make it
clear.

-- 
Catalin



