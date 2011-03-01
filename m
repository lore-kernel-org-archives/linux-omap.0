From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/3] arm: omap4: support pmu
Date: Tue, 1 Mar 2011 19:06:46 +0530
Message-ID: <98808a1e9a0e0409013a83a66c3847e7@mail.gmail.com>
References: <1298985434-3009-1-git-send-email-tom.leiming@gmail.com> <1298985434-3009-4-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50899 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753139Ab1CANgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 08:36:49 -0500
Received: by mail-qy0-f174.google.com with SMTP id 7so3248215qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 05:36:48 -0800 (PST)
In-Reply-To: <1298985434-3009-4-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of tom.leiming@gmail.com
> Sent: Tuesday, March 01, 2011 6:47 PM
> To: linux@arm.linux.org.uk
> Cc: linux-arm-kernel@lists.infradead.org; Ming Lei; Woodruff
> Richard; Tony Lindgren; linux-omap@vger.kernel.org
> Subject: [PATCH 3/3] arm: omap4: support pmu
>
> From: Ming Lei <tom.leiming@gmail.com>
>
> This patch supports pmu irq routed from CTI, so
> make pmu/perf working on OMAP4.
>
> The idea is from Woodruff Richard in the disscussion
> "Oprofile on Pandaboard / Omap4" of pandaboard@googlegroups.com.
>
> Cc: Woodruff Richard <r-woodruff2@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---

Thanks Mein Lei for this.

>  arch/arm/mach-omap2/devices.c |   54
> ++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 53 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> omap2/devices.c
> index 71f099b..54e9705 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -34,6 +34,7 @@
>
>  #include "mux.h"
>  #include "control.h"
> +#include "dbg44xx.h"
>
>  #if defined(CONFIG_VIDEO_OMAP2) ||
> defined(CONFIG_VIDEO_OMAP2_MODULE)
>
> @@ -347,19 +348,70 @@ static struct resource omap3_pmu_resource = {
>  	.flags	= IORESOURCE_IRQ,
>  };
>
> +static struct resource omap4_pmu_resource[] = {
> +	{
> +	.start	= OMAP44XX_IRQ_CTI0,
> +	.end	= OMAP44XX_IRQ_CTI0,
> +	.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +	.start	= OMAP44XX_IRQ_CTI1,
> +	.end	= OMAP44XX_IRQ_CTI1,
> +	.flags	= IORESOURCE_IRQ,
> +	}
> +};
> +
>  static struct platform_device omap_pmu_device = {
>  	.name		= "arm-pmu",
>  	.id		= ARM_PMU_DEVICE_CPU,
>  	.num_resources	= 1,
>  };
>
> +struct pmu_platform_data omap4_pmu_data;
> +
> +static void omap4_configure_pmu_irq(void)
> +{
> +	void *base0;
> +	void *base1;
> +
> +	base0 = ioremap(OMAP4430_CTI0_BASE, 4096);
> +	base1 = ioremap(OMAP4430_CTI1_BASE, 4096);
> +	if (!base0 && !base1) {
> +		pr_err("ioremap for omap4 CTI failed\n");
> +		return;
> +	}
> +
> +	/*configure CTI0 for pmu irq routing*/
> +	cti_init(&omap4_pmu_data.cti[0], base0,
> +			OMAP44XX_IRQ_CTI0, 6);
> +	cti_unlock(&omap4_pmu_data.cti[0]);
> +	cti_map_trigger(&omap4_pmu_data.cti[0],
> +			1, 6, 2);
> +
> +	/*configure CTI1 for pmu irq routing*/
> +	cti_init(&omap4_pmu_data.cti[1], base1,
> +			OMAP44XX_IRQ_CTI1, 6);
> +	cti_unlock(&omap4_pmu_data.cti[1]);
> +	cti_map_trigger(&omap4_pmu_data.cti[1],
> +			1, 6, 3);
> +
> +	omap4_pmu_data.cti_cnt = 2;
> +	omap4_pmu_data.use_cti_irq = 1;
> +}
> +
>  static void omap_init_pmu(void)
>  {
>  	if (cpu_is_omap24xx())
>  		omap_pmu_device.resource = &omap2_pmu_resource;
>  	else if (cpu_is_omap34xx())
>  		omap_pmu_device.resource = &omap3_pmu_resource;
> -	else
> +	else if (cpu_is_omap44xx()) {
> +		omap_pmu_device.resource = omap4_pmu_resource;
> +		omap_pmu_device.num_resources = 2;
> +		omap_pmu_device.dev.platform_data = &omap4_pmu_data;
> +
> +		omap4_configure_pmu_irq();
> +	} else
>  		return;
>
>  	platform_device_register(&omap_pmu_device);
> --
> 1.7.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
