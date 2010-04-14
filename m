From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCHV3] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
	in SDRC after a Warm-reset
Date: Wed, 14 Apr 2010 12:33:20 +0300
Message-ID: <v2y6ed0b2681004140233v303a1906v5d4e670e8c795271@mail.gmail.com>
References: <1271162228-21260-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:44525 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab0DNJdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 05:33:22 -0400
Received: by ewy20 with SMTP id 20so2996412ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 14 Apr 2010 02:33:20 -0700 (PDT)
In-Reply-To: <1271162228-21260-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Teerth Reddy <teerth@ti.com>

On Tue, Apr 13, 2010 at 3:37 PM, Vishwanath BS <vishwanath.bs@ti.com> w=
rote:
> From: Teerth Reddy <teerth@ti.com>
>
> This patch has the workaround for errata 1.176.
> In some cases, user is not able to access DDR memory after
> warm-reset.This situation occurs while the warm-reset
> happens during a read access to DDR memory. In that
> particular conditions, DDR memory does not respond to a
> corrupted read command due to the warm reset occurence but
> SDRC is waiting for read completion.SDRC is not sensitive to
> the warm reset, but the interconect is reset on the fly,
> thus causing a misalignment between SDRC logic, interconect
> logic and DDR memory state.
>
> Root cause description: A corrupted read transaction is
> issued to a closed row: (address0, bank0) instead of the
> expected read access, violating protocol.
>
> Failure signature: Once the failure occurs and system has
> restarted, memory content is not accessible.SDRC registers
> can be accessed successfully, until 1st access to memory
> location is performed. After 1st access to memory is done,
> SDRC is stuck.
>
> WORKAROUND
> Steps to perform before a SW reset is trigged, if user needs
> to generate a SW reset and keep DDR memory content:
> 1. Enable self-refresh on idle request
> 2. Put SDRC in idle
> 3. Wait until SDRC goes to idle
> 4. Generate SW reset
>
> Steps to perform after warm reset occurs:
> If HW warm reset is the source, apply below steps before
> any accesses to SDRAM:
> 1. Reset SMS and SDRC
> 2. Re-initialize SMS, SDRC and memory
>
> This would need the u-boot/x-loader workaround changes
> as well for the reboot to work correctly.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---

<snip>

> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sra=
m34xx.S
> index de99ba2..1a1be4d
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -33,6 +33,8 @@
>
> =A0#include "sdrc.h"
> =A0#include "cm.h"
> +#include "prcm-common.h"
> +#include "prm.h"
>
> =A0 =A0 =A0 =A0.text
>
> @@ -68,6 +70,9 @@
> =A0/* CM_CLKSEL1_PLL bit settings */
> =A0#define CORE_DPLL_CLKOUT_DIV_SHIFT =A0 =A0 0x1b
>
> +/* PRM_RSTCTRL bit setting */
> +#define EN_DPLL3_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4
> +
> =A0/*
> =A0* omap3_sram_configure_core_dpll - change DPLL3 M2 divider
> =A0*
> @@ -313,3 +318,49 @@ core_m2_mask_val:
> =A0ENTRY(omap3_sram_configure_core_dpll_sz)
> =A0 =A0 =A0 =A0.word =A0 . - omap3_sram_configure_core_dpll
>
> +
> +/*
> +* omap3_sram_configure_core_dpll_warmreset
> +* Enable SDRC self refresh on idle request, put SDRC in idle,
> +* wait until SDRC goes to idle
> +* Enable DPLL3 reset bit in RM_RSTCTRL
> +*/
> +
> +ENTRY(omap3_sram_configure_core_dpll_warmreset)

don't you need to stack some registers here? r9, r11 and lr are callee-=
saved.

> +
> + =A0 =A0 =A0 bl =A0 =A0 =A0sdram_in_selfrefresh1
> + =A0 =A0 =A0 ldr =A0 =A0 r11, omap3_reset_cntrl
> + =A0 =A0 =A0 ldr =A0 =A0 r12, [r11]
> + =A0 =A0 =A0 orr =A0 =A0 r12, r12, #EN_DPLL3_RESET =A0 =A0 =A0 @ Ena=
ble DPLL3 reset bit
> + =A0 =A0 =A0 str =A0 =A0 r12, [r11]
> +
> +sdram_in_selfrefresh1:
> + =A0 =A0 =A0 ldr =A0 =A0 r11, omap3_sdrc_power1 =A0@ read the SDRC_P=
OWER register
> + =A0 =A0 =A0 ldr =A0 =A0 r12, [r11] =A0 =A0 =A0 =A0 =A0 =A0 =A0@ rea=
d the contents of SDRC_POWER
> + =A0 =A0 =A0 mov =A0 =A0 r9, r12 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ k=
eep a copy of SDRC_POWER bits

where is this used?

> + =A0 =A0 =A0 orr =A0 =A0 r12, r12, #SRFRONIDLEREQ_MASK =A0 @ enable =
self refresh on idle
> + =A0 =A0 =A0 str =A0 =A0 r12, [r11] =A0 =A0 =A0 =A0 =A0 =A0 =A0@ wri=
te back to SDRC_POWER register
> + =A0 =A0 =A0 ldr =A0 =A0 r12, [r11] =A0 =A0 =A0 =A0 =A0 =A0 =A0@ pos=
ted-write barrier for SDRC
> + =A0 =A0 =A0 ldr =A0 =A0 r11, omap3_cm_iclken1_core1 =A0 =A0 @ read =
the CM_ICLKEN1_CORE reg
> + =A0 =A0 =A0 ldr =A0 =A0 r12, [r11]
> + =A0 =A0 =A0 bic =A0 =A0 r12, r12, #EN_SDRC_MASK =A0 =A0 =A0 =A0 @ d=
isable iclk bit for SDRC
> + =A0 =A0 =A0 str =A0 =A0 r12, [r11]
> +wait_sdrc_idle2:
> + =A0 =A0 =A0 ldr =A0 =A0 r11, omap3_cm_idlest1_core1
> + =A0 =A0 =A0 ldr =A0 =A0 r12, [r11]
> + =A0 =A0 =A0 and =A0 =A0 r12, r12, #ST_SDRC_MASK =A0 =A0 =A0 =A0 @ c=
heck for SDRC idle
> + =A0 =A0 =A0 cmp =A0 =A0 r12, #ST_SDRC_MASK
> + =A0 =A0 =A0 bne =A0 =A0 wait_sdrc_idle2
> + =A0 =A0 =A0 bx =A0 =A0 =A0lr

Are you positive this code actually works? To me it looks like it
could deadlock.

> +
> +omap3_reset_cntrl:
> + =A0 =A0 =A0 .word OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, OMAP2_RM_RS=
TCTRL)
> +omap3_sdrc_power1:
> + =A0 =A0 =A0 .word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> +omap3_cm_idlest1_core1:
> + =A0 =A0 =A0 .word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
> +omap3_cm_iclken1_core1:
> + =A0 =A0 =A0 .word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
> +
> +ENTRY(omap3_sram_configure_core_dpll_warmreset_sz)
> + =A0 =A0 =A0 .word =A0 . - omap3_sram_configure_core_dpll_warmreset

<snip>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
