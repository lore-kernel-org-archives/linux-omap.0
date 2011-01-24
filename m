From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Mon, 24 Jan 2011 16:11:30 +0000
Message-ID: <AANLkTinT8YZn3igYBqSdOZURzof3d_hX_QwRccPe=7Vi@mail.gmail.com>
References: <1295352126-29171-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65378 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1AXQLx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 11:11:53 -0500
Received: by ewy5 with SMTP id 5so1923277ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 08:11:31 -0800 (PST)
In-Reply-To: <1295352126-29171-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi there, I just spotted a couple of things merging your patch...

On Tue, Jan 18, 2011 at 12:02 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> The new fncpy API is better suited for copying some
> code to SRAM at runtime. This patch changes the ad-hoc
> code to the more generic fncpy API.
>
> Tested OK on OMAP3 in low power modes (RET/OFF)
> using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.
> Compile tested on OMAP1/2 using omap1_defconfig.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/mach-omap1/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 ++=
+---
> =A0arch/arm/mach-omap1/sleep.S =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +++
> =A0arch/arm/mach-omap1/sram.S =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/sleep24xx.S =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/arm/mach-omap2/sleep34xx.S =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/arm/mach-omap2/sram242x.S =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0arch/arm/mach-omap2/sram243x.S =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0arch/arm/mach-omap2/sram34xx.S =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/plat-omap/include/plat/sram.h | =A0 14 +++++++++++++-
> =A0arch/arm/plat-omap/sram.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 ++++=
+++++-----
> =A011 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/pm.h b/arch/arm/mach-omap1/pm.h
> index 56a6479..cd926dc 100644
> --- a/arch/arm/mach-omap1/pm.h
> +++ b/arch/arm/mach-omap1/pm.h
> @@ -123,9 +123,9 @@ extern void allow_idle_sleep(void);
> =A0extern void omap1_pm_idle(void);
> =A0extern void omap1_pm_suspend(void);
>
> -extern void omap7xx_cpu_suspend(unsigned short, unsigned short);
> -extern void omap1510_cpu_suspend(unsigned short, unsigned short);
> -extern void omap1610_cpu_suspend(unsigned short, unsigned short);
> +extern void omap7xx_cpu_suspend(unsigned long, unsigned long);
> +extern void omap1510_cpu_suspend(unsigned long, unsigned long);
> +extern void omap1610_cpu_suspend(unsigned long, unsigned long);
> =A0extern void omap7xx_idle_loop_suspend(void);
> =A0extern void omap1510_idle_loop_suspend(void);
> =A0extern void omap1610_idle_loop_suspend(void);
> diff --git a/arch/arm/mach-omap1/sleep.S b/arch/arm/mach-omap1/sleep.=
S
> index ef771ce..c875bdc 100644
> --- a/arch/arm/mach-omap1/sleep.S
> +++ b/arch/arm/mach-omap1/sleep.S
> @@ -58,6 +58,7 @@
> =A0*/
>
> =A0#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap7xx_cpu_suspend)
>
> =A0 =A0 =A0 =A0@ save registers on stack
> @@ -137,6 +138,7 @@ ENTRY(omap7xx_cpu_suspend_sz)
> =A0#endif /* CONFIG_ARCH_OMAP730 || CONFIG_ARCH_OMAP850 */
>
> =A0#ifdef CONFIG_ARCH_OMAP15XX
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap1510_cpu_suspend)
>
> =A0 =A0 =A0 =A0@ save registers on stack
> @@ -211,6 +213,7 @@ ENTRY(omap1510_cpu_suspend_sz)
> =A0#endif /* CONFIG_ARCH_OMAP15XX */
>
> =A0#if defined(CONFIG_ARCH_OMAP16XX)
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap1610_cpu_suspend)
>
> =A0 =A0 =A0 =A0@ save registers on stack
> diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
> index 7724e52..692587d 100644
> --- a/arch/arm/mach-omap1/sram.S
> +++ b/arch/arm/mach-omap1/sram.S
> @@ -18,6 +18,7 @@
> =A0/*
> =A0* Reprograms ULPD and CKCTL.
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap1_sram_reprogram_clock)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0 - r12, lr} =A0 =A0 =A0 =A0 =A0 =A0 =
@ save registers on stack
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 1c1b0ab..39580e6 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -92,7 +92,7 @@ extern void omap24xx_idle_loop_suspend(void);
> =A0extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_=
dlla_ctrl,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0void __iomem *sdrc_power);
> =A0extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
> -extern void save_secure_ram_context(u32 *addr);
> +extern int save_secure_ram_context(u32 *addr);
> =A0extern void omap3_save_scratchpad_contents(void);
>
> =A0extern unsigned int omap24xx_idle_loop_suspend_sz;
> diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sl=
eep24xx.S
> index c7780cc..b5071a4 100644
> --- a/arch/arm/mach-omap2/sleep24xx.S
> +++ b/arch/arm/mach-omap2/sleep24xx.S
> @@ -47,6 +47,7 @@
> =A0* Note: This code get's copied to internal SRAM at boot. When the =
OMAP
> =A0* =A0 =A0 =A0wakes up it continues execution at the point it went =
to sleep.
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap24xx_idle_loop_suspend)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0, lr} =A0 =A0 =A0 =A0 =A0 @ save reg=
isters on stack
> =A0 =A0 =A0 =A0mov =A0 =A0 r0, #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ clear for mcr setup
> @@ -82,6 +83,7 @@ ENTRY(omap24xx_idle_loop_suspend_sz)
> =A0* The DLL load value is not kept in RETENTION or OFF. It needs to =
be restored
> =A0* at wake
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap24xx_cpu_suspend)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0 - r12, lr} =A0 =A0 @ save registers=
 on stack
> =A0 =A0 =A0 =A0mov =A0 =A0 r3, #0x0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
clear for mcr call
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index 98d8232..951a0be 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -118,6 +118,7 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
>
> =A0 =A0 =A0 =A0.text
> =A0/* Function to call rom code to save secure ram context */
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(save_secure_ram_context)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r1-r12, lr} =A0 =A0 =A0 @ save registe=
rs on stack
> =A0 =A0 =A0 =A0adr =A0 =A0 r3, api_params =A0 =A0 =A0 =A0 =A0@ r3 poi=
nts to parameters
> @@ -169,6 +170,7 @@ ENTRY(save_secure_ram_context_sz)
> =A0* =A0 depending on the low power mode (non-OFF vs OFF modes),
> =A0* =A0 cf. 'Resume path for xxx mode' comments.
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap34xx_cpu_suspend)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 @ save registe=
rs on stack
>
> diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sra=
m242x.S
> index 055310c..ff9b9db 100644
> --- a/arch/arm/mach-omap2/sram242x.S
> +++ b/arch/arm/mach-omap2/sram242x.S
> @@ -39,6 +39,7 @@
>
> =A0 =A0 =A0 =A0.text
>
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap242x_sram_ddr_init)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0 - r12, lr} =A0 =A0 @ save registers=
 on stack
