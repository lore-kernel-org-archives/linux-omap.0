From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Mon, 6 Jul 2015 15:12:27 +0200
Message-ID: <201507061512.27124@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <201507061423.23505@pali> <20150706123126.GG10705@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1533396.2MSfHpyKUP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150706123126.GG10705-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart1533396.2MSfHpyKUP
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 06 July 2015 14:31:27 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150706 05:25]:
> > into which file should I put documentation about new DT properties?
>=20
> If it's Linux generic like linux,revision, then how about
> Documentation/devicetree/bindings/revision.txt?
>=20
> For the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?
>=20
> Regards,
>=20
> Tony

Hm... now I'm thinking into which DT field should I put atags and=20
revision. In previous emails you wrote to use "linux,atags", now=20
"arm,atags"? And put them into root node? Or other?

In arch/arm/boot/compressed/atags_to_fdt.c code I see that most atag=20
properties are converted into "/chosen" node in DT...

So what do you prefer for "revision" and what for "atags"?

Some mentioned examples:

"/revision"
"/chosen/revision"
"/linux,revision"
"/chosen/linux,revision"
=2E..

"/atags"
"/chosen/atags"
"/linux,atags"
"/chosen/linux,atags"
"/arm,atags"
"/chosen/arm,atags"
=2E..

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1533396.2MSfHpyKUP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWafrsACgkQi/DJPQPkQ1IfZACfTJJCt2EvEed0eNR2dk1ReJ1K
0WoAoMGhe4onh7EJr0jwWA7iq3yY1a94
=AEDq
-----END PGP SIGNATURE-----

--nextPart1533396.2MSfHpyKUP--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
