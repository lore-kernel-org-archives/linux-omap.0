From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb: musb: omap2430: use *syscon* framework API to write
 to mailbox register
Date: Wed, 5 Aug 2015 01:01:14 -0700
Message-ID: <20150805080113.GV16878@atomide.com>
References: <1438697169-32359-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438697169-32359-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150804 07:11]:
> Deprecate using phy-omap-control driver to write to the mailbox register
> and start using *syscon* framework to do the same.
..
> @@ -512,6 +558,40 @@ static const struct musb_platform_ops omap2430_ops = {
>  
>  static u64 omap2430_dmamask = DMA_BIT_MASK(32);
>  
> +static int omap2430_get_sys_ctrl(struct omap2430_glue *glue,
> +				 struct device_node *np)
> +{
> +	struct device_node *control_node;
> +	struct platform_device *control_pdev;
> +
> +	glue->syscon_otghs = syscon_regmap_lookup_by_phandle(np,
> +							     "syscon-otghs");
> +	if (IS_ERR(glue->syscon_otghs)) {
> +		dev_dbg(glue->dev, "can't get syscon, using control device\n");
> +		glue->syscon_otghs = NULL;
> +
> +		control_node = of_parse_phandle(np, "ctrl-module", 0);
> +		if (control_node) {
> +			control_pdev = of_find_device_by_node(control_node);
> +			if (!control_pdev) {
> +				dev_err(glue->dev,
> +					"Failed to get control device\n");
> +				return -EINVAL;
> +			}
> +			glue->control_otghs = &control_pdev->dev;
> +		}
> +	} else {
> +		if (of_property_read_u32_index(np, "syscon-otghs", 1,
> +					       &glue->otghs_reg)) {
> +			dev_err(glue->dev,
> +				"couldn't get otghs reg. offset\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}

We don't have syscon-otghs and to me it seems we need a PHY driver
as I pointed out at:

https://lkml.org/lkml/2015/6/24/231

So let's sort that issue first. It also seems this just completely
breaks the MUSB support?

Regards,

Tony
