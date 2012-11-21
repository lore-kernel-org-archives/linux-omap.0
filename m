From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 02/16] mfd: omap-usb-tll: Clean up clock handling
Date: Wed, 21 Nov 2012 13:55:56 +0200
Message-ID: <20121121115556.GD10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-3-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47712 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587Ab2KUMC2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 07:02:28 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-3-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:00PM +0200, Roger Quadros wrote:
> Every channel has a functional clock that is similarly named.
> It makes sense to use a for loop to manage these clocks as OMAPs
> can come with upto 3 channels.

s/upto/up to

BTW, this patch is doing a lot more than "cleaning up clock handling".
This needs to be split into smaller patches.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-tll.c |  130 +++++++++++++++++++++++++-------------=
------
>  1 files changed, 74 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index d1750a4..943ac14 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -82,8 +82,12 @@
>  #define	OMAP_TLL_ULPI_DEBUG(num)			(0x815 + 0x100 * num)
>  #define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)		(0x816 + 0x100 * num)
> =20
> -#define OMAP_REV2_TLL_CHANNEL_COUNT			2
> -#define OMAP_TLL_CHANNEL_COUNT				3
> +#define REV2_TLL_CHANNEL_COUNT				2

why are you dropping the OMAP_ prefix ? You shouldn't do that.

> +#define DEFAULT_TLL_CHANNEL_COUNT			3

Add OMAP_ prefix here.

> +
> +/* Update if any chip has more */
> +#define MAX_TLL_CHANNEL_COUNT				3

