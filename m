From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH V3] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Sun, 4 Jan 2015 00:39:50 +0100
Message-ID: <20150103233949.GA4108@earth.universe>
References: <1420309826-7904-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57632 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbbACXkD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 3 Jan 2015 18:40:03 -0500
Content-Disposition: inline
In-Reply-To: <1420309826-7904-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nishanth,

On Sat, Jan 03, 2015 at 12:30:26PM -0600, Nishanth Menon wrote:
> [...]
> +		gpio-fan,speed-map = <0    0
> +				      13000 1>;
> [...]

iirc DT maintainers prefer this format:

gpio-fan,speed-map = <0     0>,
                     <13000 1>;

This should result in the same .dtb, but is a bit easier to read.

-- Sebastian

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUqH3CAAoJENju1/PIO/qaXV8P/0GKBTc3KrsIhA0jX0IzRV4v
ujGllhzLjN6dMdOrsAPO1WLLqmJ+/Db2PyHfiVQJO0Dke3nx7PR9QHieX30NKMOW
Ac49CHAr+e2qiXn0nMvxEOWhMF3p7XNeF8JornndY5bBFGTPaLNtu0y3CK5mpr1q
m/dXT4x7EMfHRFVxabhLQ2ypMp50PwCyA1PekahccTbiO+fc+uDFzfq1ylOEN1sG
vMy+kXIMdeN2PcglTK3htm5sWbVQhOscdS863CnsjX8O08afgOHvKNwff2fS4ymC
JiRydfLG/0eIhKYPyLbtxLroNIP6sW2y5rM53WdwWfVWMEJGfhcKCxjuEBieWCMH
YP86R644qA66zDLylvzYykgwXK+840GGsXHvmVJ0MW0MHgLrLBf27Ucj0sIreSm9
Khl76dpsNivhl5og60GfYxFDuDvyqBmo19rmMINVRZJNkLuusm8pfQ4arjtRx8TS
HFJCH7Yo398GEst7pMrTCkE7TcYkn3cNabd1DoQkpv4AfpXxH9s9UyAZwN1LPicg
CxmCeanXCTp5s7p6rxsLcXnSHeFz20gl6KUg40WN0AjvWXZOU4PjJnAWUd9oF228
HA8/mB78XD2LTYqZZCMxKjT5nfA2Q0e4Jl0Zrw/8QEIfDOXxb748QTx6dOxw23G3
TXUqAGbpg48Jg0tQe4/c
=5uFp
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
