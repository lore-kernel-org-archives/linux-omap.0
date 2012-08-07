From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/4] i2c: omap: switch over to autosuspend API
Date: Tue, 7 Aug 2012 15:07:29 +0300
Message-ID: <20120807120728.GW8468@arwen.pp.htv.fi>
References: <1344262737-6662-1-git-send-email-balbi@ti.com>
 <1344262737-6662-5-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQcP9vuZCkvmDKre"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:52547 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752630Ab2HGMLI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 08:11:08 -0400
Received: by lbbgf7 with SMTP id gf7so1377141lbb.8
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 05:11:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344262737-6662-5-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de


--lQcP9vuZCkvmDKre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 06, 2012 at 05:18:57PM +0300, Felipe Balbi wrote:
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message been started
> soon.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 60928f2..22efaba 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -645,7 +645,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_ms=
g msgs[], int num)
> =20
>  	omap_i2c_wait_for_bb(dev);
>  out:
> -	pm_runtime_put(dev->dev);
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
>  	return r;
>  }
> =20
> @@ -1113,6 +1114,9 @@ omap_i2c_probe(struct platform_device *pdev)
>  		dev->regs =3D (u8 *)reg_map_ip_v1;
> =20
>  	pm_runtime_enable(dev->dev);
> +	pm_runtime_set_autosuspend_delay(dev->dev, 1000);
> +	pm_runtime_use_autosuspend(dev->dev);
> +
>  	r =3D pm_runtime_get_sync(dev->dev);
>  	if (IS_ERR_VALUE(r))
>  		goto err_free_mem;
> @@ -1189,7 +1193,7 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  	of_i2c_register_devices(adap);
> =20
> -	pm_runtime_put(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);

Probably... nice catch. Will send v2

--=20
balbi

--lQcP9vuZCkvmDKre
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIQUAAAoJEIaOsuA1yqREyKAP/2/AJHTzHoj+Mz5iRmNHQG7F
pxMFNc2iABo0WXy5GNb/1rMHAJgICHURjaYTiVZCAwndBQ7OUs83URasGjfwVCJt
uujECfxYIV0LIq+go/tJCc1dbmeAEACPNmV29iSpaXg7k9DBweUN4L1f+btHOX5H
1g2awyLryd92qyVC9rjSFqvvnT3GVlg4D7BXGLvlQizy7972uAjVpF36uZp1dX2H
XgCYI3nRnNORY4zMjILUdEwYBlS1wJxDh2KQxjXQgLu5GiLUaZM/h0i8utDG4FR9
2YHhPB/Do+OFfbhVl/kdjahhjWh/ZjC9DXwvRWQOMNz7qiwyqk4Usx0tXYB4OFnP
3SZ3DJqhLyISkb6p2bnVwfgNDMzW0jxjoLtVd/VYyh1He2DGm4rmFw8KtthkzkTz
9nh2EicaDLvTHbOVXrxvEnHj8rvRdDGPLCfQ0lu9oSHS3sIPRqbh5SpjBhehhB9G
/VsZZZ0eYZiGMpE3qIVSlzeJGTiruQyZWeJtk+KjhoywrPLZvIziOAgFSyTtvlRp
w16Tq9aUd7lfvDz4t/CEH5m2h2v2GukF32NMES0kJ0efdU8MEhS4SYBSltLBYZ/0
5LQ9+WOX30VWvEtRtFcCLzfSFcxS222M06HVM95ybOmE3t2KRAdfoLiCotCBtQqG
oBjNwhAOELfVqpXSa1Ah
=Aukf
-----END PGP SIGNATURE-----

--lQcP9vuZCkvmDKre--
