From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] i2c: omap: re-factor omap_i2c_init function
Date: Thu, 25 Oct 2012 13:52:17 +0300
Message-ID: <20121025105217.GG21217@arwen.pp.htv.fi>
References: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com>
 <1351160586-12306-2-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58789 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684Ab2JYK6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 06:58:14 -0400
Content-Disposition: inline
In-Reply-To: <1351160586-12306-2-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(a small top-post here, don't forget to keep the patch version in the
subject, I think this is v3 already, so next patch should be v4)

On Thu, Oct 25, 2012 at 03:53:05PM +0530, Shubhrajyoti D wrote:
> re-factor omap_i2c_init() so that we can re-use it for resume.
> While at it also remove the bufstate variable as we write it
> in omap_i2c_resize_fifo for every transfer.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   71 ++++++++++++++++++-----------------=
-----
>  1 files changed, 32 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5e5cefb..3d400b1 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -209,7 +209,6 @@ struct omap_i2c_dev {
>  	u16			pscstate;
>  	u16			scllstate;
>  	u16			sclhstate;
> -	u16			bufstate;
>  	u16			syscstate;
>  	u16			westate;
>  	u16			errata;
> @@ -285,9 +284,31 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_=
dev *i2c_dev, int reg)
>  	}
>  }
> =20
> +static void __omap_i2c_init(struct omap_i2c_dev *dev)
> +{
> +
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> +
> +	/* SCL low and high time values */
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
> +	if (dev->rev >=3D OMAP_I2C_REV_ON_3430_3530)
> +		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> +	/* Take the I2C module out of reset: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +	/*
> +	 * Don't write to this register if the IE state is 0 as it can
> +	 * cause deadlock.
> +	 */
> +	if (dev->iestate)
> +		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);

you still miss the extra blank lines here. Try something like below:


omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);

/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);

/* SCL low and high time values */
omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);

if (dev->rev >=3D OMAP_I2C_REV_ON_3430_3530)
	omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);

/* Take the I2C module out of reset: */
omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);

/*
 * Don't write to this register if the IE state is 0 as it can
 * cause deadlock.
 */
if (dev->iestate)
	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);


--=20
balbi

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiRnhAAoJEIaOsuA1yqREAsEP/jTfDElpEdiYs/w8Tb4BoF6v
c9P9D4y/WCr17tC5j+f8Yn+7+BLXwYOqeqIhbuhRnIAs0Mlx9LYm3cjV/Txv+RoR
9yCo2EdaPIsXu4FQlFIOyDeMPtseTmPbYefr/yvr3MX3HkDimFTq9Tz424Z0bS78
CHAsxbZ8mmzWQ6voejlU544Z85qCCrmsk7jnnEmQrxNo59w9LoJI8ioFDZY3fKWC
Yxtw3tGKXpmVEdODiLq7unkL7MqGg891qHpmNzZ1ORd1lLHogg1q7OTUoZNnaA/A
ayg34Q0c33cWlbQNESGwU65Vmja81yiHd/hZ1eJqbXg4vdy2Y4IYojyzM+tAlv/J
DUpT4ktdRd9nVS8SA5qDhp2Ba5jH6K6+sdmfo5ctH3dGOvnNfwZLCLx5OEvSy10l
2ly8P05tT7ozzKC2Dz9/3ThoSilCykP3+o8Y50b1MA7xJXanxD4l1hTvK9kpYJh7
qpQ6DodDiRp16SLNWwHUNxWLQHpKCgPJg71Jg8gvr/H9R69rZhPom1IzDT5YJjMN
/mBXT3pZ2v7MOYFf3cEp3yei47DHrjpHID46EqMJJpzh3PeR5IBnrIJjtoKADl6X
RIVodcVWKrtFAnQKiThqTEz2Hlbt1oY9svepcASOML1oaMA+DFRonIgfB/jAaCN0
p9c1TaIDIJksvj2C9a1i
=Livh
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
