From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Sun, 29 Nov 2015 19:19:18 +0100
Message-ID: <201511291919.18179@pali>
References: <20150713131902.GH26485@atomide.com> <alpine.LFD.2.20.1511281232440.22569@knanqh.ubzr> <20151129180939.GE30871@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1764706.CuXU1jnmuQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151129180939.GE30871@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

--nextPart1764706.CuXU1jnmuQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 29 November 2015 19:09:39 Russell King - ARM Linux wrote:
> On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> > Good. And Arnd likes the idea too. So we might be converging at
> > last which is a good thing.
>=20
> I disagree with the idea that there is convergence.  There might be
> convergence towards an idea, but... Here's a mail extract, from July
> 7th, from earlier in this very thread:
>=20
> Pali:
> > Me:
> > > Are the ATAGs at a fixed address on the N900?
> >=20
> > Yes, in board-rx51.c is:
> >=20
> > .atag_offset    =3D 0x100
> >=20
> > and Nokia Bootloader (proprietary) store them to that address.
> >=20
> > > Can that be handled in
> > > some kind of legacy file for the N900 which calls save_atags() on
> > > it, so we don't end up introducing yet more stuff that we have
> > > to maintain into the distant future?  If not, what about copying
> > > a known working atag structure into a legacy file for the N900?
> >=20
> > I already asked question if it is possible to read ATAGs from DT
> > booted kernel. And somebody (do not remember who) wrote to ML,
> > that it is not possible and it can be done in that uncompress
> > code.
>=20
> So you're converging on an idea that has already been rejected.=20
> That's not a good thing, IMHO.

Or in other case show that such implementation is possible...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1764706.CuXU1jnmuQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZbQaYACgkQi/DJPQPkQ1JX3wCgyPyTnnweVM+EU9OUYxHOZ6Zi
yucAmwRwDLztII6xd2ZtuIVK9Y3c2abG
=hOPN
-----END PGP SIGNATURE-----

--nextPart1764706.CuXU1jnmuQ--
