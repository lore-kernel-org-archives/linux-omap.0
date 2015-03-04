From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 1/4] usb: phy: twl4030: make runtime pm more reliable.
Date: Wed, 4 Mar 2015 17:24:59 +1100
Message-ID: <20150304172459.19e24d23@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
	<20150224034036.31400.6133.stgit@notabene.brown>
	<20150302210359.GG13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/mUcCP8GG4yjdbEUmeUJ3_k."; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302210359.GG13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/mUcCP8GG4yjdbEUmeUJ3_k.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:03:59 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > +		status_changed =3D
> > +			(twl->linkstat =3D=3D OMAP_MUSB_VBUS_VALID ||
> > +			 twl->linkstat =3D=3D OMAP_MUSB_ID_GROUND)
> > +			!=3D
> > +			(status =3D=3D OMAP_MUSB_VBUS_VALID ||
> > +			 status =3D=3D OMAP_MUSB_ID_GROUND);
> >  		twl->linkstat =3D status;
> ...
> > @@ -768,6 +770,10 @@ static int twl4030_usb_remove(struct platform_devi=
ce *pdev)
> > =20
> >  	/* disable complete OTG block */
> >  	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
> > +
> > +	if (twl->linkstat =3D=3D OMAP_MUSB_VBUS_VALID ||
> > +	    twl->linkstat =3D=3D OMAP_MUSB_ID_GROUND)
> > +		pm_runtime_put_noidle(twl->dev);
> >  	pm_runtime_mark_last_busy(twl->dev);
>=20
> inline function returning (x =3D=3D OMAP_MUSB_VBUS_VALID || x =3D=3D
> OMAP_MUSB_ID_GROUND) would really help readability here.
>=20
> Thanks,
> 									Pavel

Good idea.  I've done that.  The function is called "cable_present()".

Thanks,
NeilBrown

--Sig_/mUcCP8GG4yjdbEUmeUJ3_k.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPalOznsnt1WYoG5AQKDQA/8DJe6fB5FYfieUosKtmWGyyjPwd+pZFKS
VzHVG8HBdGig1sOGEnPiPw23d6XKmjKtGCe9f0Jxh8CZ5LqbIDsN1EIuBGTfpQDT
It9PO09vY88dhP57r/eKi9SKPIVVyhSX9F7sXBnOcJ8qGwSmR537jAuA+8u+zkGY
ibXYyDVPdPfvTD87G74+uRRCzFvyt4DnGzYET18oiCcH9StezUFgyfA8+pjAOsVQ
gYXG7lBob25N1/KKYogKu7aWgDStP3YjmC7vM707cON/7aFmqy6HUpSKt6Ta7SHx
BEDxNGUmS/j7JOfA/VMJ2+jKhlefRZAnpwagaytvv9Y53FFOwmwJM0HNJ8q5jMnu
//GGdwbeFUaz3MkKm2RLU/7eyjfl5FRWPy6RVfD3JLOK2hfJXr1eCLx848x5yz+Q
8SS9FevHUxfHTjOfZp7Eu9W8BL/vLB2chaH9Oxsm8eQyXbHfXhYzRlBfPZW3fQhG
XnyxvgMm3pfctorMLbr7YuThs3iePfeddXe4DFClrzHFTauqzhu2cBfs7HSLcGjj
pAvQhbGHMev9sOnhe7QYVy8P90yyllFIMFYhSdDGhWJxrDTTwIHWCwIMixjiMx0r
kzrl7d/HDLY49C/mIsSRgJXXgRSUClBwOL+eLn2cg73RnAPtrLMKNOGDreYbYcV1
NxWGzsOqJ7s=
=upEl
-----END PGP SIGNATURE-----

--Sig_/mUcCP8GG4yjdbEUmeUJ3_k.--
