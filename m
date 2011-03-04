From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [patch v3 3/3] arm: omap4: support pmu
Date: Fri, 4 Mar 2011 11:46:07 +0530
Message-ID: <3734c031c0714f7f6bea072bb8b75a02@mail.gmail.com>
References: <1299149633-699-1-git-send-email-tom.leiming@gmail.com> <1299149633-699-4-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49965 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751099Ab1CDGQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 01:16:09 -0500
Received: by mail-qw0-f47.google.com with SMTP id 2so1426937qwi.6
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 22:16:07 -0800 (PST)
In-reply-to: <1299149633-699-4-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: tom.leiming@gmail.com [mailto:tom.leiming@gmail.com]
> Sent: Thursday, March 03, 2011 4:24 PM
> To: linux@arm.linux.org.uk
> Cc: linux-arm-kernel@lists.infradead.org; will.deacon@arm.com; Ming
> Lei; Santosh Shilimkar; Woodruff Richard; Tony Lindgren; linux-
> omap@vger.kernel.org
> Subject: [patch v3 3/3] arm: omap4: support pmu
>
> From: Ming Lei <tom.leiming@gmail.com>
>
> This patch supports pmu irq routed from CTI, so
> make pmu/perf working on OMAP4.
>
> The idea is from Woodruff Richard in the disscussion
> about "Oprofile on Pandaboard / Omap4" on
> pandaboard@googlegroups.com.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Woodruff Richard <r-woodruff2@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>  arch/arm/mach-omap2/devices.c              |   82
> +++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/omap44xx.h |    2 +
>  2 files changed, 81 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> omap2/devices.c
> index d216976..d97bb5a 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -22,6 +22,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
>  #include <asm/pmu.h>
> +#include <asm/cti.h>
>
>  #include <plat/tc.h>
>  #include <plat/board.h>
> @@ -322,20 +323,95 @@ static struct resource omap3_pmu_resource = {
>  	.flags	= IORESOURCE_IRQ,
>  };
>
> +static struct resource omap4_pmu_resource[] = {
> +	{
> +		.start	= OMAP44XX_IRQ_CTI0,
> +		.end	= OMAP44XX_IRQ_CTI0,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= OMAP44XX_IRQ_CTI1,
> +		.end	= OMAP44XX_IRQ_CTI1,
> +		.flags	= IORESOURCE_IRQ,
> +	}
> +};
> +
>  static struct platform_device omap_pmu_device = {
>  	.name		= "arm-pmu",
>  	.id		= ARM_PMU_DEVICE_CPU,
>  	.num_resources	= 1,
>  };
>
> +static struct arm_pmu_platdata omap4_pmu_data;
> +static struct cti omap4_cti[2];
> +
> +static void omap4_enable_cti(int irq)
> +{
> +	if (irq == OMAP44XX_IRQ_CTI0)
> +		cti_enable(&omap4_cti[0]);
> +	else if (irq == OMAP44XX_IRQ_CTI1)
> +		cti_enable(&omap4_cti[1]);
> +}
> +
> +static void omap4_disable_cti(int irq)
> +{
> +	if (irq == OMAP44XX_IRQ_CTI0)
> +		cti_disable(&omap4_cti[0]);
> +	else if (irq == OMAP44XX_IRQ_CTI1)
> +		cti_disable(&omap4_cti[1]);
> +}
> +
> +static irqreturn_t omap4_pmu_handler(int irq, void *dev,
> irq_handler_t handler)
> +{
> +	if (irq == OMAP44XX_IRQ_CTI0)
> +		cti_irq_ack(&omap4_cti[0]);
> +	else if (irq == OMAP44XX_IRQ_CTI1)
> +		cti_irq_ack(&omap4_cti[1]);
> +
> +	return handler(irq, dev);
> +}
> +
> +static void omap4_configure_pmu_irq(void)
> +{
> +	void __iomem *base0;
> +	void __iomem *base1;
> +
> +	base0 = ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
> +	base1 = ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
> +	if (!base0 && !base1) {
> +		pr_err("ioremap for OMAP4 CTI failed\n");
> +		return;
> +	}
> +
> +	/*configure CTI0 for pmu irq routing*/
> +	cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
> +	cti_unlock(&omap4_cti[0]);
> +	cti_map_trigger(&omap4_cti[0], 1, 6, 2);
> +
> +	/*configure CTI1 for pmu irq routing*/
> +	cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
> +	cti_unlock(&omap4_cti[1]);
> +	cti_map_trigger(&omap4_cti[1], 1, 6, 2);
> +
> +	omap4_pmu_data.handle_irq = omap4_pmu_handler;
> +	omap4_pmu_data.enable_irq = omap4_enable_cti;
> +	omap4_pmu_data.disable_irq = omap4_disable_cti;
> +}
> +
>  static void omap_init_pmu(void)
>  {
> -	if (cpu_is_omap24xx())
> +	if (cpu_is_omap24xx()) {
>  		omap_pmu_device.resource = &omap2_pmu_resource;
> -	else if (cpu_is_omap34xx())
> +	} else if (cpu_is_omap34xx()) {
>  		omap_pmu_device.resource = &omap3_pmu_resource;
> -	else
> +	} else if (cpu_is_omap44xx()) {
> +		omap_pmu_device.resource = omap4_pmu_resource;
> +		omap_pmu_device.num_resources = 2;
> +		omap_pmu_device.dev.platform_data = &omap4_pmu_data;
> +		omap4_configure_pmu_irq();
> +	} else {
>  		return;
> +	}
>
>  	platform_device_register(&omap_pmu_device);
>  }
> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h
> b/arch/arm/plat-omap/include/plat/omap44xx.h
> index ea2b8a6..b127a16 100644
> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> @@ -57,5 +57,7 @@
>  #define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
>  #define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
>
> +#define OMAP44XX_CTI0_BASE		0x54148000
> +#define OMAP44XX_CTI1_BASE		0x54149000
>  #endif /* __ASM_ARCH_OMAP44XX_H */
>
> --
> 1.7.3
