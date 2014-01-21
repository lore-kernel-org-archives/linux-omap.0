From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 0/6] N900 DTS additions for 3.14
Date: Tue, 21 Jan 2014 14:26:54 +0100
Message-ID: <20140121132653.GA8964@earth.universe>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
 <20140120155950.GB17118@earth.universe>
 <52DE612E.2080205@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:43589 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbaAUN1B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 08:27:01 -0500
Content-Disposition: inline
In-Reply-To: <52DE612E.2080205@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 12:59:42PM +0100, Benoit Cousson wrote:
> On 20/01/2014 16:59, Sebastian Reichel wrote:
> >On Sat, Jan 11, 2014 at 10:16:57PM +0100, Sebastian Reichel wrote:
> >>Here are a couple of additions for the Nokia N900 Device Tree
> >>Source file. All related drivers changes are queued for 3.14
> >>(except for the tpa6130a2, which got merged into 3.13).
> >>
> >>I may have some more additions if the driver changes for the
> >>accelerometer, the touchscreen or the wireless lan chip will be
> >>queued up.
> >
> >ping?
> >
> >Also it seems, that for_3.14/dts branch on bcousson/linux-omap-dt.git
> >merged some branches, which Tony no longer intends to be merged for
> >3.14.
>=20
> Yeah, I will have to sync with Tony to understand what will be in
> 3.14-rc1. Do you have strong dep with the series Tony has done?

No. There is no dependency at all as far as i know. I just noticed
it when I checked if you already merged this patchset.

-- Sebastian

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJS3nWdAAoJENju1/PIO/qaHPsP/AgHK5Z58R8p6zwBul/UgWzF
Wrzw5gXUs9+i71LKoW5Ln2S8gPlEOncO6xGRrS6pz4YdS3U5wZTAlMXBieZLMVau
i8Hb2j2DsefeyxPwezPPOCz1vTYpAHyZziD/4JZ1orU+tlZ6JUvc6uW2NWgizI1b
7feZMSYso1axY0u6PABEfJKnp8lk5/K/36GRBBHVXyWkyTnvdg85bKiyiAf4BDtS
sAuGIAY4cY7/2MxpMAyUt+11A/PNlk0cUa8d3taXsHvj821zfAvRC6QbkIOiFGZz
Gg07EfpBSdqev1VuZincQOXutnYfqZwzfxUZnALsqqD/oXd7DBQy1WXo/M8kQ/qh
sad2QJr5vfXgg3Dv1GlWbKd4g0fUddl/Cvme6dWZoWesQ8NFinFxrzSVNtfiaM6F
kI9kZphiXUrUcI7yVxoDPf6KcskKggkcVwr+AUOJXz74c3A+dDQy1/S7jDc5Idlr
RV2JmPcFSEj0FpEajEbt7lbK7u5C1l7+onG8JF1ROaBdtpBb89Hb/liJkP11kVWC
a0JDvgdhCGeCAxsA3VeCSLElk22+/N6ZJVtQeWji45Ybhq3ACpJHfBIVRDFGj31T
lcIAMwOL0ZX+Qm0FSjWkgLM26OQXM7kKLhGkv8N18wM0Psjoturcaj77xH6jcm3I
IpfzT9shG2kVEPdAYDIc
=HLoe
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
