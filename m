From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2 5/7] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
Date: Fri, 24 Feb 2012 09:01:57 +0200
Message-ID: <4F4735E5.3070709@compulab.co.il>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com> <1329997247-27342-6-git-send-email-rnayak@ti.com> <4F464CFF.3080006@compulab.co.il> <20120223184751.GX18185@atomide.com> <4F470DDA.7050603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:39642
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751985Ab2BXHCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 02:02:10 -0500
In-Reply-To: <4F470DDA.7050603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

On 02/24/12 06:11, Rajendra Nayak wrote:
> On Friday 24 February 2012 12:17 AM, Tony Lindgren wrote:
>> * Igor Grinberg<grinberg@compulab.co.il>  [120223 05:56]:
>>>> --- a/arch/arm/mach-omap2/board-cm-t35.c
>>>> +++ b/arch/arm/mach-omap2/board-cm-t35.c
>>>> @@ -411,9 +411,9 @@ static struct omap2_hsmmc_info mmc[] = {
>>>>       {
>>>>           .mmc        = 1,
>>>>           .caps        = MMC_CAP_4_BIT_DATA,
>>>> -        .gpio_cd    = -EINVAL,
>>>> +        .gpio_cd    = OMAP_MAX_GPIO_LINES + 0,
>>>>           .gpio_wp    = -EINVAL,
>>
>> I don't have these changes, in my second revision of the patch.
>>
>> It's best not to hardcode the values here.
> 
> Ok, I just though doing it the other way is more round about
> hardcoding where in the board passes a hardcoded value to
> twl4030 gpio driver and the driver passes the *same* hardcoded
> value back to the board callback, which is then populated in
> mmc pdata. The board could as well directly hardcode it in the
> mmc pdata.
> That makes it much more readable than this round about
> hardcoding.
> But I'll go back to the old way if you think thats how we should
> handle this.

The "old" way is preferable. Thanks.

> 
>>
>>>> -
>>>> +        .deferred    = true,
>>>>       },
>>>>       {
>>>>           .mmc        = 2,
>>>> @@ -422,6 +422,7 @@ static struct omap2_hsmmc_info mmc[] = {
>>>>           .gpio_cd    = -EINVAL,
>>>>           .gpio_wp    = -EINVAL,
>>>>           .ocr_mask    = 0x00100000,    /* 3.3V */
>>>> +        .deferred    = true,
>>>
>>> Why do you defer this one?
>>> It does not use external GPIO chip, in fact it does not use CD/WP at all.
>>
>> Why do you have the following then to set gpio_cd?
> 
> There is only one instance of gpio_cd being populated for the
> first element in the array mmc[], which is already deferred.
> 
>>>> -    mmc[0].gpio_cd = gpio + 0;
> 
> Igor was asking about the second element in the array which never
> has gpio_cd populated. Its just initialized to -EINVAL and stays
> that way.

Exactly.

> 
>>
>>>>       },
>>>>       {}    /* Terminator */
>>>>   };
>>>> @@ -469,9 +470,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
>>>>           pr_err("CM-T35: could not obtain gpio for WiFi reset\n");
>>>>       }
>>>>
>>>> -    /* gpio + 0 is "mmc0_cd" (input/IRQ) */
>>>> -    mmc[0].gpio_cd = gpio + 0;
>>>> -    omap2_hsmmc_init(mmc);
>>>> +    omap_hsmmc_deferred_add(mmc);
>>>>
>>>>       return 0;
>>>>   }
>>
>> Hmm I don't have omap_hsmmc_deferred_add() in my second version
>> of the patch either.
>>
>> Rajendra, please do the patches on that, now it's impossible to
>> see what else you've changed. That's the version posted here:
>>
>> http://www.spinics.net/lists/linux-omap/msg64884.html
> 
> Sorry for the mess up. I will make sure I have taken all changes/fixes
> from your reposts.
> 
> regards,
> Rajendra
>>
>>>> @@ -639,6 +638,7 @@ static void __init cm_t3x_common_init(void)
>>>>       omap_serial_init();
>>>>       omap_sdrc_init(mt46h32m32lf6_sdrc_params,
>>>>                    mt46h32m32lf6_sdrc_params);
>>>> +    omap_hsmmc_init(mmc);
>>>>       cm_t35_init_i2c();
>>>>       omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
>>>>       cm_t35_init_ethernet();
>>>
>>> Other then the comment above, looks fine.
>>> I will probably be able to test this on Sunday.
>>
>> OK
>>
>>>> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
>>>> index a59ace0..11a6aa4 100644
>>>> --- a/arch/arm/mach-omap2/board-igep0020.c
>>>> +++ b/arch/arm/mach-omap2/board-igep0020.c
>>>> @@ -293,8 +293,9 @@ static struct omap2_hsmmc_info mmc[] = {
>>>>       {
>>>>           .mmc        = 1,
>>>>           .caps        = MMC_CAP_4_BIT_DATA,
>>>> -        .gpio_cd    = -EINVAL,
>>>> +        .gpio_cd    = OMAP_MAX_GPIO_LINES + 0,
>>>>           .gpio_wp    = -EINVAL,
>>>> +        .deferred    = true,
>>>>       },
>>>>   #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
>>>>       {
>>>> @@ -302,6 +303,7 @@ static struct omap2_hsmmc_info mmc[] = {
>>>>           .caps        = MMC_CAP_4_BIT_DATA,
>>>>           .gpio_cd    = -EINVAL,
>>>>           .gpio_wp    = -EINVAL,
>>>> +        .deferred    = true,
>>>
>>> same here, why defer it?
>>
>> Because it too sets gpio_cd in the callback.

Well, not this array element...

>>
>>> ditto
>>
>> ditto, that too sets gpio_cd..

Nope... ditto ;)

>>
>>>>       },
>>>>   #endif
>>>>       {}    /* Terminator */
>>>> @@ -360,10 +362,8 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
>>>>   {
>>>>       int r, lcd_bl_en;
>>>>
>>>> -    /* gpio + 0 is "mmc0_cd" (input/IRQ) */
>>>>       omap_mux_init_gpio(63, OMAP_PIN_INPUT);
>>>> -    mmc[0].gpio_cd = gpio + 0;
>>
>> ..here. Same for the others. So maybe check is some are wrong?

I failed parsing the question...
Here only the first array element gets the gpio_cd value set.


-- 
Regards,
Igor.
