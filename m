From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 3/4] usb: phy: twl4030: add support for reading restore
 on ID pin.
Date: Wed, 4 Mar 2015 17:35:51 +1100
Message-ID: <20150304173551.7cb93917@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
	<20150224034037.31400.52748.stgit@notabene.brown>
	<20150302210431.GH13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/gz7tSihQgc0nEG16jvrT3y+"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302210431.GH13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/gz7tSihQgc0nEG16jvrT3y+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:04:31 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > The twl4030 phy can measure, with low precision, the
> > resistance-to-ground of the ID pin.
> >=20
> > Add a function to read the value, and export the result
> > via sysfs.
> >=20
> > If the read fails, which it does sometimes, try again in 50msec.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  drivers/phy/phy-twl4030-usb.c |   63 +++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 63 insertions(+)
> >=20
> > diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-us=
b.c
> > index 023fe150c7a1..759950898df9 100644
> > --- a/drivers/phy/phy-twl4030-usb.c
> > +++ b/drivers/phy/phy-twl4030-usb.c
> > @@ -374,6 +374,56 @@ static void twl4030_i2c_access(struct twl4030_usb =
*twl, int on)
> >  	}
> >  }
> > =20
> > +enum twl4030_id_status {
> > +	TWL4030_GROUND,
> > +	TWL4030_102K,
> > +	TWL4030_200K,
> > +	TWL4030_440K,
> > +	TWL4030_FLOATING,
> > +	TWL4030_ID_UNKNOWN,
> > +};
> > +static char *twl4030_id_names[] =3D {
> > +	"ground",
> > +	"102k",
> > +	"200k",
> > +	"440k",
>=20
> New /sys files should be documented somewhere...?

Preferably with the code...

>=20
> Does it make sense to change "440k" -> "440KOhm"?

Interesting question.  I prefer to avoid including units in files - bare
numbers is better.  But there is no number to match "floating" unless I spe=
ll
it out as "infinity", and wouldn't be helpful.

Certainly "K" would be preferred over "k", and given that I have "ground"
and  "floating", it is more consistent to include the "Ohm"....

These are really names, not measures of resistance.  The data sheet calls
them:
 ID_RES_FLOAT  (or sometimes ID_FLOAT)
 ID_RES_440K
 ID_RES_200K
 ID_RES_102K
 ID_GND        (or sometimes ID_RES_GND)

So using those names is defensible.

I think I'll change them all to upper case, but leave out the "Ohm".
My justification is consistency with the data sheet.




>=20
> Plus I guess you need to update Documentation/

I guess I'll need to give in to this eventually :-)

>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20

Thanks,
NeilBrown

--Sig_/gz7tSihQgc0nEG16jvrT3y+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPanyDnsnt1WYoG5AQLhxA/9H7842axLSmJWLO1vQVyqTMZdyjQZS4Bi
EDsYCbBsIbEJ+Cg61xgtP9hivF1OSgHoOElhXjhR2GV51emfnGMuy4CkBNDbgjsm
zCndNk55MLNUd7Bwdj4+bTiNrz3qo/kn0fD2J4TDbUom/R3zWiPhFHbXhQG/xesE
N+ba7TDNClLPGtfHXX6GZ40gZ4K5DD+Rc2bNvugftoSQTagUxxbJZFgcwdFd/Ay8
4p9Q/mj2+jGeFm2cUJfSt4ti3gvZ73xhDA2X4+A92jlAGIZByvFAMKlFx97mAYAS
853DxGT+VwYJv6bPQc97TnXnrA6dpNGNjOb/Dy+jUVe1IHmFCzP1xO1vnUUOVYmv
Xpx8QVgmRX+w/1LWpceIqVpNVbe3IgQp7nUML3hqDoIztk+5uSUoMBGSL0nKwpIZ
vGDDteEvP/TMY7RPajInArKj3sRKtjg2YgviPAy/mWhJlalEchP5A5kHRH1Lx6Oh
O8oukrILjkp2b+jI0RTiIpVKty10bc9Ddbf8Pv199H0vPBKaPQXXfYrxTmefa8kS
drJUDabuRVZ6lS+GSTlIDdmDZ31Kk7ClFc6c9C2d2lp1xieQaGyKs8+UeVpj+Gct
i+9d3UPuNFGUsc7J0/v5I3AD2Txg7HN8ynldpiuLO/0F0UpHcEJYC47QqDerpLA0
GDrK3UxnADQ=
=6Vjq
-----END PGP SIGNATURE-----

--Sig_/gz7tSihQgc0nEG16jvrT3y+--
