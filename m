From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH, RFC] default machine descriptor for multiplatform
Date: Thu, 31 Jan 2013 15:34:58 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1301311532590.6300@xanadu.home>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <20130131161823.GT2637@n2100.arm.linux.org.uk> <1731670.s76EGcEZ7m@wuerfel>
 <1638002.UJ7zfj1Wn5@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:44916 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab3AaUfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 15:35:14 -0500
Received: from xanadu.home ([24.202.213.203]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MHI005JTBUA9950@VL-VM-MR001.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Thu, 31 Jan 2013 15:34:59 -0500 (EST)
In-reply-to: <1638002.UJ7zfj1Wn5@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

On Thu, 31 Jan 2013, Arnd Bergmann wrote:

> This is what I think it would look like to do a default platform
> with an empty machine descriptor on ARM. It makes the few required
> entries in the descriptor optional by using the new irqchip_init()
> and clocksource_of_init() functions as defaults, and adds
> a fallback for the DT case to customize_machine to probe all
> the default devices.
> 
> For the case that CONFIG_MULTIPLATFORM is enabled, it then
> adds a machine descriptor that never matches any machine but
> is used as a fallback if nothing else matches.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks sensible.

Acked-by: Nicolas Pitre <nico@linaro.org>

> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3e3444e..8ff1d38 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -979,7 +979,6 @@ config ARCH_MULTI_V7
>  	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
>  	default y
>  	select ARCH_MULTI_V6_V7
> -	select ARCH_VEXPRESS
>  	select CPU_V7
>  
>  config ARCH_MULTI_V6_V7
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 70f1bde..e6e34ba 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -180,6 +180,13 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  	unsigned long dt_root;
>  	const char *model;
>  
> +	if (IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM)) {
> +		DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
> +		MACHINE_END
> +
> +		mdesc_best = (struct machine_desc *)&__mach_desc_GENERIC_DT;
> +	}
> +
>  	if (!dt_phys)
>  		return NULL;
>  
> @@ -199,7 +206,7 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  			mdesc_score = score;
>  		}
>  	}
> -	if (!mdesc_best) {
> +	if (!mdesc_best && !IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM)) {
>  		const char *prop;
>  		long size;
>  
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 8e4ef4c..df6f9a1 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -26,6 +26,7 @@
>  #include <linux/ioport.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip.h>
>  #include <linux/random.h>
>  #include <linux/smp.h>
>  #include <linux/init.h>
> @@ -114,7 +115,10 @@ EXPORT_SYMBOL_GPL(set_irq_flags);
>  
>  void __init init_IRQ(void)
>  {
> -	machine_desc->init_irq();
> +	if (machine_desc->init_irq)
> +		machine_desc->init_irq();
> +	else
> +		irqchip_init();
>  }
>  
>  #ifdef CONFIG_MULTI_IRQ_HANDLER
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 3f6cbb2..1d40c9d 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -18,6 +18,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/seq_file.h>
>  #include <linux/screen_info.h>
> +#include <linux/of_platform.h>
>  #include <linux/init.h>
>  #include <linux/kexec.h>
>  #include <linux/of_fdt.h>
> @@ -640,9 +641,17 @@ struct screen_info screen_info = {
>  
>  static int __init customize_machine(void)
>  {
> -	/* customizes platform devices, or adds new ones */
> +	/*
> +	 * customizes platform devices, or adds new ones
> +	 * On DT based machines, we fall back to populating the
> +	 * machine from the device tree, if no callback is provided,
> +	 * otherwise we would always need an init_machine callback.
> +	 */
>  	if (machine_desc->init_machine)
>  		machine_desc->init_machine();
> +	else
> +		of_platform_populate(NULL, of_default_bus_match_table,
> +					NULL, NULL);
>  	return 0;
>  }
>  arch_initcall(customize_machine);
> @@ -732,7 +741,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	setup_processor();
>  	mdesc = setup_machine_fdt(__atags_pointer);
> -	if (!mdesc)
> +	if (!mdesc && __machine_arch_type != ~0)
>  		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
>  	machine_desc = mdesc;
>  	machine_name = mdesc->name;
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index 955d92d..abff4e9 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -22,6 +22,7 @@
>  #include <linux/errno.h>
>  #include <linux/profile.h>
>  #include <linux/timer.h>
> +#include <linux/clocksource.h>
>  #include <linux/irq.h>
>  
>  #include <asm/thread_info.h>
> @@ -115,6 +116,10 @@ int __init register_persistent_clock(clock_access_fn read_boot,
>  
>  void __init time_init(void)
>  {
> -	machine_desc->init_time();
> +	if (machine_desc->init_time)
> +		machine_desc->init_time();
> +	else
> +		clocksource_of_init();
> +
>  	sched_clock_postinit();
>  }
> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
> index f496afc..c5e7a45 100644
> --- a/drivers/irqchip/irqchip.c
> +++ b/drivers/irqchip/irqchip.c
> @@ -24,7 +24,13 @@ irqchip_of_match_end __used __section(__irqchip_of_end);
>  
>  extern struct of_device_id __irqchip_begin[];
>  
> +#ifdef CONFIG_IRQCHIP
>  void __init irqchip_init(void)
>  {
>  	of_irq_init(__irqchip_begin);
>  }
> +#else
> +static inline void irqchip_init(void)
> +{
> +}
> +#endif
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 7944f14..b14d224 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -339,6 +339,10 @@ extern void clocksource_of_init(void);
>  	static const struct of_device_id __clksrc_of_table_##name	\
>  		__used __section(__clksrc_of_table)			\
>  		 = { .compatible = compat, .data = fn };
> +#else
> +static inline void clocksource_of_init(void)
> +{
> +}
>  #endif
>  
>  #endif /* _LINUX_CLOCKSOURCE_H */
> 
