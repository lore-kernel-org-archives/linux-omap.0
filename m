From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: OMAP3xxx: clockdomain: fix software supervised wakeup/sleep
Date: Tue, 31 Jul 2012 11:11:03 +0530
Message-ID: <50176FEF.6060600@ti.com>
References: <alpine.DEB.2.00.1207261503290.14468@utopia.booyaka.com> <50122A75.2030108@ti.com> <501761E8.3030307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50642 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751710Ab2GaFlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 01:41:11 -0400
Received: by pbbro8 with SMTP id ro8so10796853pbb.25
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 22:41:09 -0700 (PDT)
In-Reply-To: <501761E8.3030307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jon,

On Tuesday 31 July 2012 10:11 AM, Jon Hunter wrote:
> Hi Paul, Rajendra,
>
> On 07/27/2012 12:43 AM, Rajendra Nayak wrote:
>> On Friday 27 July 2012 02:34 AM, Paul Walmsley wrote:
>>>
>>> Commit 4da71ae6 ("OMAP: clockdomain: Arch specific funcs for
>>> clkdm_clk_enable/disable") called the OMAP2xxx-specific functions for
>>> clockdomain wakeup and sleep.  This would probably have broken
>>> software-supervised clockdomain wakeup and sleep on OMAP3.
>>
>> Its strange this went unnoticed for so long. Thanks for this fix and
>> sorry about introducing the bug in the first place.
>
> Any chance that's because of the following code? I needed to
> remove this to get the EMU clock domain to turn off on OMAP3
> whilst testing PMU.

No, this doesn't seem right. We still have clockdomains for omap2/3
controlled using clkdm_clk_enable/disable functions called from
within clk framework, and not clkdm_hwmod_enable/disable from
within hwmod framework.
Besides you removing these checks only in clkdm_hwmod_disable (and
keeping them in clkdm_hwmod_enable) tells me its just hiding some
usecounting issues you were having with clkdm_clk_enable/disable.

Btw, on OMAP2/3 as long as a domain has interface clocks which are
explicitly enabled and autoidled, the clkdm usecount never ends up
going to 0, which is probably what you are hit with too.

regards,
Rajendra

>
> Cheers
> Jon
>
> commit a0307bd539ecef976793679a1c4ff0d47b22c4bd
> Author: Jon Hunter<jon-hunter@ti.com>
> Date:   Mon Jul 30 18:04:06 2012 -0500
>
>      ARM: OMAP2/3: Allow HWMOD to disable clock domains
>
>      Currently when HWMOD attempts to disable a clock domain on OMAP2/3 devices we
>      will return from the function clkdm_hwmod_disable() without actually disabling
>      the clock domain. Per the comment this is deliberate because initially HWMOD
>      OMAP2/3 devices did not support clock domains. However, clock domains are now
>      supported by HWMOD for these devices and so allow HWMOD to disable the clock
>      domains.
>
>      XXX - Tested on OMAP3430 beagle board, but needs more testing on OMAP2/3
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 011186f..8f7a941 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -1075,10 +1075,6 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>    */
>   int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>   {
> -       /* The clkdm attribute does not exist yet prior OMAP4 */
> -       if (cpu_is_omap24xx() || cpu_is_omap34xx())
> -               return 0;
> -
>          /*
>           * XXX Rewrite this code to maintain a list of enabled
>           * downstream hwmods for debugging purposes?
>

