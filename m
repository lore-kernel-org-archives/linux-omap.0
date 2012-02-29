From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] twl-regulator DT adaptation and updates to add new
 regulators
Date: Wed, 29 Feb 2012 23:18:19 +0000
Message-ID: <20120229231818.GA8295@opensource.wolfsonmicro.com>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33305 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965072Ab2B2XSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 18:18:22 -0500
Content-Disposition: inline
In-Reply-To: <1330421953-29517-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2012 at 03:09:09PM +0530, Rajendra Nayak wrote:
> Hi Mark,
>=20
> Here is a consolidated series which adds DT support for twl regulator
> driver and adds support for VDD1/2/3 regulator and support for
> fixed LDO V1V8 and V2V1. The patches are based on -next and tested
> on omap3 beagle and omap4 panda boards.

Applied all, thanks.  Please do try to use subject lines consistent with
the subsystem.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTrI0AAoJEBus8iNuMP3d3N4P/2rsttR7MF1b2Ghp9NRTwCYp
0b0DxfRVuuoPBb9F6+ybACmToiqadYF4VMXKCdH0kxdkpiTBuYIePgt0g1amlnG5
7XsLl+NKuvxXWPjqyiz8HZHuR4apK+0xotRl/qBTuvndPahbqdaUgV8KiEIhRPLZ
NfMIIxFzUS4Hbwn2rweE1x5T2TOzfADRKzof7hE4mennNlJihjjzRyiudaPVvftj
t1p4ndYpLQ1FPWA3ktMVIIWQxKkA9fZea601zrhT6covuT2yd05nbiQ4cI9QkO94
Dgb0+KxFOlirkRe8QD20a2XduKNlybZ86WxFy5TaDBuXIQju+gEWaHTMHU+GkTTL
KD1SqFDlHT3oOpVwu92Ie8Jbcc6tP4XvDJweVafG2cwJEYYL2Ke01zad7dMgLpmA
1KhXxAisfwrJNXlzav/LA35fdZ4ACOuFE3fr5T3OEiMcde1n/Y/uTBkoBUnHInrt
5C4t8//I0+Ez5jYDwfOcxHzSvWbiY/uFyC7WL1dHrPZ1F3q1ygCF3gxaYu12jw9o
ytlDgu4aD/EBdsH6obZF213cAzUH74P4SP9QAFhixUk+ibXxOBHjvY+jT452+SQH
GfEp651RLJvWgoCZazAEUkq3BB9kAzzOep0LLOe4mFVApaOU67IeKC4D6XjkFDrx
q58Q+9thtpCIbsHJWy88
=vvCH
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
