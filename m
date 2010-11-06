From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 4/7] omap: mailbox: initial hwmod support
Date: Sat, 06 Nov 2010 13:44:25 -0400
Message-ID: <4CD593F9.6070200@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com> <1289006244-27147-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46968 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab0KFRnd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 13:43:33 -0400
In-Reply-To: <1289006244-27147-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Felipe,

On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
> From: Felipe Contreras<felipe.contreras@gmail.com>
>
> hwmod support for omap mailbox module.
>
> Signed-off-by: Felipe Contreras<felipe.contreras@gmail.com>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/devices.c |  100 ++++++----------------------------------
>   1 files changed, 15 insertions(+), 85 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index eaf3799..d977572 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -141,95 +141,25 @@ static inline void omap_init_camera(void)
>   #endif
>
>   #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
> -
> -#define MBOX_REG_SIZE   0x120
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct resource omap2_mbox_resources[] = {
> -	{
> -		.start		= OMAP24XX_MAILBOX_BASE,
> -		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
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
> -static int omap2_mbox_resources_sz = ARRAY_SIZE(omap2_mbox_resources);
> -#else
> -#define omap2_mbox_resources		NULL
> -#define omap2_mbox_resources_sz		0
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct resource omap3_mbox_resources[] = {
> -	{
> -		.start		= OMAP34XX_MAILBOX_BASE,
> -		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -	{
> -		.start		= INT_24XX_MAIL_U0_MPU,
> -		.flags		= IORESOURCE_IRQ,
> -		.name		= "dsp",
> -	},
> -};
> -static int omap3_mbox_resources_sz = ARRAY_SIZE(omap3_mbox_resources);
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
> -static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
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
>   static inline void omap_init_mbox(void)
>   {
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

If possible, it will be better to use the "omap_" prefix in order to 
start having some consitency in the omap devices name.

Today, we have a little bit of a mess:

i2c_omap.1
omap2_mcspi.1
omap-mcbsp.1
mmci-omap-hs.0
musb_hdrc
omap-aes
omap-sham
omap_hdq.0
omap_rng
omap_wdt
omapdss


Thanks,
Benoit

> +			NULL, 0,
> +			NULL, 0,
> +			0);
> +	if (!od) {
> +		pr_err("%s: could not build device\n", __func__);
>   		return;
>   	}
> -	platform_device_register(&mbox_device);
>   }
>   #else
>   static inline void omap_init_mbox(void) { }

