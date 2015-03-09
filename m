From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v5 2/3] wl18xx: add basic device-tree support
Date: Mon, 09 Mar 2015 20:47:46 +0100
Message-ID: <10327320.45ToCM2gnq@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com> <1425915402-10012-2-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425915402-10012-2-git-send-email-eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 09 March 2015 17:36:41 Eliad Peller wrote:
> @@ -323,11 +388,14 @@ out:
>  static void wl1271_remove(struct sdio_func *func)
>  {
>         struct wl12xx_sdio_glue *glue = sdio_get_drvdata(func);
> +       struct wlcore_platdev_data *pdev_data = glue->core->dev.platform_data;
> +       struct wl12xx_platform_data *pdata = pdev_data->pdata;
>  
>         /* Undo decrement done above in wl1271_probe */
>         pm_runtime_get_noresume(&func->dev);
>  
>         platform_device_unregister(glue->core);
> +       wlcore_del_platform_data(pdata);
>         kfree(glue);
>  }
>  
> 

The third patch looks ok, but now you should remove the wl12xx_platform_data
from the wlcore code, since it's not used any more, it was broken to start
with (as it supports only one instance) and we want to prevent others from
adding new users of that. Since the only thing you need is the irq number,
you can directly add the irq number to struct wlcore_platdev_data and
remove the pdata pointer there.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
