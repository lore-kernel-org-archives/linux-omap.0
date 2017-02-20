From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 22:07:38 +0100
Message-ID: <201702202207.38582@pali>
References: <cover.1482936802.git.hns@goldelico.com> <201702202042.15878@pali> <53529A9D-E2AA-405C-A12A-716984D2CDBC@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3297778.tM1pNtk2eR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53529A9D-E2AA-405C-A12A-716984D2CDBC-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?utf-8?q?Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org

--nextPart3297778.tM1pNtk2eR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 February 2017 21:35:18 H. Nikolaus Schaller wrote:
> Hi Pali,
>=20
> > Am 20.02.2017 um 20:42 schrieb Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >=20
> > Hi Nikolaus!
> >=20
> > On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> >> Hi Dmitry,
> >>=20
> >>> Input driver may set resolution for given axis in units per mm
> >>> (or units per radian for rotational axis ABS_RX, ABS_RY,
> >>> ABS_RZ), and if you check the binding, you can use
> >>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
> >>> entire touch surface and set resolution from it so that
> >>> userspace can calculate the proper scaling factor.
> >>=20
> >> How is this information exposed by the kernel to user-space? By
> >> scanning the DT file or tree?
> >=20
> > Set input_abs_set_res() from kernel. And in userspace call
> > EVIOCGABS ioctl() on input device. Look at struct input_absinfo,
> > you should have all needed information here. This is generic input
> > interface, no DT is needed.
>=20
> This assumes that I can and want to write a graphics system myself.

Not only. There are already existing graphics systems. And you need to=20
provide needed information from kernel, so they can start using it.

So input_abs_set_res() is needed to use in your kernel driver.

> > I hope that XServer is already using it for evdev devices...
>=20
> No idea if it does. It is a black box for me out of our control.

https://cgit.freedesktop.org/xorg/driver/xf86-input-evdev/tree/src/evdev.c#=
n1479

So yes, it does.

> > For whole implementation look at evtest program. That should be
> > good starting point for your userspace implementation.
>=20
> The problem I have is that *I* have no userspace implementation and
> the GTA04 project does not want to enforce one. We have several
> different ones: X11 based (LXDE and others), Qt (fb based),
> Replicant to name some.
>=20
> All have the same problem to be solved once. The common denominator
> for a solution are 2 lines of code in the kernel plus some DT
> properties you need anyways if calibration should be automated in
> userland.

As I wrote above part of linux input API is resolution value. And from=20
all information I understood that having current value, minimal value,=20
maximal value and resolution is enough for correct calculation of pixel=20
coordinates in userspace.

And Xserver evdev driver is using it.

If other non-X11 application (which you want/need to use) use resolution=20
information incorrectly (or calculate positions incorrectly), then this=20
is bug that application. Not in Linux kernel, that is important.

And I would rather see fixes of such bugs in that (broken) application=20
as doing workarounds in kernel, just because of bugs in application.

More important, are those applications really broken?

=46rom my point of view: Reporting size of input device is already part of=
=20
stable kernel <--> userspace API/ABI and it should be used instead of=20
inventing new way...

> > While I'm watching this discussion... in my opinion kernel should
> > just invert input axes (when needed) and should not do any other
> > normalization or integer/floating-point
> > re-calibration/re-calculation. If it correctly exports minimum
> > value, maximum value and resolution then userspace can correctly
> > re-scale input events to units which userspace needs (e.g. mapping
> > into LCD screen pixels or whatever is needed).
>=20
> It can, but afaik it does not yet.

I did not tested it, but code is in xf86-input-evdev already there.

So please try to implement input_abs_set_res() in kernel driver and test=20
userspace.

> And if it does, it does it in a
> plethora of different implementation states. That is the reason why
> we want to solve it once for all userlands in the kernel and not
> rely on user-space help.

=46or me this looks like "we are going to fix userspace bugs in kernel".=20
Really! Not a good idea. Plus I still see this as abusing kernel API/ABI=20
as resolution should be handled differently as you are proposing.

> Surely, userland can do a lot of things. It could also do the whole
> file system stuff (FUSE).
>=20
> A more input device related example comes to my mind: userland could
> do keyboard mapping completely. It would suffice if the kernel
> presents some x/y coordinates or gpio-numbers for buttons and
> user-space could map. Still there is a (pre-)mapping to Key-Codes.
> And yes, they are mapped a second time in userland if needed, but it
> works sufficiently well if not done.
>=20
> BR and thanks,
> Nikolaus

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart3297778.tM1pNtk2eR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlirWpoACgkQi/DJPQPkQ1Ik3QCfdBf6q0xhG5k/RiIhUiGltVj2
2QkAoJRdwSZUZRQBXQRCroBKUknMjRE2
=HjFQ
-----END PGP SIGNATURE-----

--nextPart3297778.tM1pNtk2eR--
