From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Thu, 27 Jan 2011 14:50:49 +0100
Message-ID: <AANLkTikY=YR8sLnuFcGWh2a0kRX0HyqZd_QWwq6HKxg4@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com>
	<AANLkTiniZuR9LFmJpo8WfmQN2D3zcB=jbfd-Nhv=Fbsr@mail.gmail.com>
	<e5e976880879f22d944bb8cf98cc3aa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49358 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab1A0Nuu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 08:50:50 -0500
Received: by qwa26 with SMTP id 26so2130968qwa.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 05:50:49 -0800 (PST)
In-Reply-To: <e5e976880879f22d944bb8cf98cc3aa9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

On Thu, Jan 27, 2011 at 11:13 AM, Vishwanath Sripathy
<vishwanath.bs@ti.com> wrote:
> Jean,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Jean Pihet
>> Sent: Monday, January 24, 2011 7:59 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Jean Pihet
>> Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>
>> On Thu, Jan 13, 2011 at 5:19 PM, =A0<jean.pihet@newoldbits.com> wrot=
e:
>> > From: Jean Pihet <j-pihet@ti.com>
>> >
>> > Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
>> > is copied to internal SRAM and run from there.
>> > However only a small part of the code really needs to run from
> internal
>> SRAM.
>> >
>> > This fix lets most of the ASM idle code run from the DDR
>> > in order to minimize the SRAM usage. No performance
>> > loss or gain can be measured with a 32KHz clock period.
>> >
>> > The only pieces of code that are mandatory in SRAM
>> > are:
>> > - the i443 erratum WA,
>> > - the i581 erratum WA,
>> > - the security extension code.
>> >
>> > SRAM usage:
>> > - original code:
>> > =A0. 560 bytes for omap3_sram_configure_core_dpll (used by DVFS),
>> > =A0. 1368 bytes for omap_sram_idle (used by suspend/resume in
>> RETention),
>> > =A0. 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mod=
e
>> on ES3.x),
>> > =A0. 108 bytes for save_secure_ram_context (used on HS parts).
>> >
>> > With this fix the usage for suspend/resume in RETention goes down
>> 312 bytes, so the
>> > gain in SRAM usage for suspend/resume is > 1KB.
>> >
>> > Tested on OMAP3EVM, Beagleboard (ES2.x) and N900 (ES3.1)
>> > in idle with full RET and OFF modes.
>> >
>> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>
>> Is there any feedback on this code?
>> This change would need some more testing on all OMAP3 platforms,
>> especially on the 36xx platforms that I do not have at hand.
> I tested this patch on ZOOM3 (OMAP3630) using kevin's PM branch for b=
oth
> retention and off in CPUIdle and suspend path and it seems to work fi=
ne.
> You can add
> Tested-by: Vishwanath BS <Vishwanath.bs@ti.com>
Thanks Vishwa!

Regards,
Jean

