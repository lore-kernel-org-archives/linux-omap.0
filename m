From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: PM: remove get_*_restore_pointer functions,
 directly use entry points
Date: Fri, 24 Jun 2011 10:24:29 +0200
Message-ID: <BANLkTik1gOnXd=o8e_FA7trtOe_mQykJEA@mail.gmail.com>
References: <1308874574-30663-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59165 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab1FXIYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 04:24:30 -0400
Received: by qyk9 with SMTP id 9so1494474qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 01:24:29 -0700 (PDT)
In-Reply-To: <1308874574-30663-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

Kevin,

On Fri, Jun 24, 2011 at 2:16 AM, Kevin Hilman <khilman@ti.com> wrote:
> Upon return from off-mode, the ROM code jumps to a restore function
> saved in the scratchpad. =A0Based on SoC revision or errata, this
> restore entry point is different. =A0Current code uses some helper
> functions in sleep34xx.S (get_*_restore_pointer) to get the restore
> function entry point.
>
> When returning from off-mode, this code is executed from SDRAM, so
> there's no reason to use these helper functions when using the SDRAM
> entry points directly would work just fine.
>
> This patch uses ENTRY/ENDPROC to create "real" entry points for these
> functions, and uses those values directly when writing the scratchpad=
=2E
>
> Tested all three entry points
> - restore_es3: 3430/n900
> - restore_3630: 3630/Zoom3
> - restore: 3530/Overo
>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

This makes sense. FWIW:
Acked-by: Jean Pihet <j-pihet@ti.com

Thanks,
Jean

