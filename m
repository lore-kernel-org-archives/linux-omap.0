From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Thu, 22 Nov 2012 15:16:50 +0300
Message-ID: <CAK0ocyCe3oJ8ynpNWpzcCFHtG3J4u7NBeNPTJK0GikFHaPAXOA@mail.gmail.com>
References: <k80da6$61d$1@ger.gmane.org>
	<CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
	<20121121183809.GZ18567@atomide.com>
	<CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
	<50ADBB5B.7090401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:63395 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab2KVTGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 14:06:32 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2307599dak.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Nov 2012 11:06:32 -0800 (PST)
In-Reply-To: <50ADBB5B.7090401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

On Thu, Nov 22, 2012 at 9:42 AM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
>
>
> On 11/22/2012 1:30 AM, Igor Mazanov wrote:
>> On Wed, Nov 21, 2012 at 9:38 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Jean Pihet <jean.pihet@newoldbits.com> [121114 08:43]:
>>>> On Wed, Nov 14, 2012 at 4:28 PM, Igor Mazanov <i.mazanov@gmail.com> wrote:
>>>>>
>>>>> Beaglebone boot process is broken with the current git kernel. I use
>>>>> omap2plus_defconfig for tests.
>>>>>
>>>>> It looks like the boot process stops due to the last changes in the AM33xx
>>>>> clock sysbsystem. A following patch resolves this issue:
>>> ...
>>>
>>>> The patch should change the name of the hwmod entry as well, can you
>>>> fold this change in the current patch?
>>>
>>> Any news on updating this?
>>
>> The current kernel boots, but after a switching to CCF doesn't work
>> the debugss - it's just disabled in the current hwmod code. So, it
>> looks like we can't  use JTAG to connect to the running kernel.
>>
>
> just resumed from vacation...
>
> JTAG clock will get disabled because, CONFIG_OMAP_RESET_CLOCKS will
> disable unused clocks, so as debugss clock.
>
> There is another thread started by Joel on the similar issue,
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg80863.html
>
> Something below should be done for debugss on AM33xx,
>
> diff --git a/arch/arm/mach-omap2/clock33xx_data.c
> b/arch/arm/mach-omap2/clock33xx_data.c
> index 17e3de5..60e0b53 100644
> --- a/arch/arm/mach-omap2/clock33xx_data.c
> +++ b/arch/arm/mach-omap2/clock33xx_data.c
> @@ -584,6 +584,9 @@ static struct clk debugss_ick = {
>         .clkdm_name     = "l3_aon_clkdm",
>         .parent         = &dpll_core_m4_ck,
>         .ops            = &clkops_omap2_dflt,
> +#ifdef CONFIG_DEBUG_KERNEL
> +       .flags          = ENABLE_ON_INIT,
> +#endif
>         .enable_reg     = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
>         .enable_bit     = AM33XX_MODULEMODE_SWCTRL,
>         .recalc         = &followparent_recalc,

Yes, I noticed this thread. But now a clock subsystem in the current
kernel is switched to Common Clock Framework and debugss (and several
another modules) is disabled (#if 0 .... #endif) in
omap_hwmod_33xx_data.c.

>From omap_hwmod_33xx_data.c:

/*
 * Modules omap_hwmod structures
 *
 * The following IPs are excluded for the moment because:
 * - They do not need an explicit SW control using omap_hwmod API.
 * - They still need to be validated with the driver
 *   properly adapted to omap_hwmod / omap_device
 *
 *    - cEFUSE (doesn't fall under any ocp_if)
 *    - clkdiv32k
 *    - debugss
 *    - ocmc ram
 *    - ocp watch point
 *    - aes0
 *    - sha0
 */

I uncommented the debugss entry in the omap_hwmod settings, but only
got a warning like:

 CC      arch/arm/mach-omap2/omap_hwmod_33xx_data.o
arch/arm/mach-omap2/omap_hwmod_33xx_data.c:472:26: warning:
'am33xx_debugss_hwmod' defined but not used [-Wunused-variable]

By the way, I need to use JTAG to trace a problem described in this thread:

http://marc.info/?l=linux-omap&m=135307646415429&w=2

May be, it's the clocks related issue too...

> Thanks,
> Vaibhav
>
>> Regards,
>> Igor.
>>
>>> Regards,
>>>
>>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
