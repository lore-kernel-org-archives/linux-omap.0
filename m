From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v1 09/11] drivers: usb: musb: Add device tree support
 for omap musb glue
Date: Tue, 10 Jul 2012 07:14:22 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EACE24C@DBDE01.ent.ti.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>
 <1340884267-28908-10-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340884267-28908-10-git-send-email-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
>  Documentation/devicetree/bindings/usb/omap-usb.txt |   34
> ++++++++++++-
>  drivers/usb/musb/omap2430.c                        |   52
> ++++++++++++++++++++
[...]
> +		of_property_read_u32(np, "mode", (u32 *)&pdata->mode);
> +		of_property_read_u32(np, "interface_type",
> +						(u32 *)&data->interface_type);
> +		of_property_read_u32(np, "num_eps", (u32 *)&config-
> >num_eps);
> +		of_property_read_u32(np, "ram_bits", (u32 *)&config-
> >ram_bits);
> +		of_property_read_u32(np, "mode", (u32 *)&pdata->mode);

'mode' has already been read so this should be dropped.

Ajay

> +		of_property_read_u32(np, "power", (u32 *)&pdata->power);
> +		config->multipoint = of_property_read_bool(np,
> "multipoint");
> +
> +		pdata->board_data	= data;
> +		pdata->config		= config;
> +	}
> +
>  	pdata->platform_ops		= &omap2430_ops;
> 
>  	platform_set_drvdata(pdev, glue);
> @@ -597,12 +638,23 @@ static struct dev_pm_ops omap2430_pm_ops = {
>  #define DEV_PM_OPS	NULL
>  #endif
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id omap2430_id_table[] = {
> +	{ .compatible = "ti,musb-omap2430" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, omap2430_id_table);
> +#else
> +#define omap2430_id_table NULL
> +#endif
> +
>  static struct platform_driver omap2430_driver = {
>  	.probe		= omap2430_probe,
>  	.remove		= __devexit_p(omap2430_remove),
>  	.driver		= {
>  		.name	= "musb-omap2430",
>  		.pm	= DEV_PM_OPS,
> +		.of_match_table = omap2430_id_table,
>  	},
>  };
> 
> --
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
