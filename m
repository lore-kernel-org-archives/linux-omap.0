From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH] ARM: OMAP2+: Fix DMA hang after off-idle
Date: Wed, 21 May 2014 23:57:32 +0200
Message-ID: <20140521215731.GB26362@earth.universe>
References: <20140516210535.GC12881@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [5.45.105.125] ([5.45.105.125]:60077 "EHLO ring0.de"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbaEUV5h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 17:57:37 -0400
Content-Disposition: inline
In-Reply-To: <20140516210535.GC12881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2014 at 02:05:35PM -0700, Tony Lindgren wrote:
> Commit 6ddeb6d84459 (dmaengine: omap-dma: move IRQ handling to omap-dma)
> added support for handling interrupts in the omap dmaengine driver
> instead of the legacy driver. Because of different handling for
> interrupts this however caused omap3 to hang eventually after hitting
> off-idle.
>=20
> Any of the virtual 32 DMA channels can be assigned to any of the
> four DMA interrupts. So commit 6ddeb6d84459 made the omap dmaengine
> driver to use the second DMA interrupt while keeping the legacy code
> still using the first DMA interrupt.
>=20
> This means we need to save and restore both IRQENABLE_L1 in addition
> to IRQENABLE_L0. As there is a chance that the DSP might be using
> IRQENABLE_L2 or IRQENABLE_L3 lines, let's not touch those until
> this has been confirmed. Let's just add a comment to the code for
> now.
>=20
> Fixes: 6ddeb6d84459 (dmaengine: omap-dma: move IRQ handling to omap-dma)
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I can confirm the omap3 hang after hitting off-idle and I can
confirm, that this patch fixes the problem.

Tested-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTfSFKAAoJENju1/PIO/qa6LcP/jufcYBXGqDgbW6fRH29khWA
bt1c46oiNgKrbgSCgzs0YhOIlSX7jv+XtZ766++2GVExMx+ehzhm9mRhd4xQE7B6
rGZ77KNzxRy5j/VXnw2d4WoNYnBsyrRRxuOUJZY7nptfgfvbfznjYribDxxXHl7t
rniSp6w3jmwOR41lpJsZCLmI/wkqi1SPm0zxXxWwC1v3oVoceGhHXLta2jxKTLUS
npbmiBbnmmL9Zdgp9lioRBoW8inLZMukJ2gRX+/L8g474VwzlHQi0gXDRzvlWcBA
3HJIxFwxoyGjUcd9AEkqmksZ3YUTeZVfZ+UAwvXV7T6vsEG408nIFcJY1HvnTtov
GC9usBX+xWWp6U9mfSaeLkhcV3Ft8tvZ5BeagLZRLfIQL0WhiJTwYg5scrH+koD9
v5fE1itCXgmxQYB5xCtBA4Pq2+fohckUgiy/jWbapI3lVplpPv0o/ppxw/ylDRZA
Z9l9aXqg522af986K8w+Zx1+S65g4g7ZA6rv9rCwuyFOvtIMcGKnmQif6GIfoIHR
uLnk3s31+nfp4XCPNYr0U8rxO7Mp/OVkzysorjW4oi6Xzv4boIaDBlOXjsTGLwie
2XRNbw93+PI8EcAdY6JU/v5Vzxuagf1feXJ59SswM8TwMk7tUpBDcHlRG5jbWE37
7siDzrItEFqwDsu089Kc
=qeLz
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
