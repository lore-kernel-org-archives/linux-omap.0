From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Fri, 22 May 2015 09:27:07 +0300
Message-ID: <555ECC3B.6000701@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com> <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com> <555C744C.6070901@ti.com> <555C74E8.5010105@ti.com> <555CE1BF.4050506@codeaurora.org> <alpine.DEB.2.02.1505210254330.7960@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iKuOIQTM119iSG5ueeLXFOTI03v2WK9fH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57479 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbbEVG1i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 02:27:38 -0400
In-Reply-To: <alpine.DEB.2.02.1505210254330.7960@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org

--iKuOIQTM119iSG5ueeLXFOTI03v2WK9fH
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 21/05/15 06:06, Paul Walmsley wrote:

>> Enable falls under the "critical clocks" discussion that is ongoing. I=

>> assume that this is some sort of critical clock that can't be turned o=
ff?
>=20
> It only needs to be enabled for this particular display IP subsystem to=
=20
> function:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D142071550111482&w=3D2
>=20
> I believe Tomi is taking this approach (enabling it unconditionally) to=
=20
> avoid adding support for a secondary IP block "main clock" to the hwmod=
=20

Right. I don't think that would be a simple task (correct me if I'm
wrong), and that would all be only for this one IP on this particular
SoC type.

> code.  Apparently, the chips that contain this clock gating bit are not=
=20
> intended to be used for power-critical use cases, so there's not much=20
> motivation to switch it on and off with the display controller.

Even in power-critical use cases the the power use difference should be
negligible.

 Tomi


--iKuOIQTM119iSG5ueeLXFOTI03v2WK9fH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVXsw7AAoJEPo9qoy8lh71bSQP/iYmQLBtqx0bUS61QZJhk1Ft
O9fTWhE1Stu6SzitL/j8Y9E550DMSF1VLbNjCzTwr5cWJlg0MXLbdYVp9AnzfSyX
UW4670ChWpSw+/cn9XP+XhYE1NmAqjat1xc9B/nm4TD/Ky1l5GntSkku3eQKuTZT
qPSNzKzVqbAnN0rymWEdkXFOQGzCHhmqCo9bx7uM+qMpspqXB6s9XpFLmd4EQRpB
bQPWPHjVV/maUWbKsR6CZjpdZPsL8f0Tnj69OCoVU/Lptp9+FPUj8P0cy15L3Zlw
DuQHM2vBnfK6MJOK7H+D5DV/IgTEzid9Rnyr1yt33YUxb89YPbRo2cMZym/rwNE2
+6rs5yaEAs8mSdnj0kTY65O6V+aaYC6yDSCEm0jcJa4IyiWZsxvl3hcL2lgxSEPh
R00/exCNvbHp5vutSJsP5TfZ4KRSb77DGc3XuSuoSQShOIcFlfgmXC+FzEvVD1MQ
5DUag8sBUQBf6CCgThxCr8RQtFUIXfkUKc3hXxk5q1MaynBf34Daf3t3KoHvCg75
nIB494gLtraMK8Mgr5n2INLX0S90/3Z6Dw2BL2qT1lhk6CRxTBLUcpDTfRjGpR3/
H0tWS+D4z4aDsoUiinWjOoL3kz4P+Su++3cmcD3/P1TdiPrMCPBTMMYQ3gc6ABSh
/MxKig90iMFLO9BqEIVJ
=wU7o
-----END PGP SIGNATURE-----

--iKuOIQTM119iSG5ueeLXFOTI03v2WK9fH--