> ---
> Applies on top of Russell's suspend cleanup/rejig, and available
> (along with Russell's series) in my pm-wip/idle-suspend branch.
>
> Russell, since it depends on your series, feel free to add it to your
> series if you like. =A0Or if you prefer, we can take it through the O=
MAP
> tree.
>
> =A0arch/arm/mach-omap2/control.c =A0 | =A0 =A07 ++--
> =A0arch/arm/mach-omap2/control.h =A0 | =A0 =A06 ++--
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 61 +++++++------------------=
-------------
> =A03 files changed, 19 insertions(+), 55 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/cont=
rol.c
> index da53ba3..aab884f 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -286,14 +286,15 @@ void omap3_save_scratchpad_contents(void)
> =A0 =A0 =A0 =A0scratchpad_contents.boot_config_ptr =3D 0x0;
> =A0 =A0 =A0 =A0if (cpu_is_omap3630())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratchpad_contents.public_restore_ptr=
 =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(get_omap36=
30_restore_pointer());
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(omap3_rest=
ore_3630);
> =A0 =A0 =A0 =A0else if (omap_rev() !=3D OMAP3430_REV_ES3_0 &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0omap_rev() !=3D OMAP3430_REV_ES3_1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratchpad_contents.public_restore_ptr=
 =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(get_restor=
e_pointer());
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(omap3_rest=
ore);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratchpad_contents.public_restore_ptr=
 =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(get_es3_re=
store_pointer());
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to_phys(omap3_rest=
ore_es3);
> +
> =A0 =A0 =A0 =A0if (omap_type() =3D=3D OMAP2_DEVICE_TYPE_GP)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratchpad_contents.secure_ram_restore=
_ptr =3D 0x0;
> =A0 =A0 =A0 =A0else
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/cont=
rol.h
> index a016c8b..d4ef75d 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -386,9 +386,9 @@ extern void omap4_ctrl_pad_writel(u32 val, u16 of=
fset);
>
> =A0extern void omap3_save_scratchpad_contents(void);
> =A0extern void omap3_clear_scratchpad_contents(void);
> -extern u32 *get_restore_pointer(void);
> -extern u32 *get_es3_restore_pointer(void);
> -extern u32 *get_omap3630_restore_pointer(void);
> +extern void omap3_restore(void);
> +extern void omap3_restore_es3(void);
> +extern void omap3_restore_3630(void);
> =A0extern u32 omap3_arm_context[128];
> =A0extern void omap3_control_save_context(void);
> =A0extern void omap3_control_restore_context(void);
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index 9a1349e..177f70f 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -74,46 +74,6 @@
> =A0* API functions
> =A0*/
>
> -/*
> - * The "get_*restore_pointer" functions are used to provide a
> - * physical restore address where the ROM code jumps while waking
> - * up from MPU OFF/OSWR state.
> - * The restore pointer is stored into the scratchpad.
> - */
> -
> - =A0 =A0 =A0 .text
> -/* Function call to get the restore pointer for resume from OFF */
> -ENTRY(get_restore_pointer)
> - =A0 =A0 =A0 stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on sta=
ck
> - =A0 =A0 =A0 adr =A0 =A0 r0, restore
> - =A0 =A0 =A0 ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and retu=
rn
> -ENDPROC(get_restore_pointer)
> - =A0 =A0 =A0 .align
> -ENTRY(get_restore_pointer_sz)
> - =A0 =A0 =A0 .word =A0 . - get_restore_pointer
> -
> - =A0 =A0 =A0 .text
> -/* Function call to get the restore pointer for 3630 resume from OFF=
 */
> -ENTRY(get_omap3630_restore_pointer)
> - =A0 =A0 =A0 stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on sta=
ck
> - =A0 =A0 =A0 adr =A0 =A0 r0, restore_3630
> - =A0 =A0 =A0 ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and retu=
rn
> -ENDPROC(get_omap3630_restore_pointer)
> - =A0 =A0 =A0 .align
> -ENTRY(get_omap3630_restore_pointer_sz)
> - =A0 =A0 =A0 .word =A0 . - get_omap3630_restore_pointer
> -
> - =A0 =A0 =A0 .text
> -/* Function call to get the restore pointer for ES3 to resume from O=
=46F */
> -ENTRY(get_es3_restore_pointer)
> - =A0 =A0 =A0 stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on sta=
ck
> - =A0 =A0 =A0 adr =A0 =A0 r0, restore_es3
> - =A0 =A0 =A0 ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and retu=
rn
> -ENDPROC(get_es3_restore_pointer)
> - =A0 =A0 =A0 .align
> -ENTRY(get_es3_restore_pointer_sz)
> - =A0 =A0 =A0 .word =A0 . - get_es3_restore_pointer
> -
> =A0 =A0 =A0 =A0.text
> =A0/*
> =A0* L2 cache needs to be toggled for stable OFF mode functionality o=
n 3630.
> @@ -316,12 +276,12 @@ omap3_do_wfi:
> =A0* =A0restore_3630: applies to 36xx
> =A0* =A0restore: common code for 3xxx
> =A0*/
> -restore_es3:
> +ENTRY(omap3_restore_es3)
> =A0 =A0 =A0 =A0ldr =A0 =A0 r5, pm_prepwstst_core_p
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [r5]
> =A0 =A0 =A0 =A0and =A0 =A0 r4, r4, #0x3
> =A0 =A0 =A0 =A0cmp =A0 =A0 r4, #0x0 =A0 =A0 =A0 =A0@ Check if previou=
s power state of CORE is OFF
> - =A0 =A0 =A0 bne =A0 =A0 restore
> + =A0 =A0 =A0 bne =A0 =A0 omap3_restore
> =A0 =A0 =A0 =A0adr =A0 =A0 r0, es3_sdrc_fix
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, sram_base
> =A0 =A0 =A0 =A0ldr =A0 =A0 r2, es3_sdrc_fix_sz
> @@ -333,22 +293,24 @@ copy_to_sram:
> =A0 =A0 =A0 =A0bne =A0 =A0 copy_to_sram
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, sram_base
> =A0 =A0 =A0 =A0blx =A0 =A0 r1
> - =A0 =A0 =A0 b =A0 =A0 =A0 restore
> -
> -restore_3630:
> + =A0 =A0 =A0 b =A0 =A0 =A0 omap3_restore
> +ENDPROC(omap3_restore_es3)
> +
> +ENTRY(omap3_restore_3630)
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, pm_prepwstst_core_p
> =A0 =A0 =A0 =A0ldr =A0 =A0 r2, [r1]
> =A0 =A0 =A0 =A0and =A0 =A0 r2, r2, #0x3
> =A0 =A0 =A0 =A0cmp =A0 =A0 r2, #0x0 =A0 =A0 =A0 =A0@ Check if previou=
s power state of CORE is OFF
> - =A0 =A0 =A0 bne =A0 =A0 restore
> + =A0 =A0 =A0 bne =A0 =A0 omap3_restore
> =A0 =A0 =A0 =A0/* Disable RTA before giving control */
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, control_mem_rta
> =A0 =A0 =A0 =A0mov =A0 =A0 r2, #OMAP36XX_RTA_DISABLE
> =A0 =A0 =A0 =A0str =A0 =A0 r2, [r1]
> -
> +ENDPROC(omap3_restore_3630)
> +
> =A0 =A0 =A0 =A0/* Fall through to common code for the remaining logic=
 */
>
> -restore:
> +ENTRY(omap3_restore)
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Read the pwstctrl register to check the reason for =
mpu reset.
> =A0 =A0 =A0 =A0 * This tells us what was lost.
> @@ -438,7 +400,8 @@ skipl2reen:
>
> =A0 =A0 =A0 =A0/* Now branch to the common CPU resume function */
> =A0 =A0 =A0 =A0b =A0 =A0 =A0 cpu_resume
> -
> +ENDPROC(omap3_restore)
> +
> =A0 =A0 =A0 =A0.ltorg
>
> =A0/*
> --
> 1.7.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
