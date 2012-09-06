From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 00/10] ARM: OMAP: DMTIMER fixes and clean-up
Date: Thu, 6 Sep 2012 09:30:56 -0500
Message-ID: <5048B3A0.5090108@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com> <50489DEB.9010709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59963 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab2IFObA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 10:31:00 -0400
In-Reply-To: <50489DEB.9010709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 09/06/2012 07:58 AM, Vaibhav Hiremath wrote:
> 
> 
> On 9/6/2012 12:34 AM, Jon Hunter wrote:
>> This series includes several fixes for the OMAP DMTIMER driver and a few
>> clean-ups to simplify some of the code. This series is based upon 3.6-rc4.
>>
>> Tested on OMAP5912 OSK, OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda.
>> Testing includes ...
>> 1. Booting kernel on above boards
>> 2. Set date and ensuring time of day is correct after 24 hours
>> 3. Checking the timer counter is incrementing when configuring and starting
>>    a timer
>> 4. Checking the timer overflow interrupt when timer expires.
>> 5. Using different clock sources to operate the timer with.
>> 6. Running a loop test overnight that continually runs test #3 and #4 for
>>    each available timer
>>
> 
> On the other hand I have validated this patch-series on both AM37xEVM
> and BeagleBone platform. I used the test code which you shared with me
> to validate it.

Thanks!

> AM33XX Clock tree needs minor change here,
> 
> diff --git a/arch/arm/mach-omap2/clock33xx_data.c
> b/arch/arm/mach-omap2/clock33xx_data.c
> index a4006b2..daa36a5 100644
> --- a/arch/arm/mach-omap2/clock33xx_data.c
> +++ b/arch/arm/mach-omap2/clock33xx_data.c
> @@ -1070,6 +1070,8 @@ static struct omap_clk am33xx_clks[] = {
>         CLK(NULL,       "gfx_fck_div_ck",       &gfx_fck_div_ck,
> CK_AM33XX),
>         CLK(NULL,       "sysclkout_pre_ck",     &sysclkout_pre_ck,
> CK_AM33XX),
>         CLK(NULL,       "clkout2_ck",           &clkout2_ck,    CK_AM33XX),
> +       CLK(NULL,       "timer_32k_ck",         &clkdiv32k_ick, CK_AM33XX),
> +       CLK(NULL,       "timer_sys_ck",         &sys_clkin_ck,  CK_AM33XX),
>  };
> 
>  int __init am33xx_clk_init(void)

Ok, do you plan to submit this? If I need to do a V2 of this series, I
can include this one too.

Cheers
Jon
