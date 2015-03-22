From: NeilBrown <neilb@suse.de>
Subject: Re: [Gta04-owner] [PATCH 3/4] usb: phy: twl4030: add support for
 reading restore on ID pin.
Date: Sun, 22 Mar 2015 17:05:55 +1100
Message-ID: <20150322170555.5f97f2c2@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
	<20150224034037.31400.52748.stgit@notabene.brown>
	<20150302210431.GH13270@amd>
	<20150304173551.7cb93917@notabene.brown>
	<BF76BA84-5DD6-499D-8A00-E787C843BF7F@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/8p1kxH+4L9hvLDtUhxDxOFh"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BF76BA84-5DD6-499D-8A00-E787C843BF7F@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/8p1kxH+4L9hvLDtUhxDxOFh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2015 07:54:41 +0100 "Dr. H. Nikolaus Schaller"
<hns@goldelico.com> wrote:

>=20
> Am 04.03.2015 um 07:35 schrieb NeilBrown <neilb@suse.de>:
>=20
> > On Mon, 2 Mar 2015 22:04:31 +0100 Pavel Machek <pavel@ucw.cz> wrote:
> >=20
> >> Hi!
> >>=20
> >>> The twl4030 phy can measure, with low precision, the
> >>> resistance-to-ground of the ID pin.
> >>>=20
> >>> Add a function to read the value, and export the result
> >>> via sysfs.
> >>>=20
> >>> If the read fails, which it does sometimes, try again in 50msec.
> >>>=20
> >>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>> ---
> >>> drivers/phy/phy-twl4030-usb.c |   63 ++++++++++++++++++++++++++++++++=
+++++++++
> >>> 1 file changed, 63 insertions(+)
> >>>=20
> >>> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-=
usb.c
> >>> index 023fe150c7a1..759950898df9 100644
> >>> --- a/drivers/phy/phy-twl4030-usb.c
> >>> +++ b/drivers/phy/phy-twl4030-usb.c
> >>> @@ -374,6 +374,56 @@ static void twl4030_i2c_access(struct twl4030_us=
b *twl, int on)
> >>> 	}
> >>> }
> >>>=20
> >>> +enum twl4030_id_status {
> >>> +	TWL4030_GROUND,
> >>> +	TWL4030_102K,
> >>> +	TWL4030_200K,
> >>> +	TWL4030_440K,
> >>> +	TWL4030_FLOATING,
> >>> +	TWL4030_ID_UNKNOWN,
> >>> +};
> >>> +static char *twl4030_id_names[] =3D {
> >>> +	"ground",
> >>> +	"102k",
> >>> +	"200k",
> >>> +	"440k",
> >>=20
> >> New /sys files should be documented somewhere...?
> >=20
> > Preferably with the code...
> >=20
> >>=20
> >> Does it make sense to change "440k" -> "440KOhm"?
> >=20
> > Interesting question.  I prefer to avoid including units in files - bare
> > numbers is better.  But there is no number to match "floating" unless I=
 spell
> > it out as "infinity", and wouldn't be helpful.
> >=20
> > Certainly "K" would be preferred over "k=E2=80=9C,
>=20
> The international standard for kilo =3D 1000 is a lower case k.
> While it is (non-standard) to use K for 1024:
>=20
> http://en.wikipedia.org/wiki/Kilobyte
>=20
> So I would keep the string constants lower case to avoid this potential c=
onfusion.

Yes, I got that backwards, didn't I.

I think I'll leave it as lower-case.
I won't include the word "ohm" - it is very uncommon to have units explicit
in sysfs attribute values.

Thanks,
NeilBrown

--Sig_/8p1kxH+4L9hvLDtUhxDxOFh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVQ5bwznsnt1WYoG5AQIoZBAAmB4M5DAX6gDbnhv5GcXstF2LNFn+91lE
HieB0ztJvsxhq1uzPBL/TA5uBPe3K+rtiTsPT9EM67iw81+Uo+5pjc2w+0nJRJvg
0jPTR7RaRXyQWAK9XZA9/NSNTVrpwB1IAPP1tl0ehkHByKZkzpUokCeHipOqciJB
V66dCGJ1HEvSQizKH66bqwTabAdfwtGwY3tI/ZUNSpcY4Zq8Ft/Nu09dQfljx4y/
l7xtrnIKNs8YOjRj1AUltkmXdQU6yoNdhxdU5tpkv2IDFkr3uVdkbn1dic2PG8xY
EqjWTG7AQb0z9K1fTdwGliffHae9/mq66yZKvSAt3gpnay2YnCDL1cgLs9ap8FKT
v2Cni2sB8CJgX2tzYenr7A8haf3vlO/vwkBUFBPhyWeKlgxLH8q0ELuqqybVZwMH
41KKLkIJCzwG1xX2TbcQw51HyIDKSkxJKEvq6Onf1qwpuoeowMxlJhU57xSFBVs1
tsDmHBrcfZld57lp8sxPPxUOslqYtOS/bCPdo4hMn8hkrNumu9ZeXtA1oTPYVoTl
byd04IefYGRW9y4SAJeucAHUJmXPdT/nIVLqyQOG1gYWPnJ00e5H+NPbZoo19bHP
2j84aMUk9MF/5hsx8GN+3C4vBK/0A+0DrZBbjV6WwnGKseUyloNezIFnTpSJ1dz3
W9HxXJOSwMQ=
=ax10
-----END PGP SIGNATURE-----

--Sig_/8p1kxH+4L9hvLDtUhxDxOFh--
