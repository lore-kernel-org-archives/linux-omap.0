From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Wed, 25 Nov 2015 22:44:28 +0100
Message-ID: <201511252244.28797@pali>
References: <20150713131902.GH26485@atomide.com> <20151125210310.GT2517@atomide.com> <3245119.krc4KB3uae@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1602315.3aKPk7AD5o";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3245119.krc4KB3uae@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart1602315.3aKPk7AD5o
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 November 2015 22:29:53 Arnd Bergmann wrote:
> On Wednesday 25 November 2015 13:03:10 Tony Lindgren wrote:
> > * Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [151125 11:50]:
> > > On Wednesday 25 November 2015 10:16:44 Tony Lindgren wrote:
> > > > At least I don't have better solutions in mind.
> > >=20
> > > I would be happier if we could restrict this as much as possible
> > > to the boards that need it, as an opt-in. That way it doesn't
> > > become an ABI for people that don't already rely in this
> > > information. How about adding a check the code adds the
> > > linux,atags property to do it only for a whitelist of board
> > > numbers?
> >=20
> > Or populate /proc/atags only for the ones that need it from machine
> > specific init_early?
>=20
> That would also address my main concern about /proc/atags, but still
> leave the atags in /proc/device-tree/chosen/linux,atags, and it would
> be bad if someone who currently uses /proc/atags changes their code
> to use the other file instead of finding a proper solution.
>=20
> 	Arnd

Arnd, my question about proper solution reminds... Proprietary=20
bootloader which cannot be replaced (e.g. it is signed or do unknown=20
magic) provides information to booted kernel via custom specific ATAGs=20
fields. How userspace could properly read those custom information from=20
bootloader?

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1602315.3aKPk7AD5o
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZWK7wACgkQi/DJPQPkQ1KDGACfbEg3+2P69BSWI3ZMloVuHtl7
0tQAnRWutvOg9ockxWsG/32s3Wm7P1Xg
=F6mX
-----END PGP SIGNATURE-----

--nextPart1602315.3aKPk7AD5o--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
