From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 19:02:16 +0300
Message-ID: <1337616136.2717.12.camel@deskari>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
	 <CA+Bv8XYYe_3xprvVORXkdX2N54iDn_2v7GXndB6+cCtU0bLhcA@mail.gmail.com>
	 <1337615716.2717.9.camel@deskari>
	 <CA+Bv8XZDz=tvAqAYLhJqpuzy=2kwQj1O8a87ZqBVr8MPw1SEAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-HfBxMfGoCdzHcnC7ZkA9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:33105 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752797Ab2EUQCV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 12:02:21 -0400
Received: by lboj14 with SMTP id j14so5046657lbo.35
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 09:02:19 -0700 (PDT)
In-Reply-To: <CA+Bv8XZDz=tvAqAYLhJqpuzy=2kwQj1O8a87ZqBVr8MPw1SEAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


--=-HfBxMfGoCdzHcnC7ZkA9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-21 at 09:01 -0700, Russ Dill wrote:
> On Mon, May 21, 2012 at 8:55 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Mon, 2012-05-21 at 08:52 -0700, Russ Dill wrote:
> >> The correct patch for this was sent earlier:
> >>
> >> http://www.spinics.net/lists/linux-omap/msg70042.html
> >> "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"
> >>
> >> On Mon, May 21, 2012 at 2:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> >> > Tony,
> >> >
> >> > There is a bug in the for-l-o-3.5 branch I sent earlier, causing the=
 DVI driver
> >> > to fail to request the power-down GPIO. This patch fixes it.
> >>
> >>
> >> The correct patch for this was sent earlier:
> >>
> >> http://www.spinics.net/lists/linux-omap/msg70042.html
> >> "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"
> >
> > Right, and I was cc'd. Sorry, I somehow totally forgot about that =3D).
> >
> > So ignore my patch.
>=20
> Did you also get the 'OMAPDSS: TFP410: use gpio_set_value_cansleep'?

Yes, that has been applied into omapdss tree.

 Tomi


--=-HfBxMfGoCdzHcnC7ZkA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPumcIAAoJEPo9qoy8lh71yfQP/RQG4+DrpC/neFjHCG1SMZOT
WENVjVOPqk10Tz5vYgCUBp9KtjDsozdDczrE/YdI7gxi7xSvQlB/w8l7doayUbD1
ft4JFuEqh3QJ7PIxqBxh+pHDvBN3g3ZPUWePQak2M4vBZh1vzrpuC0Npbs6pL3zb
JwJfllf2jDT/eNdL7CCDoGf7iYRdntEDt804rDqo+QDYJ979jcqwsFd/czgQwI2v
b/06s3qpDVpgY68g9qQrpATKII16bd8Pb7bzLgM3SEzjIw/w5IR9bOo7S/XqlgLw
oRjBXxQXUT3VSB6ueb1dnSqhCmz/m1PcpDc+l+iug0JmUo6GW7B106SY1p41DWaY
Gzki75OMEBSQ9s02c2PRNlYAKJX9sib2WbCX2q8Kw+5Uy1PXGdKCAS53h7RAvvZD
nGYQrS6FTeeM7TFcfDCdaXB+8DItPWzSI8CKwBFgFnoCX08k7McwR0eC1m1h2ppW
F30DXUHmkD8av5GohJZLGXpbud48DKjoAMJbeFXYtFH1OR7pgIxyG6wPXCa+O/XW
57YfzCnxSfIGm0jfhrh8NpIx7IA8Osw/hngCLAuhN+fAGLYtswIrHnAOjlF2xoa1
QOXmllfBcgltAO5TwSoQNpPEdEVjckRoURQZqa33Bi+ay/gGHXSY9Kg6G5C2Z2qz
UCi2k42sRSLZD7xLybct
=kCtA
-----END PGP SIGNATURE-----

--=-HfBxMfGoCdzHcnC7ZkA9--

