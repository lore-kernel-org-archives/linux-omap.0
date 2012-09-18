From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: Remove unnecessary checks from
 suspend/resume
Date: Tue, 18 Sep 2012 14:34:46 +0300
Message-ID: <20120918113444.GG24047@arwen.pp.htv.fi>
References: <1347968154-27997-1-git-send-email-sourav.poddar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347968154-27997-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, santosh.shilimkar@ti.com
List-Id: linux-omap@vger.kernel.org


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2012 at 05:05:54PM +0530, Sourav Poddar wrote:
> Drop the check for "up" being valid on suspend/resume callbacks.
> It should be valid always. Get rid of the "pdata" check also as
> serial_omap_get_context_loss_count() checks for it.
>=20
> Tested on omap4 panda and 3630 based Beagle board.

you need a blank line here. Other than that:

Reviewed-by: Felipe Balbi <balbi@ti.com>

ps: what kind of tests did you run, btw ?

> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c |   23 +++++++++--------------
>  1 files changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-s=
erial.c
> index f175385..3c05c5e 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1222,10 +1222,8 @@ static int serial_omap_suspend(struct device *dev)
>  {
>  	struct uart_omap_port *up =3D dev_get_drvdata(dev);
> =20
> -	if (up) {
> -		uart_suspend_port(&serial_omap_reg, &up->port);
> -		flush_work_sync(&up->qos_work);
> -	}
> +	uart_suspend_port(&serial_omap_reg, &up->port);
> +	flush_work_sync(&up->qos_work);
> =20
>  	return 0;
>  }
> @@ -1234,8 +1232,8 @@ static int serial_omap_resume(struct device *dev)
>  {
>  	struct uart_omap_port *up =3D dev_get_drvdata(dev);
> =20
> -	if (up)
> -		uart_resume_port(&serial_omap_reg, &up->port);
> +	uart_resume_port(&serial_omap_reg, &up->port);
> +
>  	return 0;
>  }
>  #endif
> @@ -1553,17 +1551,14 @@ static int serial_omap_runtime_suspend(struct dev=
ice *dev)
>  static int serial_omap_runtime_resume(struct device *dev)
>  {
>  	struct uart_omap_port *up =3D dev_get_drvdata(dev);
> -	struct omap_uart_port_info *pdata =3D dev->platform_data;
> =20
> -	if (up && pdata) {
> -			u32 loss_cnt =3D serial_omap_get_context_loss_count(up);
> +	u32 loss_cnt =3D serial_omap_get_context_loss_count(up);
> =20
> -			if (up->context_loss_cnt !=3D loss_cnt)
> -				serial_omap_restore_context(up);
> +	if (up->context_loss_cnt !=3D loss_cnt)
> +		serial_omap_restore_context(up);
> =20
> -		up->latency =3D up->calc_latency;
> -		schedule_work(&up->qos_work);
> -	}
> +	up->latency =3D up->calc_latency;
> +	schedule_work(&up->qos_work);
> =20
>  	return 0;
>  }
> --=20
> 1.7.1
>=20

--=20
balbi

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQWFxUAAoJEIaOsuA1yqREEucP/j6m7HVUEQksrOs9VxrgkQSY
KOJ/fTPA8n7Kry4SUL0nxlrujAi75eDhgOG4aBm3FxGlMl1a6GyfFf1746/Y+mco
m/hwOzx2kz31Pa3rvH2oA+d1XmZqK7lEOqyUJHQVRYZcEspPwE9YaqEPunLSkolO
momb2wnjPgkJzKQ7zfxccI0Ui0WmG6Me8Zch47YnU1zMOuCeDleRKMaQi04duXp2
UgSSzTJ9H37dpFnUsmThyq21p9mqENbotXFFpdPu2fn+pYxirS/AHRssgDsgnBDE
alPJD9jtWk3BCuyUrw62XusIgF73Jn8DoNOfs6EjAtJL7/FTeekdnAVfkeORe9PA
tY6/v+0XxDkSfYLTnvYruGmxpfdTNLfUs1RVjH/CBbLrW5FvInBi1NaKNfhH85h8
21+Zdh3tYPGwN80ILtkFrbIg4qX5FRSZNiEYJG9iI7TGwGJwmxDHopZgkTYmoBLX
8i+X15MdZ1syku2fCjjGECLgtVcuhazjjsCoTeOfrkUvsmnqWOGgVyCf+CueR7MB
RzB+acrmsJ9pV7I2JwMl/dahIVBGZhenHTR7b9eXMJsLciiLpz9ZcdCFKG5ShZXR
BdSdf6tKEuLlKEaVDio1eji3gadowsi1lKBHUL8t13WgDA9VE9z2hixCAOXraQaf
E6LmOZRD0CGAjg9x8XG0
=tB91
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
