From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Tue, 17 Jun 2014 08:19:35 -0500
Message-ID: <20140617131935.GB9070@saruman.home>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49508 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbaFQNU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 09:20:26 -0400
Content-Disposition: inline
In-Reply-To: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 04:04:51PM +0530, Sekhar Nori wrote:
> ROM code on AM437x does not support writing to L2C-310 power control
> register. The L2C driver, however, tries writing to this register for
> all revisions >=3D r3p0.
>=20
> This leads to a warning dump on boot which leads most users to believe
> that L2 cache is non-functional.
>=20
> Since the problem is understood, and cannot be addressed through software,
> replace the warning with a pr_info() while maintaining the WARN_ON() for
> other truly unexpected scenarios.
>=20
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Tested with today's linux-next
(5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) with am437x-sk, I can see
that the WARNING goes away.

Tested-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToEBnAAoJEIaOsuA1yqRE5eQP+QEY7h7JIAvoQOmTZQBsSHP1
GkMGwKyv+fCmiTCHhSLAA0icNHAkUCgRmGddN7ru7xjILw5GTWLn0VqYK22I12be
r0IYGwK5gAcN+ougU7NNTnLtFmk4EijFYoTswU5rX5yWbqd70K6WDylWbQWkvdad
tytgWIXJM73X6PaxMa99EU0hDWVejyzASGUdJo5WJ4t4MAA3K6/0+53+dNdnkKAO
pjLBG4PhVxNjRj726oEgkPwVRpJed4SBtO+LKH8N9Ljqgtn8sSKmGkTrwpGWGMgn
2Y+VXIaIM6G8MIpW+oRlwUelGRCck+iEJvtZdATLFcQYQIlQDNx0L6E2BnrQL3eS
N5yTF0hiCjR2gOkVKs1hH3v3JFagWccfImpAZkDSEwXk3wI3X2wSvUsrPtRVFbpv
CcMbn21asGF/Iyj63gwNhE8NLpojNKL5fh2CJOudSTAy6XmE0lPHGpku95l6OGe5
X1VZEduW5L2oCwBI6MJIhvMhf70bINh0Rg35pLRO76p15r6ShfbwiJhRd2V5siA6
wM16UZH3jF09UkK9wUUwrU8427gkAUik/g5Sk0ReuFy9YHl4WwWqujE20/7Yxc5r
RsE2j4nJFb8dDYEEGT1Xxymheky7g4QAt34GfMeN/ZJNLcbC3QccQup+veqfpIZO
+WQsV7yY1ZqsV2ff0suw
=pNVE
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
