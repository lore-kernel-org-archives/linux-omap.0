From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
Date: Tue, 13 Oct 2015 01:53:43 +0200
Message-ID: <20151012235343.GA7755@earth>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
 <1443212447-5841-3-git-send-email-marek@goldelico.com>
 <20150926172936.GD22315@earth>
 <CAAfyv36nZ3c-yw7QQHwBWk3GwY31rV3Uq2n0dz5hppn5JFhEcA@mail.gmail.com>
 <20151012213827.GC23801@atomide.com>
 <20151012222009.GH23801@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151012222009.GH23801@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Neil Brown <neilb@suse.de>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 12, 2015 at 03:20:10PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151012 14:43]:
> > * Belisko Marek <marek.belisko@gmail.com> [150926 13:02]:
> > > Tony sorry I forgot to add you to the recipients for this patchset.
> > > Can you please queue this patch. Many thanks.
> >=20
> > OK applying into omap-for-v4.4/dt thanks.
>=20
> Actually dropping this one, it makes build fail as we don't
> have twl4030_madc yet.
>=20
> Maybe please send a separate set of dts patches for me.

mh that's strange, twl4030-madc is there since a long time. But
checking the patch, it seems Marek got the phandle wrong:

$ grep -B1 "ti,twl4030-madc" arch/arm/boot/dts/twl4030.dtsi
	twl_madc: madc {
		compatible =3D "ti,twl4030-madc";

Once that is fixed, the patch should have no dependencies.

-- Sebastian

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWHEf/AAoJENju1/PIO/qaj6MQAJaqWfUiWCix7/p30B+WT6Qk
q5fFzmut5dtOlRi5nwnzeBvxf5bXe1ovT6AvH+wHlHYxlnjzN01cmD1UTNjN6zY6
jZK28/zUejqDn8gIx+G/2zr7Bvxsk5soVdgV38ItRO4LrYUdhqQjIAJ34YV4QfpV
lzISa0IuohzQZmPGz7rTYASzz2Cfak/2ybFrlJCXUIxWp8a7U8ZTBXfH1EPKsqTB
Zfs1wh5phZvTL/bpcGupqJIM85IwT00fhkt0KrI3G5qNCfqvoOwjF65kgzQ5xlca
jzYdT/oAAIu73dLyOgmS2F12a4EmnAuLV+T1R8xsuv40A2k2e+HGiotpcN0xdUEl
L7IvJtkKzxXs/xpealulZdLfRSf3OXG11HFI32rsRPocSUjOGAjfeEmbrA860S8k
BRTI7EVc1Y9C4260mNLIdPvkn8xfygIE07mPDSN6nL5a3A/0pNFX7ZuXGgt7Yr31
bJYl8chxnAfiOeKmvTmKue7eqoxTmD5BqV9B11yB9hhR1mqUKu9xKOMEhf9rIhJX
7yq3tOSDD7XV+FyfGDbOZEAJ5NQfITHyuf5zK9blqQ1dt7VhCXGa9xyiiPkzjD02
R5Xu7vw2M5dQJIvR63XS5BSyVdIWpyxDFl3qhd2oovhZfbAU4AXHtLsX+bZW6ElU
7utfcgyqRd4aGtx7yVSi
=uS/w
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
