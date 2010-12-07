From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi() forCONFIG_THUMB2_KERNEL
Date: Tue, 7 Dec 2010 11:58:47 +0530
Message-ID: <a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org> <1291656937-24992-3-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47895 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751424Ab0LGG2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 01:28:50 -0500
Received: by mail-qw0-f47.google.com with SMTP id 5so12009423qwg.20
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 22:28:49 -0800 (PST)
In-Reply-To: <1291656937-24992-3-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

Dave,
> -----Original Message-----
> From: linaro-dev-bounces@lists.linaro.org [mailto:linaro-dev-
> bounces@lists.linaro.org] On Behalf Of Dave Martin
> Sent: Monday, December 06, 2010 11:06 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Tony Lindgren; Dave Martin; linux-omap@vger.kernel.org; linaro-
> dev@lists.linaro.org
> Subject: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
> forCONFIG_THUMB2_KERNEL
>
> For the Thumb-2 case, the "wfi" mnemonic is used, since in this
> case the tools will necessarily be new enough to support it.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> KernelVersion: 2.6.37-rc4

The choice of opcode instead of instruction here was not because
of toolchain. The problem was it breaks multi-omap build where
ARMv6 and ARMv7 are build together.

For this reason I NAK this patch.

>
>  arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h
> b/arch/arm/mach-omap2/include/mach/omap4-common.h
> index 2744dfe..c6b1320 100644
> --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
> +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
> @@ -17,8 +17,13 @@
>   * wfi used in low power code. Directly opcode is used instead
>   * of instruction to avoid mulit-omap build break
>   */
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define do_wfi()			\
> +		__asm__ __volatile__ ("wfi" : : : "memory")
> +#else
>  #define do_wfi()			\
>  		__asm__ __volatile__ (".word	0xe320f003" : : :
"memory")
> +#endif
>
>  #ifdef CONFIG_CACHE_L2X0
>  extern void __iomem *l2cache_base;
> --
> 1.7.1
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
