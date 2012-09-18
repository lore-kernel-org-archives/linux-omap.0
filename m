From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
Date: Tue, 18 Sep 2012 17:02:17 +0300
Message-ID: <20120918140213.GA27463@arwen.pp.htv.fi>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, balbi@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2012 at 06:10:50PM +0530, Sourav Poddar wrote:
> Greg's tty-next is not booting on 2420 based N800. The failure is
> observed at serial init itself. The reason might be that n800 tries to
> resume even though it is not suspended before.
>=20
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

Paul does this fix the issue for you ? Note that it depends on a
previous patch Sourav sent [1]

[1] http://marc.info/?l=3Dlinux-omap&m=3D134796819607889&w=3D2

There's one thing that gets my attention, though, why only n800 would
fail here ?

I wonder if we should be using:

pm_runtime_set_active(dev);
pm_runtime_get_enable(dev);

to prevent our runtime_resume() to be called from probe, but Sourav
tested and it doesn't work on BeagleBoard, but it works on PandaBoard.

Does it ring any bell ??

> ---
> This patch is developed on top of greg's tty-next branch
> CommitId: e740d8f tty: serial: Samsung: Fix return value +
> the following patch which I have already posted to the mailing list.
> http://comments.gmane.org/gmane.linux.ports.arm.omap/84729
>=20
>  drivers/tty/serial/omap-serial.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-s=
erial.c
> index 3c05c5e..bc355f2 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -110,6 +110,7 @@ struct uart_omap_port {
>  	u32			calc_latency;
>  	struct work_struct	qos_work;
>  	struct pinctrl		*pins;
> +	unsigned int		suspended:1;
>  };
> =20
>  #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, =
port)))
> @@ -1545,14 +1546,20 @@ static int serial_omap_runtime_suspend(struct dev=
ice *dev)
>  	up->latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
>  	schedule_work(&up->qos_work);
> =20
> +	up->suspended =3D true;
> +
>  	return 0;
>  }
> =20
>  static int serial_omap_runtime_resume(struct device *dev)
>  {
>  	struct uart_omap_port *up =3D dev_get_drvdata(dev);
> +	u32 loss_cnt;
> +
> +	if (!up->suspended)
> +		return 0;
> =20
> -	u32 loss_cnt =3D serial_omap_get_context_loss_count(up);
> +	loss_cnt =3D serial_omap_get_context_loss_count(up);
> =20
>  	if (up->context_loss_cnt !=3D loss_cnt)
>  		serial_omap_restore_context(up);
> @@ -1560,6 +1567,8 @@ static int serial_omap_runtime_resume(struct device=
 *dev)
>  	up->latency =3D up->calc_latency;
>  	schedule_work(&up->qos_work);
> =20
> +	up->suspended =3D false;
> +
>  	return 0;
>  }
>  #endif
> --=20
> 1.7.1
>=20

--=20
balbi

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQWH7lAAoJEIaOsuA1yqREYDUP/0o0veibz7UEo1FP5bnAsNUW
zULkHGzwKPa6McM6cTVepuN6NhdLLxHvx/zOdcq27YCU4swE4ZIX0nzl83QJOcaP
UmHW1bljT8m7NqeBGWo8GURe939DFF3wfN9gqB3BmfwwwY5pT8u+50y0Ut8kJ3Bd
RhjABXnUS81OdntcLcPlEgWaiI5zkcESwfoi3JaXtpXhClOn2c54FeuMibfUBytR
KtLskxEGt9dwXVraIxR5EloFpZrTgDDOK+vErjYMOqI86BM/GFTP6pwlIu/F24LM
idLYhwsbdHpbDwkfYz7X/izdoUz6e88XIK8fEsH/ZWzVTzJiVXVaNzB3ZEMQNvEb
TjyZ5nHtzGj9h4AYFE/fSjlSyt3xa2gNznG/Vm3+kMWMg+z7VNuse1jUIAepvg/0
o4XAngk/is/pp47vDRp+F18raSaPfKaFVJKyOs4xk84SKp+CdHNbT+nfxIjYVrJ7
+E43k57Yf49Jkjs5NgljQdTiY8FXTd2ptR1GPUZmPfMeT3SqkfdlJN3fMT8/4Z7E
vF5Aychije1+1sW2CeJiDz8PDf8aO2p4LtNHtdgFVnOesKKwwjpQjSCI85kOhfG8
sN7StSIBzQHpsA5YInd2qRlicozbHnuv3xCr6AUhr7ihR71X4HWlTYRvlZyCIHNC
EQtZzylmeo5QnGVXUQi1
=Ah57
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