>
> Vishwa
>>
>> Comments are welcome!
>>
>> Regards,
>> Jean
>>
>> > ---
>> > =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0| =A0 19 ++-
>> > =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 19 ++-
>> > =A0arch/arm/mach-omap2/sleep34xx.S | =A0299
>> +++++++++++++++++++++++----------------
>> > =A03 files changed, 200 insertions(+), 137 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-
>> omap2/pm.h
>> > index 1c1b0ab..ae9dec0 100644
>> > --- a/arch/arm/mach-omap2/pm.h
>> > +++ b/arch/arm/mach-omap2/pm.h
>> > @@ -87,18 +87,29 @@ extern int pm_dbg_regset_init(int reg_set);
>> > =A0#define pm_dbg_regset_init(reg_set) do {} while (0);
>> > =A0#endif /* CONFIG_PM_DEBUG */
>> >
>> > +/* 24xx */
>> > =A0extern void omap24xx_idle_loop_suspend(void);
>> > +extern unsigned int omap24xx_idle_loop_suspend_sz;
>> >
>> > =A0extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem
>> *sdrc_dlla_ctrl,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0void __iomem *sdrc_power);
>> > +extern unsigned int omap24xx_cpu_suspend_sz;
>> > +
>> > +/* 3xxx */
>> > =A0extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
>> > +
>> > +/* omap3_do_wfi function pointer and size, for copy to SRAM */
>> > +extern void omap3_do_wfi(void);
>> > +extern unsigned int omap3_do_wfi_sz;
>> > +/* ... and its pointer from SRAM after copy */
>> > +extern void (*omap3_do_wfi_sram)(void);
>> > +
>> > +/* save_secure_ram_context function pointer and size, for copy to
>> SRAM */
>> > =A0extern void save_secure_ram_context(u32 *addr);
>> > -extern void omap3_save_scratchpad_contents(void);
>> >
>> > -extern unsigned int omap24xx_idle_loop_suspend_sz;
>> > =A0extern unsigned int save_secure_ram_context_sz;
>> > -extern unsigned int omap24xx_cpu_suspend_sz;
>> > -extern unsigned int omap34xx_cpu_suspend_sz;
>> > +
>> > +extern void omap3_save_scratchpad_contents(void);
>> >
>> > =A0#define PM_RTA_ERRATUM_i608 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> > =A0#define PM_SDRC_WAKEUP_ERRATUM_i583 =A0 =A0(1 << 1)
>> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
>> omap2/pm34xx.c
>> > index 5b323f2..56ca3cb 100644
>> > --- a/arch/arm/mach-omap2/pm34xx.c
>> > +++ b/arch/arm/mach-omap2/pm34xx.c
>> > @@ -82,9 +82,8 @@ struct power_state {
>> >
>> > =A0static LIST_HEAD(pwrst_list);
>> >
>> > -static void (*_omap_sram_idle)(u32 *addr, int save_state);
>> > -
>> > =A0static int (*_omap_save_secure_sram)(u32 *addr);
>> > +void (*omap3_do_wfi_sram)(void);
>> >
>> > =A0static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>> > =A0static struct powerdomain *core_pwrdm, *per_pwrdm;
>> > @@ -355,9 +354,6 @@ void omap_sram_idle(void)
>> > =A0 =A0 =A0 =A0int core_prev_state, per_prev_state;
>> > =A0 =A0 =A0 =A0u32 sdrc_pwr =3D 0;
>> >
>> > - =A0 =A0 =A0 if (!_omap_sram_idle)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > -
>> > =A0 =A0 =A0 =A0pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
>> > =A0 =A0 =A0 =A0pwrdm_clear_all_prev_pwrst(neon_pwrdm);
>> > =A0 =A0 =A0 =A0pwrdm_clear_all_prev_pwrst(core_pwrdm);
>> > @@ -439,7 +435,7 @@ void omap_sram_idle(void)
>> > =A0 =A0 =A0 =A0 * get saved. The restore path then reads from this
>> > =A0 =A0 =A0 =A0 * location and restores them back.
>> > =A0 =A0 =A0 =A0 */
>> > - =A0 =A0 =A0 _omap_sram_idle(omap3_arm_context, save_state);
>> > + =A0 =A0 =A0 omap34xx_cpu_suspend(omap3_arm_context, save_state);
>> > =A0 =A0 =A0 =A0cpu_init();
>> >
>> > =A0 =A0 =A0 =A0/* Restore normal SDRC POWER settings */
>> > @@ -996,10 +992,17 @@ static int __init clkdms_setup(struct
>> clockdomain *clkdm, void *unused)
>> > =A0 =A0 =A0 =A0return 0;
>> > =A0}
>> >
>> > +/*
>> > + * Push functions to SRAM
>> > + *
>> > + * The minimum set of functions is pushed to SRAM for execution:
>> > + * - omap3_do_wfi for erratum i581 WA,
>> > + * - save_secure_ram_context for security extensions.
>> > + */
>> > =A0void omap_push_sram_idle(void)
>> > =A0{
>> > - =A0 =A0 =A0 _omap_sram_idle =3D omap_sram_push(omap34xx_cpu_susp=
end,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 omap34xx_cpu_suspend_sz);
>> > + =A0 =A0 =A0 omap3_do_wfi_sram =3D omap_sram_push(omap3_do_wfi,
>> omap3_do_wfi_sz);
>> > +
>> > =A0 =A0 =A0 =A0if (omap_type() !=3D OMAP2_DEVICE_TYPE_GP)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_omap_save_secure_sram =3D
>> omap_sram_push(save_secure_ram_context,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sav=
e_secure_ram_context_sz);
>> > diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
>> omap2/sleep34xx.S
>> > index 98d8232..ced85b5 100644
>> > --- a/arch/arm/mach-omap2/sleep34xx.S
>> > +++ b/arch/arm/mach-omap2/sleep34xx.S
>> > @@ -163,8 +163,10 @@ ENTRY(save_secure_ram_context_sz)
>> > =A0*
>> > =A0*
>> > =A0* Notes:
>> > - * - this code gets copied to internal SRAM at boot and after wak=
e-up
>> > - * =A0 from OFF mode. The execution pointer in SRAM is
>> _omap_sram_idle.
>> > + * - only the minimum set of functions gets copied to internal SR=
AM
>> at boot
>> > + * =A0 and after wake-up from OFF mode, cf. omap_push_sram_idle.
>> The function
>> > + * =A0 pointers in SDRAM or SRAM are called depending on the desi=
red
>> low power
>> > + * =A0 target state.
>> > =A0* - when the OMAP wakes up it continues at different execution =
points
>> > =A0* =A0 depending on the low power mode (non-OFF vs OFF modes),
>> > =A0* =A0 cf. 'Resume path for xxx mode' comments.
>> > @@ -181,9 +183,15 @@ ENTRY(omap34xx_cpu_suspend)
>> > =A0 =A0 =A0 =A0 * =A0 3 - Both L1 and L2 lost
>> > =A0 =A0 =A0 =A0 */
>> >
>> > - =A0 =A0 =A0 /* Directly jump to WFI is the context save is not r=
equired */
>> > - =A0 =A0 =A0 cmp =A0 =A0 r1, #0x0
>> > - =A0 =A0 =A0 beq =A0 =A0 omap3_do_wfi
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* For OFF mode: save context and jump to WFI in S=
DRAM
>> (omap3_do_wfi)
>> > + =A0 =A0 =A0 =A0* For non-OFF modes: jump to the WFI code in SRAM
>> (omap3_do_wfi_sram)
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, omap3_do_wfi_sram_addr
>> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > + =A0 =A0 =A0 cmp =A0 =A0 r1, #0x0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ If no context save required,
>> > + =A0 =A0 =A0 bxeq =A0 =A0r5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0@ =A0jump to the WFI code in
> SRAM
>> > +
>> >
>> > =A0 =A0 =A0 =A0/* Otherwise fall through to the save context code =
*/
>> > =A0save_context_wfi:
>> > @@ -282,7 +290,31 @@ clean_l2:
>> > =A0 =A0 =A0 =A0mov =A0 =A0 lr, pc
>> > =A0 =A0 =A0 =A0bx =A0 =A0 =A0r1
>> >
>> > -omap3_do_wfi:
>> > + =A0 =A0 =A0 b =A0 =A0 =A0 omap3_do_wfi
>> > +
>> > +/*
>> > + * Local variables
>> > + */
>> > +omap3_do_wfi_sram_addr:
>> > + =A0 =A0 =A0 .word omap3_do_wfi_sram
>> > +kernel_flush:
>> > + =A0 =A0 =A0 .word v7_flush_dcache_all
>> > +
>> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > + * =3D=3D WFI instruction =3D> Enter idle =3D=3D
>> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > + */
>> > +
>> > +/*
>> > + * Do WFI instruction
>> > + * Includes the resume path for non-OFF modes
>> > + *
>> > + * This code gets copied to internal SRAM and is accessible
>> > + * from both SDRAM and SRAM:
>> > + * - executed from SRAM for non-off modes (omap3_do_wfi_sram),
>> > + * - executed from SDRAM for OFF mode (omap3_do_wfi).
>> > + */
>> > +ENTRY(omap3_do_wfi)
>> > =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ rea=
d the SDRC_POWER register
>> > =A0 =A0 =A0 =A0ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ read the contents of
> SDRC_POWER
>> > =A0 =A0 =A0 =A0orr =A0 =A0 r5, r5, #0x40 =A0 =A0 =A0 =A0 =A0 @ ena=
ble self refresh on idle
> req
>> > @@ -315,15 +347,111 @@ omap3_do_wfi:
>> > =A0 =A0 =A0 =A0nop
>> > =A0 =A0 =A0 =A0nop
>> > =A0 =A0 =A0 =A0nop
>> > - =A0 =A0 =A0 bl wait_sdrc_ok
>> > +
>> > +/*
>> > + * wait_sdrc_ok implements the erratum ID i581 WA:
>> > + * =A0SDRC state restore before accessing the SDRAM
>> > + *
>> > + * Only used at return from non-OFF mode. For OFF
>> > + * mode the ROM code configures the SDRC and
>> > + * the DPLL before calling the restore code directly
>> > + * from SDRAM.
>> > + */
>> > +
>> > +/* Make sure SDRC accesses are ok */
>> > +wait_sdrc_ok:
>> > +
>> > +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW
>> ensures this */
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest_ckgen
>> > +wait_dpll3_lock:
>> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > + =A0 =A0 =A0 tst =A0 =A0 r5, #1
>> > + =A0 =A0 =A0 beq =A0 =A0 wait_dpll3_lock
>> > +
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest1_core
>> > +wait_sdrc_ready:
>> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > + =A0 =A0 =A0 tst =A0 =A0 r5, #0x2
>> > + =A0 =A0 =A0 bne =A0 =A0 wait_sdrc_ready
>> > + =A0 =A0 =A0 /* allow DLL powerdown upon hw idle req */
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_power
>> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > + =A0 =A0 =A0 bic =A0 =A0 r5, r5, #0x40
>> > + =A0 =A0 =A0 str =A0 =A0 r5, [r4]
>> > +
>> > +is_dll_in_lock_mode:
>> > + =A0 =A0 =A0 /* Is dll in lock mode? */
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
>> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > + =A0 =A0 =A0 tst =A0 =A0 r5, #0x4
>> > + =A0 =A0 =A0 bne =A0 =A0 exit_nonoff_modes =A0 =A0 =A0 @ Return i=
f locked
>> > +
>> > + =A0 =A0 =A0 /* wait till dll locks */
>> > +wait_dll_lock_timed:
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, wait_dll_lock_counter
>> > + =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
>> > + =A0 =A0 =A0 str =A0 =A0 r4, wait_dll_lock_counter
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_status
>> > + =A0 =A0 =A0 /* Wait 20uS for lock */
>> > + =A0 =A0 =A0 mov =A0 =A0 r6, #8
>> > +wait_dll_lock:
>> > + =A0 =A0 =A0 subs =A0 =A0r6, r6, #0x1
>> > + =A0 =A0 =A0 beq =A0 =A0 kick_dll
>> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > + =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x4
>> > + =A0 =A0 =A0 cmp =A0 =A0 r5, #0x4
>> > + =A0 =A0 =A0 bne =A0 =A0 wait_dll_lock
>> > + =A0 =A0 =A0 b =A0 =A0 =A0 exit_nonoff_modes =A0 =A0 =A0 @ Return=
 when locked
>> > +
>> > + =A0 =A0 =A0 /* disable/reenable DLL if not locked */
>> > +kick_dll:
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
>> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > + =A0 =A0 =A0 mov =A0 =A0 r6, r5
>> > + =A0 =A0 =A0 bic =A0 =A0 r6, #(1<<3) =A0 =A0 =A0 =A0 =A0 =A0 @ di=
sable dll
>> > + =A0 =A0 =A0 str =A0 =A0 r6, [r4]
>> > + =A0 =A0 =A0 dsb
>> > + =A0 =A0 =A0 orr =A0 =A0 r6, r6, #(1<<3) =A0 =A0 =A0 =A0 @ enable=
 dll
>> > + =A0 =A0 =A0 str =A0 =A0 r6, [r4]
>> > + =A0 =A0 =A0 dsb
>> > + =A0 =A0 =A0 ldr =A0 =A0 r4, kick_counter
>> > + =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
>> > + =A0 =A0 =A0 str =A0 =A0 r4, kick_counter
>> > + =A0 =A0 =A0 b =A0 =A0 =A0 wait_dll_lock_timed
>> >
>> > =A0/*
>> > =A0* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > =A0* =3D=3D Exit point from non-OFF modes =3D=3D
>> > =A0* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > =A0*/
>> > +exit_nonoff_modes:
>> > =A0 =A0 =A0 =A0ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore r=
egs and return
>> >
>> > +/*
>> > + * Local variables
>> > + */
>> > +sdrc_power:
>> > + =A0 =A0 =A0 .word =A0 SDRC_POWER_V
>> > +cm_idlest1_core:
>> > + =A0 =A0 =A0 .word =A0 CM_IDLEST1_CORE_V
>> > +cm_idlest_ckgen:
>> > + =A0 =A0 =A0 .word =A0 CM_IDLEST_CKGEN_V
>> > +sdrc_dlla_status:
>> > + =A0 =A0 =A0 .word =A0 SDRC_DLLA_STATUS_V
>> > +sdrc_dlla_ctrl:
>> > + =A0 =A0 =A0 .word =A0 SDRC_DLLA_CTRL_V
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* When exporting to userspace while the counters =
are in SRAM,
>> > + =A0 =A0 =A0 =A0* these 2 words need to be at the end to facilita=
te retrival!
>> > + =A0 =A0 =A0 =A0*/
>> > +kick_counter:
>> > + =A0 =A0 =A0 .word =A0 0
>> > +wait_dll_lock_counter:
>> > + =A0 =A0 =A0 .word =A0 0
>> > +
>> > +ENTRY(omap3_do_wfi_sz)
>> > + =A0 =A0 =A0 .word =A0 . - omap3_do_wfi
>> > +
>> >
>> > =A0/*
>> > =A0* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > @@ -339,6 +467,10 @@ omap3_do_wfi:
>> > =A0* =A0restore_es3: applies to 34xx >=3D ES3.0
>> > =A0* =A0restore_3630: applies to 36xx
>> > =A0* =A0restore: common code for 3xxx
>> > + *
>> > + * Note: when back from CORE and MPU OFF mode we are running
>> > + * =A0from SDRAM, without MMU, without the caches and prediction.
>> > + * =A0Also the SRAM content has been cleared.
>> > =A0*/
>> > =A0restore_es3:
>> > =A0 =A0 =A0 =A0ldr =A0 =A0 r5, pm_prepwstst_core_p
>> > @@ -357,7 +489,8 @@ copy_to_sram:
>> > =A0 =A0 =A0 =A0bne =A0 =A0 copy_to_sram
>> > =A0 =A0 =A0 =A0ldr =A0 =A0 r1, sram_base
>> > =A0 =A0 =A0 =A0blx =A0 =A0 r1
>> > - =A0 =A0 =A0 b =A0 =A0 =A0 restore
>> > +
>> > + =A0 =A0 =A0 b =A0 =A0 =A0 restore =A0 =A0 =A0 =A0 @ Fall through=
 to common code
>> >
>> > =A0restore_3630:
>> > =A0 =A0 =A0 =A0ldr =A0 =A0 r1, pm_prepwstst_core_p
>> > @@ -600,12 +733,41 @@ usettbr0:
>> > =A0*/
>> > =A0 =A0 =A0 =A0ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore r=
egs and return
>> >
>> > +/*
>> > + * Local variables
>> > + */
>> > +pm_prepwstst_core_p:
>> > + =A0 =A0 =A0 .word =A0 PM_PREPWSTST_CORE_P
>> > +pm_pwstctrl_mpu:
>> > + =A0 =A0 =A0 .word =A0 PM_PWSTCTRL_MPU_P
>> > +scratchpad_base:
>> > + =A0 =A0 =A0 .word =A0 SCRATCHPAD_BASE_P
>> > +sram_base:
>> > + =A0 =A0 =A0 .word =A0 SRAM_BASE_P + 0x8000
>> > +ttbrbit_mask:
>> > + =A0 =A0 =A0 .word =A0 0xFFFFC000
>> > +table_index_mask:
>> > + =A0 =A0 =A0 .word =A0 0xFFF00000
>> > +table_entry:
>> > + =A0 =A0 =A0 .word =A0 0x00000C02
>> > +cache_pred_disable_mask:
>> > + =A0 =A0 =A0 .word =A0 0xFFFFE7FB
>> > +control_stat:
>> > + =A0 =A0 =A0 .word =A0 CONTROL_STAT
>> > +control_mem_rta:
>> > + =A0 =A0 =A0 .word =A0 CONTROL_MEM_RTA_CTRL
>> > +l2dis_3630:
>> > + =A0 =A0 =A0 .word =A0 0
>> > +
>> >
>> > =A0/*
>> > =A0* Internal functions
>> > =A0*/
>> >
>> > -/* This function implements the erratum ID i443 WA, applies to 34=
xx
>> >=3D ES3.0 */
>> > +/* This function implements the erratum ID i443 WA, applies to 34=
xx
>> >=3D ES3.0
>> > + *
>> > + * Copied and run from SRAM in order to reconfigure the SDRC
>> parameters.
>> > + */
>> > =A0 =A0 =A0 =A0.text
>> > =A0ENTRY(es3_sdrc_fix)
>> > =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_syscfg =A0 =A0 =A0 =A0 @ get c=
onfig addr
>> > @@ -634,6 +796,9 @@ ENTRY(es3_sdrc_fix)
>> > =A0 =A0 =A0 =A0str =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ kick off refreshes
>> > =A0 =A0 =A0 =A0bx =A0 =A0 =A0lr
>> >
>> > +/*
>> > + * Local variables
>> > + */
>> > =A0sdrc_syscfg:
>> > =A0 =A0 =A0 =A0.word =A0 SDRC_SYSCONFIG_P
>> > =A0sdrc_mr_0:
>> > @@ -650,119 +815,3 @@ sdrc_manual_1:
>> > =A0 =A0 =A0 =A0.word =A0 SDRC_MANUAL_1_P
>> > =A0ENTRY(es3_sdrc_fix_sz)
>> > =A0 =A0 =A0 =A0.word =A0 . - es3_sdrc_fix
>> > -
>> > -/*
>> > - * This function implements the erratum ID i581 WA:
>> > - * =A0SDRC state restore before accessing the SDRAM
>> > - *
>> > - * Only used at return from non-OFF mode. For OFF
>> > - * mode the ROM code configures the SDRC and
>> > - * the DPLL before calling the restore code directly
>> > - * from DDR.
>> > - */
>> > -
>> > -/* Make sure SDRC accesses are ok */
>> > -wait_sdrc_ok:
>> > -
>> > -/* DPLL3 must be locked before accessing the SDRC. Maybe the HW
>> ensures this */
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest_ckgen
>> > -wait_dpll3_lock:
>> > - =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > - =A0 =A0 =A0 tst =A0 =A0 r5, #1
>> > - =A0 =A0 =A0 beq =A0 =A0 wait_dpll3_lock
>> > -
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest1_core
>> > -wait_sdrc_ready:
>> > - =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > - =A0 =A0 =A0 tst =A0 =A0 r5, #0x2
>> > - =A0 =A0 =A0 bne =A0 =A0 wait_sdrc_ready
>> > - =A0 =A0 =A0 /* allow DLL powerdown upon hw idle req */
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_power
>> > - =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > - =A0 =A0 =A0 bic =A0 =A0 r5, r5, #0x40
>> > - =A0 =A0 =A0 str =A0 =A0 r5, [r4]
>> > -
>> > -is_dll_in_lock_mode:
>> > - =A0 =A0 =A0 /* Is dll in lock mode? */
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
>> > - =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > - =A0 =A0 =A0 tst =A0 =A0 r5, #0x4
>> > - =A0 =A0 =A0 bxne =A0 =A0lr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0@ Return if locked
>> > - =A0 =A0 =A0 /* wait till dll locks */
>> > -wait_dll_lock_timed:
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, wait_dll_lock_counter
>> > - =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
>> > - =A0 =A0 =A0 str =A0 =A0 r4, wait_dll_lock_counter
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_status
>> > - =A0 =A0 =A0 /* Wait 20uS for lock */
>> > - =A0 =A0 =A0 mov =A0 =A0 r6, #8
>> > -wait_dll_lock:
>> > - =A0 =A0 =A0 subs =A0 =A0r6, r6, #0x1
>> > - =A0 =A0 =A0 beq =A0 =A0 kick_dll
>> > - =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > - =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x4
>> > - =A0 =A0 =A0 cmp =A0 =A0 r5, #0x4
>> > - =A0 =A0 =A0 bne =A0 =A0 wait_dll_lock
>> > - =A0 =A0 =A0 bx =A0 =A0 =A0lr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0@ Return when locked
>> > -
>> > - =A0 =A0 =A0 /* disable/reenable DLL if not locked */
>> > -kick_dll:
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
>> > - =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> > - =A0 =A0 =A0 mov =A0 =A0 r6, r5
>> > - =A0 =A0 =A0 bic =A0 =A0 r6, #(1<<3) =A0 =A0 =A0 =A0 =A0 =A0 @ di=
sable dll
>> > - =A0 =A0 =A0 str =A0 =A0 r6, [r4]
>> > - =A0 =A0 =A0 dsb
>> > - =A0 =A0 =A0 orr =A0 =A0 r6, r6, #(1<<3) =A0 =A0 =A0 =A0 @ enable=
 dll
>> > - =A0 =A0 =A0 str =A0 =A0 r6, [r4]
>> > - =A0 =A0 =A0 dsb
>> > - =A0 =A0 =A0 ldr =A0 =A0 r4, kick_counter
>> > - =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
>> > - =A0 =A0 =A0 str =A0 =A0 r4, kick_counter
>> > - =A0 =A0 =A0 b =A0 =A0 =A0 wait_dll_lock_timed
>> > -
>> > -cm_idlest1_core:
>> > - =A0 =A0 =A0 .word =A0 CM_IDLEST1_CORE_V
>> > -cm_idlest_ckgen:
>> > - =A0 =A0 =A0 .word =A0 CM_IDLEST_CKGEN_V
>> > -sdrc_dlla_status:
>> > - =A0 =A0 =A0 .word =A0 SDRC_DLLA_STATUS_V
>> > -sdrc_dlla_ctrl:
>> > - =A0 =A0 =A0 .word =A0 SDRC_DLLA_CTRL_V
>> > -pm_prepwstst_core_p:
>> > - =A0 =A0 =A0 .word =A0 PM_PREPWSTST_CORE_P
>> > -pm_pwstctrl_mpu:
>> > - =A0 =A0 =A0 .word =A0 PM_PWSTCTRL_MPU_P
>> > -scratchpad_base:
>> > - =A0 =A0 =A0 .word =A0 SCRATCHPAD_BASE_P
>> > -sram_base:
>> > - =A0 =A0 =A0 .word =A0 SRAM_BASE_P + 0x8000
>> > -sdrc_power:
>> > - =A0 =A0 =A0 .word =A0 SDRC_POWER_V
>> > -ttbrbit_mask:
>> > - =A0 =A0 =A0 .word =A0 0xFFFFC000
>> > -table_index_mask:
>> > - =A0 =A0 =A0 .word =A0 0xFFF00000
>> > -table_entry:
>> > - =A0 =A0 =A0 .word =A0 0x00000C02
>> > -cache_pred_disable_mask:
>> > - =A0 =A0 =A0 .word =A0 0xFFFFE7FB
>> > -control_stat:
>> > - =A0 =A0 =A0 .word =A0 CONTROL_STAT
>> > -control_mem_rta:
>> > - =A0 =A0 =A0 .word =A0 CONTROL_MEM_RTA_CTRL
>> > -kernel_flush:
>> > - =A0 =A0 =A0 .word =A0 v7_flush_dcache_all
>> > -l2dis_3630:
>> > - =A0 =A0 =A0 .word =A0 0
>> > - =A0 =A0 =A0 /*
>> > - =A0 =A0 =A0 =A0* When exporting to userspace while the counters =
are in SRAM,
>> > - =A0 =A0 =A0 =A0* these 2 words need to be at the end to facilita=
te retrival!
>> > - =A0 =A0 =A0 =A0*/
>> > -kick_counter:
>> > - =A0 =A0 =A0 .word =A0 0
>> > -wait_dll_lock_counter:
>> > - =A0 =A0 =A0 .word =A0 0
>> > -
>> > -ENTRY(omap34xx_cpu_suspend_sz)
>> > - =A0 =A0 =A0 .word =A0 . - omap34xx_cpu_suspend
>> > --
>> > 1.7.2.3
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
