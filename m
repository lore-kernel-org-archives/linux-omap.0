From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Fri, 3 Mar 2017 12:17:03 +0100
Message-ID: <20170303111703.jxl3prdisencuddu@earth>
References: <20170302010900.28532-1-sre@kernel.org>
 <20170302013707.GK20572@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tieslaqwnab6kga4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170302013707.GK20572-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--tieslaqwnab6kga4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 01, 2017 at 05:37:08PM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170301 17:10]:
> > Hi,
> >=20
> > Tony, since your omap4-droid4 dts patches were not
> > yet in a public repository and they would merge conflict
> > with my patches I put them all together into a single
> > patchset. I also added my Tested-By to your patches.
>=20
> OK
>=20
> > The mounting-matrix for the sensors and the touchscreen's=20
> > rotation assume, that the phone's default rotation is vertical.
> > I think that's sensible, because
> >=20
> >  * Android on the phone uses this as default rotation
> >    (like almost? all other phones)
> >  * volume buttons make sense (in horizontal position one
> >    would expect, that left button means lower volume. I
> >    know at least Maemo swaps them)
> >=20
> > That should cover all mainline drivers.
>=20
> Heheheh cool looks like you configured compass and accelerometer :)

Easy targets with driver already available :)

One of them actually does not forward the mount rotation matrix
to sysfs/userspace at the moment due to missing driver support,
but the binding is generic.

> I have a better touchscreen patch that also configures the wakeirq
> that I did not post yet at http://muru.com/linux/d4/patches/ in the
> updated set droid4-wip-next-20170217.tar.gz.

It's part of the LCD patch, so I missed it.

> I have few more interesting ones coming, I got the HDMI working
> reliably over the weekend. I was planning on waiting until -rc1 to
> post them but let's see if I can send few patches out before that.

Thanks for the reminder, that I still have to buy an adapter from
=B5HDMI to HDMI.

> I was planning on waiting until -rc1 to post them but let's see if
> I can send few patches out before that.
>=20
> Anyways, I'll post a better touchscreen patch then let's apply these
> into omap-for-v4.12/dt-droid4 branch when -rc1 is tagged.

Sure.

-- Sebastian

--tieslaqwnab6kga4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli5UKwACgkQ2O7X88g7
+poGahAAlYhFKDSIqKdkcW3ViIw5NrnS2uS7FXzk6ykje9eW5/RhjDY1KlkrMEdt
Mn54HN6Hl2tgZS/ncFaQfNvVl5wFxTKAwIsiv50Tbn/1cLPFkfnpQIou/K+Gmbet
a4MZCtUsrWHCqb5gwd2kM1gj5E7T3J0F1SxK/KSXPim70voKADFwwEYbBBKt70Xr
XF5tALl9Lr02uNf1aCkdNyAlebCVi/xM/7BUS45eiQ0GawnFE6EAHDQZe9UdCh16
wEyAzzhgMc4m2F/YpfwoE7ImauaN8dZKV0ojkIpRe37XYL1Gmrryr8S1nMAYUz7n
+k+UlMY9fa8cW651obtKpVBtdNotdyRDap2n3mM9TUfZNb0r75XvRUWmlXtckPUJ
+gkZSwC/lWGXaFvHN7tFbPDeq6K0hjiinw+i8/k1DrIYhtsoDW+6lQwc6NleeIyb
5Uf8DJw38Xqc1R7IfVEd6jCjgM6hmMdolRY8K0syrvlbhitKiYeSmx1WqRUqevXh
z1r7qiynK+Qvl0duIzkryeEsXHAe9f/XsuaceYFLBaetbInWyy5SRW8yaS3GN1QN
yplb7ZbCcCTjZltVFuE8pSLG79D81YZfe2hRFWKM4XncFXPwpGRwxAiefNLSlf40
EJ0QeXLJ8uZVDf6NazhmZMJFrsp3AQLkq3mMlCfMglpdgEMaDtE=
=DjMY
-----END PGP SIGNATURE-----

--tieslaqwnab6kga4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
