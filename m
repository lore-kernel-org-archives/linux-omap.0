From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [2.6.29-rc7][take #2][PATCH 2/3] ARM: OMAP: Add command line
	option for I2C bus speed
Date: Mon, 16 Mar 2009 10:29:08 -0700
Message-ID: <20090316172908.GA19229@atomide.com>
References: <20090306161349.GC32353@atomide.com> <1236674831-3637-1-git-send-email-jarkko.nikula@nokia.com> <1236674831-3637-2-git-send-email-jarkko.nikula@nokia.com> <1236674831-3637-3-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1236674831-3637-3-git-send-email-jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [090310 01:47]:
> This patch adds a new command line option "i2c_bus=bus_id,clkrate" into
> I2C bus registration helper. Purpose of the option is to override the
> default board specific bus speed which is supplied by the
> omap_register_i2c_bus.
> 
> The default bus speed is typically set to speed of slowest I2C chip on the
> bus and overriding allow to use some experimental configurations or updated
> chip versions without any kernel modifications.

Thanks for updating this. I've updated my omap-upstream series with your
patches #2 and #3, looks like #1 did not need updating.

Regards,

Tony
 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/kernel-parameters.txt |    4 ++
>  arch/arm/plat-omap/i2c.c            |   54 ++++++++++++++++++++++++++++------
>  2 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 54f21a5..d775076 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -830,6 +830,10 @@ and is between 256 and 4096 characters. It is defined in the file
>  	hvc_iucv=	[S390] Number of z/VM IUCV hypervisor console (HVC)
>  			       terminal devices. Valid values: 0..8
>  
> +	i2c_bus=	[HW] Override the default board specific I2C bus speed
> +			     Format:
> +			     <bus_id>,<clkrate>
> +
>  	i8042.debug	[HW] Toggle i8042 debug mode
>  	i8042.direct	[HW] Put keyboard port into non-translated mode
>  	i8042.dumbkbd	[HW] Pretend that controller can only read data from
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index 3e95954..aa70e43 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -119,6 +119,46 @@ static void __init omap_i2c_mux_pins(int bus)
>  	omap_cfg_reg(scl);
>  }
>  
> +static int __init omap_i2c_nr_ports(void)
> +{
> +	int ports = 0;
> +
> +	if (cpu_class_is_omap1())
> +		ports = 1;
> +	else if (cpu_is_omap24xx())
> +		ports = 2;
> +	else if (cpu_is_omap34xx())
> +		ports = 3;
> +
> +	return ports;
> +}
> +
> +/**
> + * omap_i2c_bus_setup - Process command line options for the I2C bus speed
> + * @str: String of options
> + *
> + * This function allow to override the default I2C bus speed for given I2C
> + * bus with a command line option.
> + *
> + * Format: i2c_bus=bus_id,clkrate (in kHz)
> + *
> + * Returns 1 on success, 0 otherwise.
> + */
> +static int __init omap_i2c_bus_setup(char *str)
> +{
> +	int ports;
> +	int ints[3];
> +
> +	ports = omap_i2c_nr_ports();
> +	get_options(str, 3, ints);
> +	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
> +		return 0;
> +	i2c_rate[ints[1] - 1] = ints[2];
> +
> +	return 1;
> +}
> +__setup("i2c_bus=", omap_i2c_bus_setup);
> +
>  /**
>   * omap_register_i2c_bus - register I2C bus with device descriptors
>   * @bus_id: bus id counting from number 1
> @@ -132,19 +172,12 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
>  			  struct i2c_board_info const *info,
>  			  unsigned len)
>  {
> -	int ports, err;
> +	int err;
>  	struct platform_device *pdev;
>  	struct resource *res;
>  	resource_size_t base, irq;
>  
> -	if (cpu_class_is_omap1())
> -		ports = 1;
> -	else if (cpu_is_omap24xx())
> -		ports = 2;
> -	else if (cpu_is_omap34xx())
> -		ports = 3;
> -
> -	BUG_ON(bus_id < 1 || bus_id > ports);
> +	BUG_ON(bus_id < 1 || bus_id > omap_i2c_nr_ports());
>  
>  	if (info) {
>  		err = i2c_register_board_info(bus_id, info, len);
> @@ -153,7 +186,8 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
>  	}
>  
>  	pdev = &omap_i2c_devices[bus_id - 1];
> -	*(u32 *)pdev->dev.platform_data = clkrate;
> +	if (i2c_rate[bus_id - 1] == 0)
> +		i2c_rate[bus_id - 1] = clkrate;
>  
>  	if (bus_id == 1) {
>  		res = pdev->resource;
> -- 
> 1.6.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
