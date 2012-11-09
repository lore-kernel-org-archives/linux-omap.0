From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Prevent redefinition errors for soc.h
Date: Fri, 9 Nov 2012 08:22:59 -0800
Message-ID: <20121109162259.GO6801@atomide.com>
References: <1352477961-7634-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44762 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753502Ab2KIQXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 11:23:03 -0500
Content-Disposition: inline
In-Reply-To: <1352477961-7634-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121109 08:21]:
> If the header soc.h is included more than once in a source (for example
> once directly by the source file and once indirectly by another header
> file), then the compiler will generate redefintion errors for the macros
> in soc.h. Prevent this by only allowing the content in soc.h to be
> included once.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
> 
> Please note that I ran into this problem when rebasing my dmtimer fixes
> series [1] on Tony's Linux-OMAP master branch. I am including plat/cpu.h
> in dmtimer.h and I found several other files including dmtimer.h are also
> including soc.h and so generate a lot of errors.
> 
> [1] http://marc.info/?l=linux-omap&m=135231490218361&w=2

As these headers are private to mach-omap2, I'd rather not allow including
them more than once so we can eventually clean up the includes further.

We should include the headers directly where used, except for the
legacy board-*.c files that will be going away anyways.

Including the files directly should fix this easily, if not let me
know.

Regards,

Tony
 
>  arch/arm/mach-omap2/soc.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
> index 0700964..6b270a0 100644
> --- a/arch/arm/mach-omap2/soc.h
> +++ b/arch/arm/mach-omap2/soc.h
> @@ -25,6 +25,9 @@
>   *
>   */
>  
> +#ifndef __ARCH_ARM_MACH_OMAP2_SOC_H
> +#define __ARCH_ARM_MACH_OMAP2_SOC_H
> +
>  #include "omap24xx.h"
>  #include "omap34xx.h"
>  #include "omap44xx.h"
> @@ -471,3 +474,4 @@ OMAP4_HAS_FEATURE(mpu_1_5ghz, MPU_1_5GHZ)
>  
>  #endif	/* __ASSEMBLY__ */
>  
> +#endif	/* __ARCH_ARM_MACH_OMAP2_SOC_H */
> -- 
> 1.7.9.5
> 
