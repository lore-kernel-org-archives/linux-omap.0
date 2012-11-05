From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
Date: Mon, 5 Nov 2012 10:04:41 +0200
Message-ID: <50977319.9070902@ti.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local> <20121101224828.2103.82950.stgit@muffinssi.local> <50936A6E.3020202@ti.com> <5093891D.6070302@ti.com> <50938A69.9040908@ti.com> <20121102154901.GU15766@atomide.com> <20121102185453.GY15766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3383A771A4C1EC4ABF8DECE4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067Ab2KEIEq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 03:04:46 -0500
In-Reply-To: <20121102185453.GY15766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enig3383A771A4C1EC4ABF8DECE4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-02 20:54, Tony Lindgren wrote:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [121102 01:56]:
>>> On Friday 02 November 2012 02:19 PM, Tomi Valkeinen wrote:
>>>> On 2012-11-02 08:38, Santosh Shilimkar wrote:
>>>>>
>>>>> Lets not move this in DMA code since the above is really related
>>>>> to frame buffer. It reserves more DMA area for dma_alloc_coherent()=

>>>>> etc than default 2 MB. Infact, we should no longer need this with
>>>>> CMA and memblock in place.
>>>>>
>>>>> Tomi,
>>>>> Can we not get rid of the above memory reservation ?
>>>>
>>>> Yes, I think so. This one is only used for the old omapfb, i.e. omap=
1,
>>>> and I have no means to test it out, though. But below is a patch to
>>>> remove it. I also attached the patch, as it looks like thunderbird w=
ants
>>>> to reformat the pasted patch... I'll remove the
>>>> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE from the omapfb driver's Kconfig =
file
>>>> in my tree later.
>=20
> Hmm actually, is it safe to remove for omap1, or should we
> still keep it around for omap1?

Why wouldn't it be safe? Do you mean that CMA doesn't work on omap1,
or...? I'm no expert on CMA, but as far as I can see with it's ARM
generic stuff.

 Tomi



--------------enig3383A771A4C1EC4ABF8DECE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQl3MZAAoJEPo9qoy8lh71gGsP/0IWiM6yrzY5rVs76WWSiirl
WG5n1v23tzBmDKY+sv8TU7mxlDsFRkwxlYR1JCVKQhRSNAeYkel0kAPD9sLhrb5j
aQGM6761I04pBV9O0Jys7wP2oxFCQG1dV+MHyDMVeStcjgfFog+jJoBLTevAwiDv
QUYOYsUwox9l9Hb4tzMT4R5SJgiJFhSYCQeABJqZVoH5+6jZKP8DeP+ZIZcO/VER
gVhHUXQryNaMtVCbyiYXyOBRZnHW5Os+UG439Y+0qPuNLcbwVWd+q57RazgR4l+m
66vfDobPJX0pQrmfENIfxDKv3MA+j1sZZwUUkxEyS5u51ZxxBxAf9ZtKU90+AFES
6hM06BhEgEaDee8+MNzzU7O2znU2M/pNIKi9bI6Jg+VmIGqX7s1dyfxuorF2XyiI
Vvi26TuQDxMA/A11nNoaQJGOtDRabVyLdS4LCCF3MOaNpG2OasAb0aBAw49fEQhO
VVi10lNC+VKKqyRwej/+ZTR6FvSPfplFemG6hI+zabUm4C1O/7yG1L7/26IwEw/X
TA3epXfOGQTX0eBdQ40uxRQlJouw9RHSPCkpTLbfS+AoZ+UOT56b2iHct8PnAf+2
VGXnFQu60mKvXIsKivKABWkLn4ECJubdf/nUOdq4rQuU/eerruTvGe/EY0PwuDiS
pL+xqQS8s926mpd2d+gk
=6bPO
-----END PGP SIGNATURE-----

--------------enig3383A771A4C1EC4ABF8DECE4--
