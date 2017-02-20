From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 22:08:50 +0100
Message-ID: <201702202208.50498@pali>
References: <cover.1482936802.git.hns@goldelico.com> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1744452.UVGmpsnQfS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201702202042.15878@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?utf-8?q?Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org

--nextPart1744452.UVGmpsnQfS
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
> Hi Nikolaus!
>=20
> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> > Hi Dmitry,
> >=20
> > > Input driver may set resolution for given axis in units per mm
> > > (or units per radian for rotational axis ABS_RX, ABS_RY,
> > > ABS_RZ), and if you check the binding, you can use
> > > "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
> > > entire touch surface and set resolution from it so that
> > > userspace can calculate the proper scaling factor.
> >=20
> > How is this information exposed by the kernel to user-space? By
> > scanning the DT file or tree?
>=20
> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
> ioctl() on input device. Look at struct input_absinfo, you should
> have all needed information here. This is generic input interface,
> no DT is needed.

Looking at kernel code... via EVIOCSABS ioctl() you can even set=20
resolution from userspace for specified input device.

So this could be potentially used for calibrating input device from=20
userspace? (In case DT data will not fully match current HW)

> I hope that XServer is already using it for evdev devices...
>=20
> For whole implementation look at evtest program. That should be good
> starting point for your userspace implementation.
>=20
> While I'm watching this discussion... in my opinion kernel should
> just invert input axes (when needed) and should not do any other
> normalization or integer/floating-point
> re-calibration/re-calculation. If it correctly exports minimum
> value, maximum value and resolution then userspace can correctly
> re-scale input events to units which userspace needs (e.g. mapping
> into LCD screen pixels or whatever is needed).

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1744452.UVGmpsnQfS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlirWuIACgkQi/DJPQPkQ1LF6ACbBrF6PHJA3rBGfSzDBZ7i0gYp
ugYAn16sy9AkgXOzJBfvTjJGEI0Q6AUc
=dm6m
-----END PGP SIGNATURE-----

--nextPart1744452.UVGmpsnQfS--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
