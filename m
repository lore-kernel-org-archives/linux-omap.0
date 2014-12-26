From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] input: misc: add tps65218 power button driver
Date: Fri, 26 Dec 2014 13:33:28 -0600
Message-ID: <20141226193327.GK17430@saruman>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-4-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419622104-25812-4-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 26, 2014 at 01:28:22PM -0600, Felipe Balbi wrote:
> +static struct of_device_id of_tps65218_pwr_match[] =3D {
> +	{ .compatible =3D "ti,tps65218-pwrbutton" },

forgot to document this compatible. I'll add it localy but still wait a
a few days before resending so people have time to review.

--=20
balbi

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnbgHAAoJEIaOsuA1yqREadQP/AiMWX5PIe54mikIHG8uSnVA
Frjf6SwGz3ub7121/gC5GFCIML6YqbNKygQ5iFuSLt81u7aKLP8tk8CZ7tQ1PFCr
2rSd5e5abfp0B/9Xkxx/+5ISCd9KBQ+0ChJPoNH8kyx/KbU5rhYbqHU/mq63DsLB
VFFEjnPL7hzwTJa7qlco/uls8bHlYCM/mo+p9ZlZU1EjDLrSuQ0qJ/KMC5SECyaa
lM9wiXduGVW6P1/SqRCwyeKKwd/Rbr/n212DsvMJJdwMV/sSwo9nao3EGr89xk6l
3VcCeX2uvfSjS2moM5B3AN1M4dUW9pIVhJJTgfGwe2JLkOV4KFT5IYZGT/c88oOJ
d6+jmxM9ZmYwm6XuZKV4CLNetyQK2ygx4rEdAP6z/n2NtFYuNYd27cuReccZO1ef
T1GWkUQrE4gpDIviDwDamQ0EEA6uOileDgMlM94kcbHn3TBx9pR7oyuPKnQNYpQj
m5o5XoAmyb51Xgoj2g8DYofki3/k8ufjq+JpjoRO0NE0sdngLp6+We5N0wDPB+7i
3KpINcclLFi0+RMgfHWt6O9H+TuqEwwHy/0PzkSRP0O80boC7F0eak9VCe0ueNqF
iFMbm5SvG5M8trdk1YWJlmcH3hmFb1fJT3IEDDO9+RMC6S4G0eFv1Clr+gCbU22I
DE+DZJCWayDjq4jdAzSr
=LtIz
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--
