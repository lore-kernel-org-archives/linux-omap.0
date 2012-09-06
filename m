From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: Use pre-empt safe cpu_get/put insted of smp_processor_id
Date: Thu, 6 Sep 2012 20:59:03 +0200
Message-ID: <CAORVsuVCNy3L9af9iC9ZSeRbRvz-n=jN0P9ixMJday90NmVGfg@mail.gmail.com>
References: <1344607558-15481-1-git-send-email-rogerq@ti.com>
	<CAORVsuW+Vb6+GyTDfEmW3n=FY33rk_KDiMkFHPv29ZS=Y4yuFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53107 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933001Ab2IFS7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 14:59:06 -0400
Received: by lagy9 with SMTP id y9so1331522lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 11:59:04 -0700 (PDT)
In-Reply-To: <CAORVsuW+Vb6+GyTDfEmW3n=FY33rk_KDiMkFHPv29ZS=Y4yuFA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Fixed Paul's email address

On Thu, Sep 6, 2012 at 8:56 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> Hi Roger,
>
> On Fri, Aug 10, 2012 at 4:05 PM, Roger Quadros <rogerq@ti.com> wrote:
>> gets rid of below messages with CONFIG_DEBUG_PREEMPT enabled
>>
>> [   28.832916] debug_smp_processor_id: 18 callbacks suppressed
>> [   28.832946] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/1763
>> [   28.841491] caller is pwrdm_set_next_pwrst+0x54/0x120
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>
> What his the status of the patch? Has it been reviewed and taken in an
> integration tree? I cannot find anything about it in l-o and
> linux-next.
>
> I have some changes on-going in the OMAP PM code and I would like to
> know if $SUBJECT is applicable.
>
> Regards,
> Jean
>
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
>>         pr_debug("clock: %s: disabling in hardware\n", clk->name);
>>
>>         if (clk->ops && clk->ops->disable) {
>> -               trace_clock_disable(clk->name, 0, smp_processor_id());
>> +               trace_clock_disable(clk->name, 0, get_cpu());
>> +               put_cpu();
>>                 clk->ops->disable(clk);
>>         }
>>
>> @@ -339,7 +340,8 @@ int omap2_clk_enable(struct clk *clk)
>>         }
>>
>>         if (clk->ops && clk->ops->enable) {
>> -               trace_clock_enable(clk->name, 1, smp_processor_id());
>> +               trace_clock_enable(clk->name, 1, get_cpu());
>> +               put_cpu();
>>                 ret = clk->ops->enable(clk);
>>                 if (ret) {
>>                         WARN(1, "clock: %s: could not enable: %d\n",
>> @@ -380,7 +382,8 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
>>
>>         /* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
>>         if (clk->set_rate) {
>> -               trace_clock_set_rate(clk->name, rate, smp_processor_id());
>> +               trace_clock_set_rate(clk->name, rate, get_cpu());
>> +               put_cpu();
>>                 ret = clk->set_rate(clk, rate);
>>         }
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index e4fc88c..81fec2e 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -357,18 +357,22 @@ void omap_sram_idle(void)
>>
>>  static void omap3_pm_idle(void)
>>  {
>> +       unsigned cpu;
>> +
>>         local_fiq_disable();
>>
>>         if (omap_irq_pending())
>>                 goto out;
>>
>> -       trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> -       trace_cpu_idle(1, smp_processor_id());
>> +       cpu = get_cpu();
>> +       trace_power_start(POWER_CSTATE, 1, cpu);
>> +       trace_cpu_idle(1, cpu);
>>
>>         omap_sram_idle();
>>
>> -       trace_power_end(smp_processor_id());
>> -       trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>> +       trace_power_end(cpu);
>> +       trace_cpu_idle(PWR_EVENT_EXIT, cpu);
>> +       put_cpu();
>>
>>  out:
>>         local_fiq_enable();
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index 69b36e1..138bf86 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -169,7 +169,8 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>                                        ((state & OMAP_POWERSTATE_MASK) << 8) |
>>                                        ((prev & OMAP_POWERSTATE_MASK) << 0));
>>                         trace_power_domain_target(pwrdm->name, trace_state,
>> -                                                 smp_processor_id());
>> +                                                 get_cpu());
>> +                       put_cpu();
>>                 }
>>                 break;
>>         default:
>> @@ -491,7 +492,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>>         if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>>                 /* Trace the pwrdm desired target state */
>>                 trace_power_domain_target(pwrdm->name, pwrst,
>> -                                         smp_processor_id());
>> +                                         get_cpu());
>> +               put_cpu();
>>                 /* Program the pwrdm desired target state */
>>                 ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>>         }
>> --
>> 1.7.4.1
>>
