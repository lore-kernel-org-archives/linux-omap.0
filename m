From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] omap3-n900.dts: Rename model name to "Nokia RX-51 board"
Date: Wed, 18 Jun 2014 22:23:03 +0200
Message-ID: <201406182223.03420@pali>
References: <1403110635-29696-1-git-send-email-pali.rohar@gmail.com> <20140618201241.GB558@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7054152.P5ARp0I99L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140618201241.GB558-7n+jfq1IuBl13aiSOxckUV9wdVTlxKpd@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart7054152.P5ARp0I99L
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 June 2014 22:12:41 Aaro Koskinen wrote:
> On Wed, Jun 18, 2014 at 06:57:15PM +0200, Pali Roh=C3=A1r wrote:
> > Use same name as in legacy board code. There are lot of
> > userspace applications which using machine/model name for
> > determinating device type.
>=20
> Can you clarify this? Nokia kernel or userspace never had DT,
> so they cannot see e.g. /proc/device-tree/model. What other
> APIs expose model?
>=20
> A.

Hi Aaro,

look at email discussion about my previous patch with subject:
[PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible

Basically that patch export model name in Hardware /proc/cpuinfo=20
instead generic DT name. And this patch change name to what=20
legacy board code reported.

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart7054152.P5ARp0I99L
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlOh9ScACgkQi/DJPQPkQ1K92wCfWPzfOnXVAXT31aaaGYEpuewG
r1gAoLoEGLEPGM6gOJb/FllP211HjRj8
=93Eg
-----END PGP SIGNATURE-----

--nextPart7054152.P5ARp0I99L--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
