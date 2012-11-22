From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Thu, 22 Nov 2012 11:12:51 +0530
Message-ID: <50ADBB5B.7090401@ti.com>
References: <k80da6$61d$1@ger.gmane.org> <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com> <20121121183809.GZ18567@atomide.com> <CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50610 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab2KVTEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 14:04:10 -0500
In-Reply-To: <CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Mazanov <i.mazanov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org



On 11/22/2012 1:30 AM, Igor Mazanov wrote:
> On Wed, Nov 21, 2012 at 9:38 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Jean Pihet <jean.pihet@newoldbits.com> [121114 08:43]:
>>> On Wed, Nov 14, 2012 at 4:28 PM, Igor Mazanov <i.mazanov@gmail.com> wrote:
>>>>
>>>> Beaglebone boot process is broken with the current git kernel. I use
>>>> omap2plus_defconfig for tests.
>>>>
>>>> It looks like the boot process stops due to the last changes in the AM33xx
>>>> clock sysbsystem. A following patch resolves this issue:
>> ...
>>
>>> The patch should change the name of the hwmod entry as well, can you
>>> fold this change in the current patch?
>>
>> Any news on updating this?
> 
> The current kernel boots, but after a switching to CCF doesn't work
> the debugss - it's just disabled in the current hwmod code. So, it
> looks like we can't  use JTAG to connect to the running kernel.
> 

just resumed from vacation...

JTAG clock will get disabled because, CONFIG_OMAP_RESET_CLOCKS will
disable unused clocks, so as debugss clock.

There is another thread started by Joel on the similar issue,

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg80863.html

Something below should be done for debugss on AM33xx,

diff --git a/arch/arm/mach-omap2/clock33xx_data.c
b/arch/arm/mach-omap2/clock33xx_data.c
index 17e3de5..60e0b53 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -584,6 +584,9 @@ static struct clk debugss_ick = {
        .clkdm_name     = "l3_aon_clkdm",
        .parent         = &dpll_core_m4_ck,
        .ops            = &clkops_omap2_dflt,
+#ifdef CONFIG_DEBUG_KERNEL
+       .flags          = ENABLE_ON_INIT,
+#endif
        .enable_reg     = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
        .enable_bit     = AM33XX_MODULEMODE_SWCTRL,
        .recalc         = &followparent_recalc,



Thanks,
Vaibhav

> Regards,
> Igor.
> 
>> Regards,
>>
>> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
