From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH] arm: dts: gta04: add gps support
Date: Wed, 30 Jan 2019 21:11:38 +0100
Message-ID: <20190130210956.6c37f065@aktux>
References: <20190125194310.11170-1-andreas@kemnade.info>
        <20190128075356.GJ3691@localhost>
        <20190128163025.7daa385b@kemnade.info>
        <20190130090232.GL3691@localhost>
        <89AF1666-1770-4C1C-A5E8-13E1C8D50EFA@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Y8ZmlrrCp1TwY3i93pZpIoJ"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89AF1666-1770-4C1C-A5E8-13E1C8D50EFA@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Johan Hovold <johan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/Y8ZmlrrCp1TwY3i93pZpIoJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jan 2019 15:06:12 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Andreas,
>=20
> > Am 30.01.2019 um 10:02 schrieb Johan Hovold <johan@kernel.org>:
> >=20
> > On Mon, Jan 28, 2019 at 05:44:29PM +0100, Andreas Kemnade wrote: =20
> >> On Mon, 28 Jan 2019 08:53:56 +0100
> >> Johan Hovold <johan@kernel.org> wrote:
> >>  =20
> >>> On Fri, Jan 25, 2019 at 08:43:10PM +0100, Andreas Kemnade wrote: =20
> >>>> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> >>>> which one is mounted so use the compatibility entry for w2sg0004
> >>>> for all which will work for both.
> >>>>=20
> >>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>>> ---
> >>>> w2sg0004 bindings (together with the corresponding support is in
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next)
> >>>> arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
> >>>> 1 file changed, 13 insertions(+) =20
> >  =20
> >>>> +	gps: gps {   =20
> >>>=20
> >>> The node should be named "gnss" as per the binding.
> >>>  =20
> >>>> +		compatible =3D "wi2wi,w2sg0004";
> >>>> +		pinctrl-names =3D "default";
> >>>> +		pinctrl-0 =3D <&gps_pins>;
> >>>> +		sirf,onoff-gpios =3D <&gpio5 17 GPIO_ACTIVE_HIGH>;
> >>>> +		lna-supply =3D <&vsim>;   =20
> >>>=20
> >>> Also, the vcc-supply is a required property.
> >>>  =20
> >> well, it is not require in the driver and it has different behavior
> >> (on even when not opened if on-off is there) than the lna-supply used
> >> here. So maybe fix the binding documentation? =20
> >=20
> > The device-tree describes hardware, and how a particular driver happens
> > to implement a binding is not relevant.
> >=20
> > That said, there is a bit of an on-going, shall we say philosophical,
> > debate about this. The regulator maintainer takes a firm position that
> > all mandatory physical supplies should be represented in firmware
> > =09
> > 	https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
> > 	https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u
> >=20
> > while Rob appears to take a slightly different stance on fixed
> > regulators while admitting that this an issue which has not yet been
> > fully resolved:
> >=20
> > 	https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-la=
ptop/T/#u
> >=20
> > Since this is a new binding, and the hardware requires the vcc supply
> > and this is reflected in the binding, I think you should add a fixed
> > regulator. At least until you hear otherwise. ;) =20
>=20
> Assuming that there is no REGEN signal from the twl4030 unless 1V8 is also
> stable, I'd suggest as a simple solution:
>=20
> 	 vcc-supply =3D <&vio>;
>=20
> Alternatively, we could define a dedicated fixed-regulator in omap3-gta04=
.dtsi
> for the 3V3 rail. Which is always-on. This would allow to describe that e=
.g. the
> itg3200, panel and other chips and sensors are also supplied by this. But=
 since
> no driver can really make use of it (turn on/off on demand) this is IMHO =
quite
> needless.
>=20
well, probably better to add that regulator, so we match the real
hardware and not doing some fake here just to satisfy that binding
requirement. I will send a new version with that regulator added.

Regards,
Andreas

--Sig_/Y8ZmlrrCp1TwY3i93pZpIoJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxSBPoACgkQfb1qx03i
kyTxVRAAgOttZuD4GQeCR8cVqaLegzKkKOeWrEbuXmO0i/YAy2APgSxxlpLMvwKG
pWVJqbazCU7woj706efgM89R2qeHhe5xsAL5oWpZMnpUgm0S+ayoEvxCB5rXJ1Kd
nMaOTHMhy0GMPnzpk+5WErlyjNwZyLm/dDf+mStDWEt/zmErFncKr6Xp8MKnQ17p
bFeFNUOU/Ij0OdKxURo/F2niHu+f1gB12Vk7EIcw/LI3V3teH0EJTCGjK8LkwEpp
T2tr2Jhfu7iuShLrTaRmGvXh8CWUZHY+bQX2KKTDehQ1HQa5Gh434CQZMUsYEtUN
zXy81a/3YE315B2lfpOta7a0geghAopzmT0kk0avBQijJTcAR3HyFmUwA0O79mSw
kie0o8dHHiR2wN4nDha/1jIeEtxsJulw1O3DNkKVfMPiENg4qKkOcJEb0kK35qL2
fac4Ej71TiMQ/tV1FpbAaohqm3oodLK7fgLctDy9O7zsXOXlqC35kk55WrqcuCJ8
kELRe2bgLaBTkq8NlfbMQO9f+p1/ltPYiKXRzwBnzeXdP8kaN99S96od6+DYfepF
VlN24c3PDQUlZXyB/B5p21NwSuxblKMOlIP6GhXDw2LKbucJEUdMdEnvIBf63xX3
gCogTT7noWcHbQckp9zyX8wFSrjVV0b8AvAToM7QYq56ub3SVaw=
=T8w6
-----END PGP SIGNATURE-----

--Sig_/Y8ZmlrrCp1TwY3i93pZpIoJ--
