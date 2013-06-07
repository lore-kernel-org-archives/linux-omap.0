From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Fri, 7 Jun 2013 15:47:16 +0300
Message-ID: <51B1D654.9070107@ti.com>
References: <51B1C9D2.6060703@ti.com> <51B1D3D6.2020803@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2FRSCBFWCOKSBPECWVWMO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53740 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab3FGMrS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 08:47:18 -0400
In-Reply-To: <51B1D3D6.2020803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

------enig2FRSCBFWCOKSBPECWVWMO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 15:36, Grygorii Strashko wrote:

> Could you check if below change will help you, pls?
> iff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap=
=2Ec
> index 13d1eca..66a62e7 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -615,11 +615,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter
> *adap,
>         if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
>                 if (msg->flags & I2C_M_IGNORE_NAK)
>                         return 0;
> -               if (stop) {
> -                       w =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);=

> -                       w |=3D OMAP_I2C_CON_STP;
> -                       omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> -               }
> +
> +               w =3D omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> +               w |=3D OMAP_I2C_CON_STP;
> +               omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> +
>                 return -EREMOTEIO;
>         }
>         return -EIO;

With that one, I don't get timeouts, but it still doesn't work (i.e.
behavior is the same as on -rc1).

When I run i2cdump the first time, I see that it (probably) manages to
read the first byte, as that's "00". Everything after that are 'XX'es.

 Tomi



------enig2FRSCBFWCOKSBPECWVWMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRsdZUAAoJEPo9qoy8lh71Fx0QAJQz+G3ZYc+VyWONkq2QEKvV
kPm92kwUZ/fIFr4w77OGdBv3cHtYE5O9okE8a0+x7vrjV3BpaFhRiYUmrV/7X2Ea
Rk4KOXkU31HngXv1NmdH0lZKwAv4MEIQjMRRyM+TDB5uQLY27D/TkCY4nR82SXPa
MRPGY8flnVM9/HMz583VmyuuSfNzKhsq1ar7a+pFoyQZuyL9QDWA08iwYrtPrQTt
KgE/Um6lG2+7b+Axc6OYYYgmmqNg+ze31eRH6myZib8P2nyO9+pxqU8bUtPeM+RY
UHcgRyqWwdJI0j+i/3rBLkNOuVj/BE6JvgDuLuAwNrLxnY9cKwb1uXP8JnU50rej
x33E/5pB2BJTzl3g5iZHWrUcKKfNbuD9HfVvisUe+EdZ72MW6Yc3bL4a9xzHz+si
A3UcxbUoEFt3ZZ351gurDsSKvIgSPwCVBUjezDWCWshy6DiFniw1h78E5F2ekRcF
LmosSTxH44+Cr910GDXk4m3QCsRHVF4R/YcdYiNo4PNyFmeGegALJ3Fho716rXLT
MRpxzV0pek3hLqbESiYwkRUpoyMeOUu4fcDQLcWW4soQIRzSwhu58xJi1/H84aaE
vYPkOOaC6L33P6WulWskN0BRbuZkgkWOd77gaw2LoiRp6+aYzqZEq8Yn3y2dpiRg
lfNbW77EnqYto94b0CGP
=WOaw
-----END PGP SIGNATURE-----

------enig2FRSCBFWCOKSBPECWVWMO--
