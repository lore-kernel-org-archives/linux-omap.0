From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have
 SMP_ON_UP fixups
Date: Wed, 16 Feb 2011 16:35:43 +0000
Message-ID: <20110216163543.GA27480@arm.com>
References: <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
 <20110210144617.GD3652@n2100.arm.linux.org.uk>
 <AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
 <20110210191125.GA12582@n2100.arm.linux.org.uk>
 <AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
 <20110211101345.GA23785@n2100.arm.linux.org.uk>
 <AANLkTikFkZH6KK_KUgXaaKyQM6eZOh-ki3xdtS2fk8zN@mail.gmail.com>
 <20110211160500.GA31529@n2100.arm.linux.org.uk>
 <AANLkTik1T_RDb_MVw9WWY_BX75isoGq2k1L+uVCN-bbq@mail.gmail.com>
 <20110211163247.GB31529@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59038 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab1BPQgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 11:36:03 -0500
Received: by wyb28 with SMTP id 28so1514239wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 08:36:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110211163247.GB31529@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Feb 11, 2011 at 04:32:47PM +0000, Russell King - ARM Linux wrote:

[...]

> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 45b5651..343d29f 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -21,6 +21,12 @@
>  #define ARM_CPU_KEEP(x)
>  #endif
>  
> +#if defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)
> +#define ARM_EXIT_KEEP(x)	x
> +#else
> +#define ARM_EXIT_KEEP(x)
> +#endif
> +
>  OUTPUT_ARCH(arm)
>  ENTRY(stext)
>  
> @@ -43,6 +49,7 @@ SECTIONS
>  		_sinittext = .;
>  			HEAD_TEXT
>  			INIT_TEXT
> +			ARM_EXIT_KEEP(EXIT_TEXT)
>  		_einittext = .;
>  		ARM_CPU_DISCARD(PROC_INFO)
>  		__arch_info_begin = .;
> @@ -71,6 +78,7 @@ SECTIONS
>  #ifndef CONFIG_XIP_KERNEL
>  		__init_begin = _stext;
>  		INIT_DATA
> +		ARM_EXIT_KEEP(EXIT_DATA)
>  #endif
>  	}
>  
> @@ -166,6 +174,7 @@ SECTIONS
>  		. = ALIGN(PAGE_SIZE);
>  		__init_begin = .;
>  		INIT_DATA
> +		ARM_EXIT_KEEP(EXIT_DATA)
>  		. = ALIGN(PAGE_SIZE);
>  		__init_end = .;
>  #endif
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

This works for me in a case known to fail without the patch.

Tested-by: Dave Martin <dave.martin@linaro.org>

I still don't quite understand the intricacies of how vmlinux
is laid out, but the patch looks sensible.

Do you need anything more from me on this?  If not, I will
throw away my patch and replace it with yours.

Cheers
---Dave
