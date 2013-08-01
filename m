From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [FAILURE] omap4430-sdp allnoconfig
Date: Thu, 1 Aug 2013 14:31:33 -0400
Message-ID: <51FAA985.3000809@ti.com>
References: <20130801175214.GA23053@n2100.arm.linux.org.uk> <51FAA4C6.10203@ti.com> <20130801182707.GB23053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42951 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab3HAScC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 14:32:02 -0400
In-Reply-To: <20130801182707.GB23053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 01 August 2013 02:27 PM, Russell King - ARM Linux wrote:
> On Thu, Aug 01, 2013 at 02:11:18PM -0400, Santosh Shilimkar wrote:
>> On Thursday 01 August 2013 01:52 PM, Russell King - ARM Linux wrote:
>>> My allnoconfig fails with this error:
>>>
>>> arch/arm/mach-omap2/built-in.o: In function `omap4_local_timer_init':
>>> dss-common.c:(.init.text+0x1d90): undefined reference to `twd_local_timer_register'
>>>
>>> Might be worth looking into whatever's missing?
>>
>> Looks like coming from below snippet but am just wondering how ?
> 
> Well, looking at the config allnoconfig generated, it doesn't have SMP
> and therefore it doesn't have local timers.
> 
> The build tree has this in it:
> 
> #ifdef CONFIG_ARCH_OMAP4
> static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
> void __init omap4_local_timer_init(void)
> {
>         omap4_sync32k_timer_init();
>         /* Local timers are not supprted on OMAP4430 ES1.0 */
>         if (omap_rev() != OMAP4430_REV_ES1_0) {
>                 int err;
> 
>                 if (of_have_populated_dt()) {
>                         clocksource_of_init();
>                         return;
>                 }
> 
>                 err = twd_local_timer_register(&twd_local_timer);
>                 if (err)
>                         pr_err("twd_local_timer_register failed %d\n", err);
>         }
> }
> #endif /* CONFIG_ARCH_OMAP4 */
> 
Now it make sense.

> which is changed from your version thanks to this commit:
> 
> commit ef3160cd2f0a400751f2cf6fd2811225fee1d5a7
> Author: Stephen Boyd <sboyd@codeaurora.org>
> Date:   Mon Mar 4 19:24:35 2013 -0800
> 
>     ARM: OMAP2+: Divorce from local timer API
>     
>     Now that the TWD doesn't rely on the local timer API, OMAP can
>     stop selecting it in Kconfig and relying on the config option to
>     decide if it should call smp_twd functions.
>     
>     Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>     Acked-by: Tony Lindgren <tony@atomide.com>
>     Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>     Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> So it seems LOCAL_TIMER is still actually required...
> 
yep. Lets see what Stephen has to say.

Regards,
Santosh
