From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 5/7] OMAP3: rework of the ASM sleep code execution paths
Date: Sat, 18 Dec 2010 16:54:38 +0100
Message-ID: <AANLkTiknkOLwAf=+6QB2wKgX5p9iT6t=b52ZcOP3=CwY@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<1292580506-4421-6-git-send-email-j-pihet@ti.com>
	<4D0B8358.3030804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63834 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab0LRPyj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 10:54:39 -0500
Received: by qyj19 with SMTP id 19so2634450qyj.19
        for <linux-omap@vger.kernel.org>; Sat, 18 Dec 2010 07:54:38 -0800 (PST)
In-Reply-To: <4D0B8358.3030804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Fri, Dec 17, 2010 at 4:35 PM, Nishanth Menon <nm@ti.com> wrote:
> jean.pihet@newoldbits.com had written, on 12/17/2010 04:08 AM, the
> following:
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> - Reworked and simplified the execution paths for better
>> =A0readability and to avoid duplication of code,
>
> is it possible to split this good rewrite into logical chunks for bet=
ter and
> easier reviewability?
>
> my suggestion clean each of the paths independently - like the code u=
pto
> wfi.. and then we can clean up the resume path as well separately.
>
>> - Added comments on the entry and exit points and the interaction
>> =A0with the ROM code for OFF mode restore,
>> - Reworked the existing comments for better readability.
>
> thanks for doing this, but, just my suggestion, looking at the amount=
 of
> changes done in this patch -> if you can keep one patch for functiona=
l
> change which is separate from cosmetic change (such as comment cleanu=
p and
> addition), it makes a reviewer's life easier :)
>
>>
>> Tested on N900 and Beagleboard with full RET and OFF modes,
>> using cpuidle and suspend.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/control.c =A0 | =A0 =A09 +-
>> =A0arch/arm/mach-omap2/sleep34xx.S | =A0313
>> +++++++++++++++++++++++----------------
>> =A02 files changed, 191 insertions(+), 131 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/con=
trol.c
>> index 728f268..f4b19ed 100644
>> --- a/arch/arm/mach-omap2/control.c
>> +++ b/arch/arm/mach-omap2/control.c
>> @@ -239,7 +239,14 @@ void omap3_save_scratchpad_contents(void)
>> =A0 =A0 =A0 =A0struct omap3_scratchpad_prcm_block prcm_block_content=
s;
>> =A0 =A0 =A0 =A0struct omap3_scratchpad_sdrc_block sdrc_block_content=
s;
>> =A0- =A0 =A0 =A0/* Populate the Scratchpad contents */
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Populate the Scratchpad contents
>> + =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0* The "get_*restore_pointer" functions are used to =
provide a
>> + =A0 =A0 =A0 =A0* physical restore address where the ROM code jumps=
 while waking
>> + =A0 =A0 =A0 =A0* up from MPU OFF/OSWR state.
>
> Just curious: we dont have OSWR(open switch retention) in l-o unless =
I am
> mistaken.. we have cswr (closed switch retention).
Yes that is correct. OSWR is not supported for now, OFF is.

