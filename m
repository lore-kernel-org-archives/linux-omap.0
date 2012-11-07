From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 01/14] ARM: OMAP: Add DMTIMER definitions for posted
 mode
Date: Wed, 7 Nov 2012 16:18:54 -0600
Message-ID: <509ADE4E.6070106@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-2-git-send-email-jon-hunter@ti.com> <509ADAFE.4070109@ti.com> <509ADC99.3020106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58199 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab2KGWS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 17:18:57 -0500
In-Reply-To: <509ADC99.3020106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 07 November 2012 04:11 PM, Jon Hunter wrote:
>
> On 11/07/2012 04:04 PM, Santosh Shilimkar wrote:
>> On Wednesday 07 November 2012 01:01 PM, Jon Hunter wrote:
>>> For OMAP2+ devices, when using DMTIMERs for system timers
>>> (clock-events and
>>> clock-source) the posted mode configuration of the timers is used. To
>>> allow
>>> the compiler to optimise the functions for configuring and reading the
>>> system
>>> timers, the posted flag variable is hard-coded with the value 1. To
>>> make it
>>> clear that posted mode is being used add some definitions so that it
>>> is more
>>> readable.
>>>
>>> Add separate definitions for the clock-events and clock-source timers
>>> so that
>>> we can change the posted mode of clock-events and clock-source
>>> independently.
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/timer.c               |   26
>>> +++++++++++++++++++-------
>>>    arch/arm/plat-omap/include/plat/dmtimer.h |    4 ++++
>>>    2 files changed, 23 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>>> index 0758bae..28c6078 100644
>>> --- a/arch/arm/mach-omap2/timer.c
>>> +++ b/arch/arm/mach-omap2/timer.c
>>> @@ -82,6 +82,13 @@
>>>    #define INCREMENTER_DENUMERATOR_RELOAD_OFFSET        0x14
>>>    #define NUMERATOR_DENUMERATOR_MASK            0xfffff000
>>>
>>> +/*
>>> + * For clock-events timer, always use posted mode to
>>> + * minimise CPU overhead for configuring the timer.
>>> + */
>>> +#define OMAP_CLKEVT_POSTEDMODE    OMAP_TIMER_POSTED
>>> +#define OMAP_CLKSRC_POSTEDMODE    OMAP_TIMER_POSTED
>>> +
>> I don't see need of above defines. Just use OMAP_TIMER_POSTED directly
>> with API. Rest of the patch looks fine.
>
> Yes that's possible, however, in patch #2, I am disabling posted mode
> for clock-source (see changelog of patch #2 for details). Having these
> #defines makes it easier to change the posted configuration. That was
> the real motivation here.
>
Sure but that is more confusing because you are flipping
the meaning of the macro. Better to specify direct
argument to avoid the confusion.

Regards
Santosh

