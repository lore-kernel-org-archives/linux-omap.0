From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 03/14] mfd: omap-usb-host: Use clock names as per
 function for reference clocks
Date: Tue, 25 Feb 2014 08:52:34 +0000
Message-ID: <20140225085234.GB19099@lee--X1>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
 <1392896409-5101-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:42432 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbaBYIwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Feb 2014 03:52:41 -0500
Received: by mail-we0-f179.google.com with SMTP id p61so69762wes.38
        for <linux-omap@vger.kernel.org>; Tue, 25 Feb 2014 00:52:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392896409-5101-4-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, nm@ti.com, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> Use a meaningful name for the reference clocks so that it indicates t=
he function.
>=20
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index 865c276..651e249 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -718,24 +718,24 @@ static int usbhs_omap_probe(struct platform_dev=
ice *pdev)
>  		goto err_mem;
>  	}
> =20
> -	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "xclk60mhsp1_ck");
> +	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "refclk_60m_ext_p1");
>  	if (IS_ERR(omap->xclk60mhsp1_ck)) {
>  		ret =3D PTR_ERR(omap->xclk60mhsp1_ck);
> -		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
> +		dev_err(dev, "refclk_60m_ext_p1 failed error:%d\n", ret);
>  		goto err_mem;
>  	}

Will anything break if I were to apply the MFD patches seperately?

> -	omap->xclk60mhsp2_ck =3D devm_clk_get(dev, "xclk60mhsp2_ck");
> +	omap->xclk60mhsp2_ck =3D devm_clk_get(dev, "refclk_60m_ext_p2");
>  	if (IS_ERR(omap->xclk60mhsp2_ck)) {
>  		ret =3D PTR_ERR(omap->xclk60mhsp2_ck);
> -		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
> +		dev_err(dev, "refclk_60m_ext_p2 failed error:%d\n", ret);
>  		goto err_mem;
>  	}
> =20
> -	omap->init_60m_fclk =3D devm_clk_get(dev, "init_60m_fclk");
> +	omap->init_60m_fclk =3D devm_clk_get(dev, "refclk_60m_int");
>  	if (IS_ERR(omap->init_60m_fclk)) {
>  		ret =3D PTR_ERR(omap->init_60m_fclk);
> -		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
> +		dev_err(dev, "refclk_60m_int failed error:%d\n", ret);
>  		goto err_mem;
>  	}
> =20

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
