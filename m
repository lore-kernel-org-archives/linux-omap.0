From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/6] phy: twl4030-usb: add support for reading resistor
 on ID pin.
Date: Sun, 7 Jun 2015 22:45:40 -0500
Message-ID: <20150608034540.GB6129@saruman.tx.rr.com>
References: <20150416075945.23307.24424.stgit@notabene.brown>
 <20150416080304.23307.41913.stgit@notabene.brown>
 <556C5FF4.3050603@ti.com>
 <20150602073731.26edbd3b@notabene.brown>
 <20150606131009.GD1329@xo-6d-61-c0.localdomain>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150606131009.GD1329@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: NeilBrown <neilb@suse.de>, Kishon Vijay Abraham I <kishon@ti.com>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2015 at 03:10:09PM +0200, Pavel Machek wrote:
> On Tue 2015-06-02 07:37:31, NeilBrown wrote:
> > On Mon, 1 Jun 2015 19:06:52 +0530 Kishon Vijay Abraham I <kishon@ti.com>
> > wrote:
> >=20
> > > Hi,
> > >=20
> > > On Thursday 16 April 2015 01:33 PM, NeilBrown wrote:
> > > > From: NeilBrown <neilb@suse.de>
> > > >
> > > > The twl4030 phy can measure, with low precision, the
> > > > resistance-to-ground of the ID pin.
> > > >
> > > > Add a function to read the value, and export the result
> > > > via sysfs.
> > >=20
> > > Little sceptical about adding new sysfs entries. Do you have a good r=
eason to=20
> > > add this?
> >=20
> > The hardware can report the value, so why not present it to user-space?
> >=20
> > I originally used this with a udev rule which would configure the maxim=
um
> > current based on the resistance measure - to work with the particular c=
harger
> > hardware I have.
> >=20
> > More recent patches try to do all of the max-current configuration in t=
he
> > kernel, so I could live without exporting the value via sysfs if that i=
s a
> > show-stopper.
> >=20
> > I can't see where the scepticism comes from though.  It is a well defin=
ed
> > and cleary documented feature of the hardware.  Why not expose it?
>=20
> sysfs interface is supposed to work for different chargers, without users=
pace
> noticing.
>=20
> Are these values the ones that are likely to be useful there?

These values come from Battery Charger specification 1.1+, IIRC, so no
other values should show up unless documented in future BC revisions.

> > > > +	Possible values are:
> > > > +		ground
> > > > +		102k
> > > > +		200k
> > > > +		440k
> > > > +		floating
> > > > +		unknown
>=20
> ...or would it make more sense to export for example numerical ohms, as t=
hat's
> what are other chargers likely to provide?

How do you expose "floating" in Ohms ? UINT_MAX might be one way, but
that would have to be documented.

--=20
balbi

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVdQ/kAAoJEIaOsuA1yqREJScP/27qLOuShQJVwnr1zLDvC0Pb
Ckp5hRJ9/mecxkXMwjnE4UsOpmegmMPPEcWOU1ocJ1Ado/KEYmRUAaMgy2JAO+MP
iWSJWNZqcs/Rq5/O0c7dqFcnlsYWRhuOKoUPUlZuMbCU7jy6SCUGC6QPwHpgegHI
LkmaAWNOUKbd4UE9q8ax0RgV+32EyBYwi05NlIFJA97nBRdNVCfu9fqVwxSDlUg2
8ncBYlY78nfSH+y7WWnlZ8AzJgXu7wX1fNc6TTmVrdIvtNn1R0/cgsweLe8Du/xU
x4oVKHMbeSB4+8nTX964AXr+n8Y+G9nUdYnSnqugRfv5nCU2aXYnDpZXXuUuj0pr
97GGuuYwhAOLzsqwLH/wyz70aXY8chd0Yik6P+j9S559qNwvWF1Qe1FaS000Ihg+
zqs+wl12YIO3aF3G6iDytVQKz2SYnVLTGrPgdBln//XJfdHISMFChdjnoKyRqHE6
3D9bM9IZPp3G9ZmiVAo5NbObNIfGmAddamB4SFa8a8Qt75puFqb9eGtnV8uTycjo
/VxB7+oTPMK0NwD+Ukvxgg/pm2N1QUSguwpthps+/7agYnPlvqLkQXWr5JJy/pLT
LFGS6L9huCrz1aYPGSRVv6KvdDZbCsAGrXWEho9DG0EMPd7tz0piONjQkhHPVCDD
xBkUMM6nDTLVqBo6Tk01
=7Qs6
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