>
>> + =A0 =A0 =A0 =A0* The restore pointer is stored into the scratchpad=
=2E
>> + =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0scratchpad_contents.boot_config_ptr =3D 0x0;
>> =A0 =A0 =A0 =A0if (cpu_is_omap3630())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratchpad_contents.public_restore_pt=
r =3D
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S
>> b/arch/arm/mach-omap2/sleep34xx.S
>> index beeb682..12061fd 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -71,6 +71,13 @@
>> =A0* API functions
>> =A0*/
>> =A0+/*
>> + * The "get_*restore_pointer" functions are used to provide a
>> + * physical restore address where the ROM code jumps while waking
>> + * up from MPU OFF/OSWR state.
>> + * The restore pointer is stored into the scratchpad.
>> + */
>> +
>
> we need to cleanup comments such as those used below:
>
>> =A0 =A0 =A0 =A0.text
>> =A0/* Function call to get the restore pointer for resume from OFF *=
/
>
> ^^^^
> may be make it explicit what the difference for get_restore_pointer i=
s etc..
>
>> =A0ENTRY(get_restore_pointer)
>> @@ -102,7 +109,7 @@ ENTRY(get_es3_restore_pointer_sz)
>> =A0/*
>> =A0* L2 cache needs to be toggled for stable OFF mode functionality =
on 3630.
>> =A0* This function sets up a flag that will allow for this toggling =
to take
>> - * place on 3630. Hopefully some version in the future maynot need =
this
>> + * place on 3630. Hopefully some version in the future may not need=
 this.
>
> I think we should split the patch up for the comment cleanup -> it is=
 a
> little nuisance trying to review the actual functional change mixed w=
ith
> comment cleanups together..
>
>> =A0*/
>> =A0ENTRY(enable_omap3630_toggle_l2_on_restore)
>> =A0 =A0 =A0 =A0 stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on stac=
k
>> @@ -144,34 +151,158 @@ ENTRY(save_secure_ram_context_sz)
>> =A0 =A0 =A0 =A0.word =A0 . - save_secure_ram_context
>> =A0/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Idle entry point =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> +
>> +/*
>> =A0* Forces OMAP into idle state
>> =A0*
>> - * omap34xx_suspend() - This bit of code just executes the WFI
>> - * for normal idles.
>> + * omap34xx_suspend() - This bit of code saves the CPU context if n=
eeded
>> + * and executes the WFI instruction
>
> since we are cleaning up, I might as well suggest - what condition do=
 we
> save the CPU context might be worth mentioning. is this called during=
 RET
> transition or OFF transition is not clear..
Re-phrased that.

>>
>> =A0*
>> - * Note: This code get's copied to internal SRAM at boot. When the =
OMAP
>> - * =A0 =A0 =A0wakes up it continues execution at the point it went =
to sleep.
>> + * Notes:
>> + * - this code gets copied to internal SRAM at boot.
>> + * - when the OMAP wakes up it continues at different execution poi=
nts
>> + * =A0 depending on the low power mode (non-OFF vs OFF modes),
>> + * =A0 cf. 'Resume path for xxx mode' comments.
>
> Further, might as well help people and say that this is the call
> _omap_sram_idle actually takes ;)
Added

>
> Also might be a little indepth pseudo code overview of this complex c=
ode
> flow might help for code maintainers later on..
>
> omap34xx_cpu_suspend
> =A0 |- if Context save not required -> omap3_do_wfi -> wfi
> =A0 \- if context save required: -> save_context_wfi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cache =
maintenance:
> cache maintenance:
> =A0 =A0 =A0 =A0- what happens when l1 is lost, what happens when l2 i=
s lost..
This can come later as the code settles down a bit.

>
>> =A0*/
>> =A0ENTRY(omap34xx_cpu_suspend)
>> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 @ save registers on stack
>> =A0- =A0 =A0 =A0/* r0 contains restore pointer in sdram */
>> - =A0 =A0 =A0 /* r1 contains information about saving context */
>> - =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ read t=
he SDRC_POWER register
>> - =A0 =A0 =A0 ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
read the contents of SDRC_POWER
>> - =A0 =A0 =A0 orr =A0 =A0 r5, r5, #0x40 =A0 =A0 =A0 =A0 =A0 @ enable=
 self refresh on idle req
>> - =A0 =A0 =A0 str =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
write back to SDRC_POWER
>> register
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* r0 contains restore pointer in sdram
>> + =A0 =A0 =A0 =A0* r1 contains information about saving context:
>> + =A0 =A0 =A0 =A0* =A0 0 - No context lost
>> + =A0 =A0 =A0 =A0* =A0 1 - Only L1 and logic lost
>> + =A0 =A0 =A0 =A0* =A0 2 - Only L2 lost
>> + =A0 =A0 =A0 =A0* =A0 3 - Both L1 and L2 lost
>
> Since we are cleaning up, one generic Suggestion:
> since these 0 1 2 3 are used by pm34xx.c and this code alone, we migh=
t as
> well define it in a common header and save ourselves the pain of defi=
ning
> this in 2 places and some one screwing things up later on..
>

That makes perfect sense! However that will be done later since it
touches the code dangerously.

