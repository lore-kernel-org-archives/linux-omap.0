From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP4: suspend: Do not get dsp/tesla out of
 reset
Date: Tue, 28 Feb 2012 11:04:51 +0530
Message-ID: <4F4C677B.4020501@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>	<1330003320-17400-6-git-send-email-t-kristo@ti.com> <87ehtfssx7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43195 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752033Ab2B1Fe5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 00:34:57 -0500
Received: by mail-yw0-f45.google.com with SMTP id o21so935945yho.32
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 21:34:56 -0800 (PST)
In-Reply-To: <87ehtfssx7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Tuesday 28 February 2012 05:58 AM, Kevin Hilman wrote:
> Tero Kristo<t-kristo@ti.com>  writes:
>
>> From: Rajendra Nayak<rnayak@ti.com>
>>
>> With no driver handling DSP/TESLA, if brought out of reset, it stays
>> active and does not assert standby.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>
> Subject says 'OMAP4: suspend'.  How does HWMOD_INIT_NO_RESET affect
> suspend?

The v2 of this patch posted by Tero has a better $subject as suggested
by Benoit which says 'ARM: OMAP4: hwmod_data: Do not get DSP out of
reset at boot time'

The intention of this patch is to *not* get DSP out of reset at boot,
because once out of reset DSP needs some code that executes a 'wfi'
equivalent for it to assert a standby and allow suspend to sleep.

regards,
Rajendra

>
> Kevin
>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index ef0524c..81d90da 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -1160,6 +1160,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
>>   	.name		= "dsp",
>>   	.class		=&omap44xx_dsp_hwmod_class,
>>   	.clkdm_name	= "tesla_clkdm",
>> +	.flags		= HWMOD_INIT_NO_RESET,
>>   	.mpu_irqs	= omap44xx_dsp_irqs,
>>   	.rst_lines	= omap44xx_dsp_resets,
>>   	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),

