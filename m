From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: OMAP* Latest build failures
Date: Wed, 28 Nov 2012 15:43:35 -0600
Message-ID: <50B68587.3050200@ti.com>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk> <20121117093307.GL3332@n2100.arm.linux.org.uk> <20121120175733.GH18567@atomide.com> <50AC0B83.9070704@ti.com> <20121128151814.GZ3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33375 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755182Ab2K1Vno (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 16:43:44 -0500
In-Reply-To: <20121128151814.GZ3332@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Radhesh Fadnis <radhesh.fadnis@ti.com>


On 11/28/2012 09:18 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 20, 2012 at 05:00:19PM -0600, Jon Hunter wrote:
>>
>> On 11/20/2012 11:57 AM, Tony Lindgren wrote:
>>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121117 01:35]:
>>>> On Wed, Nov 14, 2012 at 09:26:43AM +0000, Russell King - ARM Linux wrote:
>>>>> OMAP* allnoconfig fails:
>>>>>
>>>>> arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
>>>>> twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
>>>>> arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
>>>>> twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
>>>>> arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
>>>>> twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
>>>>> arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
>>>>> twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
>>>>> arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
>>>>> twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
>>>>> arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
>>>>> twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
>>>>> arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
>>>>> twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'
>>>>
>>>> These are now gone, but we have a new warning:
>>>>
>>>> arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used
>>>
>>> Jon, care to fix this one?
>>
>> Fix already available here [1]. I actually included this in my latest
>> pull request with some other timer clean-ups [2]. Let me know if you are
>> ok with this being part of this pull request or if you want to handle
>> this separately.
>>
>> Cheers
>> Jon
>>
>> [1] http://marc.info/?l=linux-omap&m=135300866115036&w=2
>> [2] http://marc.info/?l=linux-omap&m=135308624321232&w=2
> 
> Well, it's now two weeks on, and the warning is still there... what's going
> on?  Why aren't fixes propagating upstream?

I saw a pull request from Tony on Monday night [1], however, does not
appear to have made its way to ARM SoC yet. So it's on it's way.

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=135397838631792&w=2

