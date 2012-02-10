From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: GPMC in HWMOD (and a related AM335X issue)
Date: Fri, 10 Feb 2012 03:51:32 +0100
Message-ID: <4F348634.8040909@ti.com>
References: <1328790544-4423-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54109 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381Ab2BJCve (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 21:51:34 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1A2pXkH018373
	for <linux-omap@vger.kernel.org>; Thu, 9 Feb 2012 20:51:33 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1A2pXQv025039
	for <linux-omap@vger.kernel.org>; Thu, 9 Feb 2012 20:51:33 -0600 (CST)
In-Reply-To: <1328790544-4423-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, hvaibhav@ti.com, nsekhar@ti.com

Hi Mohammed,

On 2/9/2012 1:29 PM, Afzal Mohammed wrote:
> Hi,
>
> OMAP HWMOD currently does not have GPMC adapted to it.
>
> We are facing a problem indirectly related to it in the case of
> AM335X SoC. It can reuse GPMC code of OMAP except that base address
> &  IRQ# is different. But we get a kernel crash without
> (at least) following change
>
> -------------------------------------------------------------------
>      arm:omap:gpmc: am33xx base address
>
>      GPMC base address of AM335X SoC is same as that of OMAP44XX,
>      update it (eventhough AM33XX is a member of OMAP34XX family)
>      Without this change, Kernel would crash for AM335X
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index dfffbbf..4ee2e90 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -711,7 +711,10 @@ static int __init gpmc_init(void)
>                  gpmc_irq = INT_34XX_GPMC_IRQ;
>          } else if (cpu_is_omap34xx()) {
>                  ck = "gpmc_fck";
> -               l = OMAP34XX_GPMC_BASE;
> +               if (cpu_is_am33xx())
> +                       l = OMAP44XX_GPMC_BASE;
> +               else
> +                       l = OMAP34XX_GPMC_BASE;
>                  gpmc_irq = INT_34XX_GPMC_IRQ;
>          } else if (cpu_is_omap44xx()) {
>                  ck = "gpmc_ck";
> -------------------------------------------------------------------
>
> But the above is not sufficient, even the IRQ # has to be changed
> And for that we need to feed the proper IRQ # too. Now if it was a
> HWMOD device, we could have passed it in HWMOD database&  it would
> have been taken care. Other option is to have a new AM335X specific
> IRQ header file (which, if my understanding is correct, we can't get
> into mainline as HWMOD is present for OMAP&  due to DT things)
>
> HWMOD entries currently does contain GPMC, is it due to the reason that
> GPMC is not yet adapted to omap_device / omap_hwmod or is there any
> other reason for not having it in HWMOD (as GPMC not yet a driver?)

Yes, that's the reason.
Nobody had the time to update that driver yet to omap_device and thus we 
did not create the hwmod entry for it.
And since we do not use the GPMC on OMAP4 boards, we did not have some 
good way to test any change on this driver.

Do not hesitate to update that driver and add the DT support if you want:-)

Regards,
Benoit
