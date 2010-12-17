From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 5/7] OMAP3: rework of the ASM sleep code execution paths
Date: Fri, 17 Dec 2010 11:14:47 +0100
Message-ID: <AANLkTinOC1EbrxF9LOvMNujKY=ax_5AjeByrWc2m-9x0@mail.gmail.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
	<1292521858-3810-6-git-send-email-j-pihet@ti.com>
	<001905ac88dd754f5426cfa2dc76ddc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58680 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab0LQKOs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 05:14:48 -0500
Received: by qwa26 with SMTP id 26so505329qwa.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:14:47 -0800 (PST)
In-Reply-To: <001905ac88dd754f5426cfa2dc76ddc2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

On Fri, Dec 17, 2010 at 6:04 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
>> Sent: Thursday, December 16, 2010 11:21 PM
>> To: linux-omap@vger.kernel.org
>> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.or=
g;
>> Jean Pihet
>> Subject: [PATCH 5/7] OMAP3: rework of the ASM sleep code execution p=
aths
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> - Reworked and simplified the execution paths for better
>> =A0 readability and to avoid duplication of code,
>> - Added comments on the entry and exit points and the interaction
>> =A0 with the ROM code for OFF mode restore,
>> - Reworked the existing comments for better readability.
>>
>> Tested on N900 and Beagleboard with full RET and OFF modes,
>> using cpuidle and suspend.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/control.c =A0 | =A0 10 +-
>> =A0arch/arm/mach-omap2/sleep34xx.S | =A0309
> ++++++++++++++++++++++------------
>> ----
>> =A02 files changed, 188 insertions(+), 131 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/control.c
> b/arch/arm/mach-omap2/control.c
>> index 728f268..5cb7276 100644
>> --- a/arch/arm/mach-omap2/control.c
>> +++ b/arch/arm/mach-omap2/control.c
>> @@ -239,7 +239,15 @@ void omap3_save_scratchpad_contents(void)
>> =A0 =A0 =A0 struct omap3_scratchpad_prcm_block prcm_block_contents;
>> =A0 =A0 =A0 struct omap3_scratchpad_sdrc_block sdrc_block_contents;
>>
>> - =A0 =A0 /* Populate the Scratchpad contents */
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Populate the Scratchpad contents
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* The get_*restore_pointer functions are used to get th=
e resume
>> + =A0 =A0 =A0* =A0function pointer to be called by the ROM code when=
 back from
> WFI
>> + =A0 =A0 =A0* =A0in OFF mode.
> Align your text here.
>> + =A0 =A0 =A0* The restore pointer is stored into the scratchpad for=
 later
>> access
>> + =A0 =A0 =A0* =A0by the ROM code.
> The text needs to be reworked a bit.
>
> The "get_*restore_pointer" functions are used to provide a physical
> restore
> address where ROM code jumps while waking up from MPU OFF/OSWR state.
> The restore pointer is stored into the scratchpad

That sounds better. Fixed.

