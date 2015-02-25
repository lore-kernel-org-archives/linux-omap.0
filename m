From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 04/35] ARM: OMAP3+: PRM: add common APIs for
 prm_vp_check/clear_txdone
Date: Wed, 25 Feb 2015 13:09:30 -0600
Message-ID: <20150225190930.GN11136@saruman.tx.rr.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
 <1424891085-10392-5-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K4LMwn8CgX2KMboP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51492 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753339AbbBYTKR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:10:17 -0500
Content-Disposition: inline
In-Reply-To: <1424891085-10392-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 25, 2015 at 09:04:14PM +0200, Tero Kristo wrote:
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_c=
ommon.c
> index 2c2e7ed..79cee11 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -555,6 +555,40 @@ int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32=
 wkst_mask)
>  }
> =20
>  /**
> + * omap_prm_vp_check_txdone - check voltage processor TX done status
> + *
> + * Checks if voltage processor transmission has been completed.
> + * Returns non-zero if a transmission has completed, 0 otherwise.
> + */
> +u32 omap_prm_vp_check_txdone(u8 vp_id)
> +{
> +	if (!prm_ll_data->vp_check_txdone) {
> +		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
> +			  __func__);

same here:

	if (WARN_ONCE(!prm_ll_data->vp_check_txdone,
		"prm: %s: no mapping function defined\n", __func__))

same for all others below

--=20
balbi

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7h3qAAoJEIaOsuA1yqRE038QAKdcFYDA1bPtdVnVIYJzDClF
E7P5dFfYvImw04gZ3Ui+wLgm4ZwRzRSlgDImIkeyrbG1wsHuqvcYIl/lxHsbpAWW
Q5LRquZ5Xruu3V0NftaDIH1/fG1L3n1IDcAyAz1h/8I673nMLjEY1rrWfIF9peO9
oUgG9PGld5wWrfiZHeoREXO2HXmXqNIF78zzbBGC0vRO+DNvydfmFSDNTyrkYOGm
PTL+EugXBup3x+SrNxTK+FoC6NC9nrvVmKqDo94lRAbIEqkiVE06yZMDx9q1EOor
ghDklIIepEr1wGqQQT0NtHY8tnsdnTKE4vqh8z9MG9xjh3PENryRFFRwcmYNe/yd
0PCO2SIWNxHZD3ZGSBSeiuUFs/iOa+Hxg818DJQhVHtl/CW6lf98NWe4X/ug6bDp
YMwf4ZVTMu8wv0B1s2k80jEsjg1OgPJKKr5KBgOrR+fxMNl+9hvIqE7fN+AGcNbs
WivROgbtYo9gz8Y+IMRrCG/s4J8jl8cgfgmEeKZKPjNFqB4a46e+Px4XwPM8dxrV
qxvGVY0JiqffsJEblIkbk4q/a2QYWUansrugm4eT3xwfQ9iwan3ulri8xL1wqUHJ
jqhTW+lgi2b69UAjB5LHJnDNV6vjOmpGJmxMoAGtEitVfYo/uY9uaYneB7xUimXS
5sd9t4ZXbO0s7Sg7Tm4p
=b42e
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--
