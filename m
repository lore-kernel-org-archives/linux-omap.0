From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 2/2] arm: dts: gta04: add gps support
Date: Fri, 1 Feb 2019 20:06:30 +0100
Message-ID: <20190201200630.2efc9eef@kemnade.info>
References: <20190131180640.14480-1-andreas@kemnade.info>
        <20190131180640.14480-3-andreas@kemnade.info>
        <20190201100416.GD3691@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/01NHARD8ceDsp1l45OdUP9y"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201100416.GD3691@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/01NHARD8ceDsp1l45OdUP9y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Feb 2019 11:04:16 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
> > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > which one is mounted so use the compatibility entry for w2sg0004
> > for all which will work for both.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v3:
> > - converted to a patchset
> > - added vcc-supply
> >=20
> > Changes in v2:
> > - some s/gps/gnss/
> > - not added vcc-supply because the regulator is not modelled
> >   in dts at all
> >=20
> > w2sg0004 bindings are in next-20190129
> >=20
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/oma=
p3-gta04.dtsi
> > index 02d8274a2f47..4ea0f7dc37c6 100644
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -320,6 +320,12 @@ =20
> >  		>; =20
> >         };
> > =20
> > +	gps_pins: pinmux_gps_pins { =20
>=20
> s/gps/gnss/ would be more consistent, but whatever.
>=20
well, gps is already in the file at another place. So it is a bit
inconsistent in any case, without further cleanup. If someone comes
up with a strong opinion here I would of course change it.

Regards,
Andreas

--Sig_/01NHARD8ceDsp1l45OdUP9y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxUmLYACgkQl4jFM1s/
ye+00xAAujwl4zZ01Q52FI7OapO7C6j5SXClBced5WldTb6FBxs6aS6ui9LdQp6Y
upieKwXd3WUwLqrfvw2EfEpeY6vDd6zIXbuQookzUJebIf2rN1DrLmQaXF8IVfmw
lFbybhZykmmGyqeS0S0008+PHlVDtBDXAJ/wR1EhwuUJYcDGrB7NWyRx5mzUy/YW
UXTZJmKE7Ce0si2zJW00NJ1rBo5c/HfNcLdnzxLpW2VyHzC8cVupFlPsa6lAX/DX
VsbtONc0gIVBgT8mcCnkT2f4InpJDBb1Y1ndCpaD2CA6VitbrWVfunshW5umlZne
7aTf1uckalGLMPtZg71CXBndFi8OtRYydeX9JF7nO9iL9cpEkFnE04yNgiDDWedv
IzYq+m94T4pXfCfB07A1gIFvMAec2nOuDbQ0VfLOOPPPSNatnyYV7vggfaurmGwI
M9tz5+mxd3pI7cSKMH/3Q7o/4vejEQ0iMi5/45g9ePOTb3Nddi7kerzMhcz8vqHz
sDzvg60pkFS3vlUqfE0+arSUuA0IwPvimb53DxMUUCLJpCbKoNIgNQLbnO4Y0WFd
x6RTDiTOvnYFquXpT+JioYYCxkHyFYsayngXn0e3d2VrdZmYhlXhYMjtOJikxvZA
7zpLyjlhEpLZRjzb+QlDggfDGU1HbRPuY8aeX+UDGoP8D3CgYGM=
=/2br
-----END PGP SIGNATURE-----

--Sig_/01NHARD8ceDsp1l45OdUP9y--
