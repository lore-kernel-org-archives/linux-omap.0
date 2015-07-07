From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] pinctrl: single: dra7: remove PCS_QUIRK_SHARED_IRQ
Date: Tue, 7 Jul 2015 10:23:08 +0300
Message-ID: <559B7E5C.2010204@ti.com>
References: <1436195510-23880-1-git-send-email-grygorii.strashko@ti.com> <20150706152549.GL10705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150706152549.GL10705@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 07/06/2015 06:25 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [150706 08:14]:
>> On DRA7 there is one pinctrl domain (dra7_pmx_core) and
>> PRCM wake-up IRQ is not shared, so remove quirk.
>>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Fixes: 31320beaa3d3 ('pinctrl: single: Add DRA7 pinctrl compatibility')
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/pinctrl/pinctrl-single.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
>> index 0b8d480..9b24b343 100644
>> --- a/drivers/pinctrl/pinctrl-single.c
>> +++ b/drivers/pinctrl/pinctrl-single.c
>> @@ -1983,7 +1983,6 @@ static const struct pcs_soc_data pinctrl_single_omap_wkup = {
>>   };
>>
>>   static const struct pcs_soc_data pinctrl_single_dra7 = {
>> -	.flags = PCS_QUIRK_SHARED_IRQ,
>>   	.irq_enable_mask = (1 << 24),	/* WAKEUPENABLE */
>>   	.irq_status_mask = (1 << 25),	/* WAKEUPEVENT */
>>   };
>
> Tero, care to take a look at this one and ack if OK?

Looks fine to me.

Acked-by: Tero Kristo <t-kristo@ti.com>

>
> Regards,
>
> Tony
>