> looking at pm34xx.c, I dont see 2 being defined at all :( unless I mi=
ssed
> something, pm34xx.c:
> =A0switch (mpu_next_state) {
> =A0case PWRDM_POWER_ON:
> =A0case PWRDM_POWER_RET:
> =A0 =A0 =A0 =A0 /* No need to save context */
> Which is kind of funny for me. since we use this parameter to determi=
ne to
> clean cache or not :D - another misinterpretation of using values ins=
tead of
> readable macros ;)
> =A0 =A0 =A0 =A0 save_state =3D 0;
> =A0 =A0 =A0 =A0 break;
> =A0case PWRDM_POWER_OFF:
> =A0 =A0 =A0 =A0 save_state =3D 3;
> =A0 =A0 =A0 =A0 break;
>
>> + =A0 =A0 =A0 =A0*/
>> =A0+ =A0 =A0 =A0/* Save context only if required */
>> =A0 =A0 =A0 =A0cmp =A0 =A0 r1, #0x0
>> - =A0 =A0 =A0 /* If context save is required, do that and execute wf=
i */
>> - =A0 =A0 =A0 bne =A0 =A0 save_context_wfi
>> + =A0 =A0 =A0 beq =A0 =A0 omap3_do_wfi
>> +
>
> Add comment to fall through here.
>
>> +save_context_wfi:
>> + =A0 =A0 =A0 mov =A0 =A0 r8, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ Store SDRAM address in r8
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c1, c0, 1 =A0 @ Read Auxiliary=
 Control Register
>> + =A0 =A0 =A0 mov =A0 =A0 r4, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
Number of parameters for restore
>> call
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push p=
arameters for restore call
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 1, r5, c9, c0, 2 =A0 @ Read L2 AUX ct=
rl register
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push p=
arameters for restore call
>> +
>> + =A0 =A0 =A0 =A0/* Check what that target sleep state is from r1 */
>> + =A0 =A0 =A0 cmp =A0 =A0 r1, #0x2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
Only L2 lost, no need to save
>> context
>> + =A0 =A0 =A0 beq =A0 =A0 clean_caches
>
> one suggestion here:
> how about:
> =A0 =A0 =A0 =A0and rn, r1, #L2_LOGIC_LOST
> =A0 =A0 =A0 =A0cmp rn, #L2_LOGIC_LOST
> =A0 =A0 =A0 =A0bleq l2_cleanup
> =A0 =A0 =A0 =A0and rn, r1, #L1_LOGIC_LOST
> =A0 =A0 =A0 =A0cmp rn, #L1_LOGIC_LOST
> =A0 =A0 =A0 =A0bleq l1_cleanup
> =A0 =A0 =A0 =A0move the omap3_do_wfi code here
>
> l1_cleanup:
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0save_context
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0return back
>
> l2_cleanup:
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0return back
>
> or am I simplifying things too much here?
>
>> +
>> +l1_logic_lost:
>> + =A0 =A0 =A0 /* Store sp and spsr to SDRAM */
>> + =A0 =A0 =A0 mov =A0 =A0 r4, sp
>> + =A0 =A0 =A0 mrs =A0 =A0 r5, spsr
>> + =A0 =A0 =A0 mov =A0 =A0 r6, lr
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 =A0 /* Save all ARM registers */
>> + =A0 =A0 =A0 /* Coprocessor access control register */
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c1, c0, 2
>> + =A0 =A0 =A0 stmia =A0 r8!, {r6}
>> + =A0 =A0 =A0 /* TTBR0, TTBR1 and Translation table base control */
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c2, c0, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c2, c0, 1
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c2, c0, 2
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Domain access control register, data fault status=
 register,
>> + =A0 =A0 =A0 =A0* and instruction fault status register
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c3, c0, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c0, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c5, c0, 1
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Data aux fault status register, instruction aux f=
ault status,
>> + =A0 =A0 =A0 =A0* data fault address register and instruction fault=
 address
>> register
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c5, c1, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c1, 1
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c6, c0, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c6, c0, 2
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r7}
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* user r/w thread and process ID, user r/o thread a=
nd process ID,
>> + =A0 =A0 =A0 =A0* priv only thread and process ID, cache size selec=
tion
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 2
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 3
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 4
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 2, r7, c0, c0, 0
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r7}
>> + =A0 =A0 =A0 /* Data TLB lockdown, instruction TLB lockdown registe=
rs */
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c0, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c10, c0, 1
>> + =A0 =A0 =A0 stmia =A0 r8!, {r5-r6}
>> + =A0 =A0 =A0 /* Secure or non secure vector base address, FCSE PID,=
 Context
>> PID*/
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c12, c0, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 1
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> + =A0 =A0 =A0 /* Primary remap, normal remap registers */
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c10, c2, 0
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c2, 1
>> + =A0 =A0 =A0 stmia =A0 r8!,{r4-r5}
>> +
>> + =A0 =A0 =A0 /* Store current cpsr*/
>> + =A0 =A0 =A0 mrs =A0 =A0 r2, cpsr
>> + =A0 =A0 =A0 stmia =A0 r8!, {r2}
>> +
>> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c1, c0, 0
>> + =A0 =A0 =A0 /* save control register */
>> + =A0 =A0 =A0 stmia =A0 r8!, {r4}
>> +
>> +clean_caches:
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Clean Data or unified cache to POU
>> + =A0 =A0 =A0 =A0* How to invalidate only L1 cache???? - #FIX_ME#
>> + =A0 =A0 =A0 =A0* mcr =A0p15, 0, r11, c7, c11, 1
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 cmp =A0 =A0 r1, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
Check whether L2 inval is
>> required
>> + =A0 =A0 =A0 beq =A0 =A0 omap3_do_wfi
>> +
>> +clean_l2:
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* jump out to kernel flush routine
>> + =A0 =A0 =A0 =A0* =A0- reuse that code is better
>> + =A0 =A0 =A0 =A0* =A0- it executes in a cached space so is faster t=
han refetch
>> per-block
>> + =A0 =A0 =A0 =A0* =A0- should be faster and will change with kernel
>> + =A0 =A0 =A0 =A0* =A0- 'might' have to copy address, load and jump =
to it
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 ldr r1, kernel_flush
>> + =A0 =A0 =A0 mov lr, pc
>> + =A0 =A0 =A0 bx =A0r1
>> +
>> +omap3_do_wfi:
>
> recommend changing the name -> basically the flow is split into two:
> wfi with save of context: save_context_wfi
> wfi without save of context: omap3_do_wfi (I suppose the naming is be=
cause
> it is being used in multiple paths)
>
>
>
>> + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ read t=
he SDRC_POWER register
>> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
read the contents of SDRC_POWER
>> + =A0 =A0 =A0 orr =A0 =A0 r5, r5, #0x40 =A0 =A0 =A0 =A0 =A0 @ enable=
 self refresh on idle req
