From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 1/3] omap1: Use asm_irq_flags for entry-macro.S
Date: Fri, 10 Dec 2010 17:06:22 +0100
Message-ID: <201012101706.24089.jkrzyszt@tis.icnet.pl>
References: <20101204001435.28853.29616.stgit@baageli.muru.com> <20101208014548.GJ17435@atomide.com> <20101208014728.GK17435@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57593 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756170Ab0LJQGw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 11:06:52 -0500
In-Reply-To: <20101208014728.GK17435@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Wednesday 08 December 2010 02:47:28 Tony Lindgren napisa=C5=82(a):
> Initialize asm_irq_flags in omap_init_irq and use it in
> get_irqnr_and_base to detect between omap7xx and omap15xx/16xx.
>
> Note that both INT_1510_IH2_IRQ and INT_1510_IH2_IRQ are defined
> as 0, so use INT_1510_IH2_IRQ for both of them.

Tested on Amstrad Delta.

> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

> diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S
> b/arch/arm/mach-omap1/include/mach/entry-macro.S index df9060e..c9be6=
d4
> 100644
> --- a/arch/arm/mach-omap1/include/mach/entry-macro.S
> +++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
> @@ -14,18 +14,17 @@
>  #include <mach/irqs.h>
>  #include <asm/hardware/gic.h>
>
> -#if (defined(CONFIG_ARCH_OMAP730)||defined(CONFIG_ARCH_OMAP850)) && =
\
> -	(defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX))
> -#error "FIXME: OMAP7XX doesn't support multiple-OMAP"
> -#elif defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> -#define INT_IH2_IRQ		INT_7XX_IH2_IRQ
> -#elif defined(CONFIG_ARCH_OMAP15XX)
> -#define INT_IH2_IRQ		INT_1510_IH2_IRQ
> -#elif defined(CONFIG_ARCH_OMAP16XX)
> -#define INT_IH2_IRQ		INT_1610_IH2_IRQ
> -#else
> -#warning "IH2 IRQ defaulted"
> -#define INT_IH2_IRQ		INT_1510_IH2_IRQ
> +/*
> + * We use __glue to avoid errors with multiple definitions of
> + * .globl omap_irq_flags as it's included from entry-armv.S but not
> + * from entry-common.S.
> + */
> +#ifdef __glue
> +		.pushsection .data
> +		.globl	omap_irq_flags
> +omap_irq_flags:
> +		.word	0
> +		.popsection
>  #endif
>
>   		.macro	disable_fiq
> @@ -47,9 +46,11 @@
>  		beq	1510f
>
>  		ldr	\irqnr, [\base, #IRQ_SIR_FIQ_REG_OFFSET]
> +		ldr	\tmp, =3Domap_irq_flags	@ irq flags address
> +		ldr	\tmp, [\tmp, #0]	@ irq flags value
>  		cmp	\irqnr, #0
>  		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
> -		cmpeq	\irqnr, #INT_IH2_IRQ
> +		cmpeq	\irqnr, \tmp
>  		ldreq	\base, =3DOMAP1_IO_ADDRESS(OMAP_IH2_BASE)
>  		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
>  		addeqs	\irqnr, \irqnr, #32
> diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
> index db913c3..6bddbc8 100644
> --- a/arch/arm/mach-omap1/irq.c
> +++ b/arch/arm/mach-omap1/irq.c
> @@ -176,26 +176,31 @@ static struct irq_chip omap_irq_chip =3D {
>
>  void __init omap_init_irq(void)
>  {
> +	extern unsigned int omap_irq_flags;
>  	int i, j;
>
>  #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
>  	if (cpu_is_omap7xx()) {
> +		omap_irq_flags =3D INT_7XX_IH2_IRQ;
>  		irq_banks =3D omap7xx_irq_banks;
>  		irq_bank_count =3D ARRAY_SIZE(omap7xx_irq_banks);
>  	}
>  #endif
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap1510()) {
> +		omap_irq_flags =3D INT_1510_IH2_IRQ;
>  		irq_banks =3D omap1510_irq_banks;
>  		irq_bank_count =3D ARRAY_SIZE(omap1510_irq_banks);
>  	}
>  	if (cpu_is_omap310()) {
> +		omap_irq_flags =3D INT_1510_IH2_IRQ;
>  		irq_banks =3D omap310_irq_banks;
>  		irq_bank_count =3D ARRAY_SIZE(omap310_irq_banks);
>  	}
>  #endif
>  #if defined(CONFIG_ARCH_OMAP16XX)
>  	if (cpu_is_omap16xx()) {
> +		omap_irq_flags =3D INT_1510_IH2_IRQ;
>  		irq_banks =3D omap1610_irq_banks;
>  		irq_bank_count =3D ARRAY_SIZE(omap1610_irq_banks);
>  	}
> diff --git a/arch/arm/plat-omap/include/plat/irqs.h
> b/arch/arm/plat-omap/include/plat/irqs.h index 65e20a6..2910de9 10064=
4
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -77,7 +77,7 @@
>  /*
>   * OMAP-1610 specific IRQ numbers for interrupt handler 1
>   */
> -#define INT_1610_IH2_IRQ	0
> +#define INT_1610_IH2_IRQ	INT_1510_IH2_IRQ
>  #define INT_1610_IH2_FIQ	2
>  #define INT_1610_McBSP2_TX	4
>  #define INT_1610_McBSP2_RX	5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
