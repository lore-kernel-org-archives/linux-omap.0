From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 03/18] ARM: OMAP4+: PM: Consolidate and use OMAP4 PM
 code for OMAP5
Date: Thu, 4 Apr 2013 17:25:31 +0530
Message-ID: <515D6A33.1050405@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-4-git-send-email-santosh.shilimkar@ti.com> <87li8zwel4.fsf@linaro.org> <515D6957.5000802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756978Ab3DDLxa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 07:53:30 -0400
In-Reply-To: <515D6957.5000802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 05:21 PM, Santosh Shilimkar wrote:
> On Thursday 04 April 2013 01:50 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> OMAP5 has backward compatible PRCM block and it's programming
>>> model is mostly similar to OMAP4. Same is going to be maintained
>>> for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
>>> management code so that it can be re-used on OMAP5 and later devices.
>>>
>>> With consolidated code, let basic power management code build
>>> for OMAP5 devices. While at it, update the kernel-doc for omap4_pm_init().
>>>
>>> Acked-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/Makefile                       |    9 ++--
>>>  arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   54 ++++++++++++++++----
>>>  .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
>>>  3 files changed, 49 insertions(+), 14 deletions(-)
>>>  rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (86%)
>>>  rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)
>>>
> 
> [..]

>>>  
>>>  /**
>>> - * omap4_pm_init - Init routine for OMAP4 PM
>>> + * omap4_init_static_deps - Add OMAP4 static dependencies
>>>   *
>>> - * Initializes all powerdomain and clockdomain target states
>>> - * and all PRCM settings.
>>> + * Add needed static clockdomain dependencies on OMAP4 devices.
>>> + * Return: 0 on success or 'err' on failures
>>>   */
>>> -int __init omap4_pm_init(void)
>>> +static inline int omap4_init_static_deps(void)
>>
>> You dropped the __init here, but it's still only called from another
>> __init function, so I suspect it should stay.
>>
> Yep. Will keep that in next version.
> 
I was too quick to respond. The function is "static inline" so
there is no need to add __init here.

Regards,
Santosh

