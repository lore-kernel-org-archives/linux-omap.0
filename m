From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Fri, 05 Feb 2016 19:48:53 +0100
Message-ID: <1454698133.2623.4.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151229200244.GA27426@rob-hp-laptop> <1451424412.13576.1.camel@collins>
	 <CAL_JsqLiuNR_MQ+eX_TQVMDtn85hUTweNRL2Q+7Z8Tq-HJhx2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-GpDPiNqqG5268MV+irpZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLiuNR_MQ+eX_TQVMDtn85hUTweNRL2Q+7Z8Tq-HJhx2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--=-GpDPiNqqG5268MV+irpZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 29 d=C3=A9cembre 2015 =C3=A0 15:55 -0600, Rob Herring a =C3=A9crit=
 :
> On Tue, Dec 29, 2015 at 3:26 PM, Paul Kocialkowski <contact@paulk.fr> wro=
te:
> > Le mardi 29 d=C3=A9cembre 2015 =C3=A0 14:02 -0600, Rob Herring a =C3=A9=
crit :
> >> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> >> > LP872x regulators are made active via the EN pin, which might be hoo=
ked to a
> >> > GPIO. This adds support for driving the GPIO high when the driver is=
 in use.
> >> >
> >> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> >> > ---
> >> >  .../devicetree/bindings/regulator/lp872x.txt       |  1 +
> >> >  drivers/regulator/lp872x.c                         | 33 +++++++++++=
+++++++++--
> >> >  include/linux/regulator/lp872x.h                   |  2 ++
> >> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt =
b/Documentation/devicetree/bindings/regulator/lp872x.txt
> >> > index 7818318..0559c25 100644
> >> > --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
> >> > +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
> >> > @@ -28,6 +28,7 @@ Optional properties:
> >> >    - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP8=
72x devices.
> >> >    - ti,dvs-vsel: DVS selector. 0 =3D SEL_V1, 1 =3D SEL_V2.
> >> >    - ti,dvs-state: initial DVS pin state. 0 =3D DVS_LOW, 1 =3D DVS_H=
IGH.
> >> > +  - ti,enable-gpio: GPIO specifier for EN pin control of LP872x dev=
ices.
> >>
> >> Should be "-gpios" instead of "-gpio".

Thanks for the review Rob, I have just submitted v2 with those
suggestions integrated.

> > Care to comment why? There is only one GPIO that can be used here, sinc=
e
> > there is only one single EN pin. I thought this matched what is done
> > already with "ti,dvs-gpio".
>=20
> To be consistent. We use "clocks" and "interrupts" always whether one
> or more for example.
>=20
> -gpio is documented as deprecated now.
>=20
> Rob


--=-GpDPiNqqG5268MV+irpZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWtO6VAAoJEIT9weqP7pUMws4P/0lA85r/osKheboOMXhiPMBc
IfIsI3w+6dSkZQUjBffFxwLi3GTqIsePhMfuAt1GWQ+7epKNYlBAbTFQoUXr3Z8v
XhapphmicfEKAvs0NkQrP80+gPJik1ko8riU4Pq24xl0OqJ+iMEjzlJyRgRk+pSR
WR6wFTWHa/GpZloawLt+TJDrv8MgLngJ/1V+4ac7lo/36LynefCcw9hO8NRV4dUL
hBXR5bNYMBnjuhBrhxNZEkKhuhTnSZdI5S+9DpH5gH2DN6uHsjdClCZqeexH/U0Z
w/CXVnqwrNEiHrbMy0gRNPYqO0Z4vxqBJHzZoxE98r6taqLXmiOmhX0tUBpBlDHE
+2Yn1/dVZzF6DDU6FDHy26z2TE/47aY2Xu9RtFiR+MDFdZ6myASfRZc3T5DAw/ZB
D08gzHbAU75NWs6CmhzveZQDB08E/Opi1CK9erUIzJtJIXs48ot8yZgTLLFijyRh
hD7Q7jD4wGIGq6l9LaVj9bU88Nd1YGSsjZqyirhNVi4wl85Mo9cN1Od4Gd0RkeaX
s9ePDcmWXzWnk0oET23/0f6D78FY+wDp34hICknm5rMgDa0z0gVY1x/KElcTr8uv
vlGRtpZHtpNGudcOZdRhi3j3oJV7ZLfFSe7AYhl5fBRQkk74Kyl9bClICHAdoyKM
H0Bdb7YOxYx0h3jHkexB
=Xqzh
-----END PGP SIGNATURE-----

--=-GpDPiNqqG5268MV+irpZ--
