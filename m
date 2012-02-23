From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/2] regulator: twl: adapt twl-regulator driver to dt
Date: Thu, 23 Feb 2012 15:31:27 +0000
Message-ID: <20120223153127.GD4553@opensource.wolfsonmicro.com>
References: <1329996954-27083-1-git-send-email-rnayak@ti.com>
 <1329996954-27083-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55860 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756054Ab2BWPbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 10:31:31 -0500
Content-Disposition: inline
In-Reply-To: <1329996954-27083-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, Tero Kristo <t-kristo@ti.com>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2012 at 05:05:53PM +0530, Rajendra Nayak wrote:
> Modify the twl regulator driver to extract the regulator_init_data from
> device tree when passed, instead of getting it through platform_data
> structures (on non-DT builds)

This doesn't apply to current -next, I expect because of the SMPS
regulator changes which went in.  Please always submit patches against
-next.  There's also a patch from Tero adding support for some
additional regulators which is floating around and would conflict with
this.  Could you guys please coordinate with each other on this?

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRlvGAAoJEBus8iNuMP3df04P/A/A6CVCcbWoD2dpmcefDJGD
uzfA5wZsC7AUnEmbQK6TKxhyuKRqcIBWGaAEJWGDISyxhpC4KM3/F4LPezzCe/3Q
CHb2PtEp3Is6MbJ2I+qNo4Qxe7EmV7sjl4oLNW2tKH73SY6Py+/RXTMsOt+ba2vx
Z3IfAnzZmPhgY09rStxVkLPvYAHTd30Uoyz5LjIkafBZti/zIYOFcFAas6xvpSK5
UuZw5zR29rJKA5Od/uTXnvquwHriGAfzT4mswkrEXAdIj9Ysmhy/+zkYUiusp0kh
kf1ycCqz+U+4w0P6bm1Bgq/YMRnz5jgBMpfHNZio4Z2xZsnv3ME0rWkNoK907Hej
lLonMbZDdbFrmT+RJvdzTgYtRwsTJjZCyIE8huDfYSDmTTaEy4MZ2s8v8gaWAFlw
OQzuJw7BsLZGBAqRAhK3ggaWiZI2XEF/kI1QYLN43yRJAs57WPsAHIikpoKBb89U
QO3BQTJysIRCDtBRdJzmxYNunJoYTa7jDtQb4eo/mXOh9W3UPh9mpt98Gcw/orZp
AMv3UF/HHSnNCdgDmyKKkHBJa/PTyb8Wg6C4azTNZhim8N+2ZhMuPT5Nxxg7czhy
wZSmPbKEFWqiCbs/F6g+ixkSblDTggwCYlApUgA5uV2boEJDuUVMMe4wDo9vhIEk
6I+qRcZD4ZyQB3TV1OgK
=EafO
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
