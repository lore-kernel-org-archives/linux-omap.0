From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP: fix IVA2 module base address
Date: Tue, 28 May 2013 07:30:05 -0700
Message-ID: <87bo7vdvo2.fsf@linaro.org>
References: <1369741577-21984-1-git-send-email-aida.mynzhasova@skitlab.ru>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:39530 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934123Ab3E1OaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 May 2013 10:30:10 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so7941732pbc.31
        for <linux-omap@vger.kernel.org>; Tue, 28 May 2013 07:30:09 -0700 (PDT)
In-Reply-To: <1369741577-21984-1-git-send-email-aida.mynzhasova@skitlab.ru>
	(Aida Mynzhasova's message of "Tue, 28 May 2013 15:46:17 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Aida Mynzhasova <aida.mynzhasova@skitlab.ru> writes:

> This patch corrects the base address of IVA2 module on omap3430.
>
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>

I know it looks a bit weird to have a negative offset like this, but
it's actually correct.  These offsets are used relative to
prm_base (on 34xx, it's OMAP3430_PRM_BASE defined in omap34xx.h).
So I suggest you double check the values there, and cross reference to
the "PRCM Register Manual" section of the TRM (last section of the PRCM
chapter.)

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/prcm-common.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index c7d355f..d5ec044 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -37,7 +37,7 @@
>  #define OMAP2430_MDM_MOD				0xc00
>  
>  /* IVA2 module is < base on 3430 */
> -#define OMAP3430_IVA2_MOD				-0x800
> +#define OMAP3430_IVA2_MOD				0x800
>  #define OMAP3430ES2_SGX_MOD				GFX_MOD
>  #define OMAP3430_CCR_MOD				PLL_MOD
>  #define OMAP3430_DSS_MOD				0x600
