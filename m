From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 6/6] usb: dwc3: core: add dt support for dwc3 core
Date: Sun, 30 Sep 2012 18:47:22 +0200
Message-ID: <5068779A.20402@mvista.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com> <1348836795-4783-7-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1348836795-4783-7-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hello.

On 28-09-2012 14:53, Kishon Vijay Abraham I wrote:

> Added dwc3 support for dwc3 core and update the documentation with
> device tree binding information.
>
> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
[...]

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 08a5738..0c17a7a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
[...]
> @@ -602,11 +601,22 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_dwc3_matach[] = {

     I guess you meant 'of_dwc3_match' here and below?


> +	{
> +		.compatible = "synopsis,dwc3"
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_dwc3_matach);
> +#endif
> +
>   static struct platform_driver dwc3_driver = {
>   	.probe		= dwc3_probe,
>   	.remove		= __devexit_p(dwc3_remove),
>   	.driver		= {
>   		.name	= "dwc3",
> +		.of_match_table	= of_match_ptr(of_dwc3_matach),
>   	},
>   };
>   

WBR, Sergei

