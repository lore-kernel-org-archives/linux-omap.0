From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] musb: omap: Fix: pass all the resources to musb core
Date: Mon, 08 Jul 2013 16:22:02 +0400
Message-ID: <51DAAEEA.60409@cogentembedded.com>
References: <1373280929-19052-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373280929-19052-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 08-07-2013 14:55, Kishon Vijay Abraham I wrote:

> commit 09fc7d (usb: musb: fix incorrect usage of resource pointer)
> assumes musb core will always have only 2 resources. But for OMAP
> platforms there can be 3 resources (2 irq resource and 1 iomem
> resource). Fixed it here.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/usb/musb/omap2430.c |   18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)

> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 5b6113a..5bbef78 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
[...]
> @@ -489,6 +489,7 @@ static int omap2430_probe(struct platform_device *pdev)
>   	struct device_node		*np = pdev->dev.of_node;
>   	struct musb_hdrc_config		*config;
>   	int				ret = -ENOMEM;
> +	int				i = 0;

    Redundant initialization.

>   	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
>   	if (!glue) {
> @@ -571,15 +572,12 @@ static int omap2430_probe(struct platform_device *pdev)
>   	memset(musb_resources, 0x00, sizeof(*musb_resources) *
>   			ARRAY_SIZE(musb_resources));
>
> -	musb_resources[0].name = pdev->resource[0].name;
> -	musb_resources[0].start = pdev->resource[0].start;
> -	musb_resources[0].end = pdev->resource[0].end;
> -	musb_resources[0].flags = pdev->resource[0].flags;
> -
> -	musb_resources[1].name = pdev->resource[1].name;
> -	musb_resources[1].start = pdev->resource[1].start;
> -	musb_resources[1].end = pdev->resource[1].end;
> -	musb_resources[1].flags = pdev->resource[1].flags;
> +	for (i = 0; i < ARRAY_SIZE(musb_resources); i++) {
> +		musb_resources[i].name = pdev->resource[i].name;
> +		musb_resources[i].start = pdev->resource[i].start;
> +		musb_resources[i].end = pdev->resource[i].end;
> +		musb_resources[i].flags = pdev->resource[i].flags;
> +	}

WBR, Sergei
