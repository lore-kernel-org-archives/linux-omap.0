From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [5/7 v2] usb: otg: TWL6030: Introduce the twl6030_phy_suspend
 function.
Date: Tue, 15 Feb 2011 15:22:17 +0300
Message-ID: <4D5A6FF9.8000709@ru.mvista.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com> <1297762958-26199-5-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297762958-26199-5-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 15-02-2011 12:42, Hema HK wrote:

> From: Kalliguddi, Hema<hemahk-l0cyMroinI0@public.gmane.org>

> Introduce the twl6030_phy_suspend function and assign to otg.set_suspend
> function pointer.
> This function is used by the musb-omap2430 platform driver
> during suspend/resume.

> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>

[...]

> Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
> +++ linux-2.6/drivers/usb/otg/twl6030-usb.c
> @@ -177,6 +177,20 @@ static void twl6030_phy_shutdown(struct
>   	pdata->phy_power(twl->dev, 0, 0);
>   }
>
> +static int twl6030_phy_suspend(struct otg_transceiver *x, int suspend)
> +{
> +	struct twl6030_usb *twl;
> +	struct device *dev;
> +	struct twl4030_usb_data *pdata;
> +
> +	twl = xceiv_to_twl(x);
> +	dev  = twl->dev;
> +	pdata = dev->platform_data;

    Why not do all the above in the intializers?

> +	pdata->phy_suspend(twl->dev, suspend);
> +
> +	return 0;
> +}
> +

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
