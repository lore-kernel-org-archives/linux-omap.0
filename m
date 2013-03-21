From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
Date: Thu, 21 Mar 2013 11:35:49 +0000
Message-ID: <514AF095.5060802@arm.com>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com> <20130321110646.GE15279@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130321110646.GE15279@e106331-lin.cambridge.arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robherring2@gmail.com>, Simon Horman <horms@verge.net.au>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 21/03/13 11:06, Mark Rutland wrote:
> Hi Rob,
> 
> (adding Marc to Cc as he may have comments).
> 
> On Wed, Mar 20, 2013 at 10:34:35PM +0000, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This converts arm and arm64 to use CLKSRC_OF DT based initialization for
>> the arch timer. A new function arch_timer_arch_init is added to allow for
>> arch specific setup.
>>
>> This has a side effect of enabling sched_clock on omap5 and exynos5. There
>> should not be any reason not to use the arch timers for sched_clock.
> 
> Nice! I was just about to post a (slightly updated) version of Thomas Abraham's
> arch_timer clocksource_of_init patch, but this seems much more comprehensive.
> 
> I have some other arch_timer patches which may clash, but they could be rebased
> atop of this.
> 
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-samsung-soc@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>> ---
>> This is dependent on my CLKSRC_OF clean-up in arm-soc, my 64-bit sched_clock
>> support series, and Arnd's default machine descriptor patch (for default
>> clocksource_of_init call). This is only compile tested on arm.
>>
>> The full series (including sp804 work) is available here:
>> git://sources.calxeda.com/kernel/linux.git arm-timers
>>
>> Rob
>>
> 
> [...]
> 
>> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
>> index d0ad789..6215717 100644
>> --- a/arch/arm/mach-vexpress/v2m.c
>> +++ b/arch/arm/mach-vexpress/v2m.c
>> @@ -1,6 +1,7 @@
>>  /*
>>   * Versatile Express V2M Motherboard Support
>>   */
>> +#include <linux/clocksource.h>
>>  #include <linux/device.h>
>>  #include <linux/amba/bus.h>
>>  #include <linux/amba/mmci.h>
>> @@ -23,7 +24,6 @@
>>  #include <linux/regulator/machine.h>
>>  #include <linux/vexpress.h>
>>
>> -#include <asm/arch_timer.h>
>>  #include <asm/mach-types.h>
>>  #include <asm/sizes.h>
>>  #include <asm/mach/arch.h>
>> @@ -446,10 +446,7 @@ static void __init v2m_dt_timer_init(void)
>>                                 irq_of_parse_and_map(node, 0));
>>         }
>>
>> -       arch_timer_of_register();
>> -
>> -       if (arch_timer_sched_clock_init() != 0)
>> -               versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
>> +       versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
>>                                 24000000);
>>  }
>>
> 
> On TC2 this series leads to using the vexpress 24MHz clock as the sched clock
> in preference to the architected timer:
> 
>   Architected local timer running at 24.00MHz (virt).
>   Switching to timer-based delay loop
>   Registered arch_counter_get_cntvct+0x0/0x14 as sched_clock source
>   sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
>   Registered versatile_read_sched_clock+0x0/0x28 as sched_clock source
> 
> As they both have the same frequency, neither overrides the other, and
> whichever gets registered last is used as the sched_clock. As accesses to the
> architected timer are going to have a much lower overhead, this isn't very nice
> (and it could be better to use it even if it had a lower frequency).

Indeed. And if I look at it with my KVM hat on, it is even worse (the
guest will exit all the way to platform emulation in userspace on each
sched_clock read - a sure performance killer).

Of course, emulating a VE is not the best option, but that's all we have
so far when using QEMU as platform emulation.

	M.
-- 
Jazz is not dead. It just smells funny...
