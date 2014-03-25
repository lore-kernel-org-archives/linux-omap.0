From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: Fix missing pm_runtime_resume handling by
 simplifying code
Date: Tue, 25 Mar 2014 13:52:37 -0500
Message-ID: <20140325185237.GB7216@saruman.home>
References: <20140325184846.GB31906@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140325184846.GB31906@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 11:48:47AM -0700, Tony Lindgren wrote:
> The lack of pm_runtime_resume handling for the device state leads into
> device wake-up interrupts not working after a while for runtime PM.
>=20
> Also, serial-omap is confused about the use of device_may_wakeup.
> The checks for device_may_wakeup should only be done for suspend and
> resume, not for pm_runtime_suspend and pm_runtime_resume. The wake-up
> events for PM runtime should always be enabled.
>=20
> The lack of pm_runtime_resume handling leads into device wake-up
> interrupts not working after a while for runtime PM.
>=20
> Rather than try to patch over the issue of adding complex tests to
> the pm_runtime_resume, let's fix the issues properly:
>=20
> 1. Make serial_omap_enable_wakeup deal with all internal PM state
>    handling so we don't need to test for up->wakeups_enabled elsewhere.
>=20
>    Later on once omap3 boots in device tree only mode we can also
>    remove the up->wakeups_enabled flag and rely on the wake-up
>    interrupt enable/disable state alone.
>=20
> 2. Do the device_may_wakeup checks in suspend and resume only,
>    for runtime PM the wake-up events need to be always enabled.
>=20
> 3. Finally just call serial_omap_enable_wakeup and make sure we
>    call it also in pm_runtime_resume.
>=20
> 4. Note that we also have to use disable_irq_nosync as serial_omap_irq
>    calls pm_runtime_get_sync.
>=20
> Fixes: 2a0b965cfb6e (serial: omap: Add support for optional wake-up)
> Cc: stable@vger.kernel.org # v3.13+
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -225,14 +225,19 @@ static inline void serial_omap_enable_wakeirq(struc=
t uart_omap_port *up,
>  	if (enable)
>  		enable_irq(up->wakeirq);
>  	else
> -		disable_irq(up->wakeirq);
> +		disable_irq_nosync(up->wakeirq);

looks to me liket his should be a separate fix of its own...

>  static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool en=
able)
>  {
>  	struct omap_uart_port_info *pdata =3D dev_get_platdata(up->dev);
> =20
> +	if (enable =3D=3D up->wakeups_enabled)
> +		return;

is there any case where you would call this function twice with the same
argument ?

> +
>  	serial_omap_enable_wakeirq(up, enable);
> +	up->wakeups_enabled =3D enable;
> +
>  	if (!pdata || !pdata->enable_wakeup)
>  		return;
> =20
> @@ -1495,6 +1500,11 @@ static int serial_omap_suspend(struct device *dev)
>  	uart_suspend_port(&serial_omap_reg, &up->port);
>  	flush_work(&up->qos_work);
> =20
> +	if (device_may_wakeup(dev))
> +		serial_omap_enable_wakeup(up, true);
> +	else
> +		serial_omap_enable_wakeup(up, false);
> +
>  	return 0;
>  }
> =20
> @@ -1502,6 +1512,9 @@ static int serial_omap_resume(struct device *dev)
>  {
>  	struct uart_omap_port *up =3D dev_get_drvdata(dev);
> =20
> +	if (device_may_wakeup(dev))
> +		serial_omap_enable_wakeup(up, false);
> +
>  	uart_resume_port(&serial_omap_reg, &up->port);
> =20
>  	return 0;
> @@ -1877,17 +1890,7 @@ static int serial_omap_runtime_suspend(struct devi=
ce *dev)
> =20
>  	up->context_loss_cnt =3D serial_omap_get_context_loss_count(up);
> =20
> -	if (device_may_wakeup(dev)) {
> -		if (!up->wakeups_enabled) {
> -			serial_omap_enable_wakeup(up, true);
> -			up->wakeups_enabled =3D true;
> -		}
> -	} else {
> -		if (up->wakeups_enabled) {
> -			serial_omap_enable_wakeup(up, false);
> -			up->wakeups_enabled =3D false;
> -		}
> -	}
> +	serial_omap_enable_wakeup(up, true);
> =20
>  	up->latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
>  	schedule_work(&up->qos_work);
> @@ -1901,6 +1904,8 @@ static int serial_omap_runtime_resume(struct device=
 *dev)
> =20
>  	int loss_cnt =3D serial_omap_get_context_loss_count(up);
> =20
> +	serial_omap_enable_wakeup(up, false);
> +
>  	if (loss_cnt < 0) {
>  		dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
>  			loss_cnt);

--=20
balbi

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTMdB1AAoJEIaOsuA1yqREE7YP/2yBpWwiAXcPsUyN68ZRD0Ay
xalZ0y75753NDD8C4n2X2jcO8FZuvKd7f9SwT1nBV0vHM4yKd0exjj7Mtyhp4G+e
i4s0dPRn8fIWkyL+CM8j1P3AJ4uPTg81eeN8hbnSW/5f+AO9ekC6FxCLHh/yfMbP
YHDd1sWZwL3qf/eP+1qlzT+WgfcAKWRD/j457xQ9y4ZH2EZS8AqL4vroh77z7Knv
dR5sq382MxOIxsZ/H+zYqeU4Byh7ji5XKJbt/kzrX4Y+tFhcwwM0vYkt2ZfyhU01
/bZNLmV07fC5tifRSqKnxDGhE6fHKDaCjqkc20Y6tyncvlbS54U1lSV3msXux9Uk
YteGVntjW1NFWqPRpn4HL3TIISgAkr6ouxKah+sCvuDIW5zK8x245oPXkq+Us0bO
U8p/uln3oE/nfxK0HHhDGOc+c1kwtwbaAqc4HgvQjW845dnMC1lcJ9PYXVcr2eGd
6XD7l5+t+s69mN8w5Wix2a6KbY0wQTGw6mUgthGxj0aUaIqZWovu92icL0qI1dsT
6pjsbD2ooA0qt9ANrwpd0fhViEDdEpkYitZ9NA9jSWhp38HM4tCyC7Y9skEzTwIo
6v/yyfaT1BNy75BoHSPWEwfR5Op6U59XzauBmnqYRXvD0Lt0s0FdeHH0q5R9B+Dk
AEALYPQn9cEPVc+zqBRG
=0eMz
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
