From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Mon, 30 Nov 2015 01:15:12 +0100
Message-ID: <201511300115.12478@pali>
References: <20150713131902.GH26485@atomide.com> <20151129180939.GE30871@n2100.arm.linux.org.uk> <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3817658.Tbqq1GDGLX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.20.1511291902100.22569-fMhRO7WWcppj+hNMo8g0rg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--nextPart3817658.Tbqq1GDGLX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 30 November 2015 01:09:17 Nicolas Pitre wrote:
> On Sun, 29 Nov 2015, Russell King - ARM Linux wrote:
> > On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> > > Good. And Arnd likes the idea too. So we might be converging at
> > > last which is a good thing.
> >=20
> > I disagree with the idea that there is convergence.  There might be
> > convergence towards an idea, but... Here's a mail extract, from
> > July 7th, from earlier in this very thread:
> >=20
> > Pali:
> > > Me:
> > > > Are the ATAGs at a fixed address on the N900?
> > >=20
> > > Yes, in board-rx51.c is:
> > >=20
> > > .atag_offset    =3D 0x100
> > >=20
> > > and Nokia Bootloader (proprietary) store them to that address.
> > >=20
> > > > Can that be handled in
> > > > some kind of legacy file for the N900 which calls save_atags()
> > > > on it, so we don't end up introducing yet more stuff that we
> > > > have to maintain into the distant future?  If not, what about
> > > > copying a known working atag structure into a legacy file for
> > > > the N900?
> > >=20
> > > I already asked question if it is possible to read ATAGs from DT
> > > booted kernel. And somebody (do not remember who) wrote to ML,
> > > that it is not possible and it can be done in that uncompress
> > > code.
>=20
> Who is that somebody? If ever it happened to be me then objection is
> withdrawn. Otherwise that somebody should come forth and speak up
> again.
>=20

=2E.. do not remember ... this discussion were in more email threads and=20
takes more then one year... sorry but my memory is not excellent

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart3817658.Tbqq1GDGLX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZblRAACgkQi/DJPQPkQ1IpmwCeN9QCeO99b8gdCwiWdgQaL6/r
5rkAnAmFGNXecQJJmCmhox93KOnZu85Q
=XTRZ
-----END PGP SIGNATURE-----

--nextPart3817658.Tbqq1GDGLX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
