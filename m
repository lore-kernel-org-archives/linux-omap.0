From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH, RFC] default machine descriptor for multiplatform
Date: Tue, 5 Feb 2013 15:37:25 -0600
Message-ID: <CAL_JsqJ2SyGeJePvNh5fREWP5LcAxnvNsiq2=kKNxKrnquyy3Q@mail.gmail.com>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
	<20130131161823.GT2637@n2100.arm.linux.org.uk>
	<1731670.s76EGcEZ7m@wuerfel>
	<1638002.UJ7zfj1Wn5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:63351 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab3BEVh0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 16:37:26 -0500
Received: by mail-qa0-f49.google.com with SMTP id o13so364033qaj.1
        for <linux-omap@vger.kernel.org>; Tue, 05 Feb 2013 13:37:26 -0800 (PST)
In-Reply-To: <1638002.UJ7zfj1Wn5@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

On 01/31/2013 11:51 AM, Arnd Bergmann wrote:
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
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3e3444e..8ff1d38 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -979,7 +979,6 @@ config ARCH_MULTI_V7
>   bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
>   default y
>   select ARCH_MULTI_V6_V7
> - select ARCH_VEXPRESS
>   select CPU_V7
>
>  config ARCH_MULTI_V6_V7
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 70f1bde..e6e34ba 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -180,6 +180,13 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>   unsigned long dt_root;
>   const char *model;
>
> + if (IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM)) {
> + DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
> + MACHINE_END

I assume this works, but it looks a bit strange declared here.

> +
> + mdesc_best = (struct machine_desc *)&__mach_desc_GENERIC_DT;
> + }
> +
>   if (!dt_phys)
>   return NULL;
>
> @@ -199,7 +206,7 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>   mdesc_score = score;
>   }
>   }
> - if (!mdesc_best) {
> + if (!mdesc_best && !IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM)) {
>   const char *prop;
>   long size;
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
> - machine_desc->init_irq();
> + if (machine_desc->init_irq)
> + machine_desc->init_irq();
> + else
> + irqchip_init();
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
> - /* customizes platform devices, or adds new ones */
> + /*
> + * customizes platform devices, or adds new ones
> + * On DT based machines, we fall back to populating the
> + * machine from the device tree, if no callback is provided,
> + * otherwise we would always need an init_machine callback.
> + */
>   if (machine_desc->init_machine)
>   machine_desc->init_machine();
> + else
> + of_platform_populate(NULL, of_default_bus_match_table,
> + NULL, NULL);

Could this be unconditional? It should be safe to call multiple times
if a platform calls this first because ordering matters or there are
custom match tables. I would guess any ordering requirements need to
happen before this call anyway.

Rob
