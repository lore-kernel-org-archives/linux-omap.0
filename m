From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] perf: Use pre-empt safe cpu_get/put insted of smp_processor_id
Date: Tue, 11 Sep 2012 11:29:06 +0300
Message-ID: <504EF652.2020302@ti.com>
References: <1347276614-4334-1-git-send-email-rogerq@ti.com> <504E2921.50408@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab2IKI31 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 04:29:27 -0400
In-Reply-To: <504E2921.50408@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-omap@vger.kernel.org, jean.pihet@newoldbits.com, linux-arm-kernel@lists.infradead.org

On 09/10/2012 08:53 PM, Stephen Boyd wrote:
> On 09/10/12 04:30, Roger Quadros wrote:
>> gets rid of below messages with CONFIG_DEBUG_PREEMPT enabled
>>
>> [   28.832916] debug_smp_processor_id: 18 callbacks suppressed
>> [   28.832946] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/1763
>> [   28.841491] caller is pwrdm_set_next_pwrst+0x54/0x120
>>
>> changes in v2:
>> - rebased on 3.6-rc5
>> - use put_cpu() immediately after get_cpu() in omap3_pm_idle()
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/mach-omap2/clock.c       |    9 ++++++---
>>  arch/arm/mach-omap2/pm34xx.c      |   12 ++++++++----
>>  arch/arm/mach-omap2/powerdomain.c |    6 ++++--
>>  3 files changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
>> index ea3f565..06747b6 100644
>> --- a/arch/arm/mach-omap2/clock.c
>> +++ b/arch/arm/mach-omap2/clock.c
>> @@ -285,7 +285,8 @@ void omap2_clk_disable(struct clk *clk)
>>  	pr_debug("clock: %s: disabling in hardware\n", clk->name);
>>  
>>  	if (clk->ops && clk->ops->disable) {
>> -		trace_clock_disable(clk->name, 0, smp_processor_id());
>> +		trace_clock_disable(clk->name, 0, get_cpu());
>> +		put_cpu();
> 
> Why are you doing this? Why not just use raw_smp_processor_id()? Do you
> really care about the CPU number? get_cpu() and put_cpu() are about
> non-preemptible sections where you want to ensure the CPU the code is
> operating on is actually on that CPU.

You are right. raw_smp_processor_id() makes perfect sense here.

> 
> How about just put 0 all the time because the CPU number is already part
> of the trace event?
> 

I'm not sure about this. I can see that removing the cpu_id field from
trace_cpu_idle() was discussed here [1] and it was decided to keep it.
There was no conclusion about removing it from
trace_clock_enable/disable though.

For now, I will resend the patch with raw_smp_processor_id().

regards,
-roger

[1] https://lkml.org/lkml/2011/8/19/316
