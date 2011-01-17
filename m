From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
Date: Mon, 17 Jan 2011 10:37:39 +0000
Message-ID: <20110117103739.GA18626@n2100.arm.linux.org.uk>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk> <AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53676 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab1AQKhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 05:37:51 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 17, 2011 at 10:15:25AM +0000, Catalin Marinas wrote:
> On 15 January 2011 16:11, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > SMP requires at least the ARMv6K extensions to be present, so if we=
're
> > running on SMP, the WFE and SEV instructions must be available.
> >
> > However, when we run on UP, the v6K extensions may not be available=
,
> > and so we don't want WFE/SEV to be in the instruction stream. =A0Us=
e the
> > SMP alternatives infrastructure to replace these instructions with =
NOPs
> > if we build for SMP but run on UP.
> [...]
> > --- a/arch/arm/include/asm/spinlock.h
> > +++ b/arch/arm/include/asm/spinlock.h
> > @@ -5,17 +5,36 @@
> > =A0#error SMP not supported on pre-ARMv6 CPUs
> > =A0#endif
> >
> > +/*
> > + * sev and wfe are ARMv6K extensions. =A0Uniprocessor ARMv6 may no=
t have the K
> > + * extensions, so when running on UP, we have to patch these instr=
uctions away.
> > + */
> > +#define ALT_SMP(smp, up) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 "9998: =A0" smp "\n" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 " =A0 =A0 =A0 .pushsection \".alt.smp.init\", \"a\"\n=
" =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 " =A0 =A0 =A0 .long =A0 9998b\n" =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 " =A0 =A0 =A0 " up "\n" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 " =A0 =A0 =A0 .popsection\n"
> > +
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +#define SEV =A0 =A0 =A0 =A0 =A0 =A0ALT_SMP("sev.w", "nop.w")
> > +#define WFE(cond) =A0 =A0 =A0ALT_SMP("wfe" cond ".w", "nop.w")
> > +#else
> > +#define SEV =A0 =A0 =A0 =A0 =A0 =A0ALT_SMP("sev", "nop")
> > +#define WFE(cond) =A0 =A0 =A0ALT_SMP("wfe" cond, "nop")
> > +#endif
>=20
> In the SEV macro definition, can you also include the dsb?

No, you can't do preprocessor conditionals in the middle of a macro
definition, and I don't want to have 4 versions of the SEV stuff.

> This barrier is only there because of sev, otherwise we don't need it
> (we have a dmb prior to releasing the lock).

1. Does it make sense to have sev and wfe instructions in non-SMP kerne=
ls?
We now have in asm/system.h:
#if __LINUX_ARM_ARCH__ >=3D 7 ||          \
        (__LINUX_ARM_ARCH__ =3D=3D 6 && defined(CONFIG_CPU_32v6K))
#define sev()   __asm__ __volatile__ ("sev" : : : "memory")
#define wfe()   __asm__ __volatile__ ("wfe" : : : "memory")
#define wfi()   __asm__ __volatile__ ("wfi" : : : "memory")
#endif

2. Should we have a smp_dsb() which makes the dsb conditional elsewhere=
?

3. Do we always need a dsb prior to a sev?  Maybe the SPEAR patches nee=
d
another review to determine how they're using sev()?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
