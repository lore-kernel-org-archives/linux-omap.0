From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH v4 5/8] MFD: ti_am335x_tscadc: Add DT support
Date: Wed, 30 Jan 2013 11:40:09 +0100
Message-ID: <A9839AA2-ABCD-4642-9766-D56824AC27AD@dominion.thruhere.net>
References: <1358999112-31192-1-git-send-email-rachna@ti.com> <1358999112-31192-6-git-send-email-rachna@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358999112-31192-6-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, gururaja.hebbar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Op 24 jan. 2013, om 04:45 heeft "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org> het volgende geschreven:

> From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
> 
> Make changes to add DT support in the MFD core driver.
> 
> Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> ---
> Changes in v4:
> 	Non-standard properties prefixed with vendor name.
> 
> drivers/mfd/ti_am335x_tscadc.c |   28 +++++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index e9f3fb5..87b446b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -22,6 +22,8 @@
> #include <linux/regmap.h>
> #include <linux/mfd/core.h>
> #include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> 
> #include <linux/mfd/ti_am335x_tscadc.h>
> #include <linux/input/ti_am335x_tsc.h>
> @@ -64,20 +66,31 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> 	struct resource		*res;
> 	struct clk		*clk;
> 	struct mfd_tscadc_board	*pdata = pdev->dev.platform_data;
> +	struct device_node	*node = pdev->dev.of_node;
> 	struct mfd_cell		*cell;
> 	int			err, ctrl;
> 	int			clk_value, clock_rate;
> -	int			tsc_wires, adc_channels = 0, total_channels;
> +	int			tsc_wires = 0, adc_channels = 0, total_channels;
> 
> -	if (!pdata) {
> +	if (!pdata && !pdev->dev.of_node) {
> 		dev_err(&pdev->dev, "Could not find platform data\n");
> 		return -EINVAL;
> 	}
> 
> -	if (pdata->adc_init)
> -		adc_channels = pdata->adc_init->adc_channels;
> +	if (pdev->dev.platform_data) {
> +		if (pdata->tsc_init)
> +			tsc_wires = pdata->tsc_init->wires;
> +
> +		if (pdata->adc_init)
> +			adc_channels = pdata->adc_init->adc_channels;
> +	} else {
> +		node = of_find_node_by_name(pdev->dev.of_node, "tsc");
> +		of_property_read_u32(node, "ti,wires", &tsc_wires);
> +
> +		node = of_find_node_by_name(pdev->dev.of_node, "adc");
> +		of_property_read_u32(node, "ti,adc-channels", &adc_channels);
> +	}

Since AM335x is DT only, why is there a platform data codepath and why is it the first branch it tries? And I guess the next question is related to the first: why doesn't it work when used with DT? When I copy over the nodes from the evm.dts to my board I get "tsc tsc: Missing platform data" in dmesg.

What are the chances this driver will work when applied on top of 3.8-rcX? Has it even been tested with that? Has it been tested at all?
