From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v5 4/5] ARM: omap3: Thumb-2 compatibility for sram34xx.S
Date: Mon, 21 Feb 2011 09:35:41 +0100
Message-ID: <AANLkTinW8NL6FxDJtm7Bd5zurFCurQp9XWuKQvNGRjne@mail.gmail.com>
References: <1297946558-13436-1-git-send-email-dave.martin@linaro.org>
	<1297946558-13436-5-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46501 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab1BUIfm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 03:35:42 -0500
Received: by qyk7 with SMTP id 7so1759730qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 00:35:41 -0800 (PST)
In-Reply-To: <1297946558-13436-5-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, patches@linaro.org

On Thu, Feb 17, 2011 at 1:42 PM, Dave Martin <dave.martin@linaro.org> w=
rote:
> =A0* Build unconditionally as ARM for correct interoperation with
> =A0 OMAP firmware.
>
> =A0* Remove deprecated PC-relative stores
>
> =A0* Add the required ENDPROC() directive for each ENTRY().
>
> =A0* .align before data words
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> =A0arch/arm/mach-omap2/sram34xx.S | =A0 36 ++++++++++++++++++++++++++=
++--------
> =A01 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sra=
m34xx.S
> index 7f893a2..fd1531c 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -34,6 +34,12 @@
> =A0#include "sdrc.h"
> =A0#include "cm2xxx_3xxx.h"
>
> +/*
> + * This file needs be built unconditionally as ARM to interoperate c=
orrectly
> + * with non-Thumb-2-capable firmware.
> + */
> + =A0 =A0 =A0 .arm
> +
> =A0 =A0 =A0 =A0.text
>
> =A0/* r1 parameters */
> @@ -116,24 +122,36 @@ ENTRY(omap3_sram_configure_core_dpll)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0@ pull the extra args off the stack
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0@ =A0and store them in SRAM
> +
> +/*
> + * PC-relative stores are deprecated in ARMv7 and lead to undefined =
behaviour
> + * in Thumb-2: use a r7 as a base instead.
> + * Be careful not to clobber r7 when maintaing this file.
Sorry I forgot about this minor typo: 'maintaining'

Jean

> + */
> + THUMB( =A0 =A0 =A0 =A0adr =A0 =A0 r7, omap3_sram_configure_core_dpl=
l =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0)
> + =A0 =A0 =A0 .macro strtext Rt:req, label:req
> + ARM( =A0str =A0 =A0 \Rt, \label =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 )
> + THUMB( =A0 =A0 =A0 =A0str =A0 =A0 \Rt, [r7, \label - omap3_sram_con=
figure_core_dpll] =A0 =A0 =A0)
> + =A0 =A0 =A0 .endm
> +
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #52]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_rfr_ctrl_0_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_rfr_ctrl_0_val
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #56]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_actim_ctrl_a_0_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_actim_ctrl_a_0_val
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #60]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_actim_ctrl_b_0_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_actim_ctrl_b_0_val
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #64]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_mr_0_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_mr_0_val
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #68]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_rfr_ctrl_1_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_rfr_ctrl_1_val
> =A0 =A0 =A0 =A0cmp =A0 =A0 r4, #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ if SDRC_RFR_CTRL_1 is 0,
> =A0 =A0 =A0 =A0beq =A0 =A0 skip_cs1_params =A0 =A0 =A0 =A0 @ =A0do no=
t use cs1 params
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #72]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_actim_ctrl_a_1_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_actim_ctrl_a_1_val
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #76]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_actim_ctrl_b_1_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_actim_ctrl_b_1_val
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [sp, #80]
> - =A0 =A0 =A0 str =A0 =A0 r4, omap_sdrc_mr_1_val
> + =A0 =A0 =A0 strtext r4, omap_sdrc_mr_1_val
> =A0skip_cs1_params:
> =A0 =A0 =A0 =A0mrc =A0 =A0 p15, 0, r8, c1, c0, 0 =A0 @ read ctrl regi=
ster
> =A0 =A0 =A0 =A0bic =A0 =A0 r10, r8, #0x800 =A0 =A0 =A0 =A0 @ clear Z-=
bit, disable branch prediction
> @@ -271,6 +289,7 @@ skip_cs1_prog:
> =A0 =A0 =A0 =A0ldr =A0 =A0 r12, [r11] =A0 =A0 =A0 =A0 =A0 =A0 =A0@ po=
sted-write barrier for SDRC
> =A0 =A0 =A0 =A0bx =A0 =A0 =A0lr
>
> + =A0 =A0 =A0 .align
> =A0omap3_sdrc_power:
> =A0 =A0 =A0 =A0.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> =A0omap3_cm_clksel1_pll:
> @@ -319,6 +338,7 @@ omap3_sdrc_dlla_ctrl:
> =A0 =A0 =A0 =A0.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
> =A0core_m2_mask_val:
> =A0 =A0 =A0 =A0.word 0x07FFFFFF
> +ENDPROC(omap3_sram_configure_core_dpll)
>
> =A0ENTRY(omap3_sram_configure_core_dpll_sz)
> =A0 =A0 =A0 =A0.word =A0 . - omap3_sram_configure_core_dpll
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
