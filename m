From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PRCM: 34XX: Fixes to ssi clock handling
Date: Mon, 14 Apr 2008 11:09:32 -0700
Message-ID: <20080414180932.GH26832@atomide.com>
References: <1208178371-18752-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50189 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbYDNSJe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 14:09:34 -0400
Content-Disposition: inline
In-Reply-To: <1208178371-18752-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni H=F6gander <jouni.hogander@nokia.com> [080414 06:23]:
> ssi_l4_ick should have PARENT_CONTROLS_CLOCK flag.
> ST_SSI_STDBY bit in idlest register cannot be used in  omap2_clk_wait=
_ready

Pushing today.

Tony

> Signed-off-by: Jouni H=F6gander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/clock.c     |    4 +++-
>  arch/arm/mach-omap2/clock34xx.h |    3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.=
c
> index dead756..e7e8576 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -212,7 +212,9 @@ static void omap2_clk_wait_ready(struct clk *clk,=
 int enable)
>  	/* REVISIT: What are the appropriate exclusions for 34XX? */
>  	/* OMAP3: ignore DSS-mod clocks */
>  	if (cpu_is_omap34xx() &&
> -	    (((u32)reg & ~0xff) =3D=3D (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MO=
D, 0)))
> +	    (((u32)reg & ~0xff) =3D=3D (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MO=
D, 0) ||
> +	     ((((u32)reg & ~0xff) =3D=3D (u32)OMAP_CM_REGADDR(CORE_MOD, 0))=
 &&
> +	     clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)))
>  		return;
> =20
>  	bit =3D 1 << clk->enable_bit;
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cl=
ock34xx.h
> index fc03999..9ca2cdf 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -1917,7 +1917,8 @@ static struct clk omapctrl_ick =3D {
>  static struct clk ssi_l4_ick =3D {
>  	.name		=3D "ssi_l4_ick",
>  	.parent		=3D &l4_ick,
> -	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES,
> +	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
> +				PARENT_CONTROLS_CLOCK,
>  	.recalc		=3D &followparent_recalc,
>  };
> =20
> --=20
> 1.5.3.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
