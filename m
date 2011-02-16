From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6 v7] usb: musb: Using runtime pm APIs for musb.
Date: Wed, 16 Feb 2011 15:56:39 +0300
Message-ID: <4D5BC987.7090207@ru.mvista.com>
References: <1297859298-27861-1-git-send-email-hemahk@ti.com> <1297859298-27861-7-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297859298-27861-7-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 16-02-2011 15:28, Hema HK wrote:

> Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
> for enabling/disabling the clocks, sysconfig settings.

> Enable clock, configure no-idle/standby when active and configure force idle/standby
> and disable clock when idled. This is taken care by the runtime framework when
> driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.
> Need to configure MUSB into force standby and force idle mode when usb not used

> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
[...]

> Index: linux-2.6/drivers/usb/musb/omap2430.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/musb/omap2430.c
> +++ linux-2.6/drivers/usb/musb/omap2430.c
[...]
> @@ -498,8 +463,10 @@ static int omap2430_suspend(struct devic
>   	omap2430_low_level_exit(musb);
>   	otg_set_suspend(musb->xceiv, 1);
>   	omap2430_save_context(musb);
> -	clk_disable(glue->clk);
>
> +	if (!pm_runtime_suspended(dev))
> +		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)

    Could be collapsed into single *if*...

> +				dev->bus->pm->runtime_suspend(dev);

    The above line is over-indented.

>   	return 0;
>   }
>
> @@ -507,13 +474,10 @@ static int omap2430_resume(struct device
>   {
>   	struct omap2430_glue		*glue = dev_get_drvdata(dev);
>   	struct musb			*musb = glue_to_musb(glue);
> -	int				ret;
>
> -	ret = clk_enable(glue->clk);
> -	if (ret) {
> -		dev_err(dev, "faled to enable clock\n");
> -		return ret;
> -	}
> +	if (!pm_runtime_suspended(dev))
> +		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)

    Could be collapsed into single *if*...

> +			dev->bus->pm->runtime_resume(dev);
>
>   	omap2430_low_level_init(musb);
>   	omap2430_restore_context(musb);

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