>> + =A0 =A0 =A0 str =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
write back to SDRC_POWER
>> register
>> +
>
> we just changed the functional sequence of when we enable self refres=
h on
> idle req (previously - this was the first step on entry, now, we do t=
his
> after context save) -> this should be a separate patch of it's own fo=
r
> tracking any issues that may be detected by this change i suppose.
>
>> =A0 =A0 =A0 =A0/* Data memory barrier and Data sync barrier */
>> =A0 =A0 =A0 =A0mov =A0 =A0 r1, #0
>> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r1, c7, c10, 4
>> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r1, c7, c10, 5
>> =A0+/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D WFI instruction =3D> Enter idle =3D=3D
>
> idle is a bit confusing -> cpu idle can hit both RET and OFF..
>
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> =A0 =A0 =A0 =A0wfi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ wait for interrupt
>> =A0+/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Resume path for non-OFF modes =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> =A0 =A0 =A0 =A0nop
>> =A0 =A0 =A0 =A0nop
>> =A0 =A0 =A0 =A0nop
>> @@ -184,7 +315,29 @@ ENTRY(omap34xx_cpu_suspend)
>> =A0 =A0 =A0 =A0nop
>> =A0 =A0 =A0 =A0bl wait_sdrc_ok
>> =A0- =A0 =A0 =A0ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 @ restore regs and return
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Exit point from non-OFF modes =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> + =A0 =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore regs=
 and return
