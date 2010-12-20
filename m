From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
Date: Mon, 20 Dec 2010 11:27:29 +0100
Message-ID: <AANLkTims4Hfzyh-MpTZKpwROwAH5DCGo2FQBJd9DKcQt@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56240 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0LTK1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:27:30 -0500
Received: by qwa26 with SMTP id 26so2627752qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:27:29 -0800 (PST)
In-Reply-To: <1292712817-24999-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Nishant,

Here are minor remarks about comments formatting.

On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> Erratum id: i608
> RTA (Retention Till Access) feature is not supported and leads to dev=
ice
> stability issues when enabled. This impacts modules with embedded mem=
ories
> on OMAP3630
>
> Workaround is to disable RTA on boot and coming out of core off.
> For disabling rta coming out of off mode, we do this by overriding th=
e
Use caps for RTA

> restore pointer for 3630 to allow us restore handler as the first poi=
nt of
This is not clear, maybe 'to allow us to restore handler' needs to be r=
emoved.

> entry before caches are touched and is common for GP and HS devices.
> to disable earlier than this could be possible by modifying the ppa f=
or HS
Same here, it looks like the original sentence has been cut in pieces.
Use caps for PPA.

> devices, but not for GP devices.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> [ambresh@ti.com: co-developer]
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Otherwise:
Acked-by: Jean Pihet <j-pihet@ti.com>

> ---
> v4:
> =A0 =A0 =A0 =A0control register handling moved to control.c
> =A0 =A0 =A0 =A0errata handling framework introduction split out
> =A0 =A0 =A0 =A0into a separate patch
> v3: http://marc.info/?t=3D129140247800026&r=3D1&w=3D2
> =A0 =A0 =A0 =A0additional comment to explain Ambresh's contrib
> =A0 =A0 =A0 =A0removed the redundant check for cpu_is34xx - it is alr=
eady
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0done by pm_init
> =A0 =A0 =A0 =A0pm_errata_configure is __init
> v2: https://patchwork.kernel.org/patch/365242/
> =A0 =A0 =A0 =A0fixed missing b restore for 3430 es3.1 code.
> =A0 =A0 =A0 =A0introduced erratum handling logic here splitting it ou=
t of uart errata
> =A0 =A0 =A0 =A0typo fixes for erratum
> v1: http://marc.info/?l=3Dlinux-omap&m=3D129013172825240&w=3D2
>
> =A0arch/arm/mach-omap2/control.c =A0 | =A0 13 ++++++++++++-
> =A0arch/arm/mach-omap2/control.h =A0 | =A0 =A07 ++++++-
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 10 ++++++++++
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 26 +++++++++++++++++++++++++=
+
> =A05 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/cont=
rol.c
> index 1fa3294..27ed558 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -241,7 +241,10 @@ void omap3_save_scratchpad_contents(void)
>
> =A0 =A0 =A0 =A0/* Populate the Scratchpad contents */
> =A0 =A0 =A0 =A0scratchpad_contents.boot_config_ptr =3D 0x0;
> - =A0 =A0 =A0 if (omap_rev() !=3D OMAP3430_REV_ES3_0 &&
> + =A0 =A0 =A0 if (cpu_is_omap3630())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scratchpad_contents.public_restore_ptr =
=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(get_omap36=
30_restore_pointer());
> + =A0 =A0 =A0 else if (omap_rev() !=3D OMAP3430_REV_ES3_0 &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0omap_rev() !=3D OMAP3430_REV_ES3_1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratchpad_contents.public_restore_ptr=
 =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0virt_to_phys(get_resto=
re_pointer());
> @@ -474,4 +477,12 @@ void omap3_control_restore_context(void)
> =A0 =A0 =A0 =A0omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL=
_CSI);
> =A0 =A0 =A0 =A0return;
> =A0}
> +
> +void omap3630_ctrl_disable_rta(void)
> +{
> + =A0 =A0 =A0 if (!cpu_is_omap3630())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 omap_ctrl_writel(OMAP36XX_RTA_DISABLE, OMAP36XX_CONTROL=
_MEM_RTA_CTRL);
> +}
> +
> =A0#endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/cont=
rol.h
> index b6c6b7c..ec98dd7 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -204,6 +204,10 @@
> =A0#define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WK=
UP + 0x014)
> =A0#define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WK=
UP + 0x018)
>
> +/* 36xx-only RTA - Retention till Accesss control registers and bits=
 */
