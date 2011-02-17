From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v5 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
Date: Thu, 17 Feb 2011 18:12:17 +0100
Message-ID: <AANLkTin4TMQCK4Jts_xGTOKPD6XUMpFYFey-Uh5UxWan@mail.gmail.com>
References: <1297946558-13436-1-git-send-email-dave.martin@linaro.org>
	<1297946558-13436-6-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1297946558-13436-6-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, patches@linaro.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 17, 2011 at 1:42 PM, Dave Martin <dave.martin@linaro.org> wrote:
> =A0* Build unconditionally as ARM for correct interoperation with
> =A0 OMAP firmware.
>
> =A0* Fix an out-of-range ADR when building for ARM.
>
> =A0* Remove deprecated PC-relative stores.
>
> =A0* Add the required ENDPROC() directive for each ENTRY().
>
> =A0* .align before data words.
>
> =A0* Handle non-interworking return from v7_flush_dcache_all.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Reviewed OK
Reviewed-by: Jean Pihet <j-pihet@ti.com>

Tested OK on OMAP3 with and without CONFIG_THUMB2_KERNEL set. PM
RETention and OFF modes in cpuidle OK.
Tested-by: Jean Pihet <j-pihet@ti.com>

> ---
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 48 +++++++++++++++++++++++++++++=
+++++----
> =A01 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep3=
4xx.S
> index a05c348..f377724 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -64,6 +64,11 @@
> =A0#define SDRC_DLLA_STATUS_V =A0 =A0 OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STA=
TUS)
> =A0#define SDRC_DLLA_CTRL_V =A0 =A0 =A0 OMAP34XX_SDRC_REGADDR(SDRC_DLLA_C=
TRL)
>
> +/*
> + * This file needs be built unconditionally as ARM to interoperate corre=
ctly
> + * with non-Thumb-2-capable firmware.
> + */
> + =A0 =A0 =A0 .arm
>
> =A0/*
> =A0* API functions
> @@ -82,6 +87,8 @@ ENTRY(get_restore_pointer)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on stack
> =A0 =A0 =A0 =A0adr =A0 =A0 r0, restore
> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and return
> +ENDPROC(get_restore_pointer)
> + =A0 =A0 =A0 .align
> =A0ENTRY(get_restore_pointer_sz)
> =A0 =A0 =A0 =A0.word =A0 . - get_restore_pointer
>
> @@ -91,6 +98,8 @@ ENTRY(get_omap3630_restore_pointer)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on stack
> =A0 =A0 =A0 =A0adr =A0 =A0 r0, restore_3630
> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and return
> +ENDPROC(get_omap3630_restore_pointer)
> + =A0 =A0 =A0 .align
> =A0ENTRY(get_omap3630_restore_pointer_sz)
> =A0 =A0 =A0 =A0.word =A0 . - get_omap3630_restore_pointer
>
> @@ -100,6 +109,8 @@ ENTRY(get_es3_restore_pointer)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on stack
> =A0 =A0 =A0 =A0adr =A0 =A0 r0, restore_es3
> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and return
> +ENDPROC(get_es3_restore_pointer)
> + =A0 =A0 =A0 .align
> =A0ENTRY(get_es3_restore_pointer_sz)
> =A0 =A0 =A0 =A0.word =A0 . - get_es3_restore_pointer
>
> @@ -113,8 +124,10 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on stack
> =A0 =A0 =A0 =A0/* Setup so that we will disable and enable l2 */
> =A0 =A0 =A0 =A0mov =A0 =A0 r1, #0x1
> - =A0 =A0 =A0 str =A0 =A0 r1, l2dis_3630
> + =A0 =A0 =A0 adrl =A0 =A0r2, l2dis_3630 =A0@ may be too distant for plai=
n adr
> + =A0 =A0 =A0 str =A0 =A0 r1, [r2]
> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and return
> +ENDPROC(enable_omap3630_toggle_l2_on_restore)
>
> =A0 =A0 =A0 =A0.text
> =A0/* Function to call rom code to save secure ram context */
> @@ -139,12 +152,14 @@ ENTRY(save_secure_ram_context)
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {r1-r12, pc}
> + =A0 =A0 =A0 .align
> =A0sram_phy_addr_mask:
> =A0 =A0 =A0 =A0.word =A0 SRAM_BASE_P
> =A0high_mask:
> =A0 =A0 =A0 =A0.word =A0 0xffff
> =A0api_params:
> =A0 =A0 =A0 =A0.word =A0 0x4, 0x0, 0x0, 0x1, 0x1
> +ENDPROC(save_secure_ram_context)
> =A0ENTRY(save_secure_ram_context_sz)
> =A0 =A0 =A0 =A0.word =A0 . - save_secure_ram_context
>
> @@ -279,8 +294,18 @@ clean_l2:
> =A0 =A0 =A0 =A0 * =A0- 'might' have to copy address, load and jump to it
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, kernel_flush
> - =A0 =A0 =A0 mov =A0 =A0 lr, pc
> - =A0 =A0 =A0 bx =A0 =A0 =A0r1
> + =A0 =A0 =A0 blx =A0 =A0 r1
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The kernel doesn't interwork: v7_flush_dcache_all in p=
articluar will
> + =A0 =A0 =A0 =A0* always return in Thumb state when CONFIG_THUMB2_KERNEL=
 is enabled.
