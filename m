From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 2/2] SERIAL: OMAP: Remove the idle handling from
 the driver
Date: Fri, 15 Feb 2013 14:57:40 +0200
Message-ID: <20130215125740.GB16558@arwen.pp.htv.fi>
References: <1360930135-32092-1-git-send-email-santosh.shilimkar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761702Ab3BOM6C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 07:58:02 -0500
Content-Disposition: inline
In-Reply-To: <1360930135-32092-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Rajendra nayak <rnayak@ti.com>

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2013 at 05:38:55PM +0530, Santosh Shilimkar wrote:
> UART IP idle handling now taken care by runtime pm apis so remove
> the hackery from the driver.
>=20
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c     |   31 -------------------------------
>  drivers/tty/serial/omap-serial.c |   23 -----------------------
>  2 files changed, 54 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 04fdbc4..037e691 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -95,38 +95,9 @@ static void omap_uart_enable_wakeup(struct device *dev=
, bool enable)
>  		omap_hwmod_disable_wakeup(od->hwmods[0]);
>  }
> =20
> -/*
> - * Errata i291: [UART]:Cannot Acknowledge Idle Requests
> - * in Smartidle Mode When Configured for DMA Operations.
> - * WA: configure uart in force idle mode.
> - */
> -static void omap_uart_set_noidle(struct device *dev)
> -{
> -	struct platform_device *pdev =3D to_platform_device(dev);
> -	struct omap_device *od =3D to_omap_device(pdev);
> -
> -	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
> -}
> -
> -static void omap_uart_set_smartidle(struct device *dev)
> -{
> -	struct platform_device *pdev =3D to_platform_device(dev);
> -	struct omap_device *od =3D to_omap_device(pdev);
> -	u8 idlemode;
> -
> -	if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART_WKUP)
> -		idlemode =3D HWMOD_IDLEMODE_SMART_WKUP;
> -	else
> -		idlemode =3D HWMOD_IDLEMODE_SMART;
> -
> -	omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
> -}
> -
>  #else
>  static void omap_uart_enable_wakeup(struct device *dev, bool enable)
>  {}
> -static void omap_uart_set_noidle(struct device *dev) {}
> -static void omap_uart_set_smartidle(struct device *dev) {}
>  #endif /* CONFIG_PM */
> =20
>  #ifdef CONFIG_OMAP_MUX
> @@ -299,8 +270,6 @@ void __init omap_serial_init_port(struct omap_board_d=
ata *bdata,
>  	omap_up.uartclk =3D OMAP24XX_BASE_BAUD * 16;
>  	omap_up.flags =3D UPF_BOOT_AUTOCONF;
>  	omap_up.get_context_loss_count =3D omap_pm_get_dev_context_loss_count;
> -	omap_up.set_forceidle =3D omap_uart_set_smartidle;
> -	omap_up.set_noidle =3D omap_uart_set_noidle;
>  	omap_up.enable_wakeup =3D omap_uart_enable_wakeup;
>  	omap_up.dma_rx_buf_size =3D info->dma_rx_buf_size;
>  	omap_up.dma_rx_timeout =3D info->dma_rx_timeout;
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-s=
erial.c
> index 57d6b29..5722eaf 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -201,26 +201,6 @@ static int serial_omap_get_context_loss_count(struct=
 uart_omap_port *up)
>  	return pdata->get_context_loss_count(up->dev);
>  }
> =20
> -static void serial_omap_set_forceidle(struct uart_omap_port *up)
> -{
> -	struct omap_uart_port_info *pdata =3D up->dev->platform_data;
> -
> -	if (!pdata || !pdata->set_forceidle)
> -		return;
> -
> -	pdata->set_forceidle(up->dev);
> -}
> -
> -static void serial_omap_set_noidle(struct uart_omap_port *up)
> -{
> -	struct omap_uart_port_info *pdata =3D up->dev->platform_data;
> -
> -	if (!pdata || !pdata->set_noidle)
> -		return;
> -
> -	pdata->set_noidle(up->dev);
> -}
> -
>  static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool en=
able)
>  {
>  	struct omap_uart_port_info *pdata =3D up->dev->platform_data;
> @@ -279,8 +259,6 @@ static void serial_omap_stop_tx(struct uart_port *por=
t)
>  		serial_out(up, UART_IER, up->ier);
>  	}
> =20
> -	serial_omap_set_forceidle(up);
> -
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
>  }
> @@ -348,7 +326,6 @@ static void serial_omap_start_tx(struct uart_port *po=
rt)
> =20
>  	pm_runtime_get_sync(up->dev);
>  	serial_omap_enable_ier_thri(up);
> -	serial_omap_set_noidle(up);

this patch is changing behavior. Currently driver has:

start_tx()
get_sync()
set_noidle()
put_autosuspend()

=2E...

stop_tx()
get_sync()
set_force_idle()
put_autosuspend()

with this change, you will have:

start_tx()
get_sync()
set_noidle()
put_autosuspend()
set_force_idle()

this in itself might be enough to go back to corrupted serial if
put_autosuspend is so quick that set_force_idle() is called before all
data has been shifted out of FIFO and through the UART lines.

Before doing this, you should at least test that removing
pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() from
start_tx() and removing pm_runtime_get_sync() from stop_tx() works fine.

Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
there is still the regression of UART never being wakeup capable.

I wonder what are your ideas to sort that part out, I mean, how do you
plan to implement ->set_wake() for the tty port ?

One last comment, to avoid conflicts, it'd be better to split driver
part from removal of platform_data function pointer initialization, so
that we can send driver changes in one merge window and the
platform_data part in another.

--=20
balbi

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHjDEAAoJEIaOsuA1yqREI18P/jUaUINp/BPzLne69IPUOziD
XaXVR6zItDRM7t6mF37mmbR384DsRbvk0I7sdHqqWAoSS1TnXatW9WbSAtOj7p6L
yUTNLk4jn5g9AgvgGQ76achcNxOjsRn487wXPqrmWuiIWPgd/P1CMF8U8sh/Srqb
KSS2FnKiwYIotnqcS7kd0YM21jZ6QkfLUnMJPSgCMB9JYyCYQL+GxU8ZRqMRmSqS
RYxDqtB2uHKT3fLB5NmlF5uzcUQlRvccdd3HeUBdwnT1oD7RDakIhXdQhTHUz5bC
JeTTDclAmFV0jOdehcyfyzCEttTmlXKGidG6quKJLyJG0VKSn82vivIawBPaQTJx
veWMB5p03zg8vzuBaBqdaLAVrTZYl+M77IfPuHDKRT31aH56X1osNKdvfItIrjjR
Knl/fBccLu9e+K12rAYd+k5FQar1XaAvGygcqwkPCO2ugcfeC/LzJG8o0MhKBNcq
m8hx2RKlLWy5Y/0yrYDsrxfjs+NOOk8NkxFbgbnDK6bnNx8x3jE401iPKwoH74Yk
ae4rgQg7+DJ1Vd5cHOOTQWSQdr1Z97hqbIWv2MOItxJjPjn1y8IiSgnSFyeUkfj8
k5AglVi80/MCeYKQcDCK2V/FqVrpDrEmIw2/hqbLc6qOqR8uzeyBTZGLw6ULUYse
oDsT8a6IfbhKbkZY+KEZ
=BC8M
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
