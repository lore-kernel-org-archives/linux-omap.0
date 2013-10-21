From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: Add support for optional wake-up interrupt
Date: Mon, 21 Oct 2013 07:21:16 -0500
Message-ID: <20131021122116.GL18921@gimli>
References: <20131017232820.GG15154@atomide.com>
 <20131018161916.GF18921@gimli>
 <20131018163740.GP15154@atomide.com>
 <20131018164535.GQ15154@atomide.com>
 <20131018225606.GT15154@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131018225606.GT15154@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2013 at 03:56:07PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [131018 09:45]:
> > * Tony Lindgren <tony@atomide.com> [131018 09:38]:
> > > * Felipe Balbi <balbi@ti.com> [131018 09:19]:
> > > > > @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart=
_port *port)
> > > > > =20
> > > > >  	pm_runtime_mark_last_busy(up->dev);
> > > > >  	pm_runtime_put_autosuspend(up->dev);
> > > > > -	free_irq(up->port.irq, up);
> > > > > +
> > > > > +	for (i =3D 0; i < ARRAY_SIZE(up->irqs); i++)
> > > > > +		if (up->irqs[i])
> > > > > +			devm_free_irq(up->port.dev, up->irqs[i], up);
> > > >=20
> > > > do you need this at all if you're using devm_* ?
> > >=20
> > > So it seems, startup and shutdown are managed by serial_core and
> > > that's what at least clps711x.c serial driver is doing.
> >=20
> > And that means devm_* in this case does not really help us
> > here..
> >=20
> > I guess we could keep the IRQ requested from probe, but
> > there's probably a reason why it's done in startup/shutdown.
> >=20
> > So I'll just drop the devm_* changes for now.
>=20
> Here's an updated simplified version. I also got rid of the
> for loops as the wake-up interrupt is optional and it made the
> code a bit of a pain to read.
>=20
> Regards,
>=20
> Tony
>=20
>=20
> 8< ----------------------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 16 Oct 2013 10:27:28 -0700
> Subject: [PATCH] serial: omap: Add support for optional wake-up interrupt
>=20
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

looks much nicer

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSZRw8AAoJEIaOsuA1yqREd00P/0jqtKrwyZ5ognT7FbSLh+R3
vRVD7ykDlwp7wcLRPkPuvvR1PKq+zJRHfiPegcYIXQ61NP5B0V0PCPATxf04rU6r
/x9Qd1ugbpnopwrB1Su/9L61plomdnsvWpAwFUcu6SKAzBQ3saQu97D989dlu3mX
jzi7wRClO0yvfR15iRwPlB1sG0Y3XnX9r58xDIefvsrljyUvkThJe1QNHpYbCUuv
yCK5LjbYEXUq9fGnJQaM3ZylDfrnVPhyhUFDdGKTCruY/sdzzABcbi0K5W7ahJVE
LcdAYiHeH58a5aRnIQ/4W5OYsQhdUzyjtKPDT6Ji1B2aYKF6g1/DpKPZ885BQpcB
oy0dtIcyePge/Y9S0EkEx5dJv5r6n9iF8NTkvxm41gR3cz0L9b6o2flTGjjGoD5+
eXDfFhyAFpsqka5TclJ2vVFLZS9idh0+jG65ZM3rOanO6MBixSEfp8IwbIdfrISN
hJ8b/Atj+OJHywP/dbWfL8NioiyyARTZ0nM2mQo85JyXnTxTJhEyyj+Mh+5w/XI7
G8rZwx4GxOr+p6PPDA67IOLEjPgSdfB5mYTkJvQH5wk1oPozvvAGEeEOsojCH+Yy
ARtA6QicMkPeHvJFtUs+zuCN+bn8XCvsVjYUev/sDmxkp6hzzWRLudQGKOc6jzwR
oAHLPCOnoPBPaAYQF6AN
=b8H+
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--
