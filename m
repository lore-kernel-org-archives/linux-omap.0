From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick strategy
Date: Mon, 20 Dec 2010 11:23:27 +0100
Message-ID: <AANLkTi=4DJAnXcTZ37rcmr9Kz2CmXx6uhPqNThnoR2gu@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53598 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084Ab0LTKXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:23:34 -0500
Received: by qyj19 with SMTP id 19so3806289qyj.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:23:33 -0800 (PST)
In-Reply-To: <1292712817-24999-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>
> Erratum i581 impacts OMAP3 platforms.
> PRCM DPLL control FSM removes SDRC_IDLEREQ before DPLL3 locks causing
> the DPLL not to be locked at times.
>
> IMPORTANT:
> *) This is not a complete workaround implementation as recommended
> by the silicon erratum. this is a support logic for detecting lockups=
 and
> attempting to recover where possible and is known to provide stabilit=
y
> in multiple platforms.
> *) This code is mostly important for inactive and retention. The ROM =
code
> waits for the maximum dll lock time when resuming from off mode. So f=
or
> off mode this code isn't really needed.
>
> This should eventually get refactored as part of cleanups to sleep34x=
x.S
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
> (no change done, posting for completeness of the series)
> v2: https://patchwork.kernel.org/patch/365252/
> =A0 =A0 =A0 =A0typo correction- erratum, support, added comment from =
Peter from the
> =A0 =A0 =A0 =A0thread to commit message
> v1: http://marc.info/?l=3Dlinux-omap&m=3D129013172525234&w=3D2
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 52 +++++++++++++++++++++++++=
++++++++++---
> =A01 files changed, 47 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index 2c20fcf..3fbd1e5 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -42,6 +42,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP34=
30_PM_PREPWSTST)
> =A0#define PM_PWSTCTRL_MPU_P =A0 =A0 =A0OMAP3430_PRM_BASE + MPU_MOD +=
 OMAP2_PM_PWSTCTRL
> =A0#define CM_IDLEST1_CORE_V =A0 =A0 =A0OMAP34XX_CM_REGADDR(CORE_MOD,=
 CM_IDLEST1)
> +#define CM_IDLEST_CKGEN_V =A0 =A0 =A0OMAP34XX_CM_REGADDR(PLL_MOD, CM=
_IDLEST)
> =A0#define SRAM_BASE_P =A0 =A0 =A0 =A0 =A0 =A00x40200000
> =A0#define CONTROL_STAT =A0 =A0 =A0 =A0 =A0 0x480022F0
> =A0#define SCRATCHPAD_MEM_OFFS =A0 =A00x310 /* Move this as correct p=
lace is
> @@ -554,31 +555,67 @@ skip_l2_inval:
>
> =A0/* Make sure SDRC accesses are ok */
> =A0wait_sdrc_ok:
> +
> +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensu=
res this. */
> + =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest_ckgen
> +wait_dpll3_lock:
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> + =A0 =A0 =A0 tst =A0 =A0 r5, #1
> + =A0 =A0 =A0 beq =A0 =A0 wait_dpll3_lock
> +
> =A0 =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest1_core
> +wait_sdrc_ready:
> =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> - =A0 =A0 =A0 =A0and =A0 =A0 r5, r5, #0x2
> - =A0 =A0 =A0 =A0cmp =A0 =A0 r5, #0
> - =A0 =A0 =A0 =A0bne =A0 =A0 wait_sdrc_ok
> + =A0 =A0 =A0 =A0tst =A0 =A0 r5, #0x2
> + =A0 =A0 =A0 =A0bne =A0 =A0 wait_sdrc_ready
> + =A0 =A0 =A0 /* allow DLL powerdown upon hw idle req */
> =A0 =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_power
> =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> =A0 =A0 =A0 =A0 bic =A0 =A0 r5, r5, #0x40
> =A0 =A0 =A0 =A0 str =A0 =A0 r5, [r4]
> -wait_dll_lock:
> +is_dll_in_lock_mode:
> +
> =A0 =A0 =A0 =A0 /* Is dll in lock mode? */
> =A0 =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
> =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> =A0 =A0 =A0 =A0 tst =A0 =A0 r5, #0x4
> =A0 =A0 =A0 =A0 bxne =A0 =A0lr
> =A0 =A0 =A0 =A0 /* wait till dll locks */
> - =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_dlla_status
> +wait_dll_lock_timed:
> + =A0 =A0 =A0 ldr =A0 =A0 r4, wait_dll_lock_counter
> + =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
> + =A0 =A0 =A0 str =A0 =A0 r4, wait_dll_lock_counter
> + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_status
> + =A0 =A0 =A0 =A0mov =A0 =A0r6, #8 =A0 =A0 =A0 =A0 =A0/* Wait 20uS fo=
r lock */
> +wait_dll_lock:
> + =A0 =A0 =A0 subs =A0 =A0r6, r6, #0x1
> + =A0 =A0 =A0 beq =A0 =A0 kick_dll

It would be good to have more comments on the code flow here:
- what are wait_dll_lock_counter and kick_counter used for?
- what is the timing based on? Why 20uS for the wait time?
- jumping back and forth to kick_dll and wait_dll_lock_timed is confusi=
ng.

> =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> =A0 =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x4
> =A0 =A0 =A0 =A0 cmp =A0 =A0 r5, #0x4
> =A0 =A0 =A0 =A0 bne =A0 =A0 wait_dll_lock
> =A0 =A0 =A0 =A0 bx =A0 =A0 =A0lr
>
> + =A0 =A0 =A0 /* disable/reenable DLL if not locked */
> +kick_dll:
> + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> + =A0 =A0 =A0 mov =A0 =A0 r6, r5
> + =A0 =A0 =A0 bic =A0 =A0 r6, #(1<<3) =A0 =A0 /* disable dll */
> + =A0 =A0 =A0 str =A0 =A0 r6, [r4]
> + =A0 =A0 =A0 dsb
> + =A0 =A0 =A0 orr =A0 =A0 r6, r6, #(1<<3) /* enable dll */
> + =A0 =A0 =A0 str =A0 =A0 r6, [r4]
> + =A0 =A0 =A0 dsb
> + =A0 =A0 =A0 ldr =A0 =A0 r4, kick_counter
> + =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
> + =A0 =A0 =A0 str =A0 =A0 r4, kick_counter
> + =A0 =A0 =A0 b =A0 =A0 =A0 wait_dll_lock_timed
> +
> =A0cm_idlest1_core:
> =A0 =A0 =A0 =A0.word =A0 CM_IDLEST1_CORE_V
> +cm_idlest_ckgen:
> + =A0 =A0 =A0 .word =A0 CM_IDLEST_CKGEN_V
> =A0sdrc_dlla_status:
> =A0 =A0 =A0 =A0.word =A0 SDRC_DLLA_STATUS_V
> =A0sdrc_dlla_ctrl:
> @@ -615,5 +652,10 @@ control_stat:
> =A0 =A0 =A0 =A0.word =A0 CONTROL_STAT
> =A0kernel_flush:
> =A0 =A0 =A0 =A0.word v7_flush_dcache_all
> + =A0 =A0 =A0 /* these 2 words need to be at the end !!! */
> +kick_counter:
> + =A0 =A0 =A0 .word =A0 0
> +wait_dll_lock_counter:
> + =A0 =A0 =A0 .word =A0 0
Why do they need to be at the end? Also, at the end of what do they nee=
d to be?

> =A0ENTRY(omap34xx_cpu_suspend_sz)
> =A0 =A0 =A0 =A0.word =A0 . - omap34xx_cpu_suspend
> --
> 1.6.3.3
>
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
