From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/4] ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
Date: Tue, 17 Feb 2015 15:56:56 +0200
Message-ID: <54E348A8.4040504@ti.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<54E30972.4020107@ti.com> <CAMdRc4GkmqqbrBQHWvYTySWLvdz0wROfhGBsBe5iqnq2QdhQRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54615 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbbBQN5J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Feb 2015 08:57:09 -0500
In-Reply-To: <CAMdRc4GkmqqbrBQHWvYTySWLvdz0wROfhGBsBe5iqnq2QdhQRg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Cc: khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>

On 17/02/15 15:48, Robert Abel wrote:
> Hi Roger,
> 
> On Tue, Feb 17, 2015 at 10:27 AM, Roger Quadros <rogerq@ti.com> wrote:
>>
>> Can you please point out which DT had used this pre-divided workaround? We will have to
>> fix those then.
> 
> I didn't check. A cursory glance reveals all DTS in arch/arm/boot/dts
> to use a value of 0.
> 
>>
>> Can you please rebase your patches on top of v3.19?
>> gpmc.c has been moved to drivers/memory/omap-gpmc.c
> 
> 
> Will do.
> 
>>
>> So all the below occurrences of "unsigned int clk_sel" become "enum gpmc_clksel".
> 
> Yes, I should have opted for a cleaner solution from the start.
> 
>>> +static unsigned int gpmc_ns_to_clk_ticks(unsigned int time_ns, int cs, unsigned int clk_sel)
>>>  {
>>>       unsigned long tick_ps;
>>>
>>>       /* Calculate in picosecs to yield more exact results */
>>> -     tick_ps = gpmc_get_fclk_period();
>>> +     tick_ps = gpmc_get_clk_period(cs, clk_sel);
>>>
>>>       return (time_ns * 1000 + tick_ps - 1) / tick_ps;
>>>  }
>>>
>>> +static unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
>>> +{
>>> +     return gpmc_ns_to_clk_ticks(time_ns, 0, GPMC_FCLK);
>>
>> This function should have been unchanged since we're dealing with GPMC_FCLK
>> and it was using gpmc_get_fclk_period().
> 
> 
> Which function? gpmc_ns_to_ticks? It still uses FCLK. I merely did not
> want to have the picosecond formula in two places. I don't see a good
> reason to do so now either...

Agree with you. I missed to see earlier that it was getting rid of the
picosecond formula.

> 
>>
>> Let's call this GPMC_SET_ONE_CLKSEL()
> 
> 
> Will do.
> 
> 
>>
>> You will also need to correct gpmc_cs_show_timings() to show the
>> correct timing for "wait-monitoring-ns" based on GPMC_CLK.
> 
> 
> I was working off 3.14, checked if it worked for 3.17, so both didn't
> have gpmc_cs_show_timings. I'll take a look.
> 
Thanks.

cheers,
-roger

