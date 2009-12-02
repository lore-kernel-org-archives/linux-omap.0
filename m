From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] OMAP3: SDRC: Comment out SDRC AC timing and MR changes
 in CORE DVFS SRAM code
Date: Wed, 02 Dec 2009 08:12:34 +0200
Message-ID: <4B160552.6050108@ti.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com> <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com> <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com> <1F18D6510CF0474A8C9500565A7E41A2236DA1C1F3@NOK-EUMSG-02.mgdnok.nokia.com> <alpine.DEB.2.00.0912011832290.13408@utopia.booyaka.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64408 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbZLBGMe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 01:12:34 -0500
Received: by ewy19 with SMTP id 19so5766001ewy.21
        for <linux-omap@vger.kernel.org>; Tue, 01 Dec 2009 22:12:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912011832290.13408@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tero.Kristo@nokia.com, r-woodruff2@ti.com, b-cousson@ti.com, rnayak@ti.com, c-sucur@ti.com

Paul Walmsley said the following on 12/02/2009 03:33 AM:
> The code that reprograms the SDRC memory controller during CORE DVFS,
> mach-omap2/sram34xx.S:omap3_sram_configure_core_dpll(), does not
> ensure that all L3 initiators are prevented from accessing the SDRAM
> before modifying the SDRC AC timing and MR registers.  This can cause
> memory to be corrupted or cause the SDRC to enter an unpredictable
> state.  This patch comments out that code for now and adds a note
> explaining what is going on.  Ideally it can be added back in once
> supporting code is present to ensure that other initiators aren't
> touching the SDRAM.  At the very least, these registers should be
> reprogrammable during kernel init to deal with buggy bootloaders.
>
> This is a modification of a patch originally written by Rajendra Naya=
k
> <rnayak@ti.com> (the original is at http://patchwork.kernel.org/patch=
/51927/).
> Rather than removing the code completely, this patch just comments it=
 out.
>  =20
why not make this a #ifdef instead if we need it some other time, a #if
0 and it's intention might not be readable without doing a git annotate
in a few months time..
> Thanks to Beno=EEt Cousson <b-cousson@ti.com> and Christophe Sucur
> <c-sucur@ti.com> for explaining the technical basis for this and for
> explaining what can be done to make this path work in future code.
> Thanks to Richard Woodruff <r-woodruff2@ti.com> for his comments.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Christophe Sucur <c-sucur@ti.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> ---
>  arch/arm/mach-omap2/sram34xx.S |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sra=
m34xx.S
> index 82aa4a3..8fa8955 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -91,8 +91,18 @@
>   *  new SDRC_ACTIM_CTRL_B_1 register contents
>   *  new SDRC_MR_1 register value
>   *
> - * If the param SDRC_RFR_CTRL_1 is 0, the parameters
> - *  are not programmed into the SDRC CS1 registers
> + * If the param SDRC_RFR_CTRL_1 is 0, the parameters are not program=
med into
> + * the SDRC CS1 registers
> + *
> + * NOTE: This code no longer attempts to program the SDRC AC timing =
and MR
> + * registers.  This is because the code currently cannot ensure that=
 all
> + * L3 initiators (e.g., sDMA, IVA, DSS DISPC, etc.) are not accessin=
g the
> + * SDRAM when the registers are written.  If the registers are chang=
ed while
> + * an initiator is accessing SDRAM, memory can be corrupted and/or t=
he SDRC
> + * may enter an unpredictable state.  The code to reprogram the regi=
sters,
> + * however, has been left in -- commented out in "#if 0" .. "#endif"=
 blocks --
> + * since in the future, the intent is to re-enable this code in case=
s where we
> + * can ensure that no initiators are touching the SDRAM.
>   */
>  ENTRY(omap3_sram_configure_core_dpll)
>  	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
> @@ -219,6 +229,7 @@ configure_sdrc:
>  	ldr	r12, omap_sdrc_rfr_ctrl_0_val	@ fetch value from SRAM
>  	ldr	r11, omap3_sdrc_rfr_ctrl_0	@ fetch addr from SRAM
>  	str	r12, [r11]			@ store
> +#if 0
>  	ldr	r12, omap_sdrc_actim_ctrl_a_0_val
>  	ldr	r11, omap3_sdrc_actim_ctrl_a_0
>  	str	r12, [r11]
> @@ -228,11 +239,13 @@ configure_sdrc:
>  	ldr	r12, omap_sdrc_mr_0_val
>  	ldr	r11, omap3_sdrc_mr_0
>  	str	r12, [r11]
> +#endif
>  	ldr	r12, omap_sdrc_rfr_ctrl_1_val
>  	cmp	r12, #0			@ if SDRC_RFR_CTRL_1 is 0,
>  	beq	skip_cs1_prog		@  do not program cs1 params
>  	ldr	r11, omap3_sdrc_rfr_ctrl_1
>  	str	r12, [r11]
> +#if 0
>  	ldr	r12, omap_sdrc_actim_ctrl_a_1_val
>  	ldr	r11, omap3_sdrc_actim_ctrl_a_1
>  	str	r12, [r11]
> @@ -242,6 +255,7 @@ configure_sdrc:
>  	ldr	r12, omap_sdrc_mr_1_val
>  	ldr	r11, omap3_sdrc_mr_1
>  	str	r12, [r11]
> +#endif
>  skip_cs1_prog:
>  	ldr	r12, [r11]		@ posted-write barrier for SDRC
>  	bx	lr
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
