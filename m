From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/16] mfd: omap-usb-tll: Move port clock handling out of
 runtime ops
Date: Wed, 21 Nov 2012 14:06:32 +0200
Message-ID: <20121121120408.GF10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-5-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352990054-14680-5-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:02PM +0200, Roger Quadros wrote:
> The port clocks are not required to access the port registers,
> they are only needed when the PORT is used. So we move the port clock
> handling code to omap_tll_enable/disable().
>=20
> Also get of unnecessary spinlock code in probe function and check for
> missing platform data.

this second sentence needs some rephrasing, I don't fully understand
what you mean.

This patch also does more than what $SUBJECT says, should be splitted
up.

> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/omap-usb-tll.c |  102 +++++++++++++++++---------------------=
------
>  1 files changed, 39 insertions(+), 63 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 7054395e..31ac7db 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -114,8 +114,8 @@ struct usbtll_omap {
> =20
>  /*----------------------------------------------------------------------=
---*/
> =20
> -const char usbtll_driver_name[] =3D USBTLL_DRIVER_NAME;
> -struct platform_device	*tll_pdev;
> +static const char usbtll_driver_name[] =3D USBTLL_DRIVER_NAME;
> +static struct device *tll_dev;
> =20
>  /*----------------------------------------------------------------------=
---*/
> =20
> @@ -217,7 +217,6 @@ static int __devinit usbtll_omap_probe(struct platfor=
m_device *pdev)
>  	struct resource				*res;
>  	struct usbtll_omap			*tll;
>  	unsigned				reg;
> -	unsigned long				flags;
>  	int					ret =3D 0;
>  	int					i, ver;
>  	bool needs_tll;
> @@ -230,6 +229,11 @@ static int __devinit usbtll_omap_probe(struct platfo=
rm_device *pdev)
>  		return -ENOMEM;
>  	}
> =20
> +	if (!pdata) {
> +		dev_err(dev, "%s : Platform data mising\n", __func__);
> +		return -ENODEV;
> +	}
> +
>  	spin_lock_init(&tll->lock);
> =20
>  	tll->pdata =3D pdata;
> @@ -253,8 +257,6 @@ static int __devinit usbtll_omap_probe(struct platfor=
m_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
> =20
> -	spin_lock_irqsave(&tll->lock, flags);
> -
>  	ver =3D  usbtll_read(base, OMAP_USBTLL_REVISION);
>  	switch (ver) {
>  	case OMAP_USBTLL_REV1:
> @@ -331,13 +333,13 @@ static int __devinit usbtll_omap_probe(struct platf=
orm_device *pdev)
>  		}
>  	}
> =20
> -	tll_pdev =3D pdev;
> +	/* only after this can omap_tll_enable/disable work */
> +	tll_dev =3D dev;

I'd like to get rid of that, actually. But for now we can keep it...