> +#define OMAP36XX_CONTROL_MEM_RTA_CTRL =A00x40C
> +#define OMAP36XX_RTA_DISABLE =A0 =A0 =A0 =A0 =A0 0x0
> +
> =A0/* 34xx D2D idle-related pins, handled by PM core */
> =A0#define OMAP3_PADCONF_SAD2D_MSTANDBY =A0 0x250
> =A0#define OMAP3_PADCONF_SAD2D_IDLEACK =A0 =A00x254
> @@ -347,10 +351,11 @@ extern void omap3_save_scratchpad_contents(void=
);
> =A0extern void omap3_clear_scratchpad_contents(void);
> =A0extern u32 *get_restore_pointer(void);
> =A0extern u32 *get_es3_restore_pointer(void);
> +extern u32 *get_omap3630_restore_pointer(void);
> =A0extern u32 omap3_arm_context[128];
> =A0extern void omap3_control_save_context(void);
> =A0extern void omap3_control_restore_context(void);
> -
> +extern void omap3630_ctrl_disable_rta(void);
> =A0#else
> =A0#define omap_ctrl_base_get() =A0 =A0 =A0 =A0 =A0 0
> =A0#define omap_ctrl_readb(x) =A0 =A0 =A0 =A0 =A0 =A0 0
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 0348fd7..8d9aa3e 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -85,6 +85,8 @@ extern unsigned int save_secure_ram_context_sz;
> =A0extern unsigned int omap24xx_cpu_suspend_sz;
> =A0extern unsigned int omap34xx_cpu_suspend_sz;
>
> +#define PM_RTA_ERRATUM_i608 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +
> =A0#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
> =A0extern u16 pm34xx_errata;
> =A0#define IS_PM34XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A0(pm34xx_errata & =
(id))
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 5702f41..b32a2ed 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1007,6 +1007,8 @@ void omap_push_sram_idle(void)
>
> =A0static void __init pm_errata_configure(void)
> =A0{
> + =A0 =A0 =A0 if (cpu_is_omap3630())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm34xx_errata |=3D PM_RTA_ERRATUM_i608;
> =A0}
>
> =A0static int __init omap3_pm_init(void)
> @@ -1067,6 +1069,14 @@ static int __init omap3_pm_init(void)
> =A0 =A0 =A0 =A0pm_idle =3D omap3_pm_idle;
> =A0 =A0 =A0 =A0omap3_idle_init();
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* RTA is disabled during initialization as per errat=
um i608
> + =A0 =A0 =A0 =A0* it is safer to disable rta by the bootloader, but =
we would like
Use caps for RTA

