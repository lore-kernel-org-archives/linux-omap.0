From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Tue, 15 Nov 2011 09:06:36 +0200
Message-ID: <1321340796.1895.8.camel@deskari>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
	 <20111105003550.GM31337@atomide.com>
	 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
	 <1320746911.1907.47.camel@deskari>
	 <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
	 <1320754489.1907.50.camel@deskari> <20111114204649.GL31337@atomide.com>
	 <alpine.DEB.2.00.1111141438290.19654@utopia.booyaka.com>
	 <20111114220423.GQ31337@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-l/HLxxbaxMlvzpU4j+OJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:53945 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750706Ab1KOHGt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Nov 2011 02:06:49 -0500
Received: by bkaq10 with SMTP id q10so8626592bka.40
        for <linux-omap@vger.kernel.org>; Mon, 14 Nov 2011 23:06:46 -0800 (PST)
In-Reply-To: <20111114220423.GQ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-l/HLxxbaxMlvzpU4j+OJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-11-14 at 14:04 -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [111114 13:05]:
> > On Mon, 14 Nov 2011, Tony Lindgren wrote:
> >=20
> > > I suggest we only merge the ones with "fix" in the subject during the=
 -rc
> > > cycle. The others add new features for the reset, so they should wait=
 until
> > > v3.3 merge window.
> >=20
> > Most of the other patches in the branch discuss what they fix in the pa=
tch=20
> > descriptions, rather than the subject lines.  Do you want the subject=
=20
> > lines rewritten to highlight this?
>=20
> Well we should only merge major bugs and regressions during the -rc cycle=
.
> It seems that at least "OMAP: HWMOD: Unify DSS resets for OMAPs" has high
> flame potential based on that? Maybe we should wait until the next merge
> window to start removing some of these workarounds?

I'm not sure what you mean...

The "Unify DSS resets..." patch itself fixes only a minor bug: "This
causes causes the HWMOD reset to fail for dss_dispc and dss_rfbi". But
it makes the next patch, "Ensure DSS works correctly...", possible. And
that patch fixes a bigger bug, DSS or the whole device hanging if the
bootloader had enabled the display (which I believe is the default on
the shipped beagles/pandas).

There's one patch in the series that is not a fix, though: "ARM: OMAP4:
HWMOD: remove extra clocks". I'm fine with queuing that for the next
merge window. But most of the patches have now somehow missed two merge
windows, and I'd really like to get them in.

 Tomi


--=-l/HLxxbaxMlvzpU4j+OJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOwg94AAoJEPo9qoy8lh71bP4P/ipk0IHfNq0htAc/QQzDFmWp
4IUiCH0Fe1rFFyKCiJJnl5NxC84AsELgavq/cJFW0Fxjq6ENRkIdo4ra9EVS7wC8
LLQv1aOOFja9cH8Le6V0RO60qIumWJgHa7smxlbo76e87scCnibkYZ4eCuqVrLiM
L4IeiTyRGjHwwocFfoArbU76DMChI4iePiCjFSdGOKQd3Kw3Sku393yjW8YiuwSi
BXoU0RWHGZt+z3DR1X2HuGoAFdO0oaqm+Idj4TARL3Ql4cCvj88OLTwghwihsd7Y
Kld5hUYtDBtGShDUqRb+gURGKos/5EZmmvSyyC9sEPE1n9glE8z+JG3Dite6E9Me
sMr7wbg8ZFf8vutisWVrJxmUx1glP7qil8/SUNivMPwm251i37XTUkRK1deMw0bP
AVJE0Q+WoZQ/+yF/zEvJwNmv3wypYP1AdV7uCVSD2mcbixvSvh5C1UfB6X0SIA8z
jlmUM3/DHOaOwUlzJyopKW8odcPFMN37pbCRnFMfEpwt4PzlXzlVPaxb1Qbtw6fd
1qZdvR5hBgazzmT/QEYQALNLS5XicZAWsXTltUeE86uS1sxJzi8ewBs98XhAQ9xD
8F3ja3kTmW6MOIVPfox5+2dNP5wbvPKkdIQxYdZKyyBzCoZ5NyhgaawLn6eeHObx
GsZV3+i0nQbdwDAVFdxb
=BeEk
-----END PGP SIGNATURE-----

--=-l/HLxxbaxMlvzpU4j+OJ--

