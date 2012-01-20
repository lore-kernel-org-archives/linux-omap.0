From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 14:01:26 +0200
Message-ID: <1327060886.1921.63.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-cyRBNh6Ws381wySLK0KP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:35178 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab2ATMBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 07:01:32 -0500
Received: by mail-lpp01m010-f45.google.com with SMTP id j13so336457lah.32
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 04:01:30 -0800 (PST)
In-Reply-To: <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>


--=-cyRBNh6Ws381wySLK0KP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-20 at 17:26 +0530, Govindraj wrote:
> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:

> > Is there a way to lock the OPP to the full power OPP?
> >
>=20
> btw,
>=20
> I think enabling cpu_idle and performance governor to should ensure that.
>=20
> However enabling performance governor boot fails.

I thought so too, and tried it but got the same crash as you.

However, I'd imagine that if I don't enable CPU idle or the governors,
the board would stay in full power mode always. But this doesn't seem to
be the case.

Then again, I don't see how CPU power management could affect the DSS
directly. So it's probably something like: cpu goes to RET -> something
else is allowed go to lower power state (L3?) -> DSS breaks.

 Tomi


--=-cyRBNh6Ws381wySLK0KP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGVeWAAoJEPo9qoy8lh71KuwP/iWcCN7TIlsLEjwh6UZbwZhs
kUkxbFVL9tM7lAFHS271K+qLVeSXxzhTdZMPdAivORyb5OD+06Ct+g/I+9ddoIKT
u5Bknw+LEbOLieBulsY4vRUuM3r0kPkh1Uo9kYfVcUX+XYm1iUMyWQ3FtnVkhFgH
15ltmesp0cPq91FpJET9psiFJg6YWuR5dKmDcNF97Wt7f9Inep4uoZeopbYhwfLr
2SdX8niNcs41lBUC5LyLV2hE+I8kWZOtTBSxRa5oouOKCI3MgOa7Wrce8yHWzX7v
bFd1fn7DnhJts/+h/Fv35qJ9A7B0hGxyvxqMbk+NnZU4Zgc3LnxzyNa3QhLpZD1P
ZDXATP4bRvvK4bsYihh9oGq0YnlvOa+go0MEYfBPit8ZnmmzJL4vE1GlV2T7+MgF
PfwOsnJNEAg7NTrQLOEe0Ykzq0yBGqQ7J6k4Szqxq97rq2t4qH/lmdrE7exNunGM
Bh2heXqZJqQ/Xjg/Er+Th+3sE0JoV5xzB1UU2dM+1PIoGaJP8PCIiWfmdZ48EIU2
OWVDGT9YgjwWqX62gJGp9eMZl+E65xoPtlN/KkGRkcKQ0lqKzMONRKu8ERR32P21
g78L/z2tJym1ChJwRvPw8J93hlhX0AYfmkvnpD+cT1FKjz/alMREuEc4/WQoPu40
w9fk5+P2Y3odK3xuu65H
=FOg8
-----END PGP SIGNATURE-----

--=-cyRBNh6Ws381wySLK0KP--

