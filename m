From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH v2] OMAP3 clock: fix omap2_clk_wait_ready for OMAP3430ES2 DSS
Date: Mon, 23 Jun 2008 09:16:49 +0300
Message-ID: <874p7kad66.fsf@trdhcp146196.ntc.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com>
	<485CA347.909@googlemail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB022BB66209@dbde02.ent.ti.com>
	<alpine.DEB.1.00.0806211054100.19765@utopia.booyaka.com>
	<ACAEC52B-E9B4-4789-8D63-114C53846760@student.utwente.nl>
	<13B9B4C6EF24D648824FF11BE8967162035BA2A659@dlee02.ent.ti.com>
	<alpine.DEB.1.00.0806221308090.7503@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36851 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYFWGR5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 02:17:57 -0400
In-Reply-To: <alpine.DEB.1.00.0806221308090.7503@utopia.booyaka.com> (ext Paul
	Walmsley's message of "Sun, 22 Jun 2008 13:09:33 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dirk Behme <dirk.behme@googlemail.com>

Hello Paul,

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hi everyone,
>
> The previous version of this patch tried to wait for the SSI module
> on OMAP3; this is now fixed; also, added some code cleanup. =20

It should actually wait for SSI also. Read my comments below.

>
> - Paul
>
> ----
>
> On OMAP3430ES2, DSS has both an initiator standby CM_IDLEST bit, and =
a
> target idle CM_IDLEST bit.  This is a departure from previous silicon=
,
> which only had an initiator standby bit.
>
> This means we need to test the target idle bit after enabling
> dss1_alwon_fclk.  Previous clock code has done the wrong thing since =
ES2
> came out: it's either tested the wrong bit, causing
>
>     Clock dss1_alwon_fck failed to enable in 100000 tries
>
> messages, or not tested anything at all, causing crashes during DISPC
> initialization with:
>
>     Unhandled fault: external abort on non-linefetch (0x1028)
>
> This patch modifies omap2_clk_wait_ready() to wait for the DSS to bec=
ome
> accessible after dss1_alwon_fclk, dss_l3_iclk, and dss_l4_iclk are en=
abled.
> It also does some cleanup by getting rid of some casts.
>
> Thanks to:
> . Anand Gadiyar <gadiyar@ti.com> for identifying one of the problem p=
atches,
> . Koen Kooi <k.kooi@student.utwente.nl> for testing the previous vers=
ion of
>   this patch,
> . Dirk Behme <dirk.behme@googlemail.com> for review of the previous v=
ersion,
> . Igor Stoppa <igor.stoppa@nokia.com> and Richard Woodruff
>   <r-woodruff2@ti.com> for help with the SSI portion of the patch.
>
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>
>  arch/arm/mach-omap2/clock.c           |   63 +++++++++++++++++++++++=
++--------
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++
>  2 files changed, 50 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.=
c
> index ed15868..4d76ea5 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -222,20 +222,22 @@ int omap2_wait_clock_ready(void __iomem *reg, u=
32 mask, const char *name)
>   */
>  static void omap2_clk_wait_ready(struct clk *clk)
>  {
> -	u32 bit, reg, other_reg, st_reg;
> +	u32 bit;
> +	unsigned long reg, other_reg, st_reg, prcm_mod, prcm_regid;
> =20
> -	reg =3D (__force u32)clk->enable_reg;
> -	if (((reg & 0xff) >=3D CM_FCLKEN1) &&
> -	    ((reg & 0xff) <=3D OMAP24XX_CM_FCLKEN2))
> +	reg =3D (unsigned long)clk->enable_reg;
> +	prcm_mod =3D reg & ~0xff;
> +	prcm_regid =3D reg & 0xff;
> +
> +	if (prcm_regid >=3D CM_FCLKEN1 && prcm_regid <=3D OMAP24XX_CM_FCLKE=
N2)
>  		other_reg =3D ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> -	else if (((reg & 0xff) >=3D CM_ICLKEN1) &&
> -		 ((reg & 0xff) <=3D OMAP24XX_CM_ICLKEN4))
> +	else if (prcm_regid >=3D CM_ICLKEN1 && prcm_regid <=3D OMAP24XX_CM_=
ICLKEN4)
>  		other_reg =3D ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
>  	else
>  		return;
> =20
> -	/* REVISIT: What are the appropriate exclusions for 34XX? */
> -	/* No check for DSS or cam clocks */
> +	/* No check for DSS or CAM clocks on 24xx */
> +	/* REVISIT: This should check prcm_mod against CORE_MOD */
>  	if (cpu_is_omap24xx() && (reg & 0x0f) =3D=3D 0) { /* CM_{F,I}CLKEN1=
 */
>  		if (clk->enable_bit =3D=3D OMAP24XX_EN_DSS2_SHIFT ||
>  		    clk->enable_bit =3D=3D OMAP24XX_EN_DSS1_SHIFT ||
> @@ -244,21 +246,50 @@ static void omap2_clk_wait_ready(struct clk *cl=
k)
>  	}
> =20
>  	/* REVISIT: What are the appropriate exclusions for 34XX? */
> -	/* OMAP3: ignore DSS-mod clocks */
> -	if (cpu_is_omap34xx() &&
> -	    ((reg & ~0xff) =3D=3D (__force u32)OMAP34XX_CM_REGADDR(OMAP3430=
_DSS_MOD, 0) ||
> -	     (((reg & ~0xff) =3D=3D (__force u32)OMAP34XX_CM_REGADDR(CORE_M=
OD, 0)) &&
> -	      clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)))
> -		return;
> +	if (cpu_is_omap34xx()) {
> +
> +		/* 3430ES1 DSS has no target idlest bits */
> +		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0) &&
> +		    (prcm_mod =3D=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> +		     (prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
> +		      clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)))
> +			return;
> +
> +		/*=20
> +		 * For 3430ES2 DSS, wait once (dss1_alwon_fclk,=20
> +		 * dss_l3_iclk, dss_l4_iclk) are enabled
> +		 */
> +		if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0) &&
> +		    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
> +		    clk->enable_bit !=3D OMAP3430_EN_DSS1_SHIFT)
> +			return;

