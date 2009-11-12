From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 00/19] OMAP: DSS2 v5 intro
Date: Fri, 13 Nov 2009 07:48:11 +1100
Message-ID: <20091113074811.ee61948f.sfr@canb.auug.org.au>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
	<1257856848.21596.753.camel@localhost>
	<1257929140.20378.51.camel@tubuntu.research.nokia.com>
	<1257932641.20378.77.camel@tubuntu.research.nokia.com>
	<20091111184208.GC24837@atomide.com>
	<20091112161028.427787d9.sfr@canb.auug.org.au>
	<20091112181457.GX24837@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__13_Nov_2009_07_48_11_+1100_5FbQksgPBej05U+d"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754290AbZKLUsR@vger.kernel.org>
In-Reply-To: <20091112181457.GX24837@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>
List-Id: linux-omap@vger.kernel.org

--Signature=_Fri__13_Nov_2009_07_48_11_+1100_5FbQksgPBej05U+d
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony, Tomi,

On Thu, 12 Nov 2009 10:14:57 -0800 Tony Lindgren <tony@atomide.com> wrote:
>
> OK. The only dependency is the the move of the headers.
>=20
> Tomi, can you please rebase your patches on top of the "7xx-iosplit-plat-=
merge"
> branch in linux-omap tree? This is commit 8171d88089ad63fc442b2bf32af7c18=
653adc5cb,
> and it should stay static.

OK, *if* you (Tony) guarantee that the base is stable (i.e. never
rebased, but may have things added to it) and in linux-next, then I can
take the DSS2 stuff separately if you want me to.

Tomi, you can, of course, merge that branch into your tree instead of
rebasing on top of it (which ever is easiest).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__13_Nov_2009_07_48_11_+1100_5FbQksgPBej05U+d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr8dIsACgkQjjKRsyhoI8wsmACeNkjJtOMwh9RZW3OuNNN9xPMb
jXIAnAt0QOBnyQA+UxKnlRdL3taRoXDk
=jyyj
-----END PGP SIGNATURE-----

--Signature=_Fri__13_Nov_2009_07_48_11_+1100_5FbQksgPBej05U+d--
