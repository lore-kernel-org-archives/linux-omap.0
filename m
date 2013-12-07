From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v4 4/4] USB: OMAP1: Tahvo USB transceiver driver
Date: Sat, 7 Dec 2013 16:16:23 +0200
Message-ID: <20131207141623.GL30823@blackmetal.musicnaut.iki.fi>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
 <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
 <20131206204629.GL21086@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:45600 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3LGOQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 09:16:29 -0500
Content-Disposition: inline
In-Reply-To: <20131206204629.GL21086@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Dec 06, 2013 at 02:46:29PM -0600, Felipe Balbi wrote:
> On Fri, Dec 06, 2013 at 04:13:07PM +0200, Aaro Koskinen wrote:
> > Add Tahvo USB transceiver driver.
> >=20
> > Based on old code from linux-omap tree. The original driver was wri=
tten
> > by Juha Yrj=F6l=E4, Tony Lindgren, and Timo Ter=E4s.
> >=20
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>=20
> compile error:

[...]

> fixed it up with:
>
> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.=
c
> index 7cf1766..8bb833e 100644
> --- a/drivers/usb/phy/phy-tahvo.c
> +++ b/drivers/usb/phy/phy-tahvo.c
> @@ -368,7 +368,9 @@ static int tahvo_usb_probe(struct platform_device=
 *pdev)
> =20
>  	tu->extcon.name =3D DRIVER_NAME;
>  	tu->extcon.supported_cable =3D tahvo_cable;
> -	ret =3D extcon_dev_register(&tu->extcon, &pdev->dev);
> +	tu->extcon.dev.parent =3D &pdev->dev;
> +
> +	ret =3D extcon_dev_register(&tu->extcon);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not register extcon device: %d\n",
>  			ret);
>=20
> please make sure it still works with v3.13-rc2 + this patch.

Yes, that works fine with 3.13-rc2. Sorry for this, I was accidentally
testing & basing these patches on an old branch.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