>
>> + =A0 =A0 =A0*/
>> =A0 =A0 =A0 scratchpad_contents.boot_config_ptr =3D 0x0;
>> =A0 =A0 =A0 if (cpu_is_omap3630())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 scratchpad_contents.public_restore_ptr =3D
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
>> omap2/sleep34xx.S
>> index 426af02..55ddd5a 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -70,6 +70,11 @@
>> =A0 * API functions
>> =A0 */
>>
>> +/*
>> + * The get_*restore_pointer functions are returning the resume
>> + * =A0function pointer to be called by the ROM code when back from =
WFI
>> + * =A0in OFF mode.
> Ditto
> The "get_*restore_pointer" functions are used to provide a physical
> restore
> address where ROM code jumps while waking up from MPU OFF/OSWR state.
> The restore pointer is stored into the scratchpad
Idem

>
>> + */
>> =A0 =A0 =A0 .text
>> =A0/* Function call to get the restore pointer for resume from OFF *=
/
>> =A0ENTRY(get_restore_pointer)
>> @@ -101,7 +106,7 @@ ENTRY(get_es3_restore_pointer_sz)
>> =A0/*
>> =A0 * L2 cache needs to be toggled for stable OFF mode functionality=
 on
> 3630.
>> =A0 * This function sets up a flag that will allow for this toggling=
 to
> take
>> - * place on 3630. Hopefully some version in the future maynot need =
this
>> + * place on 3630. Hopefully some version in the future maynot need
> this.
> 'maynot' ..... may not
=46ixed

>> =A0 */
>> =A0ENTRY(enable_omap3630_toggle_l2_on_restore)
>> =A0 =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on s=
tack
>> @@ -143,34 +148,156 @@ ENTRY(save_secure_ram_context_sz)
>> =A0 =A0 =A0 .word =A0 . - save_secure_ram_context
>>
>> =A0/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Idle entry point =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> +
>> +/*
>> =A0 * Forces OMAP into idle state
>> =A0 *
>> - * omap34xx_suspend() - This bit of code just executes the WFI
>> - * for normal idles.
>> + * omap34xx_suspend() - This bit of code saves the CPU context if
> needed
>> + * and executes the WFI instruction
>> =A0 *
>> - * Note: This code get's copied to internal SRAM at boot. When the =
OMAP
>> - * =A0 =A0wakes up it continues execution at the point it went to s=
leep.
>> + * Notes:
>> + * - this code gets copied to internal SRAM at boot.
>> + * - when the OMAP wakes up it continues at different execution poi=
nts
>> + * =A0 depending on the low power mode (non-OFF vs OFF modes),
>> + * =A0 cf. 'Resume path for xxx mode' comments.
>> =A0 */
>> =A0ENTRY(omap34xx_cpu_suspend)
>> =A0 =A0 =A0 stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
@ save registers on stack
>>
>> - =A0 =A0 /* r0 contains restore pointer in sdram */
>> - =A0 =A0 /* r1 contains information about saving context */
>> - =A0 =A0 ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ read the S=
DRC_POWER register
>> - =A0 =A0 ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ read=
 the contents of SDRC_POWER
>> - =A0 =A0 orr =A0 =A0 r5, r5, #0x40 =A0 =A0 =A0 =A0 =A0 @ enable sel=
f refresh on idle req
>> - =A0 =A0 str =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ writ=
e back to SDRC_POWER
> register
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* r0 contains restore pointer in sdram
>> + =A0 =A0 =A0* r1 contains information about saving context:
>> + =A0 =A0 =A0* =A0 0 - No context lost
>> + =A0 =A0 =A0* =A0 1 - Only L1 and logic lost
>> + =A0 =A0 =A0* =A0 2 - Only L2 lost
>> + =A0 =A0 =A0* =A0 3 - Both L1 and L2 lost
>> + =A0 =A0 =A0*/
>>
>> + =A0 =A0 /* Save context only if required */
>> =A0 =A0 =A0 cmp =A0 =A0 r1, #0x0
>> - =A0 =A0 /* If context save is required, do that and execute wfi */
>> - =A0 =A0 bne =A0 =A0 save_context_wfi
>> + =A0 =A0 beq =A0 =A0 omap3_do_wfi
>> +
>> +save_context_wfi:
>> + =A0 =A0 mov =A0 =A0 r8, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ St=
ore SDRAM address in r8
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c1, c0, 1 =A0 @ Read Auxiliary Con=
trol Register
>> + =A0 =A0 mov =A0 =A0 r4, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Numb=
er of parameters for restore
> call
>> + =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push param=
eters for restore call
>> + =A0 =A0 mrc =A0 =A0 p15, 1, r5, c9, c0, 2 =A0 @ Read L2 AUX ctrl r=
egister
>> + =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push param=
eters for restore call
>> +
>> + =A0 =A0 =A0 =A0/* Check what that target sleep state is from r1 */
>> + =A0 =A0 cmp =A0 =A0 r1, #0x2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Only=
 L2 lost, no need to save
> context
>> + =A0 =A0 beq =A0 =A0 clean_caches
>> +
>> +l1_logic_lost:
>> + =A0 =A0 /* Store sp and spsr to SDRAM */
>> + =A0 =A0 mov =A0 =A0 r4, sp
>> + =A0 =A0 mrs =A0 =A0 r5, spsr
>> + =A0 =A0 mov =A0 =A0 r6, lr
>> + =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 /* Save all ARM registers */
>> + =A0 =A0 /* Coprocessor access control register */
> You might want to fix above commenting style as well
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r6, c1, c0, 2
>> + =A0 =A0 stmia =A0 r8!, {r6}
>> + =A0 =A0 /* TTBR0, TTBR1 and Translation table base control */
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r4, c2, c0, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c2, c0, 1
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r6, c2, c0, 2
>> + =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Domain access control register, data fault status reg=
ister,
>> + =A0 =A0 =A0* and instruction fault status register
>> + =A0 =A0 =A0*/
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r4, c3, c0, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c0, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r6, c5, c0, 1
>> + =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Data aux fault status register, instruction aux fault=
 status,
