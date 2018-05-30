From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/6] bus: ti-sysc: Add support for using ti-sysc for
 MCAN on dra76x
Date: Wed, 30 May 2018 07:57:26 -0700
Message-ID: <20180530145726.GD5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180530141133.3711-5-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
> The dra76x MCAN generic interconnect module has a its own
> format for the bits in the control registers.
...
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -1262,6 +1262,22 @@ static const struct sysc_capabilities sysc_omap4_usb_host_fs = {
>  	.regbits = &sysc_regbits_omap4_usb_host_fs,
>  };
>  
> +static const struct sysc_regbits sysc_regbits_dra7_mcan = {
> +	.dmadisable_shift = -ENODEV,
> +	.midle_shift = -ENODEV,
> +	.sidle_shift = -ENODEV,
> +	.clkact_shift = -ENODEV,
> +	.enwkup_shift = 4,
> +	.srst_shift = 0,
> +	.emufree_shift = -ENODEV,
> +	.autoidle_shift = -ENODEV,
> +};
> +
> +static const struct sysc_capabilities sysc_dra7_mcan = {
> +	.type = TI_SYSC_DRA7_MCAN,
> +	.regbits = &sysc_regbits_dra7_mcan,
> +};
> +
>  static int sysc_init_pdata(struct sysc *ddata)
>  {
>  	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
> @@ -1441,6 +1457,7 @@ static const struct of_device_id sysc_match[] = {
>  	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
>  	{ .compatible = "ti,sysc-usb-host-fs",
>  	  .data = &sysc_omap4_usb_host_fs, },
> +	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
>  	{  },
>  };

Looks good to me. And presumably you checked that no other dra7 modules
use sysconfig register bit layout like this?

Regards,

Tony
