From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 03/12] mfd: omap-usb-host: Use clock names as per
 function for reference clocks
Date: Fri, 14 Feb 2014 10:09:15 +0000
Message-ID: <20140214100915.GD7380@lee--X1>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
 <1392200333-28397-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392200333-28397-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Use a meaningful name for the reference clocks so that it indicates t=
he function.
>=20
> CC: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/omap-usb-host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index 60a3bed..ce620a8 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -714,21 +714,21 @@ static int usbhs_omap_probe(struct platform_dev=
ice *pdev)
>  		goto err_mem;
>  	}
> =20
> -	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "xclk60mhsp1_ck");
> +	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "refclk_60m_ext_p1");

You can't do that. These changes will have to be in the same patch as
the core change i.e. where they are initialised.

>  	if (IS_ERR(omap->xclk60mhsp1_ck)) {
>  		ret =3D PTR_ERR(omap->xclk60mhsp1_ck);
>  		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
>  		goto err_mem;
>  	}
> =20
> -	omap->xclk60mhsp2_ck =3D devm_clk_get(dev, "xclk60mhsp2_ck");
> +	omap->xclk60mhsp2_ck =3D devm_clk_get(dev, "refclk_60m_ext_p2");
>  	if (IS_ERR(omap->xclk60mhsp2_ck)) {
>  		ret =3D PTR_ERR(omap->xclk60mhsp2_ck);
>  		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
>  		goto err_mem;
>  	}
> =20
> -	omap->init_60m_fclk =3D devm_clk_get(dev, "init_60m_fclk");
> +	omap->init_60m_fclk =3D devm_clk_get(dev, "refclk_60m_int");
>  	if (IS_ERR(omap->init_60m_fclk)) {
>  		ret =3D PTR_ERR(omap->init_60m_fclk);
>  		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
