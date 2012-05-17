From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for device-tree
Date: Thu, 17 May 2012 11:00:20 -0500
Message-ID: <4FB52094.6080707@ti.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com> <4FB37356.9040001@ti.com> <4FB40AB5.10302@ti.com> <CAC83ZvK4MHbtY5xrw3RoVgLvGNVToDonXWibS49H+j0yKh2MfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59468 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060Ab2EQQA2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 12:00:28 -0400
In-Reply-To: <CAC83ZvK4MHbtY5xrw3RoVgLvGNVToDonXWibS49H+j0yKh2MfQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Tarun,

On 05/17/2012 12:07 AM, DebBarma, Tarun Kanti wrote:
> On Thu, May 17, 2012 at 1:44 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>> Hi Benoit,
>>
>> On 05/16/2012 04:28 AM, Cousson, Benoit wrote:
>>> Hi Jon,
>>>
>>> On 5/16/2012 1:35 AM, Jon Hunter wrote:
>>>> From: Jon Hunter<jon-hunter@ti.com>
>>>>
>>>> In order to migrate the dmtimer driver to support device-tree I found
>>>> that it
>>>> was first necessary to clean-up the timer platform data. The goal of this
>>>> series is to simplify the timer platform data structure from ...
>>>>
>>>> struct dmtimer_platform_data {
>>>>     int (*set_timer_src)(struct platform_device *pdev, int source);
>>>>     int timer_ip_version;
>>>>     u32 needs_manual_reset:1;
>>>>     bool reserved;
>>>>     bool loses_context;
>>>>     int (*get_context_loss_count)(struct device *dev);
>>>> };
>>>>
>>>> to ...
>>>>
>>>> struct dmtimer_platform_data {
>>>>     int (*set_timer_src)(struct platform_device *pdev, int source);
>>>
>>> I guess that custom set_timer_src should not be there at all anymore.
>>> Well at least for OMAP2+.
>>> We should just use the regular clock API to change the parent. I do not
>>> see why we should add that wrapper on top of the clock API and thus
>>> store some internal clock name inside the timer device init code.
> Whatever is done within omap2_dm_timer_set_src() in mach-omap2/timer.c
> can be implemented inside omap_dm_timer_set_source() in plat-omap/dmtimer.c
> directly whereby we continue to use the generic clock APIs provided in
> include/linux/clk.h.

Have you looked at the OMAP1 code for this?

Today it is not using the clock framework at all. So first we need to
change the OMAP1 code to use the clock framework for dmtimers and then
we can move the function.

>> I have been looking into this and in order to get rid for the above
>> function pointer we would need to move at a minimum the following
>> functions from omap-mach2/clkt_clksel.c into the platform code.
>>
>> _get_clksel_by_parent()
>> _get_div_and_fieldval()
>> _write_clksel_reg()
>> omap2_init_clksel_parent()
>> omap2_clksel_set_parent()
>>
>> However, it may be simpler just to move the clkt_clksel.c file
>> completely. I have tested the above functions on omap1 and they are
>> working well. However, before doing this we would need to get Paul's
>> buy-in that this is the right thing to do.
> I am not sure if this is really needed though.

It is needed so that OMAP1 can use the clksel functions and so we can
migrate OMAP1 and OMAP2+ to use a common function for changing the
parent clock.

Cheers
Jon
