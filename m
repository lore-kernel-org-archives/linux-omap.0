From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: OMAP* Latest build failures
Date: Wed, 28 Nov 2012 10:04:33 -0400
Message-ID: <50B619F1.3000207@ti.com>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk> <20121117093307.GL3332@n2100.arm.linux.org.uk> <20121120175733.GH18567@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48292 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab2K1OEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 09:04:46 -0500
In-Reply-To: <20121120175733.GH18567@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Radhesh Fadnis <radhesh.fadnis@ti.com>, Jon Hunter <jon-hunter@ti.com>

Tony, Russell,

On 20-11-2012 13:57, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121117 01:35]:
>> On Wed, Nov 14, 2012 at 09:26:43AM +0000, Russell King - ARM Linux wrote:
>>> OMAP* allnoconfig fails:
>>>
>>> arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
>>> twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
>>> arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
>>> twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
>>> arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
>>> twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
>>> arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
>>> twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
>>> arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
>>> twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
>>> arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
>>> twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
>>> arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
>>> twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'
>>
>> These are now gone, but we have a new warning:
>>
>> arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used
>
> Jon, care to fix this one?
>
>> And the randconfig found:
>>
>> drivers/staging/omap-thermal/omap-bandgap.c: In function 'omap_bandgap_readl':
>> drivers/staging/omap-thermal/omap-bandgap.c:46:2: error: implicit declaration of function 'readl'
>> drivers/staging/omap-thermal/omap-bandgap.c: In function 'omap_bandgap_writel':
>> drivers/staging/omap-thermal/omap-bandgap.c:51:2: error: implicit declaration of function 'writel'
>>
>> Which, as its in staging, maybe its not important but it's another source
>> of unnecessary failure.

Well, it is important, thanks for checking this code. I appreciate if 
you keep your report.

>
> Radhesh & Eduardo, can you fix this?
>

This has been already fixed:
https://patchwork.kernel.org/patch/1734621/

And is already queued by Greg (staging-next):
http://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=commit;h=2aeeb8acfc19f8a9f283081bbf77919b61b92042

> Regards,
>
> Tony
>

