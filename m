From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Fri, 30 Sep 2016 16:16:04 +0200
Message-ID: <20160930141603.mlo5v75oy72j64d5@earth>
References: <cover.1474634475.git.hns@goldelico.com>
 <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com>
 <20160923224726.GA4639@rob-hp-laptop>
 <20160924003133.htaaiphjrm7vy52t@earth>
 <E8C59C6C-23D4-4417-8A9E-3E9AE5D2D100@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzu4yvdwt2tjqcxr"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E8C59C6C-23D4-4417-8A9E-3E9AE5D2D100-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--jzu4yvdwt2tjqcxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 24, 2016 at 07:55:27AM +0200, H. Nikolaus Schaller wrote:
> > So ti,max-[xy] is basically the same as touchscreen-size-[xy],
>=20
> No it is not the same and should be kept separate.
>=20
> > except, that the generic bindings don't support min-[xy] !=3D 0.
>=20
> What would be the purpose of this? Every user-space I know
> about (X11, Replicant) expects coordinates in some range
> 0..max so setting min in device tree makes no sense to me.
>=20
> >=20
> > So maybe change the generic bindings like this:
> >=20
> > touchscreen-min-x: minimum value reported by X axis ADC (default 0)
> > touchscreen-max-x: maximum value reported by Y axis ADC
> > touchscreen-min-y: minimum value reported by Y axis ADC (default 0)
> > touchscreen-max-y: maximum value reported by Y axis ADC
> > touchscreen-size-x: deprecated alias for touchscreen-max-x
> > touchscreen-size-y: deprecated alias for touchscreen-max-y
> >=20
>=20
> Initially I had thought about this but it does not solve the problems
> with touch pre-calibration. Since it mixes raw coordinates with
> system coordinates.

touchscreen-size-x was actually refering to your definition of
touchscreen-max-x and not system coordinates. For that it would
make much more sense to use a phandle to the screen IMHO.

> To achieve the goal of having a roughly precalibrated touch which
> should provide (0,0) at the lower left corner and
> (touchscreen-size-x,touchscreen-size-y) in pixel coordinates of
> the panel. Hence it roughly works without a calibration matrix in
> user space (e.g. xorg.conf or Replicant).

well I did not mean to use touchscreen-size-x/y for describing the
size of screen, as visible in n900.dts (first implementation of the
common binding), which sets the value to 4096.

> Why do we need pre-calibration? Because some systems might need
> touch interaction before they can offer (force) the user into
> a touch calibration step. We use these drivers and approach in
> our production kernels for GTA04, OpenPandora and Pyra for a while
> and nobody was even missing a user-space calibration tool any more.

I have nothing against the feature. OTOH I'm quite in of kernel
based TS calibration. Note, that you can only add it for hardware
without pre-existing touchscreen support, since you break peoples
systems otherwise (We have that problem for N900).

> The underlaying problem is that you can have the same controller chip
> in different board designs and there are different touch panel types.
> Each one has certain physical properties but they can differ.
> But you certainly want touchscreen-size-x/y to be a constant.
>
> Now if we make touchscreen-max-x/y the same as touchscreen-size-x/y
> and change the panel, we have to adjust user space transformation
> each time we change the panel. This does not seem to be right
> and can be done better by keeping them separately.
>
> This is what this approach does: the roughly correct scaling of
> raw values to pixel values.
>=20
> ti,min-x   ->   0
> ...
> x          ->   some value between 0 and touchscreen-size-x
>                 calculated by
> 			touchscreen-size-x * (x - min-x) / (max-x - min-x)
> ...
> ti,max-x   ->   touchscreen-size-x
>=20
> Hence the ti,min/max values describe the range of expected input
> values from the ADC and the touchscreen-size-x describes the touch
> in LCD pixels passed as input events.

so basically you use touchscreen-size-x to describe the screen and
not the touchscreen. When I added it, I did mean the max ADC value.
Actually I was under the impression, that X drivers would scale this
to screen size automatically. Since all my touchscreen HW required
calibration I did never test this, though.

> Example:
>=20
> ti,min-x =3D 64
> ti,max-x =3D 4016
> touchscreen-size-x =3D 480
>=20
> If we change the panel type which presents a slightly different ADC range:
>=20
> ti,min-x =3D 100
> ti,max-x =3D 3900
> touchscreen-size-x =3D 480
>=20
> and we still get a coordinate range (0 .. 480).
>=20
> Note that this feature can be effectively disabled if ti,min-x=3D0 and
> ti,max-x=3D4095 and touchscreen-size-x=3D4095, i.e. reports the full
> range of ADC values because then it multiplies by 1.
>=20
> Our proposed driver does use these values if they are missing from DT
> and therefore it should not break old DT files which expect raw values
> to be reported.
>=20
> I hope this clarifies what we need to achieve and you can
> agree.

I did understand what you want, but I disagreed about
using touchscreen-size-x/y for system coordinates. I
now see, that it's too late for that, as other people
already did so.

I do agree with Rob, that the ti,min/max-x/y should become common,
though. Also I would do s/minimum value/minimum raw value/g.
Additionally touchscreen-size-x/y should mention, that it's used to
scale the raw values.

-- Sebastian

--jzu4yvdwt2tjqcxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7nOhAAoJENju1/PIO/qavicP/0UDpqwloBnqpUudwUfl5J12
DArzKiw9tB7HAlMvZ41PBB6vTrNYNxFj+Sv+9cWN8PKMhna3OGRcZSMkp86CJVlI
EHatoEH0805Q3qUeVFjtkG91TtLnXU4naGD6Wx7ykM+TkVNKIcN7TOKtXKZQndSp
TOupDYjXtWzN82gzranemAud3Th0NcpsxEASth51uMkEwzCcCNfqFDPY+434qcyZ
SeYou65HcOXGwa/zSHdmTJidXWpKkoDkHN0UrKAfIH2fm3wQWGlt1k8makZpSraZ
ynLmsdMrNorizx32XWAo31BstqYnuQ8hnBfW3+rN7zpcK78w0OAEFuj1w1p0GlRd
A5+1wfjl56YqMnIACuKA8YTg7sJ0AZAY4cgwTcWWszDm5e237MwjVrqESvOU26nG
SO+aRp5+03+y/RP4a8AE7PuNqKLGPgyMFoTnt3VBxqROFg3ODsqFwsOC4VU1SmwJ
jSDFbenLQnEHGHqWY1EMX9MEEYd22xlz0gph1D0ubhUtAZB3NLQvYcw3wLCOnNLR
bBQx0B8GUe0u5qzdzzW6Io5WjFZSLvWP8c1SzJZG6q6XRtJ4e72hOS7Kbt3Yt1AH
z7aUcwZYA0sSS/c5dqRCK8GxSbkWFmLEFhezI4HBNtwxkLM6LG34foBfPAZ0gOIT
Tc2HIQRJ27CbutbHs7VZ
=Cz04
-----END PGP SIGNATURE-----

--jzu4yvdwt2tjqcxr--