> + =A0 =A0 =A0 =A0* to be doubly sure here and prevent any mishaps.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (IS_PM34XX_ERRATUM(PM_RTA_ERRATUM_i608))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3630_ctrl_disable_rta();
> +
> =A0 =A0 =A0 =A0clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
> =A0 =A0 =A0 =A0if (omap_type() !=3D OMAP2_DEVICE_TYPE_GP) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_secure_ram_storage =3D
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index 3fbd1e5..cc3507b 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -45,6 +45,8 @@
> =A0#define CM_IDLEST_CKGEN_V =A0 =A0 =A0OMAP34XX_CM_REGADDR(PLL_MOD, =
CM_IDLEST)
> =A0#define SRAM_BASE_P =A0 =A0 =A0 =A0 =A0 =A00x40200000
> =A0#define CONTROL_STAT =A0 =A0 =A0 =A0 =A0 0x480022F0
> +#define CONTROL_MEM_RTA_CTRL =A0 (OMAP343X_CTRL_BASE\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 + OMAP36XX_CONTROL_MEM_RTA_CTRL)
> =A0#define SCRATCHPAD_MEM_OFFS =A0 =A00x310 /* Move this as correct p=
lace is
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 * available */
> =A0#define SCRATCHPAD_BASE_P =A0 =A0 =A0(OMAP343X_CTRL_BASE + OMAP343=
X_CONTROL_MEM_WKUP\
> @@ -99,6 +101,14 @@ ENTRY(get_restore_pointer)
> =A0 =A0 =A0 =A0 ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and return
> =A0ENTRY(get_restore_pointer_sz)
> =A0 =A0 =A0 =A0 .word =A0 . - get_restore_pointer
> + =A0 =A0 =A0 .text
> +/* Function call to get the restore pointer for 3630 resume from OFF=
 */
> +ENTRY(get_omap3630_restore_pointer)
> + =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on stac=
k
> + =A0 =A0 =A0 adr =A0 =A0 r0, restore_3630
> + =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and retur=
n
> +ENTRY(get_omap3630_restore_pointer_sz)
> + =A0 =A0 =A0 =A0.word =A0 . - get_omap3630_restore_pointer
>
> =A0 =A0 =A0 =A0.text
> =A0/* Function call to get the restore pointer for for ES3 to resume =
from OFF */
> @@ -246,6 +256,20 @@ copy_to_sram:
> =A0 =A0 =A0 =A0bne =A0 =A0 copy_to_sram
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, sram_base
> =A0 =A0 =A0 =A0blx =A0 =A0 r1
> + =A0 =A0 =A0 b =A0 =A0 =A0 restore
> +
> +restore_3630:
> + =A0 =A0 =A0 /*b restore_es3630*/ =A0 =A0 =A0 =A0 =A0 =A0@ Enable to=
 debug restore code
> + =A0 =A0 =A0 ldr =A0 =A0 r1, pm_prepwstst_core_p
> + =A0 =A0 =A0 ldr =A0 =A0 r2, [r1]
> + =A0 =A0 =A0 and =A0 =A0 r2, r2, #0x3
> + =A0 =A0 =A0 cmp =A0 =A0 r2, #0x0 =A0 =A0 =A0 =A0@ Check if previous=
 power state of CORE is OFF
> + =A0 =A0 =A0 bne =A0 =A0 restore
> + =A0 =A0 =A0 /* Disable rta before giving control */
Use caps for RTA

> + =A0 =A0 =A0 ldr =A0 =A0 r1, control_mem_rta
> + =A0 =A0 =A0 mov =A0 =A0 r2, #OMAP36XX_RTA_DISABLE
> + =A0 =A0 =A0 str =A0 =A0 r2, [r1]
> + =A0 =A0 =A0 /* Fall thru for the remaining logic */
> =A0restore:
> =A0 =A0 =A0 =A0/* b restore*/ =A0@ Enable to debug restore code
> =A0 =A0 =A0 =A0 /* Check what was the reason for mpu reset and store =
the reason in r9*/
> @@ -650,6 +674,8 @@ cache_pred_disable_mask:
> =A0 =A0 =A0 =A0.word =A0 0xFFFFE7FB
> =A0control_stat:
> =A0 =A0 =A0 =A0.word =A0 CONTROL_STAT
> +control_mem_rta:
> + =A0 =A0 =A0 .word =A0 CONTROL_MEM_RTA_CTRL
> =A0kernel_flush:
> =A0 =A0 =A0 =A0.word v7_flush_dcache_all
> =A0 =A0 =A0 =A0/* these 2 words need to be at the end !!! */
> --
> 1.6.3.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
