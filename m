From: Sebastien Guiriec <s-guiriec-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: pinctrl-ify i2c-omap.c
Date: Tue, 30 Oct 2012 21:14:24 +0100
Message-ID: <50903520.5050108@ti.com>
References: <1351698930-3797-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351698930-3797-1-git-send-email-panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Pantelis,

Can you look at the early thread?
   https://patchwork.kernel.org/patch/1601331/

I send a similar patch earlier with defer probe usage.

Best regards,

Sebastien
On 10/31/2012 04:55 PM, Pantelis Antoniou wrote:
> Enable pinctrl for i2c-omap.
>
> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-omap.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..4c38aa0 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -44,6 +44,8 @@
>   #include <linux/i2c-omap.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/pm_qos.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/err.h>
>
>   /* I2C controller revisions */
>   #define OMAP_I2C_OMAP1_REV_2		0x20
> @@ -1064,6 +1066,7 @@ omap_i2c_probe(struct platform_device *pdev)
>   	const struct of_device_id *match;
>   	int irq;
>   	int r;
> +	struct pinctrl *pinctrl;
>
>   	/* NOTE: driver uses the static register mapping */
>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1202,6 +1205,13 @@ omap_i2c_probe(struct platform_device *pdev)
>
>   	of_i2c_register_devices(adap);
>
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(dev->dev, "unable to select pin group\n");
> +
> +	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
> +		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
> +
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
>
>
