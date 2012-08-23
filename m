From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: OMAP2+: twl-common: Fix compile time error when
 omap-twl4030 audio is not enabled
Date: Thu, 23 Aug 2012 12:22:04 +0100
Message-ID: <20120823112204.GY7995@opensource.wolfsonmicro.com>
References: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+qWNqCDaOkLiPcHd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44372 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752534Ab2HWLWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 07:22:06 -0400
Content-Disposition: inline
In-Reply-To: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org


--+qWNqCDaOkLiPcHd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 09:35:01AM +0300, Peter Ujfalusi wrote:
> Fixes:
> CC      arch/arm/mach-omap2/twl-common.o arch/arm/mach-omap2/twl-common.c=
:562: error: conflicting types for =E2=80=98omap_twl4030_audio_init=E2=80=99
> arch/arm/mach-omap2/twl-common.h:62: error: previous declaration of =E2=
=80=98omap_twl4030_audio_init=E2=80=99 was here
> make[1]: *** [arch/arm/mach-omap2/twl-common.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
>=20
> When building the kernel with !SND_OMAP_SOC_OMAP_TWL4030

Which branch needs this?

--+qWNqCDaOkLiPcHd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNhJVAAoJEFJkBDiqVpZ45xMQALaEulyLb6VhJyrawMLRXopY
hfWwecSoEu7hO4nH7CpGgSAbmX00upFUJjYEop6TSE+1s1eX2/GFGBmB24qQVbJM
P5QkqHZhuzez0aI7Ku2uIy8kRKroy41SPG6dMMRPWK0yjAdUivfAADGldmvYIrcC
su1WNRJ5dffoxFEdlwBjqRRTArOSJ8lwu5zNtRWOkvIYTknSWKedBaMinl+V6Ipp
bWvc9PrU/H+7O6hFbjNDj0g0ua6iGoxyksMJnAbvKE6nVVrBHhlxBnXiEsX8Tabv
SBUFgy2ISm+o0jWhDVU4bZgIO9vaI4Kv7kZnQVF5qBWz6g2igemVnI8OsA7/pj51
U7bJ8fI1SJQFAGxzewRMTX3yoA8sBlgpd19T9YuLUGcjhEzIgBWXqPKywy8SNuhT
l45u38n0mssQaU+3gXlhu6b6Dfo3pNg14nxSBEZZ4JI+o5cEIf4VFfhBmNmaNncf
9KEWMs0sBvx+fa/IDerjaglLmnfw0PjPajpAhvPamHho952hQyVAM9+0oTSK9+CY
1tlSoyRqHmI44SC1klztG7ran6kFVcWgccoSceE6Q0Cm1tOYDQOv1L70FC8H2cnL
HKbRlKnaO7las0exG4vdy+oA6E/2fmXJM595ivMNGcbaKKwdWxgWKUs1yd8uTWtd
Q+PX69bS3uXV/gp5eInZ
=ovMv
-----END PGP SIGNATURE-----

--+qWNqCDaOkLiPcHd--
