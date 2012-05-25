From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 04/11] OMAP: Add early device for system control module
Date: Fri, 25 May 2012 15:32:23 +0400
Message-ID: <4FBF6DC7.6070707@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:55966 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754325Ab2EYLc1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 07:32:27 -0400
In-Reply-To: <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

  Hi , Eduardo.

On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
> This is a way to add an early device for system control module.
> the code is also requesting for driver registration and probing.
> Done at early_initcall because at that time, ioremapping is possible.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 9332673..58cc5c3 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -40,6 +40,35 @@
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
>  
> +static struct resource control_resources[] = {
> +	[0] = {
> +		.start	= 0x4a002000,
> +		.end	= 0x4a0027ff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
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
I checked out git://gitorious.org/omap-thermal/omap-thermal.git omap_scm_dev.
Looks like that calling devm_kzalloc() and platform_get_resource() from early_initcall is too early.
I get following backtrace (probably the backtrace is kernel config dependent):
...
[    0.198455] [<c00193b4>] (unwind_backtrace+0x0/0xe0) from [<c02b2a10>] (do_raw_spin_lock+0x20/0x134)
[    0.207977] [<c02b2a10>] (do_raw_spin_lock+0x20/0x134) from [<c05df068>] (_raw_spin_lock_irqsave+0x58/0x64)
[    0.218109] [<c05df068>] (_raw_spin_lock_irqsave+0x58/0x64) from [<c02f03bc>] (devres_add+0x18/0x38)
[    0.227600] [<c02f03bc>] (devres_add+0x18/0x38) from [<c02f07d0>] (devm_kzalloc+0x50/0x5c)
[    0.236206] [<c02f07d0>] (devm_kzalloc+0x50/0x5c) from [<c05c73a4>] (omap_control_probe+0x20/0xe4)
[    0.245544] [<c05c73a4>] (omap_control_probe+0x20/0xe4) from [<c07b3178>] (early_platform_driver_probe+0x1ac/0x23c)
[    0.256378] [<c07b3178>] (early_platform_driver_probe+0x1ac/0x23c) from [<c0798030>] (plat_early_device_setup+0x2c/0x3c)
[    0.267700] [<c0798030>] (plat_early_device_setup+0x2c/0x3c) from [<c078f8c4>] (do_one_initcall+0x90/0x164)
[    0.277801] [<c078f8c4>] (do_one_initcall+0x90/0x164) from [<c078f9ec>] (kernel_init+0x54/0x1a4)
[    0.286956] [<c078f9ec>] (kernel_init+0x54/0x1a4) from [<c0013818>] (kernel_thread_exit+0x0/0x8)
[    0.296203] ------------[ cut here ]------------
[    0.301086] WARNING: at include/linux/kref.h:41 kobject_get+0x24/0x48()
[    0.308044] [<c00193b4>] (unwind_backtrace+0x0/0xe0) from [<c00394a4>] (warn_slowpath_common+0x48/0x60)
[    0.317871] [<c00394a4>] (warn_slowpath_common+0x48/0x60) from [<c0039574>] (warn_slowpath_null+0x18/0x1c)
[    0.327941] [<c0039574>] (warn_slowpath_null+0x18/0x1c) from [<c02a59b4>] (kobject_get+0x24/0x48)
[    0.337219] [<c02a59b4>] (kobject_get+0x24/0x48) from [<c02eb588>] (get_device+0x14/0x1c)
[    0.345764] [<c02eb588>] (get_device+0x14/0x1c) from [<c02eb66c>] (device_add+0xc4/0x594)
[    0.354370] [<c02eb66c>] (device_add+0xc4/0x594) from [<c03eeab4>] (of_platform_device_create_pdata+0x5c/0x7c)
[    0.364807] [<c03eeab4>] (of_platform_device_create_pdata+0x5c/0x7c) from [<c03eec94>] (of_platform_bus_create+0x1c0/0x258)
[    0.376403] [<c03eec94>] (of_platform_bus_create+0x1c0/0x258) from [<c03eee4c>] (of_platform_populate+0x5c/0x88)
[    0.387023] [<c03eee4c>] (of_platform_populate+0x5c/0x88) from [<c07b3178>] (early_platform_driver_probe+0x1ac/0x23c)
[    0.398101] [<c07b3178>] (early_platform_driver_probe+0x1ac/0x23c) from [<c0798030>] (plat_early_device_setup+0x2c/0x3c)
[    0.409423] [<c0798030>] (plat_early_device_setup+0x2c/0x3c) from [<c078f8c4>] (do_one_initcall+0x90/0x164)
[    0.419586] [<c078f8c4>] (do_one_initcall+0x90/0x164) from [<c078f9ec>] (kernel_init+0x54/0x1a4)
[    0.428771] [<c078f9ec>] (kernel_init+0x54/0x1a4) from [<c0013818>] (kernel_thread_exit+0x0/0x8)
[    0.437957] ---[ end trace da227214a82491b7 ]--
...

  BR,
    Konstantin Baydarov.

> +
> +	return 0;
> +}
> +early_initcall(plat_early_device_setup);
> +
>  static int omap_init_control(void)
>  {
>  	struct omap_hwmod		*oh;

