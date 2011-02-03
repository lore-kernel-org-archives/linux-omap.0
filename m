From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi() for CONFIG_THUMB2_KERNEL
Date: Fri, 4 Feb 2011 00:09:34 +0530
Message-ID: <b0242fa556f17e47222fa7f30a36d75b@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org> <1296756161-26092-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59363 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932312Ab1BCSjh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 13:39:37 -0500
Received: by mail-gw0-f44.google.com with SMTP id 20so666894gwb.31
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 10:39:36 -0800 (PST)
In-Reply-To: <1296756161-26092-2-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Thursday, February 03, 2011 11:33 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
> linux-omap@vger.kernel.org; Nicolas Pitre
> Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi()
> for CONFIG_THUMB2_KERNEL
>
> For the Thumb-2 case, the "wfi" mnemonic is used, since in this
> case the tools will necessarily be new enough to support it.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

I guess, we discussed this patch in your previous post.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h
> b/arch/arm/mach-omap2/include/mach/omap4-common.h
> index 5b0270b..68ce058 100644
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
> "memory")
> +#endif
>
>  #ifdef CONFIG_CACHE_L2X0
>  extern void __iomem *l2cache_base;
> --
> 1.7.1
