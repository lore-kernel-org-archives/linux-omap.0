From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: Re: [PATCH 02/13] OMAP3: PM: Errata i581 suppport: dll kick strategy
Date: Wed, 24 Nov 2010 22:21:50 +0530
Message-ID: <AANLkTi=cb1LDS0nJr+gS47qc2qpw_kRz8+ZxV_x2gSJ0@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:39541 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753697Ab0KXQvx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 11:51:53 -0500
Received: by mail-fx0-f51.google.com with SMTP id 10so2443115fxm.38
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 08:51:52 -0800 (PST)
In-Reply-To: <1290131698-6194-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>

Nishant,

On Fri, Nov 19, 2010 at 7:24 AM, Nishanth Menon <nm@ti.com> wrote:
> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>
> Errata i581 impacts OMAP3 platforms.
> PRCM DPLL control FSM removes SDRC_IDLEREQ before DPLL3 locks causing
> the DPLL not to be locked at times.
>
> IMPORTANT: this is not a complete workaround implementation as recomm=
ended
> by the silicon errata. this is a support logic for detecting lockups =
and
> attempting to recover where possible and is known to provide stabilit=
y
> in multiple platforms.

How does this WA work when Core enters off mode? SRAM contents are
lost when Core enters off. So how this code is copied to SRAM upon
wakeup? Where is this code placed when Core entered off mode?

Vishwa
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 52 +++++++++++++++++++++++++=
++++++++++---
> =A01 files changed, 47 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index 8f207b2..5a4468f 100644
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
> =A0ENTRY(omap34xx_cpu_suspend_sz)
> =A0 =A0 =A0 =A0.word =A0 . - omap34xx_cpu_suspend
> --
> 1.6.3.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
