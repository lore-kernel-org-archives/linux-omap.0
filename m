From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: Add support for optional wake-up interrupt
Date: Fri, 18 Oct 2013 11:19:16 -0500
Message-ID: <20131018161916.GF18921@gimli>
References: <20131017232820.GG15154@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5009715211362600447=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131017232820.GG15154@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============5009715211362600447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline

--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 17, 2013 at 04:28:20PM -0700, Tony Lindgren wrote:
> With the recent pinctrl-single changes, omaps can treat
> wake-up events from deeper idle states as interrupts.
>=20
> There's a separate "io chain" controller on most omaps
> that stays enabled when the device hits off-idle and the
> regular interrupt controller is powered off.
>=20
> Let's add support for the optional second interrupt for
> wake-up events. And then serial-omap can manage the
> wake-up interrupt from it's runtime PM calls to avoid
> spurious interrupts during runtime.
>=20
> Note that the wake interrupt is board specific as it
> uses the UART RX pin, and for omap3, there are six pin
> options for UART3 RX pin.
>=20
> Also Note that the legacy platform based booting handles
> the wake-ups in the legacy mux driver and does not need to
> pass the wake-up interrupt to the driver.
>=20
> And finally, to pass the wake-up interrupt in the dts file,
> either interrupt-map or the pending interrupts-extended
> property needs to be passed. It's probably best to use
> interrupts-extended when it's available.
>=20
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

looks good, minor nits below

> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -39,6 +39,7 @@
>  #include <linux/irq.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_data/serial-omap.h>
> @@ -134,7 +135,7 @@ struct uart_omap_port {
>  	struct uart_port	port;
>  	struct uart_omap_dma	uart_dma;
>  	struct device		*dev;
> -
> +	int			irqs[2];
>  	unsigned char		ier;
>  	unsigned char		lcr;
>  	unsigned char		mcr;
> @@ -176,6 +177,8 @@ struct uart_omap_port {
>  };
> =20
>  #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, =
port)))
> +#define omap_uartirq		(up->irqs[0])
> +#define omap_wakeirq		(up->irqs[1])
> =20
>  static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
> =20
> @@ -214,10 +217,23 @@ static int serial_omap_get_context_loss_count(struc=
t uart_omap_port *up)
>  	return pdata->get_context_loss_count(up->dev);
>  }
> =20
> +static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
> +				       bool enable)
> +{
> +	if (!omap_wakeirq)
> +		return;

can we drop the pointless obfuscation ?

> @@ -689,15 +705,25 @@ static int serial_omap_startup(struct uart_port *po=
rt)
>  {
>  	struct uart_omap_port *up =3D to_uart_omap_port(port);
>  	unsigned long flags =3D 0;
> -	int retval;
> +	int i, retval;
> =20
>  	/*
> -	 * Allocate the IRQ
> +	 * Allocate the IRQs, the second IRQ is the optional wakeirq
>  	 */
> -	retval =3D request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
> -				up->name, up);
> -	if (retval)
> -		return retval;
> +	for (i =3D 0; i < ARRAY_SIZE(up->irqs); i++) {
> +		if (i =3D=3D 1 && !omap_wakeirq) {
> +			dev_info(up->port.dev, "no wakeirq for uart%d\n",
> +				 up->port.line);
> +			break;
> +		}
> +		retval =3D devm_request_irq(up->port.dev, up->irqs[i],
> +					  serial_omap_irq, up->port.irqflags,
> +					  up->name, up);

conversion to devm_* should be done as another patch, it seems.

> @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *p=
ort)
> =20
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
> -	free_irq(up->port.irq, up);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(up->irqs); i++)
> +		if (up->irqs[i])
> +			devm_free_irq(up->port.dev, up->irqs[i], up);

do you need this at all if you're using devm_* ?

--=20
balbi

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSYV+EAAoJEIaOsuA1yqREBHQP/15Xl/1cRNwDtPaPiRCXeodO
s9LofebZe8WEbCTt/Dad6O7HxFIixNgE7GliH/2GsgNa5LJrq+IY7r5E2e+gGTPN
+xoDovCMGtiBfXijGKY1A94VmtC1AQg9U7786VXcGvjaVhVuAw8lpgFWhSE0ElHO
DlVKAiWBvu2l9SbQPQS3ufL8LfBYxBKVzkaY7zxUdiqjt831Z+l8Qm0Qa7QYW4Fg
9uiD5snqfgJ1SecOyzo3ILqJF2X3EZn4m5vg1zI9rEAMJmQqBvE/XXYQvlA8tkXz
+l9lxPrygwLsAucAqgnsqpKdyd4SQ7jkq2v3D99cC9vg1Tn4z/qTxs7e/bjpfwHL
v6SAqXpi3vVdHEWAXHmRTzZyAlotmZ0CwBt+mdFZbTXNI8P+oHq0uhfkJbv0zZct
rQMf+0PKuT/w02S/6pkzP7Y7cDaCmW694a2TGK9YM5lqqdimAjLWqWIupc0YiusZ
m84SNHrudOe2CS4i2hf437ZHNp8y6ngUBdCbupW+gGhpoM0T0qJFFA1BM1CVW+Rh
43l8nF48K4wjLkw5UnV+P94z4NqE7ny5o7ImfgNuzCp3ZfAbHs2e9RLuQ7EEmRFD
mxE8q9NxZnK3vKbf5EWsNykfrkm6i4Peo3z/3AB53xZE4h7OxOp8pJHBqgb9wLl4
sZYM0JeiyfsCBtvnT8Fy
=eVm5
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--


--===============5009715211362600447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5009715211362600447==--
