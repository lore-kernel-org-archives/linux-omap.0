From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] usb: musb: omap: Add device tree support for omap
 musb glue
Date: Tue, 11 Sep 2012 15:23:55 +0530
Message-ID: <504F0A33.9060606@ti.com>
References: <1347354580-5895-1-git-send-email-kishon@ti.com>
 <1347354580-5895-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1347354580-5895-4-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 9/11/2012 2:39 PM, Kishon Vijay Abraham I wrote:
> Added device tree support for omap musb driver and updated the
> Documentation with device tree binding information.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/usb/omap-usb.txt |   33 ++++++++++++
>  drivers/usb/musb/omap2430.c                        |   54 ++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/omap-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> new file mode 100644
> index 0000000..29a043e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -0,0 +1,33 @@
> +OMAP GLUE
> +
> +OMAP MUSB GLUE
> + - compatible : Should be "ti,omap4-musb" or "ti,omap3-musb"
> + - ti,hwmods : must be "usb_otg_hs"
> + - multipoint : Should be "1" indicating the musb controller supports
> +   multipoint. This is a MUSB configuration-specific setting.
> + - num_eps : Specifies the number of endpoints. This is also a
> +   MUSB configuration-specific setting. Should be set to "16"
> + - ram_bits : Specifies the ram address size. Should be set to "12"
> + - interface_type : This is a board specific setting to describe the type of
> +   interface between the controller and the phy. It should be "0" or "1"
> +   specifying ULPI and UTMI respectively.
> + - mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
> +   represents PERIPHERAL.
> + - power : Should be "50". This signifies the controller can supply upto
> +   100mA when operating in host mode.
> +
> +SOC specific device node entry
> +usb_otg_hs: usb_otg_hs@4a0ab000 {
> +	compatible = "ti,omap4-musb";
> +	ti,hwmods = "usb_otg_hs";
> +	multipoint = <1>;
> +	num_eps = <16>;
> +	ram_bits = <12>;
> +};


reg and interrupt properties are missing here.

I would encourage to specify "reg" and "interrupt" properties in every
node getting newly added to the OMAP DTS files.


Thanks,
Vaibhav
> +
> +Board specific device node entry
> +&usb_otg_hs {
> +	interface_type = <1>;
> +	mode = <3>;
> +	power = <50>;
> +};
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index f4d9503..d96873b 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -30,6 +30,7 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
> @@ -470,8 +471,11 @@ static u64 omap2430_dmamask = DMA_BIT_MASK(32);
>  static int __devinit omap2430_probe(struct platform_device *pdev)
>  {
>  	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
> +	struct omap_musb_board_data	*data;
>  	struct platform_device		*musb;
>  	struct omap2430_glue		*glue;
> +	struct device_node		*np = pdev->dev.of_node;
> +	struct musb_hdrc_config		*config;
>  	struct resource			*res;
>  	int				ret = -ENOMEM;
>  
> @@ -501,6 +505,42 @@ static int __devinit omap2430_probe(struct platform_device *pdev)
>  	if (glue->control_otghs == NULL)
>  		dev_dbg(&pdev->dev, "Failed to obtain control memory\n");
>  
> +	if (np) {
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata) {
> +			dev_err(&pdev->dev,
> +				"failed to allocate musb platfrom data\n");
> +			ret = -ENOMEM;
> +			goto err1;
> +		}
> +
> +		data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +		if (!data) {
> +			dev_err(&pdev->dev,
> +					"failed to allocate musb board data\n");
> +			ret = -ENOMEM;
> +			goto err1;
> +		}
> +
> +		config = devm_kzalloc(&pdev->dev, sizeof(*config), GFP_KERNEL);
> +		if (!data) {
> +			dev_err(&pdev->dev,
> +				"failed to allocate musb hdrc config\n");
> +			goto err1;
> +		}
> +
> +		of_property_read_u32(np, "mode", (u32 *)&pdata->mode);
> +		of_property_read_u32(np, "interface_type",
> +						(u32 *)&data->interface_type);
> +		of_property_read_u32(np, "num_eps", (u32 *)&config->num_eps);
> +		of_property_read_u32(np, "ram_bits", (u32 *)&config->ram_bits);
> +		of_property_read_u32(np, "power", (u32 *)&pdata->power);
> +		config->multipoint = of_property_read_bool(np, "multipoint");
> +
> +		pdata->board_data	= data;
> +		pdata->config		= config;
> +	}
> +
>  	pdata->platform_ops		= &omap2430_ops;
>  
>  	platform_set_drvdata(pdev, glue);
> @@ -597,12 +637,26 @@ static struct dev_pm_ops omap2430_pm_ops = {
>  #define DEV_PM_OPS	NULL
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id omap2430_id_table[] = {
> +	{
> +		.compatible = "ti,omap4-musb"
> +	},
> +	{
> +		.compatible = "ti,omap3-musb"
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap2430_id_table);
> +#endif
> +
>  static struct platform_driver omap2430_driver = {
>  	.probe		= omap2430_probe,
>  	.remove		= __devexit_p(omap2430_remove),
>  	.driver		= {
>  		.name	= "musb-omap2430",
>  		.pm	= DEV_PM_OPS,
> +		.of_match_table = of_match_ptr(omap2430_id_table),
>  	},
>  };
>  
> 