>> + =A0 =A0 =A0* data fault address register and instruction fault add=
ress
>> register
>> + =A0 =A0 =A0*/
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r4, c5, c1, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c1, 1
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r6, c6, c0, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r7, c6, c0, 2
>> + =A0 =A0 stmia =A0 r8!, {r4-r7}
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* user r/w thread and process ID, user r/o thread and p=
rocess ID,
>> + =A0 =A0 =A0* priv only thread and process ID, cache size selection
>> + =A0 =A0 =A0*/
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 2
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 3
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 4
>> + =A0 =A0 mrc =A0 =A0 p15, 2, r7, c0, c0, 0
>> + =A0 =A0 stmia =A0 r8!, {r4-r7}
>> + =A0 =A0 /* Data TLB lockdown, instruction TLB lockdown registers *=
/
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c0, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r6, c10, c0, 1
>> + =A0 =A0 stmia =A0 r8!, {r5-r6}
>> + =A0 =A0 /* Secure or non secure vector base address, FCSE PID, Con=
text
> PID*/
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r4, c12, c0, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 1
>> + =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 /* Primary remap, normal remap registers */
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r4, c10, c2, 0
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c2, 1
>> + =A0 =A0 stmia =A0 r8!,{r4-r5}
>> +
>> + =A0 =A0 /* Store current cpsr*/
>> + =A0 =A0 mrs =A0 =A0 r2, cpsr
>> + =A0 =A0 stmia =A0 r8!, {r2}
>> +
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r4, c1, c0, 0
>> + =A0 =A0 /* save control register */
>> + =A0 =A0 stmia =A0 r8!, {r4}
>> +
>> +clean_caches:
>> + =A0 =A0 /* Clean Data or unified cache to POU*/
>> + =A0 =A0 /* How to invalidate only L1 cache???? - #FIX_ME# */
>> + =A0 =A0 /* mcr =A0p15, 0, r11, c7, c11, 1 */
> And this one too...
>> + =A0 =A0 cmp =A0 =A0 r1, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Chec=
k whether L2 inval is
> required
>> + =A0 =A0 beq =A0 =A0 omap3_do_wfi
>> +
>> +clean_l2:
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* jump out to kernel flush routine
>> + =A0 =A0 =A0* =A0- reuse that code is better
>> + =A0 =A0 =A0* =A0- it executes in a cached space so is faster than =
refetch per-
>> block
>> + =A0 =A0 =A0* =A0- should be faster and will change with kernel
>> + =A0 =A0 =A0* =A0- 'might' have to copy address, load and jump to i=
t
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ldr r1, kernel_flush
>> + =A0 =A0 mov lr, pc
>> + =A0 =A0 bx =A0r1
>> +
>> +omap3_do_wfi:
>> + =A0 =A0 ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ read the S=
DRC_POWER register
>> + =A0 =A0 ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ read=
 the contents of SDRC_POWER
>> + =A0 =A0 orr =A0 =A0 r5, r5, #0x40 =A0 =A0 =A0 =A0 =A0 @ enable sel=
f refresh on idle req
>> + =A0 =A0 str =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ writ=
e back to SDRC_POWER
> register
>> +
>> =A0 =A0 =A0 /* Data memory barrier and Data sync barrier */
>> =A0 =A0 =A0 mov =A0 =A0 r1, #0
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 4
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 5
>>
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D WFI instruction =3D> Enter idle =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> =A0 =A0 =A0 wfi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 @ wait for interrupt
>>
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Resume path for non-OFF modes =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> =A0 =A0 =A0 nop
>> =A0 =A0 =A0 nop
>> =A0 =A0 =A0 nop
>> @@ -183,7 +310,29 @@ ENTRY(omap34xx_cpu_suspend)
>> =A0 =A0 =A0 nop
>> =A0 =A0 =A0 bl wait_sdrc_ok
>>
>> - =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ =
restore regs and return
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Exit point from non-OFF modes =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> + =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore regs and=
 return
