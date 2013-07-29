From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: v6: prevent gcc from reordering extended CP15 reads
 above is_smp() test
Date: Mon, 29 Jul 2013 11:02:43 +0100
Message-ID: <20130729100243.GC32383@mudshark.cambridge.arm.com>
References: <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com>
 <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com>
 <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
 <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:34162 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752093Ab3G2KDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 06:03:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Sun, Jul 28, 2013 at 09:16:29PM +0100, Paul Walmsley wrote:
> 
> Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
> don't flush icache in switch_mm with hardware broadcasting") breaks
> the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
> undefined instruction abort from the CP15 read in
> cache_ops_need_broadcast().  It turns out that gcc reorders the
> extended CP15 read above the is_smp() test.  This breaks ARM1136 r0
> cores, since they don't support several CP15 registers that later ARM
> cores do.  ARM1136JF-S TRM section 3.2.1 "Register allocation" has the
> details.

Cheers for tracking this down. Interestingly, I can't reproduce this with
anything other than GCC 4.5.* tools -- 4.6+ do what we want. Still, it looks
like a valid (if not misguided) thing to do.

> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 8c25dc4..f428eb0 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -89,13 +89,25 @@ extern unsigned int processor_id;
>  		__val;							\
>  	})
>  
> +
> +# if defined(CONFIG_CPU_V6)
> +/*
> + * The mrc in the read_cpuid_ext macro must not be reordered on ARMv6,
> + * else the compiler may move it before an is_smp() test, causing
> + * undefined instruction aborts on ARM1136 r0.
> + */
> +# define CPUID_EXT_REORDER	"cc", "memory"
> +# else
> +# define CPUID_EXT_REORDER	"cc"
> +# endif
> +
>  #define read_cpuid_ext(ext_reg)						\
>  	({								\
>  		unsigned int __val;					\
>  		asm("mrc	p15, 0, %0, c0, " ext_reg		\
>  		    : "=r" (__val)					\
>  		    :							\
> -		    : "cc");						\
> +		    : CPUID_EXT_REORDER);				\
>  		__val;							\
>  	})

I wouldn't worry about checking for CPU_V6. Besides, we probably need this
to be re-evaluated across barrier() when we get CPU migration on a
big-little platform anyway (we should probably also drop the
__attribute_const__ for that).

So you can just replace the "cc" (now that Nico kindly explained why those
aren't needed the other day) with "memory".

An alternative is to add barrier() between is_smp() and the read_cpuid_ext()
in all callers, adding a fake read from the stack to the latter (like I did
for the per-cpu accessor). However, this relies on fixing all callers for
very little gain, so I don't think it's worth the hassle.

I can cook a patch if you're tied up with other things -- just let me know.

Cheers,

Will
