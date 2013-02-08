From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: PM: Warn users about usage of older bootloaders
Date: Thu, 07 Feb 2013 17:29:33 -0800
Message-ID: <87liazzj7m.fsf@linaro.org>
References: <1359980683-12079-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1302062343230.12769@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:61403 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab3BHB3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 20:29:37 -0500
Received: by mail-da0-f53.google.com with SMTP id r13so94418daj.40
        for <linux-omap@vger.kernel.org>; Thu, 07 Feb 2013 17:29:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302062343230.12769@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 6 Feb 2013 23:44:34 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, R Sricharan <r.sricharan@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> On Mon, 4 Feb 2013, Rajendra Nayak wrote:
>
>> OMAP4 CHIP level PM works only with newer bootloaders. The
>> dependency on the bootloader comes from the fact that the
>> kernel is missing reset and initialization code for some
>> devices.
>> 
>> While the right thing to do is to add reset and init code in
>> the kernel, for some co-processor IP blocks like DSP and IVA
>> it means downloading firmware into each one of them to execute
>> idle instructions.
>> 
>> While a feasible solution is worked upon on how such IP blocks
>> can be better handled in the kernel, in the interim, to avoid
>> any further frustration to users testing PM on OMAP4 and finding
>> it broken, warn them about the bootloader being a possible
>> cause.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: R Sricharan <r.sricharan@ti.com>
>
> Thanks Rajendra, I appreciate the patch.  I've tweaked it slightly and the 
> following is what's queued here; hopefully it can go in for v3.9.
>
>
> - Paul
>
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Mon, 4 Feb 2013 17:54:43 +0530
> Subject: [PATCH] ARM: OMAP4: PM: Warn users about usage of older bootloaders
>
> OMAP4 CHIP level PM works only with newer bootloaders. The
> dependency on the bootloader comes from the fact that the
> kernel is missing reset and initialization code for some
> devices.
>
> While the right thing to do is to add reset and init code in
> the kernel, for some co-processor IP blocks like DSP and IVA
> it means downloading firmware into each one of them to execute
> idle instructions.
>
> While a feasible solution is worked upon on how such IP blocks
> can be better handled in the kernel, in the interim, to avoid
> any further frustration to users testing PM on OMAP4 and finding
> it broken, warn them about the bootloader being a possible
> cause.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: R Sricharan <r.sricharan@ti.com>
> [paul@pwsan.com: tweaked warning messages and comments slightly]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

FWIW

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  arch/arm/mach-omap2/pm44xx.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index aa6fd98..502ed9b 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -77,8 +77,18 @@ static int omap4_pm_suspend(void)
>  		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>  		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->saved_logic_state);
>  	}
> -	if (ret)
> +	if (ret) {
>  		pr_crit("Could not enter target state in pm_suspend\n");
> +		/*
> +		 * OMAP4 chip PM currently works only with certain (newer)
> +		 * versions of bootloaders. This is due to missing code in the
> +		 * kernel to properly reset and initialize some devices.
> +		 * Warn the user about the bootloader version being one of the
> +		 * possible causes.
> +		 * http://www.spinics.net/lists/arm-kernel/msg218641.html
> +		 */
> +		pr_warn("A possible cause could be an old bootloader - try u-boot >= v2012.07\n");
> +	}
>  	else
>  		pr_info("Successfully put all powerdomains to target state\n");
>  
> @@ -146,6 +156,13 @@ int __init omap4_pm_init(void)
>  	}
>  
>  	pr_err("Power Management for TI OMAP4.\n");
> +	/*
> +	 * OMAP4 chip PM currently works only with certain (newer)
> +	 * versions of bootloaders. This is due to missing code in the
> +	 * kernel to properly reset and initialize some devices.
> +	 * http://www.spinics.net/lists/arm-kernel/msg218641.html
> +	 */
> +	pr_warn("u-boot >= v2012.07 is required for full PM support\n");
>  
>  	ret = pwrdm_for_each(pwrdms_setup, NULL);
>  	if (ret) {