>> +
>> +
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Resume path for OFF mode =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> +
>> +/*
>> + * The restore_* functions are called by the ROM code
>> + * =A0when back from WFI in OFF mode.
>> + * Cf. the get_*restore_pointer functions.
>> + *
>> + * =A0restore_es3: applies to 34xx >=3D ES3.0
>> + * =A0restore_3630: applies to 36xx
>> + * =A0restore: common code for 3xxx
>> + */
>> =A0restore_es3:
>> =A0 =A0 =A0 ldr =A0 =A0 r5, pm_prepwstst_core_p
>> =A0 =A0 =A0 ldr =A0 =A0 r4, [r5]
>> @@ -213,12 +362,17 @@ restore_3630:
>> =A0 =A0 =A0 ldr =A0 =A0 r1, control_mem_rta
>> =A0 =A0 =A0 mov =A0 =A0 r2, #OMAP36XX_RTA_DISABLE
>> =A0 =A0 =A0 str =A0 =A0 r2, [r1]
>> - =A0 =A0 /* Fall thru for the remaining logic */
>> +
>> + =A0 =A0 /* Fall thru to common code for the remaining logic */
>> +
>> =A0restore:
>> - =A0 =A0 =A0 =A0/* Check what was the reason for mpu reset and stor=
e the reason
>> in r9*/
>> - =A0 =A0 =A0 =A0/* 1 - Only L1 and logic lost */
>> - =A0 =A0 =A0 =A0/* 2 - Only L2 lost - In this case, we wont be here=
 */
