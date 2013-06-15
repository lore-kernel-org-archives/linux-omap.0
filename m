From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/8] ARM: OMAP2+: hwmod: Remove remaining DMA channel
 definitions
Date: Sat, 15 Jun 2013 18:06:50 +0300
Message-ID: <20130615150650.GB27629@arwen.pp.htv.fi>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
 <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50203 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab3FOPIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Jun 2013 11:08:41 -0400
Content-Disposition: inline
In-Reply-To: <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2013 at 11:31:04AM +0300, Jarkko Nikula wrote:
> Last remaining DMA channel definitions in arch/arm/mach-omap2/dma.h
> are used only by omap_hwmod_2xxx_3xxx_ipblock_data.c and
> omap_hwmod_3xxx_data.c. Remove them by using directly DMA channel number =
in
> hwmod data and drop definitions with a following script:
>=20
> egrep '#define [OMAP|AM35XX].*DMA' arch/arm/mach-omap2/dma.h | cut -f 1,3=
 \
> 	| while read i; do \
> 		DEF=3D`echo $i |cut -d ' ' -f 2`; \
> 		CH=3D`echo $i |cut -d ' ' -f 3`; \
> 		echo "removing" $DEF; \
> 		sed -i "s/${DEF}/${CH}/" arch/arm/mach-omap2/omap_hwmod_*.c; \
> 		sed -i "/${DEF}/d" arch/arm/mach-omap2/dma.h; \
> 	done
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/dma.h                          |   19 --------------=
-----
>  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   20 ++++++++++----=
------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   18 +++++++++-----=
----
>  3 files changed, 19 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/dma.h b/arch/arm/mach-omap2/dma.h
> index 8a71c7b..aa735a4 100644
> --- a/arch/arm/mach-omap2/dma.h
> +++ b/arch/arm/mach-omap2/dma.h
> @@ -21,27 +21,8 @@
> =20
> =20
>  /* DMA channels for 24xx */

could remove the comments too.

--=20
balbi

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvIMKAAoJEIaOsuA1yqREZBwP/34z4hM0tcaO3xj5mS3rLxG0
L0DBQmy89OEKexwkg59+oi71GF/uxfRXzkT4DJS3QLAcvD4sdw20VvvuxH4pAnyJ
zM1GX4RHVnXjGkk296V0VMsyZX4RjJEb8pdxhcBT3+EfECfsVozOUkVEFIdUIzOt
Kl8Lj2n7STdGDYcgSpfJSqZxRmkTbCT5ZcAnLOdb8KGEY7CFcbagChjOpS/1nUdv
N/RBn5u4/o0aGkb2CQc5GLq0ewLG42xoYHEhvedSWxDb67dvV0J1csB5R0h6xqyJ
Ikk2xStWo07LUL8T3PjreDEE9pxgGwYFEodYcGtih+c/jtfCc90vCNIHir8XpE5n
aw1GgtKy2bWpop04pzyTbThQw0wx/ghbJ8DqdN8lAP1Dr8ejf70rN6lyCwsXReb4
nYOXeXAoy6dZUsqcz5cfv2jbshPb2Xh6SSNI2vob9qVS2qAvC4+gtYJMF6NSX9d4
bXsBeAKjR4+rHJkVpY04cR89FsyIWXku9YBwh7lHaCwATe59jBXq+HLNl6P+Fc19
ts/JTheBs4UXpfIV/oWtjkkOLw+doNcGRmv5VIduCbfOKARUDYJ34fHDCvOSCvFu
0QCPIE3JyEw422Z/NSMZI2MriHScAurs5PhmevU2AqDLs9ihkkeWux9hoPmrMEbo
ChSxeS/BP1ICHJnbMl4X
=lJfd
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