> + =A0 =A0 =A0 =A0* This sequence switches back to ARM. =A0Note that .alig=
n may insert a
> + =A0 =A0 =A0 =A0* nop: bx pc needs to be word-aligned in order to work.
> + =A0 =A0 =A0 =A0*/
> + THUMB( =A0 =A0 =A0 =A0.thumb =A0 =A0 =A0 =A0 =A0)
> + THUMB( =A0 =A0 =A0 =A0.align =A0 =A0 =A0 =A0 =A0)
> + THUMB( =A0 =A0 =A0 =A0bx =A0 =A0 =A0pc =A0 =A0 =A0)
> + THUMB( =A0 =A0 =A0 =A0nop =A0 =A0 =A0 =A0 =A0 =A0 )
> + =A0 =A0 =A0 .arm
>
> =A0omap3_do_wfi:
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ read the S=
DRC_POWER register
> @@ -438,6 +463,7 @@ skipl2dis:
> =A0#endif
> =A0 =A0 =A0 =A0b =A0 =A0 =A0 logic_l1_restore
>
> + =A0 =A0 =A0 .align
> =A0l2_inv_api_params:
> =A0 =A0 =A0 =A0.word =A0 0x1, 0x00
> =A0l2_inv_gp:
> @@ -607,6 +633,7 @@ usettbr0:
>
> =A0/* This function implements the erratum ID i443 WA, applies to 34xx >=
=3D ES3.0 */
> =A0 =A0 =A0 =A0.text
> + =A0 =A0 =A0 .align =A03
> =A0ENTRY(es3_sdrc_fix)
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_syscfg =A0 =A0 =A0 =A0 @ get config a=
ddr
> =A0 =A0 =A0 =A0ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ get =
value
> @@ -634,6 +661,7 @@ ENTRY(es3_sdrc_fix)
> =A0 =A0 =A0 =A0str =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ kick=
 off refreshes
> =A0 =A0 =A0 =A0bx =A0 =A0 =A0lr
>
> + =A0 =A0 =A0 .align
> =A0sdrc_syscfg:
> =A0 =A0 =A0 =A0.word =A0 SDRC_SYSCONFIG_P
> =A0sdrc_mr_0:
> @@ -648,6 +676,7 @@ sdrc_emr2_1:
> =A0 =A0 =A0 =A0.word =A0 SDRC_EMR2_1_P
> =A0sdrc_manual_1:
> =A0 =A0 =A0 =A0.word =A0 SDRC_MANUAL_1_P
> +ENDPROC(es3_sdrc_fix)
> =A0ENTRY(es3_sdrc_fix_sz)
> =A0 =A0 =A0 =A0.word =A0 . - es3_sdrc_fix
>
> @@ -682,6 +711,12 @@ wait_sdrc_ready:
> =A0 =A0 =A0 =A0bic =A0 =A0 r5, r5, #0x40
> =A0 =A0 =A0 =A0str =A0 =A0 r5, [r4]
>
> +/*
> + * PC-relative stores lead to undefined behaviour in Thumb-2: use a r7 a=
s a
> + * base instead.
> + * Be careful not to clobber r7 when maintaing this code.
> + */
> +
> =A0is_dll_in_lock_mode:
> =A0 =A0 =A0 =A0/* Is dll in lock mode? */
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_dlla_ctrl
> @@ -689,10 +724,11 @@ is_dll_in_lock_mode:
> =A0 =A0 =A0 =A0tst =A0 =A0 r5, #0x4
> =A0 =A0 =A0 =A0bxne =A0 =A0lr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ Return if locked
> =A0 =A0 =A0 =A0/* wait till dll locks */
> + =A0 =A0 =A0 adr =A0 =A0 r7, kick_counter
> =A0wait_dll_lock_timed:
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, wait_dll_lock_counter
> =A0 =A0 =A0 =A0add =A0 =A0 r4, r4, #1
> - =A0 =A0 =A0 str =A0 =A0 r4, wait_dll_lock_counter
> + =A0 =A0 =A0 str =A0 =A0 r4, [r7, #wait_dll_lock_counter - kick_counter]
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_dlla_status
> =A0 =A0 =A0 =A0/* Wait 20uS for lock */
> =A0 =A0 =A0 =A0mov =A0 =A0 r6, #8
> @@ -718,9 +754,10 @@ kick_dll:
> =A0 =A0 =A0 =A0dsb
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, kick_counter
> =A0 =A0 =A0 =A0add =A0 =A0 r4, r4, #1
> - =A0 =A0 =A0 str =A0 =A0 r4, kick_counter
> + =A0 =A0 =A0 str =A0 =A0 r4, [r7] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ kick_=
counter
> =A0 =A0 =A0 =A0b =A0 =A0 =A0 wait_dll_lock_timed
>
> + =A0 =A0 =A0 .align
> =A0cm_idlest1_core:
> =A0 =A0 =A0 =A0.word =A0 CM_IDLEST1_CORE_V
> =A0cm_idlest_ckgen:
> @@ -763,6 +800,7 @@ kick_counter:
> =A0 =A0 =A0 =A0.word =A0 0
> =A0wait_dll_lock_counter:
> =A0 =A0 =A0 =A0.word =A0 0
> +ENDPROC(omap34xx_cpu_suspend)
>
> =A0ENTRY(omap34xx_cpu_suspend_sz)
> =A0 =A0 =A0 =A0.word =A0 . - omap34xx_cpu_suspend
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
