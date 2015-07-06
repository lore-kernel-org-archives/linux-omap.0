From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Mon, 6 Jul 2015 14:23:23 +0200
Message-ID: <201507061423.23505@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <20150506114417.GI30910@pali> <20150625050138.GL4156@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1868398.gmUuX4L15g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150625050138.GL4156-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart1868398.gmUuX4L15g
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 25 June 2015 07:01:38 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150506 04:45]:
> > On Wednesday 06 May 2015 13:04:01 Arnd Bergmann wrote:
> > > > It needs to be done in this code, so "system_rev" variable is
> > > > set properly...
> > >=20
> > > What I mean is which code accesses this variable that early?
> >=20
> > ATAG code is doing it at same early stage, so I added it to same
> > early stage...
>=20
> Yes we should do this early like the other atags.
>=20
> > > > > Also, it seems strange to have a string property and then use
> > > > > kstrtouint to convert it into a number. I think it should
> > > > > either be specified in a DT binding to be a string and then
> > > > > have the kernel not assume that it is a number, or we should
> > > > > define it to be binary.
> > > > >=20
> > > > >       Arnd
> > > >=20
> > > > Variable "system_rev" is number and it always was. So chaning
> > > > type will break more parts.
> > > >=20
> > > > And it is string DT property to be human readable. Some other
> > > > developers suggested for v2 to change it to string (from
> > > > number).
> > >=20
> > > Both of them would be human readable, you just use something else
> > > to read them ;-)
> > >=20
> > > If we have a string here, we should just change all uses of
> > > system_rev
>=20
> > > in the kernel accordingly, there are only a few of them:
> Let's just keep it as a hex as it was. After all it's an existing
> interface in /proc that user space programs may expect to be in
> hex format already.
>=20
> Pali, care to repost the whole set again right after -rc1 with
> with rev property naming and documentation added? Just keep it
> as hex and let's forget any string conversion.
>=20
> Regards,
>=20
> Tony

Hello Tony,

into which file should I put documentation about new DT properties?

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1868398.gmUuX4L15g
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWaczsACgkQi/DJPQPkQ1IC4ACgqxuF+cYWCeSC/s4jk2SlM3+i
0aEAnAoLb30QV/Og3coVGGxBi9Rrtw8w
=Iqyo
-----END PGP SIGNATURE-----

--nextPart1868398.gmUuX4L15g--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