>
> cosmetic changes like this belong it's own patch to help the reviewer=
=2E
>
>> +
>> +
>
> additional EOL?
>>
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
>> =A0 =A0 =A0 =A0ldr =A0 =A0 r5, pm_prepwstst_core_p
>> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, [r5]
>> @@ -214,12 +367,17 @@ restore_3630:
>> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, control_mem_rta
>> =A0 =A0 =A0 =A0mov =A0 =A0 r2, #OMAP36XX_RTA_DISABLE
>> =A0 =A0 =A0 =A0str =A0 =A0 r2, [r1]
>> - =A0 =A0 =A0 /* Fall thru for the remaining logic */
>> +
>> + =A0 =A0 =A0 /* Fall thru to common code for the remaining logic */
>
> might as well replace thru with through ;)
Done!

>
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
>> + =A0 =A0 =A0 =A0* Check what was the reason for mpu reset and store=
 the reason in
>> r9:
>> + =A0 =A0 =A0 =A0* =A00 - No context lost
>> + =A0 =A0 =A0 =A0 * =A01 - Only L1 and logic lost
>> + =A0 =A0 =A0 =A0 * =A02 - Only L2 lost - In this case, we wont be h=
ere
>> + =A0 =A0 =A0 =A0 * =A03 - Both L1 and L2 lost
>> + =A0 =A0 =A0 =A0*/
>
> again something we can skip if we were to use #defines.
>
>> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, pm_pwstctrl_mpu
>> =A0 =A0 =A0 =A0ldr =A0 =A0 r2, [r1]
>> =A0 =A0 =A0 =A0and =A0 =A0 r2, r2, #0x3
>> @@ -422,118 +580,12 @@ usettbr0:
>> =A0 =A0 =A0 =A0and =A0 =A0 r4, r2
>> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r4, c1, c0, 0
>> =A0+/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Exit point from OFF mode =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> =A0 =A0 =A0 =A0ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 @ restore regs and return
>> -save_context_wfi:
>> - =A0 =A0 =A0 mov =A0 =A0 r8, r0 /* Store SDRAM address in r8 */
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c1, c0, 1 =A0 @ Read Auxiliary=
 Control Register
