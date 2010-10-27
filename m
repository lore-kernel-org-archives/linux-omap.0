From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 1/5] omap: mailbox: initial hwmod support for omap3
Date: Wed, 27 Oct 2010 10:37:14 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D3105B4@dbde02.ent.ti.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
 <1288129984-22957-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab0J0FHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 01:07:25 -0400
In-Reply-To: <1288129984-22957-2-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Ramirez Luna, Omar
> Sent: Wednesday, October 27, 2010 3:23 AM
> To: Tony Lindgren; Hiroshi DOYU
> Cc: Felipe Contreras; Dmitry Kasatkin; Kevin Hilman; Ramirez 
> Luna, Omar; Anna, Suman; Paul Walmsley; Cousson, Benoit; 
> Raja, Govindraj; C.A, Subramaniam; linux-omap@vger.kernel.org
> Subject: [PATCH 1/5] omap: mailbox: initial hwmod support for omap3
> 
> From: Felipe Contreras <felipe.contreras@gmail.com>
> 
> HWMOD support for omap3.

Use "hwmod".

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c              |  100 
> ++++-----------------------
>  arch/arm/mach-omap2/mailbox.c              |    1 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   54 +++++++++++++++
>  3 files changed, 70 insertions(+), 85 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c 
> b/arch/arm/mach-omap2/devices.c
> index eaf3799..d977572 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -141,95 +141,25 @@ static inline void omap_init_camera(void)
>  #endif
>  
>  #if defined(CONFIG_OMAP_MBOX_FWK) || 
> defined(CONFIG_OMAP_MBOX_FWK_MODULE)
> -
> -#define MBOX_REG_SIZE   0x120
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct resource omap2_mbox_resources[] = {
> -	{
> -		.start		= OMAP24XX_MAILBOX_BASE,
> -		.end		= OMAP24XX_MAILBOX_BASE + 
> MBOX_REG_SIZE - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -	{
> -		.start		= INT_24XX_MAIL_U0_MPU,
> -		.flags		= IORESOURCE_IRQ,
> -		.name		= "dsp",
> -	},
> -	{
> -		.start		= INT_24XX_MAIL_U3_MPU,
> -		.flags		= IORESOURCE_IRQ,
> -		.name		= "iva",
> -	},
> -};
> -static int omap2_mbox_resources_sz = 
> ARRAY_SIZE(omap2_mbox_resources);
> -#else
> -#define omap2_mbox_resources		NULL
> -#define omap2_mbox_resources_sz		0
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct resource omap3_mbox_resources[] = {
> -	{
> -		.start		= OMAP34XX_MAILBOX_BASE,
> -		.end		= OMAP34XX_MAILBOX_BASE + 
> MBOX_REG_SIZE - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -	{
> -		.start		= INT_24XX_MAIL_U0_MPU,
> -		.flags		= IORESOURCE_IRQ,
> -		.name		= "dsp",
> -	},
> -};
> -static int omap3_mbox_resources_sz = 
> ARRAY_SIZE(omap3_mbox_resources);
> -#else
> -#define omap3_mbox_resources		NULL
> -#define omap3_mbox_resources_sz		0
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -
> -#define OMAP4_MBOX_REG_SIZE	0x130
> -static struct resource omap4_mbox_resources[] = {
> -	{
> -		.start          = OMAP44XX_MAILBOX_BASE,
> -		.end            = OMAP44XX_MAILBOX_BASE +
> -					OMAP4_MBOX_REG_SIZE - 1,
> -		.flags          = IORESOURCE_MEM,
> -	},
> -	{
> -		.start          = OMAP44XX_IRQ_MAIL_U0,
> -		.flags          = IORESOURCE_IRQ,
> -		.name		= "mbox",
> -	},
> -};
> -static int omap4_mbox_resources_sz = 
> ARRAY_SIZE(omap4_mbox_resources);
> -#else
> -#define omap4_mbox_resources		NULL
> -#define omap4_mbox_resources_sz		0
> -#endif
> -
> -static struct platform_device mbox_device = {
> -	.name		= "omap-mailbox",
> -	.id		= -1,
> -};
> -
>  static inline void omap_init_mbox(void)
>  {
> -	if (cpu_is_omap24xx()) {
> -		mbox_device.resource = omap2_mbox_resources;
> -		mbox_device.num_resources = omap2_mbox_resources_sz;
> -	} else if (cpu_is_omap34xx()) {
> -		mbox_device.resource = omap3_mbox_resources;
> -		mbox_device.num_resources = omap3_mbox_resources_sz;
> -	} else if (cpu_is_omap44xx()) {
> -		mbox_device.resource = omap4_mbox_resources;
> -		mbox_device.num_resources = omap4_mbox_resources_sz;
> -	} else {
> -		pr_err("%s: platform not supported\n", __func__);
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +
> +	oh = omap_hwmod_lookup("mailbox");
> +	if (!oh) {
> +		pr_err("%s: unable to find hwmod\n", __func__);
> +		return;
> +	}
> +
> +	od = omap_device_build("omap-mailbox", -1, oh,
> +			NULL, 0,
> +			NULL, 0,
> +			0);

This patch series breaks OMAP4 support.

OMAP2 support is broken with this patch and the same is fixed
in the next patch. Hence patch 2 should be ordered before patch 1. 

> +	if (!od) {
> +		pr_err("%s: could not build device\n", __func__);
>  		return;
>  	}
> -	platform_device_register(&mbox_device);
>  }
>  #else
>  static inline void omap_init_mbox(void) { }
> diff --git a/arch/arm/mach-omap2/mailbox.c 
> b/arch/arm/mach-omap2/mailbox.c
> index 40ddeca..1ddb82d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <plat/mailbox.h>
> +#include <plat/omap_hwmod.h>

Is this required? I do not see this file using any hwmod info.

-V Charulatha