>> - =A0 =A0 =A0 =A0/* 3 - Both L1 and L2 lost */
>> + =A0 =A0 =A0 =A0/*
>> + =A0 =A0 =A0* Check what was the reason for mpu reset and store the=
 reason in
>> r9:
>> + =A0 =A0 =A0* =A00 - No context lost
>> + =A0 =A0 =A0 =A0 * =A01 - Only L1 and logic lost
>> + =A0 =A0 =A0 =A0 * =A02 - Only L2 lost - In this case, we wont be h=
ere
>> + =A0 =A0 =A0 =A0 * =A03 - Both L1 and L2 lost
>> + =A0 =A0 =A0*/
>> =A0 =A0 =A0 ldr =A0 =A0 r1, pm_pwstctrl_mpu
>> =A0 =A0 =A0 ldr =A0 =A0 r2, [r1]
>> =A0 =A0 =A0 and =A0 =A0 r2, r2, #0x3
>> @@ -421,118 +575,12 @@ usettbr0:
>> =A0 =A0 =A0 and =A0 =A0 r4, r2
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r4, c1, c0, 0
>>
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Exit point from OFF mode =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> =A0 =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
@ restore regs and return
>> -save_context_wfi:
>> - =A0 =A0 mov =A0 =A0 r8, r0 /* Store SDRAM address in r8 */
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c1, c0, 1 =A0 @ Read Auxiliary Con=
trol Register
>> - =A0 =A0 mov =A0 =A0 r4, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Numb=
er of parameters for restore
> call
>> - =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push param=
eters for restore call
>> - =A0 =A0 mrc =A0 =A0 p15, 1, r5, c9, c0, 2 =A0 @ Read L2 AUX ctrl r=
egister
>> - =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push param=
eters for restore call
>> - =A0 =A0 =A0 =A0/* Check what that target sleep state is:stored in =
r1*/
>> - =A0 =A0 =A0 =A0/* 1 - Only L1 and logic lost */
>> - =A0 =A0 =A0 =A0/* 2 - Only L2 lost */
>> - =A0 =A0 =A0 =A0/* 3 - Both L1 and L2 lost */
>> - =A0 =A0 cmp =A0 =A0 r1, #0x2 /* Only L2 lost */
>> - =A0 =A0 beq =A0 =A0 clean_l2
>> - =A0 =A0 cmp =A0 =A0 r1, #0x1 /* L2 retained */
>> - =A0 =A0 /* r9 stores whether to clean L2 or not*/
>> - =A0 =A0 moveq =A0 r9, #0x0 /* Dont Clean L2 */
>> - =A0 =A0 movne =A0 r9, #0x1 /* Clean L2 */
>> -l1_logic_lost:
>> - =A0 =A0 /* Store sp and spsr to SDRAM */
>> - =A0 =A0 mov =A0 =A0 r4, sp
>> - =A0 =A0 mrs =A0 =A0 r5, spsr
>> - =A0 =A0 mov =A0 =A0 r6, lr
>> - =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 /* Save all ARM registers */
>> - =A0 =A0 /* Coprocessor access control register */
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r6, c1, c0, 2
>> - =A0 =A0 stmia =A0 r8!, {r6}
>> - =A0 =A0 /* TTBR0, TTBR1 and Translation table base control */
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r4, c2, c0, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c2, c0, 1
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r6, c2, c0, 2
>> - =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 /* Domain access control register, data fault status regis=
ter,
>> - =A0 =A0 and instruction fault status register */
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r4, c3, c0, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c0, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r6, c5, c0, 1
>> - =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 /* Data aux fault status register, instruction aux fault s=
tatus,
>> - =A0 =A0 datat fault address register and instruction fault address
>> register*/
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r4, c5, c1, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c1, 1
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r6, c6, c0, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r7, c6, c0, 2
>> - =A0 =A0 stmia =A0 r8!, {r4-r7}
>> - =A0 =A0 /* user r/w thread and process ID, user r/o thread and pro=
cess ID,
>> - =A0 =A0 priv only thread and process ID, cache size selection */
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 2
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 3
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 4
>> - =A0 =A0 mrc =A0 =A0 p15, 2, r7, c0, c0, 0
>> - =A0 =A0 stmia =A0 r8!, {r4-r7}
>> - =A0 =A0 /* Data TLB lockdown, instruction TLB lockdown registers *=
/
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c0, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r6, c10, c0, 1
>> - =A0 =A0 stmia =A0 r8!, {r5-r6}
>> - =A0 =A0 /* Secure or non secure vector base address, FCSE PID, Con=
text
> PID*/
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r4, c12, c0, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 1
>> - =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 /* Primary remap, normal remap registers */
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r4, c10, c2, 0
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c2, 1
>> - =A0 =A0 stmia =A0 r8!,{r4-r5}
>> -
>> - =A0 =A0 /* Store current cpsr*/
>> - =A0 =A0 mrs =A0 =A0 r2, cpsr
>> - =A0 =A0 stmia =A0 r8!, {r2}
>> -
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r4, c1, c0, 0
>> - =A0 =A0 /* save control register */
>> - =A0 =A0 stmia =A0 r8!, {r4}
>> -clean_caches:
>> - =A0 =A0 /* Clean Data or unified cache to POU*/
>> - =A0 =A0 /* How to invalidate only L1 cache???? - #FIX_ME# */
>> - =A0 =A0 /* mcr =A0p15, 0, r11, c7, c11, 1 */
>> - =A0 =A0 cmp =A0 =A0 r9, #1 /* Check whether L2 inval is required o=
r not*/
>> - =A0 =A0 bne =A0 =A0 skip_l2_inval
>> -clean_l2:
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* Jump out to kernel flush routine
>> - =A0 =A0 =A0* =A0- reuse that code is better
>> - =A0 =A0 =A0* =A0- it executes in a cached space so is faster than =
refetch per-
>> block
>> - =A0 =A0 =A0* =A0- should be faster and will change with kernel
>> - =A0 =A0 =A0* =A0- 'might' have to copy address, load and jump to i=
t
>> - =A0 =A0 =A0*/
>> - =A0 =A0 ldr r1, kernel_flush
>> - =A0 =A0 mov lr, pc
>> - =A0 =A0 bx =A0r1
>> -
>> -skip_l2_inval:
>> - =A0 =A0 /* Data memory barrier and Data sync barrier */
>> - =A0 =A0 mov =A0 =A0 r1, #0
>> - =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 4
>> - =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 5
>> -
>> - =A0 =A0 wfi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 @ wait for interrupt
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 nop
>> - =A0 =A0 bl wait_sdrc_ok
>> - =A0 =A0 /* restore regs and return */
>> - =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc}
>>
>>
>> =A0/*
>> @@ -682,5 +730,6 @@ kick_counter:
>> =A0 =A0 =A0 .word =A0 0
>> =A0wait_dll_lock_counter:
>> =A0 =A0 =A0 .word =A0 0
>> +
>> =A0ENTRY(omap34xx_cpu_suspend_sz)
>> =A0 =A0 =A0 .word =A0 . - omap34xx_cpu_suspend
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
