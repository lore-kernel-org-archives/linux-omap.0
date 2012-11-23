From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
Date: Fri, 23 Nov 2012 12:18:11 +0100
Message-ID: <20121123111811.GA5072@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-6-git-send-email-avinashphilip@ti.com>
 <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
 <20121123105110.GA6884@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EEAAA@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9EEAAA@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 11:12:15AM +0000, Philip, Avinash wrote:
> On Fri, Nov 23, 2012 at 16:21:10, Thierry Reding wrote:
> > On Fri, Nov 23, 2012 at 10:34:02AM +0000, Philip, Avinash wrote:
> > > On Fri, Nov 23, 2012 at 02:29:44, Thierry Reding wrote:
> > > > On Wed, Nov 21, 2012 at 06:41:02PM +0530, Philip, Avinash wrote:
> > > > [...]
> > > > > +	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
> > > > > +	if (IS_ERR(pinctrl))
> > > > > +		dev_warn(&pdev->dev, "failed to configure pins from driver\n");
> > > >=20
> > > > I think we already discussed this, but shouldn't this be a fatal er=
ror?
> > >=20
> > > I had checked relevant discussion and found this can be warning messa=
ge.
> > > This is because most boards don't have pinctrl implemented at this po=
int,
> > > or may never have.
> > >=20
> > > https://lkml.org/lkml/2012/9/11/369
> > >=20
> > > Any way I will change to
> > > dev_warn(&pdev->dev, "unable to select pin group\n");
> > > as in other drivers.
> >=20
> > But in case pinctrl isn't implemented, shouldn't the implementation of
> > devm_pinctrl_get_select_default() just be a no-op?
>=20
> So driver can still exist but pin mux functionality missing. Then warning
> message will give hints.
> I am also ok with error message & failure of driver with EPROBE_DEFER,
> if you want?

Everybody seems to be doing it with a warning, so I guess that's fine
for now. I just find it strange that if you request the default pin
group to be selected when in fact the hardware doesn't support pinctrl
at all you shouldn't be getting an error either.

I'm adding LinusW on Cc, perhaps he can shed some light on it.

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQr1tzAAoJEN0jrNd/PrOh16UQAL57I3RPifYmJWDOvZINQB/p
HUqkcHPMUtPdbdu4i83XohvOcp056elhTA1jYPaCJwNDg8u5kqR4tH0b9Tg+YSXc
icPDao6lu9JJhaap32F5JA8saFgcIQoaSZyUdeUCnpBfKBtufcrix0vF1zZ/Bfs+
HM9Kex3wuAoC2S6bNtiT6e831PcBBtoTmUug0BLcWEEecUulWLGY5ej4RexMfi/3
R9L1YDSYRnpuYvsClBgPMK2v1ptXcOqDX/WsIioOvduLh3T3G5XL2OL/nH6hC8cj
vP3LAsEJZbj8FEy26pMb1Q0qJ9bPes2OC7mm1YNluOY6unHEKP8JlGZVTHLSR51y
LSP+0Fj3Ivr5uur7tnTUFmRsmn3TDBJAuwFvCaQfLbLP2LxI1snLyXDUyQC95txK
0m8UYSCG2xrlLdu2bVI0uP/KooLCudhvPfMjzq8WcoExoe5FI6L9QIvl3Z6MNVh0
fTZMti1I5bmWKT8GR+o1OPSaHAkLF+EKwgYsL/3KD7p2Tt/TLJyRs4xK5VbLWTC9
jWxPQSM7nPOAsh6ynKfoksK3gb9odQrzkC/J4Vn72rzUxNKj+0cBXq5InekSMboM
xCDFj9feVmLP+/LRwAyYbW43lDMSSCf6do4Tz5ZTrO6Xiz+yGnxkCZCITj7cm2vH
ZVx03+bwB4r3dMItfKxR
=1NHj
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
