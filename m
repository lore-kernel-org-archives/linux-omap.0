From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCHv5 2/7] HSI: omap_ssi: Introducing OMAP SSI driver
Date: Mon, 13 Jun 2011 06:21:53 -0700
Message-ID: <20110613132152.GA3352@atomide.com>
References: <1307713124-3946-1-git-send-email-carlos.chinea@nokia.com>
 <1307713124-3946-3-git-send-email-carlos.chinea@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307713124-3946-3-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Carlos Chinea <carlos.chinea@nokia.com> [110610 06:41]:
> --- /dev/null
> +++ b/arch/arm/mach-omap2/ssi.c
> +static struct platform_device ssi_pdev = {
> +	.name		= "omap_ssi",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(ssi_resources),
> +	.resource	= ssi_resources,
> +	.dev		= {
> +				.platform_data	= &ssi_pdata,
> +	},
> +};
> +
> +int __init omap_ssi_config(struct omap_ssi_board_config *ssi_config)
> +{
> +	unsigned int port, offset, cawake_gpio;
> +	int err;
> +
> +	ssi_pdata.num_ports = ssi_config->num_ports;
> +	for (port = 0, offset = 7; port < ssi_config->num_ports;
> +							port++, offset += 5) {
> +		cawake_gpio = ssi_config->cawake_gpio[port];
> +		if (!cawake_gpio)
> +			continue; /* Nothing to do */
> +		err = gpio_request(cawake_gpio, "cawake");
> +		if (err < 0)
> +			goto rback;
> +		gpio_direction_input(cawake_gpio);
> +		ssi_resources[offset].start = gpio_to_irq(cawake_gpio);
> +		ssi_resources[offset].flags &= ~IORESOURCE_UNSET;
> +		ssi_resources[offset].flags |= IORESOURCE_IRQ_HIGHEDGE |
> +							IORESOURCE_IRQ_LOWEDGE;
> +	}
> +
> +	return 0;
> +rback:
> +	dev_err(&ssi_pdev.dev, "Request cawake (gpio%d) failed\n", cawake_gpio);
> +	while (port > 0)
> +		gpio_free(ssi_config->cawake_gpio[--port]);
> +
> +	return err;
> +}
> +
> +static int __init ssi_init(void)
> +{
> +	return platform_device_register(&ssi_pdev);
> +}
> +subsys_initcall(ssi_init);

Looks like you need something here also to prevent this subsys_initcall
on running on all boards. Maybe have a pointer to ssi_pdev that only
gets initialized after omap_ssi_config?

Then you can have ssi_init fail if no configuration is called:

	if (!pdev)
		return -ENODEV;

	return platform_device_register(pdev);

Regards,

Tony
