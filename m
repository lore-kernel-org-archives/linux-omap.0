From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: dmtimer: cleanup fclk usage
Date: Mon, 16 Apr 2012 22:51:23 +0200
Message-ID: <4F8C864B.4090101@ti.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-4-git-send-email-tarun.kanti@ti.com> <alpine.DEB.2.00.1204161034290.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58922 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab2DPUv2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 16:51:28 -0400
In-Reply-To: <alpine.DEB.2.00.1204161034290.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

On 4/16/2012 6:40 PM, Paul Walmsley wrote:
> Hi
>
> a few comments
>
> On Mon, 16 Apr 2012, Tarun Kanti DebBarma wrote:

...

>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 5d7a0ee..9459d70 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -164,8 +164,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>>   		return -ENXIO;
>>
>>   	/* After the dmtimer is using hwmod these clocks won't be needed */
>> -	sprintf(name, "gpt%d_fck", gptimer_id);
>> -	timer->fclk = clk_get(NULL, name);
>> +	timer->fclk = clk_get(NULL, oh->main_clk);
>>   	if (IS_ERR(timer->fclk))
>>   		return -ENODEV;
>
> If you find yourself accessing struct omap_hwmod structure fields
> directly, something is almost certainly wrong; and this case is not an
> exception.  Since the omap_device code is defining an "fck" alias to the
> main_clk, all you should need to do is:
>
> -     sprintf(name, "gpt%d_fck", gptimer_id);
> -     timer->fclk = clk_get(NULL, name);
> +     timer->fclk = clk_get(NULL, "fck");

Are you sure that's the same in that case?
"timer1_fck" is an unique entry in the clkdev table whereas there are a 
bunch of clock nodes with the "fck" alias local to a device.
Without the proper dev_id, there is no way to guaranty we will get the 
timer fck clock alias.

Since that code is executed pretty early before there is any device, 
accessing directly the hwmod entry seems to be the only method to get 
the proper clock without having to provide again the full clock name.

AFAIR, the "fck" alias is created during the omap_device creation, so I 
guess it is too early here to have it.

To be honest I'm always a little bit confused with that early code, but 
it looks like there is no device at all in that early part of the code.

Regards,
Benoit
