From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-tahvo: Add tahvo_write_reg locking
Date: Mon, 7 Nov 2011 08:10:45 +0200
Message-ID: <20111107061044.GB4265@legolas.emea.dhcp.ti.com>
References: <20111105171954.230d12fb@milhouse>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39076 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600Ab1KGGKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 01:10:50 -0500
Received: by bkbzv15 with SMTP id zv15so5044514bkb.17
        for <linux-omap@vger.kernel.org>; Sun, 06 Nov 2011 22:10:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111105171954.230d12fb@milhouse>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 05, 2011 at 05:19:54PM +0100, Michael B=FCsch wrote:
> tahvo_write_reg() needs to take the mutex to avoid a race
> condition with tahvo_set_clear_reg_bits:
>=20
> tahvo_set_clear_reg_bits():   |  tahvo_write_reg():
>     __tahvo_read_reg()        |
>                               |      __tahvo_write_reg() <-- race here
>     __tahvo_write_reg()       |
>=20
> Signed-off-by: Michael Buesch <m@bues.ch>
>=20
> ---
>=20
> Index: linux-3.1/drivers/cbus/tahvo.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.1.orig/drivers/cbus/tahvo.c	2011-11-05 17:03:39.598846119 +01=
00
> +++ linux-3.1/drivers/cbus/tahvo.c	2011-11-05 17:04:36.274768324 +0100
> @@ -104,7 +104,9 @@ void tahvo_write_reg(struct device *chil
>  {
>  	struct tahvo		*tahvo =3D dev_get_drvdata(child->parent);
> =20
> +	mutex_lock(&tahvo->mutex);
>  	__tahvo_write_reg(tahvo, reg, val);
> +	mutex_unlock(&tahvo->mutex);

yeah, my bad. The same should be done with tahvo_read_reg(). Care to
resend this patch adding the change to tahvo_read_reg() too...

--=20
balbi

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOt3ZkAAoJEIaOsuA1yqREy1gQAKGBV0gVrq2bBx6CD4HBiq0W
JM9bGpOFpUXe96j95DdmNvyRC9GYqX90f8Z5HJghruSuURFfC1KvvCPEJBhwKTpL
4JG3px90z2oS1I/8vI99lIGAmsVVOErEgJOkv6yFvW0bMzd9s/4mcBn0/xsSSjXD
tlxiFa3ZuVl1BwB5DVNcIc7XbQA0LKL5ngs0vgHLN+dJXrj8wdmxKAB0zHOz6+V5
Ni0GLU8XsRvYhyA/imGtNX/nhTCyfhHDqRpgQrugEv0oGEEYp6UbPGW7jHk8BGpu
epujyRhX+381i1M4JDo+LpCOX872ZbzS3iHb3okNCZCu2C68CBIMMPU/nhVP7I6/
3Vk8Qnc/FFZvh2/k/qFMudeljyC80qtI4g16E6iYZay2velPt+TKEVc4A/Ate2LL
uyugvR62Z6uYSsi31fQWV6vDLqLOeUoy+XhVY0rrGuOf+PwbGsYAywu7GctCDMJy
3OXL6f1G823SUckmOxVXWmmoc/yn3Qu8S58FukH6JpavqfZ+0NRZcYv0RHx0DTmh
ImBRxF2dYaDD4UvXWfIFp9X9+Vphm3exnMsGNZxLvsUL4UdSTfA1U2dAyd3FbSWi
rTu8r3NeCFmSfjZ+ZxJYE1zjRW9PetDNmaeeVczlzBMq2s+Y8JDim6O8d9tPcFDF
694ROBu9l0KtJ3Cha4hl
=iVW4
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
