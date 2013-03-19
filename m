From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: clocks: Pass static parent pointers
 to common clock core
Date: Tue, 19 Mar 2013 10:46:50 +0530
Message-ID: <5147F4C2.5050307@ti.com>
References: <1363264618-5071-1-git-send-email-rnayak@ti.com> <1363264618-5071-3-git-send-email-rnayak@ti.com> <20130314170601.GH26093@atomide.com> <514313B6.4050905@ti.com> <20130315162049.GB9370@atomide.com> <5146CE5B.6090705@ti.com> <20130318163757.GD9462@atomide.com> <20130319012340.8663.43189@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35100 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab3CSFRH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 01:17:07 -0400
In-Reply-To: <20130319012340.8663.43189@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Tuesday 19 March 2013 06:53 AM, Mike Turquette wrote:
> Quoting Tony Lindgren (2013-03-18 09:37:58)
>> * Rajendra Nayak <rnayak@ti.com> [130318 01:25]:
>>> On Friday 15 March 2013 09:50 PM, Tony Lindgren wrote:
>>>> * Rajendra Nayak <rnayak@ti.com> [130315 05:31]:
>>>>> On Thursday 14 March 2013 10:36 PM, Tony Lindgren wrote:
>>>>>> * Rajendra Nayak <rnayak@ti.com> [130314 05:44]:
>>>>>>> OMAP clock inits happen quite early, even before the slab is available.
>>>>>>> As part of the clock init, the common clock core tries to cache parent
>>>>>>> pointers (if not passed by the caller registering the clock) which
>>>>>>> fails in case of OMAP since the slab isn't initied.
>>>>>>> Without CONFIG_DEBUG_SLAB enabled, this just results in the common clock core
>>>>>>> retrying the caching attempt at some point later.
>>>>>>> However with CONFIG_DEBUG_SLAB enabled this results in a BUG() as reported
>>>>>>> in the link below by Tony..
>>>>>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85932.html
>>>>>>>
>>>>>>> Fix this by passing static parent pointers to the common clock core
>>>>>>> while registering clocks.
>>>>>>
>>>>>> I wonder if we could easily fix this by initializing only some of the
>>>>>> clocks that early?
>>>>>
>>>>> We actually don't need any clocks that early (I mean even before slab init)
>>>>> We only need them before timer init.
>>>>
>>>> Yes and only the timer clocks at that point. The others could be initialized
>>>> later on so we get console error messages without having to turn on DEBUG_LL
>>>> and earlyprintk.
>>>
>>> but that wouldn't be possible with the hwmod dependency on clocks. We would
>>> need to move the hwmod inits further down too.
>>>
>>>>  
>>>>> This isn't something specific to OMAP so I started looking at what others
>>>>> in drivers/clk seem to do.
>>>>>
>>>>> I found imx, spear, mvebu all do their clk inits within .init_time callbacks.
>>>>> tegra seems to even do it within .init_irq callback.
>>>>>
>>>>> Either one would work for us too :)
>>>>
>>>> Well I suggest init_irq as that's when we need the first clocks for timer.
>>>
>>> For which platforms? I instead see them being needed only by init_timer, so
>>> was thinking thats a better place instead.
>>>
>>> For the -rc fix to fix the crash with DEBUG_SLAB, is it fine if I move *all*
>>> clock inits down to init_timer (or init_irq).
>>
>> Sounds good to me for the -rc series. How about initialize omap_clk_init()
>> function pointer in the SoC specific omap*_init_early() then just call
>> omap_clk_init() in timer_init?
>>  
>>> Splitting clocks alone would not work for now, without hwmod being moved down also.
>>
>> Good point. For the -rc series the sounds like your suggestion is the
>> least intrusive fix and also gets us started removing few more early
>> boot time dependencies.
>>
> 
> +1 for removing the early init dependencies.  hwmod initialization was
> the original impetus for all this static struct clk stuff.  If the
> initialization for hwmod and the omap clocks can be moved to a later
> callback then it is the first step in removing the static data and
> getting rid of clk-private.h usage.

I am working on that stuff to get rid of the dependency on clk-private.h
Will post some RFC soon once I have omap4 working and if the approach seems
fine, will move over all of omap so you can delete the clk-private.h
completely :)

> 
> Regards,
> Mike
> 
>> Regards,
>>
>> Tony