>  err_clk:
>  	for (--i; i >=3D 0 ; i--)
>  		clk_put(tll->ch_clk[i]);
> =20
> -	spin_unlock_irqrestore(&tll->lock, flags);
>  	pm_runtime_put_sync(dev);
>  	if (ret =3D=3D 0) {
>  		pr_info("OMAP USB TLL : revision 0x%x, channels %d\n",
> @@ -364,6 +366,7 @@ static int __devexit usbtll_omap_remove(struct platfo=
rm_device *pdev)
>  	struct usbtll_omap *tll =3D platform_get_drvdata(pdev);
>  	int i;
> =20
> +	tll_dev =3D NULL;
>  	iounmap(tll->base);
>  	for (i =3D 0; i < tll->nch; i++)
>  		clk_put(tll->ch_clk[i]);
> @@ -373,98 +376,71 @@ static int __devexit usbtll_omap_remove(struct plat=
form_device *pdev)
>  	return 0;
>  }
> =20
> -static int usbtll_runtime_resume(struct device *dev)
> +static struct platform_driver usbtll_omap_driver =3D {
> +	.driver =3D {
> +		.name		=3D (char *)usbtll_driver_name,
> +		.owner		=3D THIS_MODULE,
> +	},
> +	.probe		=3D usbtll_omap_probe,
> +	.remove		=3D __devexit_p(usbtll_omap_remove),

there is a big patchset floating around dropping CONFIG_HOTPLUG, that
means that __devinit, __devexit, __devexit_p(), __devinitdata,
__devinitconst will all vanish. Please don't re-add them ;-)

> +};
> +
> +int omap_tll_enable(void)
>  {
> -	struct usbtll_omap			*tll =3D dev_get_drvdata(dev);
> -	struct usbtll_omap_platform_data	*pdata =3D tll->pdata;
> +	struct usbtll_omap			*tll;
>  	unsigned long				flags;
>  	int i;
> =20
> -	dev_dbg(dev, "usbtll_runtime_resume\n");
> -
> -	if (!pdata) {
> -		dev_dbg(dev, "missing platform_data\n");
> +	if (!tll_dev) {
> +		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
>  		return  -ENODEV;
>  	}
> =20
> +	tll =3D dev_get_drvdata(tll_dev);
>  	spin_lock_irqsave(&tll->lock, flags);
> =20
>  	for (i =3D 0; i < tll->nch; i++) {
> -		if (mode_needs_tll(pdata->port_mode[i])) {
> +		if (mode_needs_tll(tll->pdata->port_mode[i])) {
>  			int r;
>  			r =3D clk_enable(tll->ch_clk[i]);
>  			if (r) {
> -				dev_err(dev,
> -				 "%s : Error enabling ch %d clock: %d\n",
> -				 __func__, i, r);
> +				dev_err(tll_dev,
> +				  "%s : Error enabling ch %d clock: %d\n",
> +				  __func__, i, r);

no need for __func__

>  			}
>  		}
>  	}
> =20
> +	i =3D pm_runtime_get_sync(tll_dev);

fair enough, you're trying to re-use the variable. But I would be more
explicit and create another ret variable. I'm sure GCC will optimize
variable usage here anyway.

>  	spin_unlock_irqrestore(&tll->lock, flags);
> =20
> -	return 0;
> +	return i;
>  }
> +EXPORT_SYMBOL_GPL(omap_tll_enable);
> =20
> -static int usbtll_runtime_suspend(struct device *dev)
> +int omap_tll_disable(void)

why ?? Why are you actually dropping runtime PM from this driver ? have
you tested PM transitions after applying this patch ?

--=20
balbi

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrMPIAAoJEIaOsuA1yqREc5oQAJpLfbDkOJ9HJcjU7rJEFUly
NDXGX/gBxH5uopC7i5hBFJY4wOBt870vP4IaI1E7kwC6EDa+I8tmlr9WeqDeiwsT
hhGu1pQkAaLMv/VMlK4qx2qd6vhIjHeAVxGvm8n3j/c5k+idXUehwSbT3/boSibb
9vq2PQy+vbmb+eZZj2VAnq00IJBuDBPlEar/+eoV+tX4qfvv4HKox8yMS43immws
KINxrTbGp386rP1SyXOeqUFvMFworqfePOYuwETz9cXs++7blAIJSO0Mu+VatV8a
ZKQDzaczJD9sE2l9nwhcTX/8OoTUxhcJ2JMDStCRHXkUMy34+ibvFVzh3o4BMkcP
24ZBZYB0v44B2MbU64Ns5+69VGEN4roFfEuGTNXantS0y6bkS1tCNLD8Uk0vcuGR
DlgMnHNrRgErWDo67eershUTAzQxJeQsXty9QDStMOBUuIZdIV4LbrnHQkc7S9l/
qC+GvsX/Tl9M+dBJRGFg6CbdgiFa1XHrRrtHcIrtRPlVZb63AIKdEoM0fkD2U47w
jnn5od6VMJtlyyT8OLIH18m+UwJQ2/+zIiarTkhFchiM5lTGaLc2JUhp659RyApQ
yAXF59SvOKBXqPnPYbQJ71fxb23cuaQF0FqY/FbIvS1nRbRDvGtXHR2hqqS6U+NX
sXxeHldMi2eJym0JTj8h
=nNzh
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
