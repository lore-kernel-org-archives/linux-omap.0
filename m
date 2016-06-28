From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/6] mfd: smsc-ece1099: Delete an unnecessary variable
 initialisation in smsc_i2c_probe()
Date: Tue, 28 Jun 2016 16:07:56 +0100
Message-ID: <20160628150756.GM24982@dell>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
 <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
 <1b29f010-5617-3862-23f5-42a5e6a1bc81@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1b29f010-5617-3862-23f5-42a5e6a1bc81@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Sun, 26 Jun 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Jun 2016 14:14:54 +0200
>=20
> The variable "ret" will be set to an appropriate value a bit later.
> Thus omit the explicit initialisation at the beginning.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/smsc-ece1099.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/smsc-ece1099.c b/drivers/mfd/smsc-ece1099.c
> index 7f89e89..2aaf89f 100644
> --- a/drivers/mfd/smsc-ece1099.c
> +++ b/drivers/mfd/smsc-ece1099.c
> @@ -36,7 +36,7 @@ static int smsc_i2c_probe(struct i2c_client *i2c,
>  {
>  	struct smsc *smsc;
>  	int devid, rev, venid_l, venid_h;
> -	int ret =3D 0;
> +	int ret;
> =20
>  	smsc =3D devm_kzalloc(&i2c->dev, sizeof(struct smsc),
>  				GFP_KERNEL);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
