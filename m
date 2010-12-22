From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 8/8] OMAP4: clock data: Add missing fixed divisors
Date: Wed, 22 Dec 2010 10:21:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012221019440.21915@utopia.booyaka.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com> <1291932820-11163-9-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1748949766-1293038474=:21915"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48761 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab0LVRVP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 12:21:15 -0500
In-Reply-To: <1291932820-11163-9-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1748949766-1293038474=:21915
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Dec 2010, Benoit Cousson wrote:

> From: Jon Hunter <jon-hunter@ti.com>
>=20
> The following OMAP4 clocks have the following fixed divisors that
> determine the frequency at which these clocks operate. These
> dividers are defined by the PRCM specification and without these
> dividers the rates of the below clocks are calculated incorrectly.
> This may cause internal peripherals using these clocks to operate
> at the wrong frequency.
>=20
> - abe_24m_fclk (freq =3D divided-by-8)
> - ddrphy_ck (freq =3D parent divided-by-2)
> - dll_clk_div_ck (freq =3D parent divided-by-2)
> - per_hs_clk_div_ck (freq =3D parent divided-by-2)
> - usb_hs_clk_div_ck (freq =3D parent divided-by-3)
> - func_12m_fclk (freq =3D parent divided-by-16)
> - func_24m_clk (freq =3D parent divided-by-4)
> - func_24mc_fclk (freq =3D parent divided-by-8)
> - func_48mc_fclk (freq =3D divided-by-4)
> - lp_clk_div_ck (freq =3D divided-by-16)
> - per_abe_24m_fclk (freq =3D divided-by-4)
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

Beno=EEt just mentioned that I missed this one too, probably since it was=
=20
posted after I had already pulled the v1 patches into a local branch. =20
I'll add this one also, re-test on OMAP4, and post a new pull request.


- Paul
--155748971-1748949766-1293038474=:21915--
