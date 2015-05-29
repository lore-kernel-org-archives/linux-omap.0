From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Add dm816x USB PHY as a
 loadable module
Date: Fri, 29 May 2015 12:20:04 -0500
Message-ID: <20150529171927.GJ2026@saruman.tx.rr.com>
References: <1432919532-20445-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbbE2RWf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 13:22:35 -0400
Content-Disposition: inline
In-Reply-To: <1432919532-20445-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>

--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 10:12:12AM -0700, Tony Lindgren wrote:
> This is needed for USB on dm816x-evm.
>=20
> Cc: Bin Liu <binmlist@gmail.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: George Cherian <george.cherian@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

it's a module, fine by me:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> index 4380291..92e4206 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -402,6 +402,7 @@ CONFIG_PWM_TIECAP=3Dm
>  CONFIG_PWM_TIEHRPWM=3Dm
>  CONFIG_PWM_TWL=3Dm
>  CONFIG_PWM_TWL_LED=3Dm
> +CONFIG_PHY_DM816X_USB=3Dm
>  CONFIG_OMAP_USB2=3Dm
>  CONFIG_TI_PIPE3=3Dy
>  CONFIG_TWL4030_USB=3Dm
> --=20
> 2.1.4
>=20

--=20
balbi

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaJ/DAAoJEIaOsuA1yqREk+8P/jMuYCbuV+/teHW2q2LJIN7e
be/MTrK14xxkFMYJPkMZtDpTkAkETD1x6vnupGnYiPhFOnixDV0hv0A5T2b1JMKn
+LO3dC6/2cHy+D3/uZgOCdJ+ppNvVW1DnhFnilkgI4EK18OJ6PxZYKHI9o0ujC4J
zWopdWXeZSsAAASxHKcl02KBiPTOTPaxlZPRZTPhyIutNVoQDttBqKecBsAxjJLy
512KDypc4oPUOYvZ1I/FsGax+i5XD4zUksJ4rFikt3tbSX6lKtMh/TItEpiBpuem
puslQuHc8YHpk6KrqaTkuhnnOldUxBxpYXIURfLM3UoQi7jD6zvjEsZmYR9QXrUq
twZBPIPzXuPW8LvPxqmWiGJXrjG5+eB4UmfJGp/F4GR25PQPnSK7oxgqxo+5pee2
dM8XGFAmv0Fx0MIrAMa5oJr1wPoteWRBFbF1Yy4hbkOYGs0n+laSVNnGivxZP9C6
SsZIHIUG78q7+AebVVQ1os6Vhx0synHVJS1Wk/xB6OQH5lzE+0xLMFoWc1d/Awkk
MWuU4idSfBHdT5Yfbzc46VSKLpGn4LrlbGBa8pD7M5Rkc+cgbBBKUTe1zI5+u8K9
jb00jFp6+QopEjUh2aOOYYG45zPIp9eAOUej/3D6rN+PwSPLeR7EM5144HLAYGVX
BmVkFl/nUsBEifGZEL35
=cqGY
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--
