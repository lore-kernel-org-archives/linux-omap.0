From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq on
 UP systems
Date: Fri, 3 Sep 2010 17:30:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7590@dbde02.ent.ti.com>
References: <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902162124.GN11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33625 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757688Ab0ICMBe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 08:01:34 -0400
In-Reply-To: <20100902162124.GN11597@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, September 02, 2010 9:51 PM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Bryan Wu; Will Deacon
> Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq on
> UP systems
> 
> From f80d3cc85327ba84748646bb44a0c45103ef66bc Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 1 Sep 2010 20:40:47 -0700
> Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq on
> UP systems
> 
> Do not call test_for_ipi or test_for_ltrirq on UP systems.
> 
> Note that we can't put test_for_ltriq into SMP statement as
> it's inlined into the code and the remaining lines of the
> macro would still run before UP macro line.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/kernel/entry-armv.S |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index bb2ef60..b8c1ec7 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -40,6 +40,11 @@
>  	bne	asm_do_IRQ
> 
>  #ifdef CONFIG_SMP
Do we need this code to be under " CONFIG_SMP" now ?
> +#ifdef CONFIG_SMP_ON_UP
> +	adr	lr, BSYM(2f)	@ set lr to end of macro for early return
> +	SMP(nop)		@ continue on SMP hardware
> +	UP(mov	pc, lr)		@ return early on UP
> +#endif
>  	/*
>  	 * XXX
>  	 *
> @@ -57,6 +62,7 @@
>  	adrne	lr, BSYM(1b)
>  	bne	do_local_timer
>  #endif
> +2:
>  #endif
> 
>  	.endm
> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
