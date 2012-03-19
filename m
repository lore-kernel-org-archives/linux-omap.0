From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
Date: Mon, 19 Mar 2012 15:23:14 +0100
Message-ID: <4F674152.5040008@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com> <1330707024-23730-2-git-send-email-b-cousson@ti.com> <87pqcegapk.fsf@ti.com> <87k42metna.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36328 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965Ab2CSOXV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 10:23:21 -0400
In-Reply-To: <87k42metna.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com
Cc: Kevin Hilman <khilman@ti.com>, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Samuel,

On 3/14/2012 10:53 PM, Kevin Hilman wrote:
> Kevin Hilman<khilman@ti.com>  writes:
>
>> Benoit Cousson<b-cousson@ti.com>  writes:
>>
>>> From: Felipe Balbi<balbi@ti.com>
>>>
>>> With sparse IRQs the driver shouldn't depend at all on
>>> any IRQ values coming from board-file.
>>>
>>> Remove every occurences of pdata->irq_base/end.
>>
>> Well, not quite *every*. :)
>>
>> If the driver isn't going to use those fields anymore, they should also
>> be removed from the pdata struct too[1].  Also, the remaining board/init
>> code that is initializing those fields should be removed as well[2], since
>> it obviously has no effect.
>>
>> The first patch below should probably be folded into this one, and then
>> the 2nd patch removes all the users.
>
> Below is a correct version of the 2nd patch which removes all the users.
>
> The previous version wouldn't apply cleanly because I generated it on
> top of a local branch that also included some other changes to
> twl-common.c from the SMPS regulator series (which seems to have missed
> the window for v3.4.)
>
> This one applies cleanly on your for_3.4/twl_irq_gpio_mmc_fix branch.

After discussing with Kevin, we think it might be better to wait 3.5 for 
this further cleanup patches.
These patches will need some patches already queued by Tony to avoid 
breaking OMAP build.
In order to reduce dependency, let's push them for 3.5.

You can the pull the current branch.

Thanks,
Benoit

>
> Kevin
>
>  From b59a4754fb66f6f729ebbd0563c4cd2bd2cda56e Mon Sep 17 00:00:00 2001
> From: Kevin Hilman<khilman@ti.com>
> Date: Wed, 14 Mar 2012 13:56:01 -0700
> Subject: [PATCH] ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end
>
> The driver has been converted to use SPARSE_IRQ and no longer needs to
> be passed IRQ base/end.  The driver no longer uses these fields, so
> remove them from the reamaining users.
>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/board-2430sdp.c    |    3 ---
>   arch/arm/mach-omap2/board-omap3logic.c |    3 ---
>   arch/arm/mach-omap2/twl-common.c       |   10 ----------
>   3 files changed, 16 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index 7370983..7dfcb96 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -218,9 +218,6 @@ static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
>   };
>
>   static struct twl4030_platform_data sdp2430_twldata = {
> -	.irq_base	= TWL4030_IRQ_BASE,
> -	.irq_end	= TWL4030_IRQ_END,
> -
>   	/* platform_data for children goes here */
>   	.gpio		=&sdp2430_gpio_data,
>   	.vmmc1		=&sdp2430_vmmc1,
> diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
> index 4198dd0..0b053b4 100644
> --- a/arch/arm/mach-omap2/board-omap3logic.c
> +++ b/arch/arm/mach-omap2/board-omap3logic.c
> @@ -85,9 +85,6 @@ static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
>   };
>
>   static struct twl4030_platform_data omap3logic_twldata = {
> -	.irq_base	= TWL4030_IRQ_BASE,
> -	.irq_end	= TWL4030_IRQ_END,
> -
>   	/* platform_data for children goes here */
>   	.gpio		=&omap3logic_gpio_data,
>   	.vmmc1		=&omap3logic_vmmc1,
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 10b20c6..ce349ac 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -129,11 +129,6 @@ static struct regulator_init_data omap3_vpll2_idata = {
>   void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
>   				  u32 pdata_flags, u32 regulators_flags)
>   {
> -	if (!pmic_data->irq_base)
> -		pmic_data->irq_base = TWL4030_IRQ_BASE;
> -	if (!pmic_data->irq_end)
> -		pmic_data->irq_end = TWL4030_IRQ_END;
> -
>   	/* Common platform data configurations */
>   	if (pdata_flags&  TWL_COMMON_PDATA_USB&&  !pmic_data->usb)
>   		pmic_data->usb =&omap3_usb_pdata;
> @@ -287,11 +282,6 @@ static struct regulator_init_data omap4_clk32kg_idata = {
>   void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
>   				  u32 pdata_flags, u32 regulators_flags)
>   {
> -	if (!pmic_data->irq_base)
> -		pmic_data->irq_base = TWL6030_IRQ_BASE;
> -	if (!pmic_data->irq_end)
> -		pmic_data->irq_end = TWL6030_IRQ_END;
> -
>   	/* Common platform data configurations */
>   	if (pdata_flags&  TWL_COMMON_PDATA_USB&&  !pmic_data->usb)
>   		pmic_data->usb =&omap4_usb_pdata;