>> - =A0 =A0 =A0 mov =A0 =A0 r4, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
Number of parameters for restore
>> call
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push p=
arameters for restore call
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 1, r5, c9, c0, 2 =A0 @ Read L2 AUX ct=
rl register
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r5} =A0 =A0 =A0 =A0 =A0 =A0@ Push p=
arameters for restore call
>> - =A0 =A0 =A0 =A0/* Check what that target sleep state is:stored in =
r1*/
>> - =A0 =A0 =A0 =A0/* 1 - Only L1 and logic lost */
>> - =A0 =A0 =A0 =A0/* 2 - Only L2 lost */
>> - =A0 =A0 =A0 =A0/* 3 - Both L1 and L2 lost */
>> - =A0 =A0 =A0 cmp =A0 =A0 r1, #0x2 /* Only L2 lost */
>> - =A0 =A0 =A0 beq =A0 =A0 clean_l2
>> - =A0 =A0 =A0 cmp =A0 =A0 r1, #0x1 /* L2 retained */
>> - =A0 =A0 =A0 /* r9 stores whether to clean L2 or not*/
>> - =A0 =A0 =A0 moveq =A0 r9, #0x0 /* Dont Clean L2 */
>> - =A0 =A0 =A0 movne =A0 r9, #0x1 /* Clean L2 */
>> -l1_logic_lost:
>> - =A0 =A0 =A0 /* Store sp and spsr to SDRAM */
>> - =A0 =A0 =A0 mov =A0 =A0 r4, sp
>> - =A0 =A0 =A0 mrs =A0 =A0 r5, spsr
>> - =A0 =A0 =A0 mov =A0 =A0 r6, lr
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 =A0 /* Save all ARM registers */
>> - =A0 =A0 =A0 /* Coprocessor access control register */
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c1, c0, 2
>> - =A0 =A0 =A0 stmia =A0 r8!, {r6}
>> - =A0 =A0 =A0 /* TTBR0, TTBR1 and Translation table base control */
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c2, c0, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c2, c0, 1
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c2, c0, 2
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 =A0 /* Domain access control register, data fault status r=
egister,
>> - =A0 =A0 =A0 and instruction fault status register */
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c3, c0, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c0, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c5, c0, 1
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 =A0 /* Data aux fault status register, instruction aux fau=
lt status,
>> - =A0 =A0 =A0 datat fault address register and instruction fault add=
ress
>> register*/
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c5, c1, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c5, c1, 1
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c6, c0, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c6, c0, 2
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r7}
>> - =A0 =A0 =A0 /* user r/w thread and process ID, user r/o thread and=
 process ID,
>> - =A0 =A0 =A0 priv only thread and process ID, cache size selection =
*/
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 2
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 3
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 4
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 2, r7, c0, c0, 0
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r7}
>> - =A0 =A0 =A0 /* Data TLB lockdown, instruction TLB lockdown registe=
rs */
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c0, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c10, c0, 1
>> - =A0 =A0 =A0 stmia =A0 r8!, {r5-r6}
>> - =A0 =A0 =A0 /* Secure or non secure vector base address, FCSE PID,=
 Context
>> PID*/
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c12, c0, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 1
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4-r6}
>> - =A0 =A0 =A0 /* Primary remap, normal remap registers */
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c10, c2, 0
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c10, c2, 1
>> - =A0 =A0 =A0 stmia =A0 r8!,{r4-r5}
>> -
>> - =A0 =A0 =A0 /* Store current cpsr*/
>> - =A0 =A0 =A0 mrs =A0 =A0 r2, cpsr
>> - =A0 =A0 =A0 stmia =A0 r8!, {r2}
>> -
>> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c1, c0, 0
>> - =A0 =A0 =A0 /* save control register */
>> - =A0 =A0 =A0 stmia =A0 r8!, {r4}
>> -clean_caches:
>> - =A0 =A0 =A0 /* Clean Data or unified cache to POU*/
>> - =A0 =A0 =A0 /* How to invalidate only L1 cache???? - #FIX_ME# */
>> - =A0 =A0 =A0 /* mcr =A0p15, 0, r11, c7, c11, 1 */
>> - =A0 =A0 =A0 cmp =A0 =A0 r9, #1 /* Check whether L2 inval is requir=
ed or not*/
>> - =A0 =A0 =A0 bne =A0 =A0 skip_l2_inval
>> -clean_l2:
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Jump out to kernel flush routine
>> - =A0 =A0 =A0 =A0* =A0- reuse that code is better
>> - =A0 =A0 =A0 =A0* =A0- it executes in a cached space so is faster t=
han refetch
>> per-block
>> - =A0 =A0 =A0 =A0* =A0- should be faster and will change with kernel
>> - =A0 =A0 =A0 =A0* =A0- 'might' have to copy address, load and jump =
to it
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 ldr r1, kernel_flush
>> - =A0 =A0 =A0 mov lr, pc
>> - =A0 =A0 =A0 bx =A0r1
>> -
>> -skip_l2_inval:
>> - =A0 =A0 =A0 /* Data memory barrier and Data sync barrier */
>> - =A0 =A0 =A0 mov =A0 =A0 r1, #0
>> - =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 4
>> - =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 5
>> -
>> - =A0 =A0 =A0 wfi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ wait for interrupt
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 nop
>> - =A0 =A0 =A0 bl wait_sdrc_ok
>> - =A0 =A0 =A0 /* restore regs and return */
>> - =A0 =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc}
>> =A0 /*
>> @@ -683,5 +735,6 @@ kick_counter:
>> =A0 =A0 =A0 =A0.word =A0 0
>> =A0wait_dll_lock_counter:
>> =A0 =A0 =A0 =A0.word =A0 0
>> +
>
> spurious change.
>
>> =A0ENTRY(omap34xx_cpu_suspend_sz)
>> =A0 =A0 =A0 =A0.word =A0 . - omap34xx_cpu_suspend
>
> as such, this patch:
>
> Tested-by: Nishanth Menon <nm@ti.com>
> Tested on:
> SDP3630
> SDP3430
> Test script:
> http://pastebin.mozilla.org/889933
>
>
> --
> Regards,
> Nishanth Menon
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