can't you figure this one out in runtime ? If this isn't in any
registers (and looks like it's not), you can pass this information to
the driver via DT or just use driver_data field on struct
platform_driver.

>  #define OMAP_TLL_CHANNEL_1_EN_MASK			(1 << 0)
>  #define OMAP_TLL_CHANNEL_2_EN_MASK			(1 << 1)
>  #define OMAP_TLL_CHANNEL_3_EN_MASK			(1 << 2)
> @@ -96,8 +100,9 @@
>  #define is_ehci_tll_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_TLL)
> =20
>  struct usbtll_omap {
> -	struct clk				*usbtll_p1_fck;
> -	struct clk				*usbtll_p2_fck;
> +	void __iomem				*base;
> +	int					nch;	/* number of channels */
> +	struct clk				*ch_clk[MAX_TLL_CHANNEL_COUNT];

should be allocated dynamically.

>  	struct usbtll_omap_platform_data	*pdata;
>  	/* secure the register updates */
>  	spinlock_t				lock;
> @@ -210,49 +215,35 @@ static int __devinit usbtll_omap_probe(struct platf=
orm_device *pdev)
>  	unsigned				reg;
>  	unsigned long				flags;
>  	int					ret =3D 0;
> -	int					i, ver, count;
> +	int					i, ver;
> =20
>  	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
> =20
>  	tll =3D kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL);
>  	if (!tll) {
>  		dev_err(dev, "Memory allocation failed\n");
> -		ret =3D -ENOMEM;
> -		goto end;
> +		return -ENOMEM;
>  	}
> =20
>  	spin_lock_init(&tll->lock);
> =20
>  	tll->pdata =3D pdata;
> =20
> -	tll->usbtll_p1_fck =3D clk_get(dev, "usb_tll_hs_usb_ch0_clk");
> -	if (IS_ERR(tll->usbtll_p1_fck)) {
> -		ret =3D PTR_ERR(tll->usbtll_p1_fck);
> -		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
> -		goto err_tll;
> -	}
> -
> -	tll->usbtll_p2_fck =3D clk_get(dev, "usb_tll_hs_usb_ch1_clk");
> -	if (IS_ERR(tll->usbtll_p2_fck)) {
> -		ret =3D PTR_ERR(tll->usbtll_p2_fck);
> -		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
> -		goto err_usbtll_p1_fck;
> -	}
> -
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(dev, "usb tll get resource failed\n");
>  		ret =3D -ENODEV;
> -		goto err_usbtll_p2_fck;
> +		goto err_mem;
>  	}
> =20
>  	base =3D ioremap(res->start, resource_size(res));
>  	if (!base) {
>  		dev_err(dev, "TLL ioremap failed\n");
>  		ret =3D -ENOMEM;
> -		goto err_usbtll_p2_fck;
> +		goto err_mem;
>  	}
> =20
> +	tll->base =3D base;
>  	platform_set_drvdata(pdev, tll);
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
> @@ -262,16 +253,33 @@ static int __devinit usbtll_omap_probe(struct platf=
orm_device *pdev)
>  	ver =3D  usbtll_read(base, OMAP_USBTLL_REVISION);
>  	switch (ver) {
>  	case OMAP_USBTLL_REV1:
> -	case OMAP_USBTLL_REV2:
> -		count =3D OMAP_TLL_CHANNEL_COUNT;
> +		tll->nch =3D DEFAULT_TLL_CHANNEL_COUNT;
>  		break;
> +	case OMAP_USBTLL_REV2:
>  	case OMAP_USBTLL_REV3:
> -		count =3D OMAP_REV2_TLL_CHANNEL_COUNT;
> +		tll->nch =3D REV2_TLL_CHANNEL_COUNT;

nice, you *can* figure that out based on the revision... In that case,
you shouldn't even define MAX_TLL_CHANNEL_COUNT, just allocate the array
dynamically for the exact size you need.

>  		break;
>  	default:
> -		dev_err(dev, "TLL version failed\n");
> -		ret =3D -ENODEV;
> -		goto err_ioremap;
> +		tll->nch =3D DEFAULT_TLL_CHANNEL_COUNT;
> +		dev_info(dev,
> +		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
> +			ver, tll->nch);

this hsould be dev_dbg().

> +		break;
> +	}
> +
> +	for (i =3D 0; i < tll->nch; i++) {
> +		char clk_name[] =3D "usb_tll_hs_usb_chx_clk";

just lazyness of counting the amount of letters ? :-p

> +		struct clk *fck;
> +
> +		sprintf(clk_name, "usb_tll_hs_usb_ch%d_clk", i);

this will overflow if 'i' (for whatever reason) goes over 9.

> +		fck =3D clk_get(dev, clk_name);

please use devm_clk_get().

> +		if (IS_ERR(fck)) {
> +			dev_err(dev, "can't get clock : %s\n", clk_name);
> +			ret =3D PTR_ERR(fck);
> +			goto err_clk;
> +		}
> +		tll->ch_clk[i] =3D fck;
>  	}
> =20
>  	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
> @@ -291,7 +299,7 @@ static int __devinit usbtll_omap_probe(struct platfor=
m_device *pdev)
>  		usbtll_write(base, OMAP_TLL_SHARED_CONF, reg);
> =20
>  		/* Enable channels now */
> -		for (i =3D 0; i < count; i++) {
> +		for (i =3D 0; i < tll->nch; i++) {
>  			reg =3D usbtll_read(base,	OMAP_TLL_CHANNEL_CONF(i));
> =20
>  			if (is_ohci_port(pdata->port_mode[i])) {
> @@ -319,25 +327,25 @@ static int __devinit usbtll_omap_probe(struct platf=
orm_device *pdev)
>  		}
>  	}
> =20
> -err_ioremap:
> -	spin_unlock_irqrestore(&tll->lock, flags);
> -	iounmap(base);
> -	pm_runtime_put_sync(dev);
>  	tll_pdev =3D pdev;
> -	if (!ret)
> -		goto end;
> -	pm_runtime_disable(dev);
> =20
> -err_usbtll_p2_fck:
> -	clk_put(tll->usbtll_p2_fck);
> +err_clk:
> +	for (--i; i >=3D 0 ; i--)
> +		clk_put(tll->ch_clk[i]);

is clk_put(NULL) safe ??

> -err_usbtll_p1_fck:
> -	clk_put(tll->usbtll_p1_fck);
> +	spin_unlock_irqrestore(&tll->lock, flags);
> +	pm_runtime_put_sync(dev);
> +	if (ret =3D=3D 0) {
> +		pr_info("OMAP USB TLL : revision 0x%x, channels %d\n",
> +				ver, tll->nch);
> +		return 0;
> +	}

the whole thing is quite confusing. Please while cleaning up the driver,
also try to clean up the error path.

> -err_tll:
> -	kfree(tll);
> +	iounmap(base);

could be using devm_request_and_ioremap()

> +	pm_runtime_disable(dev);
> =20
> -end:
> +err_mem:
> +	kfree(tll);

could be using devm_kzalloc()

>  	return ret;
>  }
> =20
> @@ -350,9 +358,12 @@ end:
>  static int __devexit usbtll_omap_remove(struct platform_device *pdev)
>  {
>  	struct usbtll_omap *tll =3D platform_get_drvdata(pdev);
> +	int i;
> +
> +	iounmap(tll->base);
> +	for (i =3D 0; i < tll->nch; i++)
> +		clk_put(tll->ch_clk[i]);
> =20
> -	clk_put(tll->usbtll_p2_fck);
> -	clk_put(tll->usbtll_p1_fck);
>  	pm_runtime_disable(&pdev->dev);
>  	kfree(tll);
>  	return 0;
> @@ -363,6 +374,7 @@ static int usbtll_runtime_resume(struct device *dev)
>  	struct usbtll_omap			*tll =3D dev_get_drvdata(dev);
>  	struct usbtll_omap_platform_data	*pdata =3D tll->pdata;
>  	unsigned long				flags;
> +	int i;
> =20
>  	dev_dbg(dev, "usbtll_runtime_resume\n");
> =20
> @@ -373,11 +385,17 @@ static int usbtll_runtime_resume(struct device *dev)
> =20
>  	spin_lock_irqsave(&tll->lock, flags);
> =20
> -	if (is_ehci_tll_mode(pdata->port_mode[0]))
> -		clk_enable(tll->usbtll_p1_fck);
> -
> -	if (is_ehci_tll_mode(pdata->port_mode[1]))
> -		clk_enable(tll->usbtll_p2_fck);
> +	for (i =3D 0; i < tll->nch; i++) {
> +		if (is_ehci_tll_mode(pdata->port_mode[i])) {
> +			int r;
> +			r =3D clk_enable(tll->ch_clk[i]);
> +			if (r) {
> +				dev_err(dev,
> +				 "%s : Error enabling ch %d clock: %d\n",
> +				 __func__, i, r);

you don't need __func__.


--=20
balbi

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrMFMAAoJEIaOsuA1yqREoKQP+wclN/lJZl0mueiU/aZVNGQM
GY3lqv/t05j9rYXoLhAnAt4F6bKpq1e4AROe2hQALIsvbSPET9SBjUjCu7hVaK4l
ggx7LIEn4tSWzzcNUAWJqqwTYnAF5Zx6OKiNRixsubApIzfimMDPyKZGWtFnN6f8
cOS2WQ5uaKxZ8uYZBAY2GvKYF0qCxzYMQb/Ymfhe2R/7mqc0YJkoEJ0ouE7rBx6n
X5uKumgv4JzgwActVBw4fo0s55n0ZnXVb4+qD56x2PtfCwDjK8o+Ud2mQGlDkAnP
cXdhlPWiN1yO3wyxFuD+rydMeeexdjTseQVLqxbn8aw5YO4W6RXGBCzwegFcgUCN
hg9uIeM3piaFzs7YXyxKMtbXNSoblwLaicrsionsHzKdA/nVmsXZ9aB17akf59CP
Yb8JTjkzapRH1dnjpgH/P8h3ymd7R1Lsduf/cr2xC3ILVhFz5aZRRJsHEkfbBxtm
OBmqNEeVTqJ2+Gba9Nzg7yTIkgzRiS4B0OHwEvkNsJ8Ezpti6I0gSsjGUQw+lko2
A5bM4wwU0/b09rk4xeuBX5cOenWXu7Qnkm5MuVhxGXL/7ed5itxF6hZuQffzE1ZZ
qMqQx3ahGZWvXYf0STb3NAWsoT7gfbRLe/RmG8Iqqgu5MEETqPqteNXS5i+lsR7l
phMbd+QrwyIghbtW9iBU
=as5f
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