Remove from this point

> +		/* SSI has no target idlest bit on OMAP3 */
> +		if (prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
> +		    clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)
> +			return;
> +

to this point

> +	}
> =20
>  	/* Check if both functional and interface clocks
>  	 * are running. */
>  	bit =3D 1 << clk->enable_bit;
> -	if (!(__raw_readl((__force void __iomem *)other_reg) & bit))
> +	if (!(__raw_readl((void __iomem *)other_reg) & bit))
>  		return;
> +
> +	/*
> +	 * OMAP3430ES2 DSS target idlest bit is at a different shift than
> +	 * the corresponding {I,F}CLKEN bits
> +	 */
> +	if (cpu_is_omap34xx() &&
> +	    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
> +	    clk->enable_bit =3D=3D OMAP3430_EN_DSS1_SHIFT) {
> +		bit =3D OMAP3430ES2_ST_DSS_IDLE;

And add this part

+       if (cpu_is_omap34xx() &&
+	    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
+	    clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT) {
+		bit =3D OMAP3430ES2_ST_SSI_IDLE;

> +	}
> +
>  	st_reg =3D ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
> =20
> -	omap2_wait_clock_ready((__force void __iomem *)st_reg, bit, clk->na=
me);
> +	omap2_wait_clock_ready((void __iomem *)st_reg, bit, clk->name);
>  }
> =20
>  /* Enables clock without considering parent dependencies or use coun=
t
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-om=
ap2/cm-regbits-34xx.h
> index 6ec66f4..946c552 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -500,7 +500,9 @@
>  #define OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT		0
> =20
>  /* CM_IDLEST_DSS */
> -#define OMAP3430_ST_DSS					(1 << 0)
> +#define OMAP3430ES2_ST_DSS_IDLE				(1 << 1)
> +#define OMAP3430ES2_ST_DSS_STDBY			(1 << 0)
> +#define OMAP3430ES1_ST_DSS				(1 << 0)
> =20
>  /* CM_AUTOIDLE_DSS */
>  #define OMAP3430_AUTO_DSS				(1 << 0)
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
