From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/5] Add device tree support for M-USB on AM35xx SOCs
Date: Wed, 28 Oct 2015 15:58:14 +0300
Message-ID: <5630C666.1030107@cogentembedded.com>
References: <562A557B.4090501@imms.de> <562A5793.3020200@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A5793.3020200-cSCHQGRfioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 10/23/2015 6:51 PM, Rolf Peukert wrote:

> Add a function that sets up necessary data structures. In older kernels
> this was done in a board_ file. To support initialization via a DT, this
> now needs to be included in the probe() function.
> Also declare a new device 'compatible' name (am35x-musb) to
> differentiate it from omap3-musb.
>
> Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
> ---
>   drivers/usb/musb/am35x.c | 73
> ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
>
> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> index c41fe58..3c1477a 100644
> --- a/drivers/usb/musb/am35x.c
> +++ b/drivers/usb/musb/am35x.c
> @@ -462,6 +462,59 @@ static const struct platform_device_info
> am35x_dev_info = {
>   	.dma_mask	= DMA_BIT_MASK(32),
>   };
>
> +static struct musb_hdrc_platform_data *am35x_get_config(
> +	struct platform_device *pdev)
> +{
[...]
> +	/* Read settings from device tree */
> +	np = pdev->dev.of_node;
> +	if (np) {
> +		of_property_read_u32(np, "mode", (u32 *)&pdata->mode);
> +		of_property_read_u32(np, "interface-type",
> +				(u32 *)&bdata->interface_type);
> +		of_property_read_u32(np, "num-eps", (u32 *)&config->num_eps);
> +		of_property_read_u32(np, "ram-bits", (u32 *)&config->ram_bits);
> +		of_property_read_u32(np, "power", (u32 *)&pdata->power);
> +
> +		ret = of_property_read_u32(np, "multipoint", &val);
> +		if (!ret && val)
> +			config->multipoint = true;

    These are common MUSB traits, so I think should be parsed by a generic 
function. If at all -- they might be determined from the "compatible" prop.

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
