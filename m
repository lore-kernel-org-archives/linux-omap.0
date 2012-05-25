From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 04/11] OMAP: Add early device for system control module
Date: Fri, 25 May 2012 14:32:41 +0200
Message-ID: <4FBF7BE9.7050804@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49504 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab2EYMcw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 08:32:52 -0400
In-Reply-To: <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
> This is a way to add an early device for system control module.
> the code is also requesting for driver registration and probing.
> Done at early_initcall because at that time, ioremapping is possible.
>
> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
> ---
>   arch/arm/mach-omap2/devices.c |   29 +++++++++++++++++++++++++++++
>   1 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 9332673..58cc5c3 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -40,6 +40,35 @@
>   #define L3_MODULES_MAX_LEN 12
>   #define L3_MODULES 3
>
> +static struct resource control_resources[] = {
> +	[0] = {
> +		.start	= 0x4a002000,
> +		.end	= 0x4a0027ff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};

I guess you should be able to do use DT to build the early device as well.
It will avoid hard coding some physical address inside the devices.

Regards,
Benoit


> +static struct platform_device control_device = {
> +	.name		= "omap-control-core",
> +	.id		= 0,
> +	.resource	= control_resources,
> +	.num_resources	= ARRAY_SIZE(control_resources),
> +};
> +
> +static struct platform_device *early_devices[] __initdata = {
> +	&control_device,
> +};
> +
> +static int __init plat_early_device_setup(void)
> +{
> +	early_platform_add_devices(early_devices,
> +				   ARRAY_SIZE(early_devices));
> +	early_platform_driver_register_all("early_omap_control");
> +	early_platform_driver_probe("early_omap_control", 1, false);
> +
> +	return 0;
> +}
> +early_initcall(plat_early_device_setup);
> +
>   static int omap_init_control(void)
>   {
>   	struct omap_hwmod		*oh;

