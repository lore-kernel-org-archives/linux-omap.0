From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Don't try to send IPI on UP systems with
	CONFIG_SMP
Date: Wed, 8 Sep 2010 09:56:57 +0100
Message-ID: <20100908085657.GA29914@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com> <20100906104413.GD20903@n2100.arm.linux.org.uk> <20100906180346.GC20849@atomide.com> <20100908030951.GH22507@atomide.com> <20100908031214.GI22507@atomide.com> <20100908031404.GJ22507@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38063 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0IHI5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 04:57:11 -0400
Content-Disposition: inline
In-Reply-To: <20100908031404.GJ22507@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

On Tue, Sep 07, 2010 at 08:14:05PM -0700, Tony Lindgren wrote:
> This is not needed on UP. Additionally with will cause issues when
> booting CONFIG_SMP_ON_UP kernel on earlier ARM cores.

Doesn't make sense.

> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 401e38b..5facdbe 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -207,9 +207,7 @@ __setup("reboot=", reboot_setup);
>  
>  void machine_shutdown(void)
>  {
> -#ifdef CONFIG_SMP
>  	smp_send_stop();
> -#endif

This will cause a link error as smp.c is not built for uniprocessor
builds.

>  }
>  
>  void machine_halt(void)
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 40dc74f..16ca27b 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -560,12 +560,17 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs)
>  
>  void smp_send_reschedule(int cpu)
>  {
> -	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
> +	if (is_smp())
> +		send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);

There won't be any other CPUs to send an IPI to - and all places which
call this are protected by a check for cpu == smp_processor_id() - in
other words, this will never be called for the current CPU.

>  }
>  
>  void smp_send_stop(void)
>  {
>  	cpumask_t mask = cpu_online_map;
> +
> +	if (!is_smp())
> +		return;
> +
>  	cpu_clear(smp_processor_id(), mask);

This results in an empty CPU mask.  It might be better to do instead:

	if (!cpus_empty(mask))

>  	send_ipi_message(&mask, IPI_CPU_STOP);
>  }
