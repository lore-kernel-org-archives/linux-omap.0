From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 04:44:55 -0600
Message-ID: <4F86B227.90802@mlbassoc.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com> <4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:42983 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab2DLKpO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 06:45:14 -0400
In-Reply-To: <87hawqt6vt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On 2012-04-11 13:17, Kevin Hilman wrote:
> Gary Thomas<gary@mlbassoc.com>  writes:
>
> [...]
>
>> I fear I'm seeing similar problems with 3.3.  I have my board (similar
>> to the BeagleBoard) ported to 3.0 and 3.3.  I'm seeing terrible network
>> performance on 3.3.  For example, if I use TFTP to download a large file
>> (~35MB), I get this:
>>    3.0:  42.5 sec
>>    3.3: 625.0 sec
>> That's a factor of 15 worse!
>
> This might not be the same problem.  What is the NIC being used, and
> does it have GPIO interrupts?

My board uses SMSC911x with GPIO interrupt signal.

>
> If it's using GPIO interrupts, then you likely need this patch from
> mainline (v3.4-rc1)

I tried to just pick up the patch you [sort of] quoted below, but had
a hard time applying it to my kernel. I've tried to just pick up the
latest files from the mainline kernel, but so far I've nothing that
builds - too many dependencies.  These are the files I've pulled in
#       modified:   arch/arm/mach-omap2/cpuidle34xx.c
#       modified:   arch/arm/mach-omap2/gpio.c
#       modified:   arch/arm/mach-omap2/pm34xx.c
#       modified:   arch/arm/plat-omap/include/plat/gpio.h
#       modified:   drivers/gpio/gpio-omap.c
but it fails with these errors:
/local/linux-3.3/arch/arm/mach-omap2/pm34xx.c:34:29: error: asm/system_misc.h: No such file or directory
/local/linux-3.3/arch/arm/mach-omap2/pm34xx.c: In function 'omap3_pm_init':
/local/linux-3.3/arch/arm/mach-omap2/pm34xx.c:744: error: 'omap_pm_clkdms_setup' undeclared (first use in this function)
/local/linux-3.3/arch/arm/mach-omap2/pm34xx.c:744: error: (Each undeclared identifier is reported only once
/local/linux-3.3/arch/arm/mach-omap2/pm34xx.c:744: error: for each function it appears in.)
/local/linux-3.3/arch/arm/mach-omap2/pm34xx.c:767: error: 'arm_pm_idle' undeclared (first use in this function)

Is this a viable path towards getting the GPIO changes into my kernel?
It's hard for me to update the whole kernel as there are some other
dependencies (OMAP3ISP and video in particular), so I'd like to stay
with this 3.3-ish base.

Thanks for any ideas

>
> If that doesn't work, or you're not using GPIO interrupts, could you
> confirm if the patch below[2] (based on idea from Grasvydas) increases
> performance for you when CONFIG_PM=y.
>
> Kevin
>
> [1]
> Author: Kevin Hilman<khilman@ti.com>   2012-03-05 15:10:04
> Committer: Grant Likely<grant.likely@secretlab.ca>   2012-03-12 09:16:11
> Parent: 25db711df3258d125dc1209800317e5c0ef3c870 (gpio/omap: Fix IRQ handling for SPARSE_IRQ)
> Child:  8805f410e4fb88a56552c1af42d61b38837a38fd (gpio/omap: Fix section warning for omap_mpuio_alloc_gc())
> Branches: many (66)
> Follows: v3.3-rc7
> Precedes: v3.4-rc1
>
>      gpio/omap: fix wakeups on level-triggered GPIOs
>
>      While both level- and edge-triggered GPIOs are capable of generating
>      interrupts, only edge-triggered GPIOs are capable of generating a
>      module-level wakeup to the PRCM (c.f. 34xx NDA TRM section 25.5.3.2.)
>
>      In order to ensure that devices using level-triggered GPIOs as
>      interrupts can also cause wakeups (e.g. from idle), this patch enables
>      edge-triggering for wakeup-enabled, level-triggered GPIOs when a GPIO
>      bank is runtime-suspended (which also happens during idle.)
>
>      This fixes a problem found in GPMC-connected network cards with GPIO
>      interrupts (e.g. smsc911x on Zoom3, Overo, ...) where network booting
>      with NFSroot was very slow since the GPIO IRQs used by the NIC were
>      not generating PRCM wakeups, and thus not waking the system from idle.
>      NOTE: until v3.3, this boot-time problem was somewhat masked because
>      the UART init prevented WFI during boot until the full serial driver
>      was available.  Preventing WFI allowed regular GPIO interrupts to fire
>      and this problem was not seen.  After the UART runtime PM cleanups, we
>      no longer avoid WFI during boot, so GPIO IRQs that were not causing
>      wakeups resulted in very slow IRQ response times.
>
>      Tested on platforms using level-triggered GPIOs for network IRQs using
>      the SMSC911x NIC: 3530/Overo and 3630/Zoom3.
>
>      Reported-by: Tony Lindgren<tony@atomide.com>
>      Tested-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>      Tested-by: Tony Lindgren<tony@atomide.com>
>      Signed-off-by: Kevin Hilman<khilman@ti.com>
>      Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
>
> [2]
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 413aac4..ace4bf6 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -120,7 +120,10 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
>   		cpu_pm_enter();
>
>   	/* Execute ARM wfi */
> -	omap_sram_idle();
> +	if (index == 0)
> +		cpu_do_idle();
> +	else
> +		omap_sram_idle();
>
>   	/*
>   	 * Call idle CPU PM enter notifier chain to restore
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
