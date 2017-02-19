From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 18:51:00 +0100
Message-ID: <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
References: <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219171518.GA12833@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,
I love discussions with you :)

> Am 19.02.2017 um 18:15 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>=20
>=20
>>> Solve it properly. That means passing calibration
>>> data from kernel to userland.
>>=20
>> As written before, the really proper solution would be to provide =
floating
>> or fixed point subpixel input events. Not arbitrarily scaling up in =
kernel
>> and leaving downscaling to user space (where everybody can make it
>> worse).
>=20
> That has no advantages,

It has the advantage of providing you with the full precision of raw =
data (but
properly scaled) so that you don't loose any bit of information. This is =
what
you just asked for - one or two mails before.

And it provides me (and my users) with properly scaled touch =
coordinates, which
is what I (and they - compare e.g. comment by Andreas Kemnade) ask for.

So it would be a solution that fulfills both requirements. And =
fulfilling
requirements of two groups of people is advantageous to making only one =
happy.
Isn't it?

> and floating point in kernel is hard. Also
> you'd either have to invent new interface, or you'd break touchscreen
> for people that already have their touchscreens calibrated.

No, I don't break calibration for people using a different chip.

And since we just upstream a solution for devices (GTA04) which already =
use this
mechanism for years, we also won't break their calibration, because they =
are happy
with the non-calibration it provides.

We break it only for those, who use the same chip *and* upgrade to a =
kernel which
includes this patch. And even then, only if they update their device =
tree to use
it (the default without DT modifications is to provide raw data as =
before). If
they stay with an older kernel or older DT there is no change and action =
required.

So there are ca. 5 pre-conditions that others will notice a change at =
all.

Do you think user-space recalibration is such a difficult task compared =
to
upgrading a kernel that it must therefore be avoided? Compared to other
kernel-userland synchronization problems it has the good side that you
even will notice it immediately and will know what to do (recalibrate =
once
and it is done forever).

> Just
> pass calibration data to userland.

What is this good for if kernel can already do the calibration for =
userland?
If the kernel does it, it don't even waste efforts to pass calibration =
data
to userland.

And don't forget: if you need calibration data in userland, there are =
much
better mechanisms. The simplest one is a file (e.g. xorg.conf) which is
something the kernel and X11 already supports.

I.e. adding a new mechanism to pass calibration data from the kernel to
user-space doesn't make any sense, IMHO.

If the kernel knows about calibration it should use it directly and =
process it.
Like in iio where you can get raw and processed data, although =
processing could
also be done completely in user-space. So there seem to be good reasons =
to do
it in kernel...

And, citing your argument from above: "Also you'd either have to invent
new interface, or you'd break touchscreen for people that already have =
their
touchscreens calibrated."

>=20
>> But I don't think it is worth implementing subpixel touch events for =
real
>> world devices due to the jitter I mentioned.
>=20
> Yes, that's not really proper solution, that just overengineered. Not
> worth implementing. Pass calibration data to userland.

You seem to repeat yourself and just say which solution you prefer,
but I am missing the arguments why your solution (Pass calibration data
to userland) is right and the best one. Which problems does it solve?
Which one does it solve better than others? How can you implement it in
a stable and portable way? How can you make sure that all user-space GUI
systems can and will make use of this calibration data?

BR and thanks,
Nikolaus


--Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqdsFAAoJEIl79TGLgAm62U4P/jGEcfSPPjKQGtGkFihPgkYU
2vVwj8ZY1AXO73aIt96oLE48QlTFKG+BpgVZsnuZawdtsh1d7FCi8xr+hKQ5sQgC
jiLlfuenjCHEuUHRjKwvcSqJ3lD4oup23tI+qDh/6E61F3IRRh8sfB7IWRLNyycn
tJP6LTs6prbbRGoQe7aM8w36Y7OWigcKHaQnjRqP5iC0bcxty1/k0K6HztN8a7/H
FOaURDox60OPolG6YkvE9sY/rUoz92D0gdbpdS2yCxC/5z3ZPrtVStFQYh++9aIu
07ujnelBkr/oKKHm7VHevAM6IswtihzfT4eesISIJWaxq2F1X1QhZCZDe5OA4PjC
PQT16dCVrNqFFNG0AlG7D3wTwsajd7PaqBQqgh01cazCYgZBr6ZA94sZI8yAUjEl
gZW7L/Z1f+g7udsWZ3GkXDm1C3fsrXwyMsWb0HIWmctpKEpyPWCjZy3NQSNibIwR
fVc4z3OabmCKgJzxq5/6WpnB3qudp3wsN4bqGRqZGX8XAvPUqz4Y3BkEs9gEAAEG
A7YwqkNd/HPWTN5Q1RDBmzNSKY5qBAgoHDPWZWIJIHAW8Jbnw/IEa02SSlcixRaH
K0QGisfQSzHUgTG8UdObj3LSE4jCf/oEBUFPlBz79oIZ+FAE5SBAC8tdl0/Ka4t6
t1H2m7MLxYPcQGoL7kTt
=El0C
-----END PGP SIGNATURE-----

--Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