>
> @@ -143,6 +144,7 @@ ENTRY(omap242x_sram_ddr_init_sz)
> =A0* r0 =3D [PRCM_FULL | PRCM_HALF] r1 =3D SDRC_DLLA_CTRL value r2 =3D=
 [DDR | SDR]
> =A0* PRCM_FULL =3D 2, PRCM_HALF =3D 1, DDR =3D 1, SDR =3D 0
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap242x_sram_reprogram_sdrc)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0 - r10, lr} =A0 =A0 @ save registers=
 on stack
> =A0 =A0 =A0 =A0mov =A0 =A0 r3, #0x0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
clear for mrc call
> @@ -238,6 +240,7 @@ ENTRY(omap242x_sram_reprogram_sdrc_sz)
> =A0/*
> =A0* Set dividers and pll. Also recalculate DLL value for DDR and unl=
ock mode.
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap242x_sram_set_prcm)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 @ regs to stac=
k
> =A0 =A0 =A0 =A0adr =A0 =A0 r4, pbegin =A0 =A0 =A0 =A0 =A0 =A0 =A0@ ad=
dr of preload start
> diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sra=
m243x.S
> index f900758..7673020 100644
> --- a/arch/arm/mach-omap2/sram243x.S
> +++ b/arch/arm/mach-omap2/sram243x.S
> @@ -39,6 +39,7 @@
>
> =A0 =A0 =A0 =A0.text
>
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap243x_sram_ddr_init)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0 - r12, lr} =A0 =A0 @ save registers=
 on stack
>
> @@ -143,6 +144,7 @@ ENTRY(omap243x_sram_ddr_init_sz)
> =A0* r0 =3D [PRCM_FULL | PRCM_HALF] r1 =3D SDRC_DLLA_CTRL value r2 =3D=
 [DDR | SDR]
> =A0* PRCM_FULL =3D 2, PRCM_HALF =3D 1, DDR =3D 1, SDR =3D 0
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap243x_sram_reprogram_sdrc)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0 - r10, lr} =A0 =A0 @ save registers=
 on stack
> =A0 =A0 =A0 =A0mov =A0 =A0 r3, #0x0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
clear for mrc call
> @@ -238,6 +240,7 @@ ENTRY(omap243x_sram_reprogram_sdrc_sz)
> =A0/*
> =A0* Set dividers and pll. Also recalculate DLL value for DDR and unl=
ock mode.
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap243x_sram_set_prcm)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 @ regs to stac=
k
> =A0 =A0 =A0 =A0adr =A0 =A0 r4, pbegin =A0 =A0 =A0 =A0 =A0 =A0 =A0@ ad=
dr of preload start
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sra=
m34xx.S
> index 7f893a2..25011ca 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -111,6 +111,7 @@
> =A0* since it will cause the ARM MMU to attempt to walk the page tabl=
es.
> =A0* These crashes may be intermittent.
> =A0*/
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(omap3_sram_configure_core_dpll)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r1-r12, lr} =A0 =A0 =A0 @ store regs t=
o stack
>
> diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-o=
map/include/plat/sram.h
> index 9967d5e..d673f2c 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -12,7 +12,19 @@
> =A0#define __ARCH_ARM_OMAP_SRAM_H
>
> =A0#ifndef __ASSEMBLY__
> -extern void * omap_sram_push(void * start, unsigned long size);
> +#include <asm/fncpy.h>
> +
> +extern void *omap_sram_push_address(unsigned long size);
> +
> +/* Macro to push a function to the internal SRAM, using the fncpy AP=
I */
> +#define omap_sram_push(funcp, size) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 typeof(&funcp) _res =3D NULL; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \

1) For fncpy() itself, I decided not to take the address of funcp
inside the macro: the reason for this was that if you do this, the
macro will silently do something silly if called with a function
pointer instead of the function itself -- i.e., some memory starting
at the stored function pointer itself will be copied instead of the
function body.

=46orcing the caller to supply the '&' is a bit ugly, but I decided it
was preferable from a safety standpoint.

This doesn't necessarily mean that omap_sram_push can't add the '&',
but if you do, you need to be careful how the macro is called.  It
will work for all existing uses of omap_sram_push, IIUC.

2) Should this be &(funcp)?  This will only matter for pretty weird
uses though.  Currently most weird uses won't work properly anyway,
because of (1).  So this might not be much of a concern.

> + =A0 =A0 =A0 void *_sram_address =3D omap_sram_push_address(size); =A0=
 =A0 \
> + =A0 =A0 =A0 if (_sram_address) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _res =3D fncpy(_sram_address, &funcp, s=
ize); =A0 =A0 =A0\

&(funcp)

(see (2))

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
