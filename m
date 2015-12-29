From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Tue, 29 Dec 2015 22:26:52 +0100
Message-ID: <1451424412.13576.1.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151229200244.GA27426@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-c2y3ko9iV8GkKy3BFzyQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151229200244.GA27426@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-c2y3ko9iV8GkKy3BFzyQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 29 d=C3=A9cembre 2015 =C3=A0 14:02 -0600, Rob Herring a =C3=A9crit=
 :
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> > LP872x regulators are made active via the EN pin, which might be hooked=
 to a
> > GPIO. This adds support for driving the GPIO high when the driver is in=
 use.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> > ---
> >  .../devicetree/bindings/regulator/lp872x.txt       |  1 +
> >  drivers/regulator/lp872x.c                         | 33 ++++++++++++++=
++++++--
> >  include/linux/regulator/lp872x.h                   |  2 ++
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/D=
ocumentation/devicetree/bindings/regulator/lp872x.txt
> > index 7818318..0559c25 100644
> > --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
> > +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
> > @@ -28,6 +28,7 @@ Optional properties:
> >    - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872x=
 devices.
> >    - ti,dvs-vsel: DVS selector. 0 =3D SEL_V1, 1 =3D SEL_V2.
> >    - ti,dvs-state: initial DVS pin state. 0 =3D DVS_LOW, 1 =3D DVS_HIGH=
.
> > +  - ti,enable-gpio: GPIO specifier for EN pin control of LP872x device=
s.
>=20
> Should be "-gpios" instead of "-gpio".

Care to comment why? There is only one GPIO that can be used here, since
there is only one single EN pin. I thought this matched what is done
already with "ti,dvs-gpio".

Thanks!

--=-c2y3ko9iV8GkKy3BFzyQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWgvqdAAoJEIT9weqP7pUM3JYP/j9fL2343VadGIjSfwUndG77
/9X4X//o/pHD9d7mWRIb2eLWC4ZOPwgy2ne3v10nvbInmOPVYvaiJvg+Pjxy0vL8
tB8wXIFczWCWoj/ZjIEWy0rjPoElh1R4Yq0orvlDoHzMA4nY8HrsXnhQDk5OBgqX
0+SuzLEpM+uU1du4vavK1+77qzIAd3ZPXWjvp6HYgdlYO6BhtbNhfmf8H2HVicY+
41pZSJTTVq5GM9AkpzgJZroVB9cAnNMF/wgt3r3G5/SM9i22+URYMDrDK1FpJtRo
Vyvx5ni/YWRpEaaX403P4PRhIFC7m1/LOKVU5xdJMm7pvUfTV7DnHZhqvtkdod9Y
fMEssQS7hZUCj5AbXYggsrDZ9HC2ifG/Ge3kmJVsQWzdcgVBRJy3PuWKpvc6CSTk
uK/8H3jPV8lUkVukiCTH5g8C1MaErfySLm728HbudjsfAeMFohs2ze0KUDWGFoWn
lwYZmhDQjOtE3mwx5K9pZHl0AdSbPbS9n1xfqT9tP8Dt58qwvmqbTAApJplybu1W
dX5SPckamgxk8bSZUvNuq88AGZG75zIwSBb6j5+vbjiclMtqi3bU2ib1xLOmUKSH
wK1mQE8waTciN7piwL6fbqXz+mz0iP98QLtPPmxbYuiCPsQja+f5UcZZ4Zgt/BTv
k6Bs85eoZGBlh3yqX5Yd
=N7IK
-----END PGP SIGNATURE-----

--=-c2y3ko9iV8GkKy3BFzyQ--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
