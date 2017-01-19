From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 5/5] usb: musb: da8xx: Add a primary support of PM
 runtime
Date: Thu, 19 Jan 2017 19:42:08 +0300
Message-ID: <6287b54d-c5ed-dc2d-2077-3eaa4a4e7d4a@cogentembedded.com>
References: <20170119140835.18981-1-abailon@baylibre.com>
 <20170119140835.18981-6-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119140835.18981-6-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/19/2017 05:08 PM, Alexandre Bailon wrote:

> Currently, DA8xx doesn't support PM runtime.
> In addition, the glue driver is managing the clock itself.
> But the CPPI DMA needs to manage this clock too.
> Add support to PM runtime and use the callback to enable / disable
> the clock.

    I think this sentence is stale now....

> And because the CPPI 4.1 is a child of Da8xx USB,
> it will be able to enable / disable the clock by using PM runtime.
>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/usb/musb/da8xx.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index 8c9850c..c4478c7 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
[...]
> @@ -377,11 +375,7 @@ static int da8xx_musb_init(struct musb *musb)
>
>  	musb->mregs += DA8XX_MENTOR_CORE_OFFSET;
>
> -	ret = clk_prepare_enable(glue->clk);
> -	if (ret) {
> -		dev_err(glue->dev, "failed to enable clock\n");
> -		return ret;
> -	}
> +	pm_runtime_get_sync(musb->controller->parent);
>
>  	/* Returns zero if e.g. not clocked */
>  	rev = musb_readl(reg_base, DA8XX_USB_REVISION_REG);
> @@ -424,7 +418,7 @@ static int da8xx_musb_init(struct musb *musb)
>  err_phy_power_on:
>  	phy_exit(glue->phy);
>  fail:
> -	clk_disable_unprepare(glue->clk);
> +	pm_runtime_put_sync(musb->controller->parent);

    Not sure we need put_sync() here and below -- usually a simple put() is 
used...

[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
