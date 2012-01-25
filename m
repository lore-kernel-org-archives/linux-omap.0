From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: Clock: Force a DPLL clkdm/pwrdm ON before a relock
Date: Wed, 25 Jan 2012 23:08:54 +0100
Message-ID: <4F207D76.9070707@ti.com>
References: <1327000976-30912-1-git-send-email-ameya.palande@ti.com> <CAHFNHeWH24iSwumFKwjB+8Tx=+t-XbWjO5YqzH2R9ta0FZWvAQ@mail.gmail.com> <CAHFNHeVXNNnZc=kLV2zrur6D3uVd5SKwog57ZEUMbWZbQo9mBA@mail.gmail.com> <alpine.DEB.2.00.1201251205220.5324@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53654 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab2AYWI7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 17:08:59 -0500
In-Reply-To: <alpine.DEB.2.00.1201251205220.5324@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Palande, Ameya" <ameya.palande@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

Hi Paul,

On 1/25/2012 8:05 PM, Paul Walmsley wrote:
> Hi
>
> On Tue, 24 Jan 2012, Palande, Ameya wrote:
>
>> Any update on this?
>
> Looks good to me, but have the scripts been updated?

Nope. The clkdm was never populated for DPLL in OMAP4 so far. We will 
have to add that extra parameters to every DPLLs in theory if we want to 
be consistent.

Hopefully, the information is available in the data source, so this is 
just a matter of printing it in the DPLL node template.

Regards,
Benoit

>
> Also could you please cc linux-arm-kernel@lists.infradead.org?
>
> - Paul
>
>>
>> On Fri, Jan 20, 2012 at 11:53 AM, Palande, Ameya<ameya.palande@ti.com>  wrote:
>>> Any update on this?
>>>
>>> On Thu, Jan 19, 2012 at 11:22 AM, Ameya Palande<ameya.palande@ti.com>  wrote:
>>>> From: Rajendra Nayak<rnayak@ti.com>
>>>>
>>>> All DPLLs except USB are in ALWON powerdomain. Make sure the
>>>> clkdm/pwrdm for USB DPLL (l3init) is turned on before attempting
>>>> a DPLL relock. So, mark the database accordingly.
>>>>
>>>> Without this fix, it was seen that DPLL relock fails while testing
>>>> relock in a loop of USB DPLL.
>>>>
>>>> CC: Nishanth Menon<nm@ti.com>
>>>> Tested-by: Ameya Palande<ameya.palande@ti.com>
>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>>> ---
>>>>   arch/arm/mach-omap2/clock44xx_data.c |    1 +
>>>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
>>>> index 08e86d7..9519374 100644
>>>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>>>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>>>> @@ -974,6 +974,7 @@ static struct clk dpll_usb_ck = {
>>>>         .recalc         =&omap3_dpll_recalc,
>>>>         .round_rate     =&omap2_dpll_round_rate,
>>>>         .set_rate       =&omap3_noncore_dpll_set_rate,
>>>> +       .clkdm_name     = "l3_init_clkdm",
>>>>   };
>>>>
>>>>   static struct clk dpll_usb_clkdcoldo_ck = {
>>>> --
>>>> 1.7.4.1
>>>>
>>
>
>
> - Paul

