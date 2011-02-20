From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Sun, 20 Feb 2011 12:00:39 +0000
Message-ID: <20110220120039.GA14495@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk> <E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk> <AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com> <20110215110453.GB11199@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45900 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab1BTMA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Feb 2011 07:00:58 -0500
Content-Disposition: inline
In-Reply-To: <20110215110453.GB11199@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org

Kukjin, could you test this update as well please?

Thanks.

On Tue, Feb 15, 2011 at 11:04:53AM +0000, Russell King - ARM Linux wrot=
e:
> On Fri, Feb 11, 2011 at 06:50:57PM -0800, Colin Cross wrote:
> > > +ENDPROC(cpu_resume_turn_mmu_on)
> > > +cpu_resume_after_mmu:
> > > + =A0 =A0 =A0 str =A0 =A0 r5, [r2, r4, lsl #2] =A0 =A0@ restore o=
ld mapping
> > > +#ifdef MULTI_CACHE
> > > + =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dcpu_cache
> > > + =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CACHE_FLUSH_KERN_ALL]
> > > +#else
> > > + =A0 =A0 =A0 b =A0 =A0 =A0 __cpuc_flush_kern_all
> > > +#endif
>=20
> I think we can eliminate this cache flush by delaying the cache enabl=
e
> as below.  Could you see whether Tegra 2 survives this please?
> Thanks.
>=20
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index bed1876..193be5f 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -4,6 +4,7 @@
>  #include <asm/assembler.h>
>  #include <asm/glue-cache.h>
>  #include <asm/glue-proc.h>
> +#include <asm/system.h>
>  	.text
> =20
>  /*
> @@ -81,25 +82,22 @@ ENTRY(cpu_resume_mmu)
>  	str	r3, [r2, r4, lsl #2]	@ setup 1:1 mapping for mmu code
>  	sub	r2, r2, r1
>  	ldr	r3, =3Dcpu_resume_after_mmu
> +	bic	r1, r0, #CR_C		@ ensure D-cache is disabled
>  	b	cpu_resume_turn_mmu_on
>  ENDPROC(cpu_resume_mmu)
>  	.ltorg
>  	.align	5
>  cpu_resume_turn_mmu_on:
> -	mcr	p15, 0, r0, c1, c0, 0	@ turn on MMU, caches, etc
> -	mrc	p15, 0, r0, c0, c0, 0	@ read id reg
> -	mov	r0, r0
> -	mov	r0, r0
> +	mcr	p15, 0, r1, c1, c0, 0	@ turn on MMU, I-cache, etc
> +	mrc	p15, 0, r1, c0, c0, 0	@ read id reg
> +	mov	r1, r1
> +	mov	r1, r1
>  	mov	pc, r3			@ jump to virtual address
>  ENDPROC(cpu_resume_turn_mmu_on)
>  cpu_resume_after_mmu:
>  	str	r5, [r2, r4, lsl #2]	@ restore old mapping
> -#ifdef MULTI_CACHE
> -	ldr	r10, =3Dcpu_cache
> -	ldr	pc, [r10, #CACHE_FLUSH_KERN_ALL]
> -#else
> -	b	__cpuc_flush_kern_all
> -#endif
> +	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
> +	mov	pc, lr
> =20
>  /*
>   * Note: Yes, part of the following code is located into the .data s=
ection.
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
