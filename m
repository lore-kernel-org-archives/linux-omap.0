From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RESEND PATCHv2 08/28] ARM: OMAP2+: clockdomain: add usecounting
 support to autoidle APIs
Date: Tue, 14 Jun 2016 09:31:14 +0300
Message-ID: <575FA4B2.70408@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-9-git-send-email-t-kristo@ti.com> <575F4257.3010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <575F4257.3010108@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 14/06/16 02:31, Nishanth Menon wrote:
> On 06/13/2016 02:04 PM, Tero Kristo wrote:
> [..]
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
> b/arch/arm/mach-omap2/omap_hwmod.c
>> index 0c85f91..635a563 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>
> [...]
>
>> @@ -2177,14 +2173,10 @@ static int _enable(struct omap_hwmod *oh)
>>
>>   	r = (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
>>   		-EINVAL;
>> -	if (!r) {
>> -		/*
>> -		 * Set the clockdomain to HW_AUTO only if the target is ready,
>> -		 * assuming that the previous state was HW_AUTO
>> -		 */
>> -		if (oh->clkdm && hwsup)
>> -			clkdm_allow_idle(oh->clkdm);
>> +	if (oh->clkdm)
>> +		clkdm_allow_idle(oh->clkdm);
>
> Should'nt this be under if (!r) ?

No, we must call clkdm_allow_idle() always, otherwise the clockdomain is 
left in force wakeup state for all eternity, which is wrong, and 
prevents any further transitions on the clockdomain. (Most likely the 
failed transition on the hwmod itself is going to prevent idle on the 
clockdomain though, but its better to keep at least the clockdomain 
state sane.)

-Tero

