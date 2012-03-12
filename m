From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for
 v3.4
Date: Mon, 12 Mar 2012 17:32:16 +0000
Message-ID: <20120312173215.GL3110@opensource.wolfsonmicro.com>
References: <877gywjhht.fsf@ti.com>
 <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com>
 <20120309003217.GB12083@atomide.com>
 <20120309114731.GA3273@opensource.wolfsonmicro.com>
 <87zkbp4wtj.fsf@ti.com>
 <20120311204232.GC3171@opensource.wolfsonmicro.com>
 <87399dzq5e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KSn4sQg3MnruwCB4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42900 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755737Ab2CLRcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 13:32:18 -0400
Content-Disposition: inline
In-Reply-To: <87399dzq5e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


--KSn4sQg3MnruwCB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2012 at 10:26:53AM -0700, Kevin Hilman wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > The branch itself is essentially stable but I'm not enthused about the
> > idea of merging the whole thing via the OMAP tree. =20

> Right, I wasn't suggesting we merge it via OMAP tree.   I was just
> looking for a stable point we could use as s dependency when merging
> everything together for the arm-soc tree.

Well, if you don't base the OMAP changes that depend on it off the
regulator changes then you'll break bisection as you'll have a bunch of
commits which won't have all their dependencies present on a branch
(since they're not present in the branch point and aren't otherwise
merged in), if bisect goes down that branch it'll be miserable.  That
seems bad and while I've not run into it with OMAP in particular it's
rather painful when it does happen.

It's much better if the branch has the required changes merged into it
prior to their being used.

--KSn4sQg3MnruwCB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXjMFAAoJEBus8iNuMP3dOIUQAJXdN5VzowQeZgFFsS2qYFYB
wVkfLq76CtauofgULmvRhCfq1YQ6zmx3A2R37eUzk4MKL3SiSzFpUze2VuEKQ7Q7
wUVWewIFg1nO+9lZC6lSDlPGee9hpNgP8ujKoA4DTOpoFfRtG+/VKrb7Fqr+K0DK
EibLULGr0syredI55fdrjgR/T2D+dbgM4DZ5lv1EcARP+Axns2brMjnm38FYOnw7
dgQxE1n7v1Km0/2kzYTmDmTFOKpN90VQmmpBKZWv+WDXgp8SGP4Pb6Yx+VEUmxLm
A5kwhl0j5b57YyYE6m/g7IqfRLDCWS213I2vsrjDslEZI3Id0RnyGfWhx8VK9kS+
iADapAE9afXY5pT4K8x8LdjHiIhqm61E5ynwPzsUku7xGopRwZ3Ehlx/lBCTXMtE
bAw7tpqZjGVKK+bDCo30/6R3JPvF1GXz5K7yZKptbrNHV22O7hrUyqIhKHYmsli6
J4zvEDyv+AQ1JPrjF7axj35lxNoFK7S8RmZzTpxLwz723EEgB9d5m9X4PLbdzc9A
8v0IFDiagSuuiE9Ploq3a7m9nEtP1LwGEP/I9sTM4orEZDkTyTfKyeuzKXasSBV3
v4vBUdrJBCnLtjf+hPHAOHOn6EERa/hqU4itj3GrDgQZkSog6sPHOc/iBHQuTy/S
Tp8wbEGnqJqUzwmZ3Cag
=MfHW
-----END PGP SIGNATURE-----

--KSn4sQg3MnruwCB4--
