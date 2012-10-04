From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: hwmod: align the SmartReflex fck names
Date: Thu, 4 Oct 2012 18:49:50 +0200
Message-ID: <CAORVsuXqyRSZ7J8XsUC_YhxDRDzc006HU6sqhgA8N5OKU0CESg@mail.gmail.com>
References: <1349279277-7634-1-git-send-email-j-pihet@ti.com>
	<1349279277-7634-2-git-send-email-j-pihet@ti.com>
	<20121003170059.GD4840@atomide.com>
	<87ehlfvzxz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64849 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab2JDQtv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 12:49:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so557544lbo.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 09:49:50 -0700 (PDT)
In-Reply-To: <87ehlfvzxz.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbou@mail.ru>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi Kevin,

On Thu, Oct 4, 2012 at 2:33 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Tony Lindgren <tony@atomide.com> writes:
>
>> * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [121003 08:48]:
>>> @@ -1036,8 +1036,8 @@ static struct omap_clk am33xx_clks[] = {
>>>      CLK("davinci-mcasp.1",  NULL,           &mcasp1_fck,    CK_AM33XX),
>>>      CLK("NULL",     "mmc2_fck",             &mmc2_fck,      CK_AM33XX),
>>>      CLK(NULL,       "mmu_fck",              &mmu_fck,       CK_AM33XX),
>>> -    CLK(NULL,       "smartreflex0_fck",     &smartreflex0_fck,      CK_AM33XX),
>>> -    CLK(NULL,       "smartreflex1_fck",     &smartreflex1_fck,      CK_AM33XX),
>>> +    CLK(NULL,       "smartreflex.0",        &smartreflex_mpu_fck,   CK_AM33XX),
>>> +    CLK(NULL,       "smartreflex.1",        &smartreflex_core_fck,  CK_AM33XX),
>>>      CLK(NULL,       "timer1_fck",           &timer1_fck,    CK_AM33XX),
>>>      CLK(NULL,       "timer2_fck",           &timer2_fck,    CK_AM33XX),
>>>      CLK(NULL,       "timer3_fck",           &timer3_fck,    CK_AM33XX),
>>
>> I think this should be something like this instead:
>>
>>       CLK("smartreflex.0",    "fck",  &smartreflex_mpu_fck,   CK_AM33XX),
>>       CLK("smartreflex.1",    "fck",  &smartreflex_core_fck,  CK_AM33XX),
>>
>> Where the first one is the dev name, the second one is the
>> alias you want to use in the client driver?
>
> Actually, the omap_device creation will create this kind of alias for
> you, with the device name populated etc, so adding device names here
> isn't necessary.
>
> For omap_devices where drivers are always using clk_get(dev, ...),
> the name in the initial clkdev table here really doesn't matter.
>
> However, for core code that needs to do a clk_get(NULL, "name"), then
> this name matters.  In chatting with Paul offline, he mentioned part of
> the CCF conversion will be using clk_get(NULL, ...) on the main_clk
> listed in each hwmod.  For that reason, it's important that this string
> match the name in the hwmod.
That makes it clear. Thanks for looking at it!

> I belive the patch below should make this compatible with any future
> use.
Sure. The driver uses clk_get(dev, "fck") to request the fcuntional
clock of the device.


> Jean, can you fold this into $SUBJECT patch?
Sure!

I just re-sent a new version of the 2 patches.

>
> Thanks,
>
> Kevin

Thanks,
Jean

>
>
> diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
> index 6de3dc7..8a16504 100644
> --- a/arch/arm/mach-omap2/clock33xx_data.c
> +++ b/arch/arm/mach-omap2/clock33xx_data.c
> @@ -1034,8 +1034,8 @@ static struct omap_clk am33xx_clks[] = {
>         CLK("davinci-mcasp.1",  NULL,           &mcasp1_fck,    CK_AM33XX),
>         CLK("NULL",     "mmc2_fck",             &mmc2_fck,      CK_AM33XX),
>         CLK(NULL,       "mmu_fck",              &mmu_fck,       CK_AM33XX),
> -       CLK(NULL,       "smartreflex.0",        &smartreflex_mpu_fck,   CK_AM33XX),
> -       CLK(NULL,       "smartreflex.1",        &smartreflex_core_fck,  CK_AM33XX),
> +       CLK(NULL,       "smartreflex_mpu_fck",  &smartreflex_mpu_fck,   CK_AM33XX),
> +       CLK(NULL,       "smartreflex_core_fck", &smartreflex_core_fck,  CK_AM33XX),
>         CLK(NULL,       "timer1_fck",           &timer1_fck,    CK_AM33XX),
>         CLK(NULL,       "timer2_fck",           &timer2_fck,    CK_AM33XX),
>         CLK(NULL,       "timer3_fck",           &timer3_fck,    CK_AM33XX),
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index a197cf2..191d261 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3447,8 +3447,8 @@ static struct omap_clk omap3xxx_clks[] = {
>         CLK(NULL,       "atclk_fck",    &atclk_fck,     CK_3XXX),
>         CLK(NULL,       "traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
>         CLK(NULL,       "traceclk_fck", &traceclk_fck,  CK_3XXX),
> -       CLK(NULL,       "smartreflex.0",        &smartreflex_mpu_iva_fck,       CK_34XX | CK_36XX),
> -       CLK(NULL,       "smartreflex.1",        &smartreflex_core_fck,  CK_34XX | CK_36XX),
> +       CLK(NULL,       "smartreflex_mpu_iva_fck", &smartreflex_mpu_iva_fck,    CK_34XX | CK_36XX),
> +       CLK(NULL,       "smartreflex_core_fck", &smartreflex_core_fck,  CK_34XX | CK_36XX),
>         CLK(NULL,       "sr_l4_ick",    &sr_l4_ick,     CK_34XX | CK_36XX),
>         CLK(NULL,       "secure_32k_fck", &secure_32k_fck, CK_3XXX),
>         CLK(NULL,       "gpt12_fck",    &gpt12_fck,     CK_3XXX),
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 9cc1112..19e0c1e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3224,8 +3224,8 @@ static struct omap_clk omap44xx_clks[] = {
>         CLK(NULL,       "slimbus2_fclk_0",              &slimbus2_fclk_0,       CK_443X),
>         CLK(NULL,       "slimbus2_slimbus_clk",         &slimbus2_slimbus_clk,  CK_443X),
>         CLK(NULL,       "slimbus2_fck",                 &slimbus2_fck,  CK_443X),
> -       CLK(NULL,       "smartreflex.0",                &smartreflex_core_fck,  CK_443X),
> -       CLK(NULL,       "smartreflex.1",                &smartreflex_iva_fck,   CK_443X),
> +       CLK(NULL,       "smartreflex_core_fck",         &smartreflex_core_fck,  CK_443X),
> +       CLK(NULL,       "smartreflex_mpu_fck",          &smartreflex_iva_fck,   CK_443X),
>         CLK(NULL,       "smartreflex.2",                &smartreflex_mpu_fck,   CK_443X),
>         CLK(NULL,       "timer1_fck",                   &timer1_fck,    CK_443X),
>         CLK(NULL,       "timer10_fck",                  &timer10_fck,   CK_443X),
