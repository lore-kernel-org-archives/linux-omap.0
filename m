From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 20:29:33 +0100
Message-ID: <20170220192933.GA23745@amd>
References: <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
 <20170219205708.GA9641@amd>
 <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com>
 <20170219221930.GA1568@amd>
 <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6610D852-4717-47A7-BFDE-52C8E9E614BB-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>Benjamin Tissoires <be>
List-Id: linux-omap@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As long as it is small (I expect <1.01 =3D 1% error in scale) it is
> barely noticeable.
>=20
> Therefore, I asked before: how big in pixels is your finger or stylus?
> Does this effect matter?

If I draw a line in gimp, I don't expect it to have steps because of
"barely noticeable" errors.

> A resistive touch is a man-machine-interface where people press buttons o=
f at
> least 12x12 pixels size (or they are no longer visually recognizable).

Resistive touch is used for drawing, too.
=20
> So the discussion boils down to "what gives the better usability?":
> a) getting rid of the nasty user-space calibration step (and plethora of =
different tools)
> b) getting highest theoretical precision which has a low practical releva=
nce
>=20
> I am in favor of a). Like most users we ask. A minority is in favor of b).
> Since we don't exclude b) users from reconfiguring their system to get it=
 done
> as they like. I think this is the best we can achieve.

Do you even read what I wrote?

Because I presented way to have both a) _and_ b).

> >>> No. You have to design interface such that they _can_ be improved, and
> >>> what you propose does not work that way.
> >>=20
> >> It works. Please do real world tests...
> >=20
> > You do a real world test on N900, and propose upgrade path.
>=20
> I have no N900 running. But since it uses a tsc2004/5 controller which se=
ems
> to be quite similar, you can likely copy&paste some code or add the algor=
ithm:
>=20
> ABS_X =3D (touchscreen-size-x * (adc_x - adc_min_x)) / (adc_max_x - adc_m=
in_x)
>=20
> Thats it.
>=20
> If you set touchscreen-size-x =3D (adc_max_x - adc_min_x) you get maximum=
 precision
> you can achieve with integer arithmetic. And if you set adc_min_x =3D 0 y=
our
> user-space gets what it would have got before adding such a formula and t=
hen you
> can and must do calibration there.
>=20
> Taking this as the defaults if none of the new properties is specified, m=
akes
> the scaling feature completely disappear. And I don't care about 2 additi=
onal
> subtractions, one multiplication and one division per axis.
>=20
> So the upgrade path is:
> 1. introduce new optional properties, parse and store them in the struct
> 2. set defaults for the optional properties as described above
> 3. add the formula to the code (1 line for each axis)
> 4. deploy - nobody will notice

Good so far.

> 5. update the DT and remove user-space calibration - people will be happy
>    that they do not have to calibrate first any more

You can't do this. And this is fatal problem with your proposal.

If I update the DT in the kernel, my users will be very unhappy,
because their screens will now be miscalibrated. New kernel must not
force users to update their userland at the same time.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlirQ50ACgkQMOfwapXb+vIxkgCbBxSCXYcHQU2dmf+rOXH1IXtb
qSEAn1/Mx6g3aCnFQoiupB5xJ/yrCLxP
=uePT
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
