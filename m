From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: omap-usb-tll: Don't hold lock during
 pm_runtime_get/put_sync()
Date: Wed, 18 Dec 2013 10:36:41 +0000
Message-ID: <20131218103641.GD14274@lee--X1>
References: <1387360909-10624-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61029 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab3LRKgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 05:36:47 -0500
Received: by mail-wg0-f46.google.com with SMTP id m15so7175626wgh.13
        for <linux-omap@vger.kernel.org>; Wed, 18 Dec 2013 02:36:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387360909-10624-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: sameo@linux.intel.com, balbi@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, stable@vger.kernel.org

> pm_runtime_get/put_sync() can sleep so don't hold spinlock while
> calling them.
>=20
> This patch prevents a BUG() when CONFIG_DEBUG_ATOMIC_SLEEP is enabled=
=2E
> Bug is present in Kernel versions v3.9 onwards.
>=20
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: <stable@vger.kernel.org> # 3.9+
> ---
>  drivers/mfd/omap-usb-tll.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 0d946ae1..248004c 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -346,7 +346,9 @@ int omap_tll_init(struct usbhs_omap_platform_data=
 *pdata)
>  	for (i =3D 0; i < tll->nch; i++)
>  		needs_tll |=3D omap_usb_mode_needs_tll(pdata->port_mode[i]);
> =20
> +	spin_unlock(&tll_lock);
>  	pm_runtime_get_sync(tll_dev);
> +	spin_lock(&tll_lock);

This is pretty ugly. Can't you move it above the spin_lock() instead?

<snip>

>  	tll =3D dev_get_drvdata(tll_dev);
> =20
> +	spin_unlock(&tll_lock);
>  	pm_runtime_get_sync(tll_dev);
> +	spin_lock(&tll_lock);

Same here?

>  	for (i =3D 0; i < tll->nch; i++) {
>  		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
> @@ -438,7 +441,6 @@ int omap_tll_enable(struct usbhs_omap_platform_da=
ta *pdata)
>  	}
> =20
>  	spin_unlock(&tll_lock);
> -

This doesn't belong in this patch and is now inconsistent with the
other functions in the driver.

>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(omap_tll_enable);
> @@ -464,9 +466,8 @@ int omap_tll_disable(struct usbhs_omap_platform_d=
ata *pdata)
>  		}
>  	}
> =20
> -	pm_runtime_put_sync(tll_dev);
> -
>  	spin_unlock(&tll_lock);
> +	pm_runtime_put_sync(tll_dev);
> =20
>  	return 0;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
