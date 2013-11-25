From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] usb: musb: conditionally save and restore the
 context on suspend
Date: Mon, 25 Nov 2013 13:44:27 -0600
Message-ID: <20131125194427.GZ18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-2-git-send-email-zonque@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cJfXB9mphngkt5vq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45863 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984Ab3KYTp3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 14:45:29 -0500
Content-Disposition: inline
In-Reply-To: <1385408393-19707-2-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

--cJfXB9mphngkt5vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 08:39:49PM +0100, Daniel Mack wrote:
> It appears not all platforms featuring a musb core need to save the musb
> core registers at suspend time and restore them on resume.
>=20
> The dsps platform does, however. So add a bit in struct
> musb_hdrc_platform_data to let platforms specify their need of such
> action being taken.
>=20
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/usb/musb/musb_core.c | 17 ++++++++++++++++-
>  include/linux/usb/musb.h     |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 0a43329..a8ded57 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2202,6 +2202,7 @@ static int musb_suspend(struct device *dev)
>  {
>  	struct musb	*musb =3D dev_to_musb(dev);
>  	unsigned long	flags;
> +	struct musb_hdrc_platform_data *plat =3D dev_get_platdata(dev);

we don't want to have platform_data on DT-based boot. It's best to just
save those registers unconditionally as it doesn't hurt.

--=20
balbi

--cJfXB9mphngkt5vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk6ibAAoJEIaOsuA1yqREYn8QALMQexY7ZE+vFf2Ki5ouuoRJ
NQgR+9WjvDscsExuyBiZI8PjWV8wbbgyGqn/XppHtJIlPU18u3I8CefeO07YOrJN
CVQgsXgW8eno1CA4/upsi0ypgyCb0F9eFNfLujgsigXUhud38ffk60JuYpxnan3V
zSifKmkwyDkyI/5tiA5FYZGcT6GCSXYKZwAs+kPIvdlUMBRNx7WXQG5SxHbXWQKE
IFK1aZgCa3/VYS1itvrA5kHkenTaGfpoHq5QXeIFsRVyYBrYPAn79oiJgtuDlLof
f7OwCvBgs3RJrPmc15LCOXS6/jxQB/TcYYN4UoiyvkpkINNzHF89OSOdXEwFSiIZ
XgNudr+0/BOxs6gL4OoK7cNIhhMU/Eo37KP5+wHaWt7xFT4saCUi1dXu2eZWXMOM
D2qGs3nCL8ETg7lGvMqQJPbggWhL+2MjXbbORjgTJgOONi0r/vex+HAvNKw5S+JO
R9gAr5TRTqJMWMSAWnvRb/NjdmGMY1yjeBgIMqAIDPGHzSR3OBM0+1v8AKMMxAMO
z69+CWKSTp3axaa5IhOzZFupcaxElKAOhrRdn8Z7o87luJq2UccwN4rslrzLQ/d3
zRZpHpyG8HLyprKaeENUC2RRc6SQSOw0quZKS9jpbtgwW+NRRUA/78n0FPy6gP7Z
DC5mtkkT1ygbCKHcvahD
=B6MP
-----END PGP SIGNATURE-----

--cJfXB9mphngkt5vq--
