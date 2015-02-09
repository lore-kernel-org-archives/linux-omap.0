From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: dra7xx: hwmod: drop .modulemode from pcie1/2 hwmods
Date: Mon, 9 Feb 2015 14:20:49 +0530
Message-ID: <54D874E9.1040302@ti.com>
References: <1422978684-4826-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760291AbbBIIvT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Feb 2015 03:51:19 -0500
In-Reply-To: <1422978684-4826-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Hi,

On Tuesday 03 February 2015 09:21 PM, grygorii.strashko@linaro.org wrot=
e:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>=20
> Now DRA7xx pcie1/2 hwmods define PRCM configuration as following:
>   .clkctrl_offs =3D DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
>   .rstctrl_offs =3D DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
>   .modulemode   =3D MODULEMODE_SWCTRL,
> which is completely wrong because DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET
> is clockdomain ctrl register and NOT module ctrl register.
> And they have diffrent allowed values for bits[0,1]:
> CLKTRCTRL=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89MODULEMODE=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89
> 0x0:=E2=80=89NO_SLEEP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=890x0=
:=E2=80=89Module=E2=80=89is=E2=80=89disabled=E2=80=89by=E2=80=89SW.=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89
> 0x1:=E2=80=89SW_SLEEP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=890x1=
:=E2=80=89Module=E2=80=89is=E2=80=89managed=E2=80=89automatically=E2=80=
=89by=E2=80=89HW=E2=80=89=E2=80=89
> 0x2:=E2=80=89SW_WKUP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=890x2:=E2=80=89Module=E2=80=89is=E2=80=89explicitly=E2=80=89enabled.=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89
> 0x3:=E2=80=89HW_AUTO=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=890x3:=E2=80=89Reserved=E2=80=89=E2=80=89
>=20
> As result, following message can be seen during suspend:
>   "omap_hwmod: pcie1: _wait_target_disable failed"
>=20
> Fix it by removing .modulemode from pcie1/2 hwmods and, in that
> way, prevent clockdomain ctrl register writing from HWMOD core.

Looks correct except for one change.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
>=20
> More over, it looks like pcie1/2 hwmods are fake and have to be dropp=
ed at all.
> The real HWMODs are PCIESS1/2.

Not sure I get this. You mean "dra7xx_pcie1_hwmod" should be replaced w=
ith
"dra7xx_pciess1_hwmod"? Or you mean an entire new hwmod is missing?

Please note we still have to enable the clock domain and main clock. We=
've also
purposefully omitted sysconfig from hwmod data since pcie reset
(RM_PCIESS_RSTCTRL) should be done before accessing the syconfig regist=
er and
the infrastructure for that is currently not present.

> Unfortunatelly, not all information on PCIE is public, so
> I could be wrong here.
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mac=
h-omap2/omap_hwmod_7xx_data.c
> index ffd6604..a428b2d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1478,7 +1478,6 @@ static struct omap_hwmod dra7xx_pcie1_hwmod =3D=
 {
>  	.prcm =3D {
>  		.omap4 =3D {
>  			.clkctrl_offs	=3D DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
> -			.modulemode	=3D MODULEMODE_SWCTRL,

I think the entire .prcm can be removed here.
>  		},
>  	},
>  };
> @@ -1492,7 +1491,6 @@ static struct omap_hwmod dra7xx_pcie2_hwmod =3D=
 {
>  	.prcm =3D {
>  		.omap4 =3D {
>  			.clkctrl_offs =3D DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
> -			.modulemode   =3D MODULEMODE_SWCTRL,
>  		},
>  	},
>  };
>=20

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
