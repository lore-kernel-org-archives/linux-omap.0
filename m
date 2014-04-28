From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5 on all OMAP3 platforms
Date: Mon, 28 Apr 2014 16:11:44 +0200
Message-ID: <2880107.LhfF5Zj821@avalon>
References: <1398085583-9615-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33474 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318AbaD1OLi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 10:11:38 -0400
In-Reply-To: <1398085583-9615-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Ping ?

On Monday 21 April 2014 15:06:23 Laurent Pinchart wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>=20
> Commit 7b2e1277598e4187c9be3e61fd9b0f0423f97986 ("ARM: OMAP3: clock:
> Back-propagate rate change from cam_mclk to dpll4_m5") enabled clock
> rate back-propagation from cam_mclk do dpll4_m5 on OMAP3630 only.
> Perform back-propagation on other OMAP3 platforms as well.
>=20
> Reported-by: Jean-Philippe Fran=E7ois <jp.francois@cynove.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/mach-omap2/cclock3xxx_data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c
> b/arch/arm/mach-omap2/cclock3xxx_data.c index 8f5121b..eb8c75e 100644
> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> @@ -456,7 +456,8 @@ static struct clk_hw_omap dpll4_m5x2_ck_hw =3D {
>  	.clkdm_name	=3D "dpll4_clkdm",
>  };
>=20
> -DEFINE_STRUCT_CLK(dpll4_m5x2_ck, dpll4_m5x2_ck_parent_names,
> dpll4_m5x2_ck_ops); +DEFINE_STRUCT_CLK_FLAGS(dpll4_m5x2_ck,
> dpll4_m5x2_ck_parent_names, +			dpll4_m5x2_ck_ops,=20
CLK_SET_RATE_PARENT);
>=20
>  static struct clk dpll4_m5x2_ck_3630 =3D {
>  	.name		=3D "dpll4_m5x2_ck",

--=20
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
