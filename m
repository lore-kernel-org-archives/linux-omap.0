From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Tue, 27 Jan 2015 11:15:32 -0600
Message-ID: <20150127171532.GC14878@saruman.tx.rr.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-2-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
 <20150126165640.GA10679@saruman.tx.rr.com>
 <20150126194933.GG6660@saruman.tx.rr.com>
 <20150127160143.GH14623@saruman.tx.rr.com>
 <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38810 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbA0RQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 12:16:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 05:12:05PM +0000, Paul Walmsley wrote:
> Hi
>=20
> On Tue, 27 Jan 2015, Felipe Balbi wrote:
>=20
> > On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> > > On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> > >
> > > > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints=
 ?
> > >=20
> > > gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> > > read as 0x 12510f00 which would translate into:
> > >=20
> > > - module disabled
> > > - all opt clocks are on
> > > - module is transitioning
> > > - module in standby
> > > - clkA as TPIU and STM trace clock
> > > - all dividers set to 2
> >=20
> > just fyi, checking with HW folks, this might be a new bug, unless
> > debugss needs something special.
>=20
> If that happens on DEBUGSS disable, it's probably the same issue as on=20
> AM33xx:
>=20
> http://www.spinics.net/lists/arm-kernel/msg320801.html
> http://www.spinics.net/lists/arm-kernel/msg321930.html
> http://www.spinics.net/lists/arm-kernel/msg329151.html
>=20
> Does adding HWMOD_INIT_NO_IDLE fix the issue you're seeing?

I'll try it out in a bit...

--=20
balbi

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUx8e0AAoJEIaOsuA1yqREbTUQAJKgMmFDPJ7uQlygE+LDceZz
I1dZxRJGF+JbVefbAzWR75nTkeGRzwuucfaHrPG6OH4RxniKcq2BMF1fwp2weX4r
5k32HvZp9GziGtuAW19tWwyvcFtgmbCGTGUAt0RPSzSvfO4p74JCGVRLU9TbEanM
gxT844ucuOAIL4S6GUYMfp99VicIHv14ODO9Hm4Dqb9pXgDLET66f+HGqU9iHQeM
n3OyEDiU/1qrZfIv97PTQhl86Sg3ICI29YkqOdfToQC0xqdnglrFQqJzp3G9b8HD
YBtWrSMmWo3VpEzdW1Zng+cW9L+YKaJo05wAZqgxA8emNYiz0sQpsvtGeJ1zGiHW
hPXaDBa9SYeFGbAL9aXvqljLLSGe8IsJOBrOQQTuPWbZOT9JIjoULYigIE/fHLBZ
HqLFbjko2hWO4d2QRIBH5pPp6iSqs2O91Gv95uTDc00h+K+gsXBxep+etx2ejFBL
lXlAQcFtnC4yU8XCIPMMgMA+RB0cPjVePdL1nUSH1tDwkr+PeEVX04ysdiKw5ikz
MBnebANEHoFHeXfBwYR1G1H1dUqRLPzN6TzP6DjgWJKkEUNkuRJqCP14pVtVS1oY
BslHLmYi0LJrhQRkBEj1Bd7ttI9yYtaa+pDNJlP6CE1ZTHQ8qTxiCK675gunCQ7Q
BT4BelDt2EsYr6ZAmL2S
=o+S3
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
