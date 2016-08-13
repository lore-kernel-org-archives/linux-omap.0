From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 2/7] tty: add support for "tty slave" devices
Date: Sat, 13 Aug 2016 22:31:24 +0200
Message-ID: <20160813203124.GA647@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-3-git-send-email-sre@kernel.org>
 <20160813100345.GA14665@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160813100345.GA14665@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 13, 2016 at 12:03:45PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 13, 2016 at 05:14:33AM +0200, Sebastian Reichel wrote:
> > From: NeilBrown <neilb@suse.de>
> >=20
> > A "tty slave" is a device connected via UART.  It may need a driver to,
> > for example, power the device on when the tty is opened, and power it
> > off when the tty is released.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.txt | 4 ++++
> >  drivers/tty/tty_io.c                              | 6 ++++++
> >  2 files changed, 10 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Docume=
ntation/devicetree/bindings/serial/8250.txt
> > index f5561ac7e17e..ecb74730f71b 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.txt
> > +++ b/Documentation/devicetree/bindings/serial/8250.txt
> > @@ -46,6 +46,10 @@ Optional properties:
> >    line respectively. It will use specified GPIO instead of the periphe=
ral
> >    function pin for the UART feature. If unsure, don't specify this pro=
perty.
> > =20
> > +Optional child node:
> > +- a device connected to the uart can be specified as child node with
> > +  compatible value.
> > +
> >  Note:
> >  * fsl,ns16550:
> >    ------------
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 734a635e7363..39ff5dcdfd50 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -95,6 +95,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/serial.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/of_platform.h>
> > =20
> >  #include <linux/uaccess.h>
> > =20
> > @@ -3317,6 +3318,11 @@ struct device *tty_register_device_attr(struct t=
ty_driver *driver,
> >  	retval =3D device_register(dev);
> >  	if (retval)
> >  		goto error;
> > +	if (device && device->of_node)
> > +		/* Children are platform devices and will be
> > +		 * runtime_pm managed by this tty.
> > +		 */
> > +		of_platform_populate(device->of_node, NULL, NULL, dev);
>
> Why are these platform devices?
> And why only OF?

I just took this patch over from Neil to get bluetooth working
on N900/N950. Both of them are DT only (well N900 still has
boardcode, but that will be removed shortly), so it was enough
for me.

I guess you have something in mind, that's similar to e.g. i2c
and spi with a serial_client device and support to instanciate
it from DT, ACPI and boardcode?

-- Sebastian

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXr4ORAAoJENju1/PIO/qa8iUQAKUVBexYZbl3qZN60osF36xo
7+Nfm+8u5bA+lN89ozBAzDUia1PwxRt2Wta/eU+Iq/VSUXCMsXxbH9T9udpRoOV+
JlgNi37FhOayHp+BKa2pjkukl4sfMhwV6VaObgLpJuCeq07PqacfeEXAry0gtCmo
suv3zMWPU+QYZ4D1DqWOYHH5x0yZ/IscopRb0QsgyeFh+tRE3MpeDpPQ0wf3Xrd3
D9q1Jvi5E6VbBe+tcFUt9apsqm8bmG3jHkcFANlY1XBnZplrxppaKp7DWlCGjuV7
vLR1p8GKYnDQocGY0s6bgzXokn9dIg1cZZpxIfS24qfwQXTT72dv07eYHlIZ25zX
gn5mfgef9aZPqezh6dVqBm5UxvUY+cvpQDCQzVO63xH6s8gY4NZCAAQEGfMIunR2
G10Us+7FnEmmgXDrb+dVloga9gNVe8LEAva/JD/ksXxWP8th63bFm7+Ow+F6nY5E
TUm8DAtnVAGofCnQrLCNqL9FJ/cNWU6mUqiu8KBlCb9erfwIdyMjDr1OXdAcZwNG
XzTrhb8l8lXZzPJkKw9+WkxgfYzDYGv8DDVz+kS1nOB9XFPpp+3YfZRWcUXTP1JU
bilwUVYyWle9qMKcOBDEW2pcgGT7/M31AAO/ahXcfOcDKA6b1a1aLv8atSGXZg1q
428XnfwCFjvhvG5tjMC0
=uZGz
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
