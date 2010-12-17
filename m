From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 7/7] OMAP3: ASM sleep code format rework
Date: Fri, 17 Dec 2010 11:16:19 +0100
Message-ID: <AANLkTim8_c4Qr5Y2j6yPHp+u9QgU0rsyfef_7GOCMXUT@mail.gmail.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
	<1292521858-3810-8-git-send-email-j-pihet@ti.com>
	<6300c4109ddb89205374f8034dee55fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41843 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab0LQKQV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 05:16:21 -0500
Received: by qwa26 with SMTP id 26so506585qwa.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:16:20 -0800 (PST)
In-Reply-To: <6300c4109ddb89205374f8034dee55fd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

On Fri, Dec 17, 2010 at 6:09 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
>> Sent: Thursday, December 16, 2010 11:21 PM
>> To: linux-omap@vger.kernel.org
>> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.or=
g;
>> Jean Pihet
>> Subject: [PATCH 7/7] OMAP3: ASM sleep code format rework
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Cosmetic fixes to the code:
>> - white spaces and tabs,
>> - alignement,
>> - comments rephrase and typos,
>> - multi-line comments
>>
>> Tested on N900 and Beagleboard with full RET and OFF modes,
>> using cpuidle and suspend.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/sleep34xx.S | =A0221
> +++++++++++++++++++++-------------
>> -----
>> =A01 files changed, 118 insertions(+), 103 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
>> omap2/sleep34xx.S
>> index 207f6e9..9c1c57e 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -1,6 +1,10 @@
>> =A0/*
>> =A0 * linux/arch/arm/mach-omap2/sleep.S
>> =A0 *
>> + * (C) Copyright 2010
>> + * Texas Instruments
>> + * Jean Pihet <j-pihet@ti.com>
>> + *
>> =A0 * (C) Copyright 2007
>> =A0 * Texas Instruments
>> =A0 * Karthik Dasu <karthik-dp@ti.com>
>> @@ -78,20 +82,20 @@
>> =A0 =A0 =A0 .text
>> =A0/* Function call to get the restore pointer for resume from OFF *=
/
>> =A0ENTRY(get_restore_pointer)
>> - =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on sta=
ck
>> + =A0 =A0 stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on stack
>> =A0 =A0 =A0 adr =A0 =A0 r0, restore
>> - =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and retu=
rn
>> + =A0 =A0 ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and return
>> =A0ENTRY(get_restore_pointer_sz)
>> - =A0 =A0 =A0 =A0.word =A0 . - get_restore_pointer
>> + =A0 =A0 .word =A0 . - get_restore_pointer
>>
>> =A0 =A0 =A0 .text
>> =A0/* Function call to get the restore pointer for 3630 resume from =
OFF */
>> =A0ENTRY(get_omap3630_restore_pointer)
>> - =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on sta=
ck
>> + =A0 =A0 stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on stack
>> =A0 =A0 =A0 adr =A0 =A0 r0, restore_3630
>> - =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and retu=
rn
>> + =A0 =A0 ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and return
>> =A0ENTRY(get_omap3630_restore_pointer_sz)
>> - =A0 =A0 =A0 =A0.word =A0 . - get_omap3630_restore_pointer
>> + =A0 =A0 .word =A0 . - get_omap3630_restore_pointer
>>
>> =A0 =A0 =A0 .text
>> =A0/* Function call to get the restore pointer for ES3 to resume fro=
m OFF
> */
>> @@ -109,16 +113,16 @@ ENTRY(get_es3_restore_pointer_sz)
>> =A0 * place on 3630. Hopefully some version in the future maynot nee=
d
> this.
>> =A0 */
>> =A0ENTRY(enable_omap3630_toggle_l2_on_restore)
>> - =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on sta=
ck
>> + =A0 =A0 stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on stack
>> =A0 =A0 =A0 /* Setup so that we will disable and enable l2 */
>> =A0 =A0 =A0 mov =A0 =A0 r1, #0x1
>> =A0 =A0 =A0 str =A0 =A0 r1, l2dis_3630
>> - =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and retu=
rn
>> + =A0 =A0 ldmfd =A0 sp!, {pc} =A0 =A0 =A0 @ restore regs and return
>>
>> + =A0 =A0 .text
>> =A0/* Function to call rom code to save secure ram context */
>> =A0ENTRY(save_secure_ram_context)
>> =A0 =A0 =A0 stmfd =A0 sp!, {r1-r12, lr} =A0 =A0 =A0 @ save registers=
 on stack
>> -
>> =A0 =A0 =A0 adr =A0 =A0 r3, api_params =A0 =A0 =A0 =A0 =A0@ r3 point=
s to parameters
>> =A0 =A0 =A0 str =A0 =A0 r0, [r3,#0x4] =A0 =A0 =A0 =A0 =A0 @ r0 has s=
dram address
>> =A0 =A0 =A0 ldr =A0 =A0 r12, high_mask
>> @@ -147,6 +151,7 @@ api_params:
>> =A0ENTRY(save_secure_ram_context_sz)
>> =A0 =A0 =A0 .word =A0 . - save_secure_ram_context
>>
>> +
>> =A0/*
>> =A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> =A0 * =3D=3D Idle entry point =3D=3D
>> @@ -160,13 +165,14 @@ ENTRY(save_secure_ram_context_sz)
>> =A0 * and executes the WFI instruction
>> =A0 *
>> =A0 * Notes:
>> - * - this code gets copied to internal SRAM at boot.
>> + * - this code gets copied to internal SRAM at boot and after wake-=
up
>> + * =A0 from OFF mode
>> =A0 * - when the OMAP wakes up it continues at different execution p=
oints
>> =A0 * =A0 depending on the low power mode (non-OFF vs OFF modes),
>> =A0 * =A0 cf. 'Resume path for xxx mode' comments.
>> =A0 */
>> =A0ENTRY(omap34xx_cpu_suspend)
>> - =A0 =A0 stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ =
save registers on stack
>> + =A0 =A0 stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 @ save registers o=
n stack
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* r0 contains restore pointer in sdram
>> @@ -271,9 +277,9 @@ clean_l2:
>> =A0 =A0 =A0 =A0* =A0- should be faster and will change with kernel
>> =A0 =A0 =A0 =A0* =A0- 'might' have to copy address, load and jump to=
 it
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 ldr r1, kernel_flush
>> - =A0 =A0 mov lr, pc
>> - =A0 =A0 bx =A0r1
>> + =A0 =A0 ldr =A0 =A0 r1, kernel_flush
>> + =A0 =A0 mov =A0 =A0 lr, pc
>> + =A0 =A0 bx =A0 =A0 =A0r1
>>
>> =A0omap3_do_wfi:
>> =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ read the=
 SDRC_POWER register
>> @@ -366,18 +372,18 @@ restore_3630:
>> =A0 =A0 =A0 /* Fall thru to common code for the remaining logic */
>>
>> =A0restore:
>> - =A0 =A0 =A0 =A0/*
>> + =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Check what was the reason for mpu reset and store t=
he reason in
>> r9:
>> =A0 =A0 =A0 =A0* =A00 - No context lost
>> - =A0 =A0 =A0 =A0 * =A01 - Only L1 and logic lost
>> - =A0 =A0 =A0 =A0 * =A02 - Only L2 lost - In this case, we wont be h=
ere
>> - =A0 =A0 =A0 =A0 * =A03 - Both L1 and L2 lost
>> + =A0 =A0 =A0* =A01 - Only L1 and logic lost
>> + =A0 =A0 =A0* =A02 - Only L2 lost - In this case, we wont be here
>> + =A0 =A0 =A0* =A03 - Both L1 and L2 lost
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 ldr =A0 =A0 r1, pm_pwstctrl_mpu
>> + =A0 =A0 ldr =A0 =A0 r1, pm_pwstctrl_mpu
>> =A0 =A0 =A0 ldr =A0 =A0 r2, [r1]
>> - =A0 =A0 and =A0 =A0 r2, r2, #0x3
>> - =A0 =A0 cmp =A0 =A0 r2, #0x0 =A0 =A0 =A0 =A0@ Check if target powe=
r state was OFF or
> RET
>> - =A0 =A0 =A0 =A0moveq =A0 r9, #0x3 =A0 =A0 =A0 =A0@ MPU OFF =3D> L1=
 and L2 lost
>> + =A0 =A0 and =A0 =A0 r2, r2, #0x3
>> + =A0 =A0 cmp =A0 =A0 r2, #0x0 =A0 =A0 =A0 =A0@ Check if target powe=
r state was OFF or
> RET
>> + =A0 =A0 moveq =A0 r9, #0x3 =A0 =A0 =A0 =A0@ MPU OFF =3D> L1 and L2=
 lost
>> =A0 =A0 =A0 movne =A0 r9, #0x1 =A0 =A0 =A0 =A0@ Only L1 and L2 lost =
=3D> avoid L2
> invalidation
>> =A0 =A0 =A0 bne =A0 =A0 logic_l1_restore
>>
>> @@ -393,71 +399,74 @@ skipl2dis:
>> =A0 =A0 =A0 and =A0 =A0 r1, #0x700
>> =A0 =A0 =A0 cmp =A0 =A0 r1, #0x300
>> =A0 =A0 =A0 beq =A0 =A0 l2_inv_gp
>> - =A0 =A0 mov =A0 =A0 r0, #40 =A0 =A0 =A0 =A0 @ set service ID for P=
PA
>> - =A0 =A0 mov =A0 =A0 r12, r0 =A0 =A0 =A0 =A0 @ copy secure Service =
ID in r12
>> - =A0 =A0 mov =A0 =A0 r1, #0 =A0 =A0 =A0 =A0 =A0@ set task id for RO=
M code in r1
>> - =A0 =A0 mov =A0 =A0 r2, #4 =A0 =A0 =A0 =A0 =A0@ set some flags in =
r2, r6
>> + =A0 =A0 mov =A0 =A0 r0, #40 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ set =
service ID for PPA
>> + =A0 =A0 mov =A0 =A0 r12, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ copy=
 secure Service ID in r12
>> + =A0 =A0 mov =A0 =A0 r1, #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ se=
t task id for ROM code in r1
>> + =A0 =A0 mov =A0 =A0 r2, #4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ se=
t some flags in r2, r6
>> =A0 =A0 =A0 mov =A0 =A0 r6, #0xff
>> =A0 =A0 =A0 adr =A0 =A0 r3, l2_inv_api_params =A0 @ r3 points to dum=
my parameters
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0@ data write barri=
er
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c10, 5 =A0@ data memory barr=
ier
>> =A0 =A0 =A0 .word =A0 0xE1600071 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ call S=
MI monitor (smi #1)
>> =A0 =A0 =A0 /* Write to Aux control register to set some bits */
>> - =A0 =A0 mov =A0 =A0 r0, #42 =A0 =A0 =A0 =A0 @ set service ID for P=
PA
>> - =A0 =A0 mov =A0 =A0 r12, r0 =A0 =A0 =A0 =A0 @ copy secure Service =
ID in r12
>> - =A0 =A0 mov =A0 =A0 r1, #0 =A0 =A0 =A0 =A0 =A0@ set task id for RO=
M code in r1
>> - =A0 =A0 mov =A0 =A0 r2, #4 =A0 =A0 =A0 =A0 =A0@ set some flags in =
r2, r6
>> + =A0 =A0 mov =A0 =A0 r0, #42 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ set =
service ID for PPA
>> + =A0 =A0 mov =A0 =A0 r12, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ copy=
 secure Service ID in r12
>> + =A0 =A0 mov =A0 =A0 r1, #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ se=
t task id for ROM code in r1
>> + =A0 =A0 mov =A0 =A0 r2, #4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ se=
t some flags in r2, r6
>> =A0 =A0 =A0 mov =A0 =A0 r6, #0xff
>> =A0 =A0 =A0 ldr =A0 =A0 r4, scratchpad_base
>> - =A0 =A0 ldr =A0 =A0 r3, [r4, #0xBC] @ r3 points to parameters
>> + =A0 =A0 ldr =A0 =A0 r3, [r4, #0xBC] =A0 =A0 =A0 =A0 @ r3 points to=
 parameters
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0@ data write barri=
er
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c10, 5 =A0@ data memory barr=
ier
>> =A0 =A0 =A0 .word =A0 0xE1600071 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ call S=
MI monitor (smi #1)
>>
>> =A0#ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
>> =A0 =A0 =A0 /* Restore L2 aux control register */
>> - =A0 =A0 @ set service ID for PPA
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ set service ID for PPA
>> =A0 =A0 =A0 mov =A0 =A0 r0, #CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_=
ID
>> - =A0 =A0 mov =A0 =A0 r12, r0 =A0 =A0 =A0 =A0 @ copy service ID in r=
12
>> - =A0 =A0 mov =A0 =A0 r1, #0 =A0 =A0 =A0 =A0 =A0@ set task ID for RO=
M code in r1
>> - =A0 =A0 mov =A0 =A0 r2, #4 =A0 =A0 =A0 =A0 =A0@ set some flags in =
r2, r6
>> + =A0 =A0 mov =A0 =A0 r12, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ copy=
 service ID in r12
>> + =A0 =A0 mov =A0 =A0 r1, #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ se=
t task ID for ROM code in r1
>> + =A0 =A0 mov =A0 =A0 r2, #4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ se=
t some flags in r2, r6
>> =A0 =A0 =A0 mov =A0 =A0 r6, #0xff
>> =A0 =A0 =A0 ldr =A0 =A0 r4, scratchpad_base
>> =A0 =A0 =A0 ldr =A0 =A0 r3, [r4, #0xBC]
>> - =A0 =A0 adds =A0 =A0r3, r3, #8 =A0 =A0 =A0@ r3 points to parameter=
s
>> + =A0 =A0 adds =A0 =A0r3, r3, #8 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ r3 poi=
nts to parameters
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0@ data write barri=
er
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c10, 5 =A0@ data memory barr=
ier
>> =A0 =A0 =A0 .word =A0 0xE1600071 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ call S=
MI monitor (smi #1)
>> =A0#endif
>> =A0 =A0 =A0 b =A0 =A0 =A0 logic_l1_restore
>> +
>> =A0l2_inv_api_params:
>> - =A0 =A0 .word =A0 0x1, 0x00
>> + =A0 =A0 .word =A0 0x1, 0x00
>> =A0l2_inv_gp:
>> =A0 =A0 =A0 /* Execute smi to invalidate L2 cache */
>> - =A0 =A0 mov r12, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 @ set up to invalide L2
>> -smi: =A0 =A0.word 0xE1600070 =A0 =A0 =A0 =A0 =A0 =A0 @ Call SMI mon=
itor (smieq)
>> + =A0 =A0 mov r12, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ set up=
 to invalidate L2
>> + =A0 =A0 .word 0xE1600070 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Call SMI=
 monitor (smieq)
>> =A0 =A0 =A0 /* Write to Aux control register to set some bits */
>> =A0 =A0 =A0 ldr =A0 =A0 r4, scratchpad_base
>> =A0 =A0 =A0 ldr =A0 =A0 r3, [r4,#0xBC]
>> =A0 =A0 =A0 ldr =A0 =A0 r0, [r3,#4]
>> =A0 =A0 =A0 mov =A0 =A0 r12, #0x3
>> - =A0 =A0 .word 0xE1600070 =A0 =A0 =A0 =A0@ Call SMI monitor (smieq)
>> + =A0 =A0 .word =A0 0xE1600070 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Call SMI=
 monitor (smieq)
>> =A0 =A0 =A0 ldr =A0 =A0 r4, scratchpad_base
>> =A0 =A0 =A0 ldr =A0 =A0 r3, [r4,#0xBC]
>> =A0 =A0 =A0 ldr =A0 =A0 r0, [r3,#12]
>> =A0 =A0 =A0 mov =A0 =A0 r12, #0x2
>> - =A0 =A0 .word 0xE1600070 =A0 =A0 =A0 =A0@ Call SMI monitor (smieq)
>> + =A0 =A0 .word =A0 0xE1600070 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Call SMI=
 monitor (smieq)
>> =A0logic_l1_restore:
>> =A0 =A0 =A0 ldr =A0 =A0 r1, l2dis_3630
>> - =A0 =A0 cmp =A0 =A0 r1, #0x1 =A0 =A0 =A0 =A0@ Do we need to re-ena=
ble L2 on 3630?
>> + =A0 =A0 cmp =A0 =A0 r1, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Test=
 if L2 re-enable needed on
> 3630
>> =A0 =A0 =A0 bne =A0 =A0 skipl2reen
>> =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r1, c1, c0, 1
>> - =A0 =A0 orr =A0 =A0 r1, r1, #2 =A0 =A0 =A0@ re-enable L2 cache
>> + =A0 =A0 orr =A0 =A0 r1, r1, #2 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ re-ena=
ble L2 cache
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c1, c0, 1
>> =A0skipl2reen:
>> =A0 =A0 =A0 mov =A0 =A0 r1, #0
>> - =A0 =A0 /* Invalidate all instruction caches to PoU
>> - =A0 =A0 =A0* and flush branch target cache */
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Invalidate all instruction caches to PoU
>> + =A0 =A0 =A0* and flush branch target cache
>> + =A0 =A0 =A0*/
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c5, 0
>>
>> =A0 =A0 =A0 ldr =A0 =A0 r4, scratchpad_base
>> @@ -478,33 +487,33 @@ skipl2reen:
>> =A0 =A0 =A0 MCR p15, 0, r6, c2, c0, 1
>> =A0 =A0 =A0 /* Translation table base control register */
>> =A0 =A0 =A0 MCR p15, 0, r7, c2, c0, 2
>> - =A0 =A0 /*domain access Control Register */
>> + =A0 =A0 /* Domain access Control Register */
>> =A0 =A0 =A0 MCR p15, 0, r8, c3, c0, 0
>> - =A0 =A0 /* data fault status Register */
>> + =A0 =A0 /* Data fault status Register */
>> =A0 =A0 =A0 MCR p15, 0, r9, c5, c0, 0
>>
>> - =A0 =A0 ldmia =A0r3!,{r4-r8}
>> - =A0 =A0 /* instruction fault status Register */
>> + =A0 =A0 ldmia =A0 r3!,{r4-r8}
>> + =A0 =A0 /* Instruction fault status Register */
>> =A0 =A0 =A0 MCR p15, 0, r4, c5, c0, 1
>> - =A0 =A0 /*Data Auxiliary Fault Status Register */
>> + =A0 =A0 /* Data Auxiliary Fault Status Register */
>> =A0 =A0 =A0 MCR p15, 0, r5, c5, c1, 0
>> - =A0 =A0 /*Instruction Auxiliary Fault Status Register*/
>> + =A0 =A0 /* Instruction Auxiliary Fault Status Register*/
>> =A0 =A0 =A0 MCR p15, 0, r6, c5, c1, 1
>> - =A0 =A0 /*Data Fault Address Register */
>> + =A0 =A0 /* Data Fault Address Register */
>> =A0 =A0 =A0 MCR p15, 0, r7, c6, c0, 0
>> - =A0 =A0 /*Instruction Fault Address Register*/
>> + =A0 =A0 /* Instruction Fault Address Register*/
>> =A0 =A0 =A0 MCR p15, 0, r8, c6, c0, 2
>> - =A0 =A0 ldmia =A0r3!,{r4-r7}
>> + =A0 =A0 ldmia =A0 r3!,{r4-r7}
>>
>> - =A0 =A0 /* user r/w thread and process ID */
>> + =A0 =A0 /* User r/w thread and process ID */
>> =A0 =A0 =A0 MCR p15, 0, r4, c13, c0, 2
>> - =A0 =A0 /* user ro thread and process ID */
>> + =A0 =A0 /* User ro thread and process ID */
>> =A0 =A0 =A0 MCR p15, 0, r5, c13, c0, 3
>> - =A0 =A0 /*Privileged only thread and process ID */
>> + =A0 =A0 /* Privileged only thread and process ID */
>> =A0 =A0 =A0 MCR p15, 0, r6, c13, c0, 4
>> - =A0 =A0 /* cache size selection */
>> + =A0 =A0 /* Cache size selection */
>> =A0 =A0 =A0 MCR p15, 2, r7, c0, c0, 0
>> - =A0 =A0 ldmia =A0r3!,{r4-r8}
>> + =A0 =A0 ldmia =A0 r3!,{r4-r8}
>> =A0 =A0 =A0 /* Data TLB lockdown registers */
>> =A0 =A0 =A0 MCR p15, 0, r4, c10, c0, 0
>> =A0 =A0 =A0 /* Instruction TLB lockdown registers */
>> @@ -516,26 +525,27 @@ skipl2reen:
>> =A0 =A0 =A0 /* Context PID */
>> =A0 =A0 =A0 MCR p15, 0, r8, c13, c0, 1
>>
>> - =A0 =A0 ldmia =A0r3!,{r4-r5}
>> - =A0 =A0 /* primary memory remap register */
>> + =A0 =A0 ldmia =A0 r3!,{r4-r5}
>> + =A0 =A0 /* Primary memory remap register */
>> =A0 =A0 =A0 MCR p15, 0, r4, c10, c2, 0
>> - =A0 =A0 /*normal memory remap register */
>> + =A0 =A0 /* Normal memory remap register */
>> =A0 =A0 =A0 MCR p15, 0, r5, c10, c2, 1
>>
>> =A0 =A0 =A0 /* Restore cpsr */
>> - =A0 =A0 ldmia =A0 r3!,{r4} =A0 =A0 =A0 =A0/*load CPSR from SDRAM*/
>> - =A0 =A0 msr =A0 =A0 cpsr, r4 =A0 =A0 =A0 =A0/*store cpsr */
>> + =A0 =A0 ldmia =A0 r3!,{r4} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ load C=
PSR from SDRAM
>> + =A0 =A0 msr =A0 =A0 cpsr, r4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ stor=
e cpsr
>>
>> =A0 =A0 =A0 /* Enabling MMU here */
>> - =A0 =A0 mrc =A0 =A0 p15, 0, r7, c2, c0, 2 /* Read TTBRControl */
>> - =A0 =A0 /* Extract N (0:2) bits and decide whether to use TTBR0 or=
 TTBR1*/
>> + =A0 =A0 mrc =A0 =A0 p15, 0, r7, c2, c0, 2 =A0 @ Read TTBRControl
>> + =A0 =A0 /* Extract N (0:2) bits and decide whether to use TTBR0 or=
 TTBR1
> */
>> =A0 =A0 =A0 and =A0 =A0 r7, #0x7
>> =A0 =A0 =A0 cmp =A0 =A0 r7, #0x0
>> =A0 =A0 =A0 beq =A0 =A0 usettbr0
>> =A0ttbr_error:
>> - =A0 =A0 /* More work needs to be done to support N[0:2] value othe=
r than 0
>> - =A0 =A0 * So looping here so that the error can be detected
>> - =A0 =A0 */
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* More work needs to be done to support N[0:2] value ot=
her than 0
>> + =A0 =A0 =A0* So looping here so that the error can be detected
>> + =A0 =A0 =A0*/
>> =A0 =A0 =A0 b =A0 =A0 =A0 ttbr_error
>> =A0usettbr0:
>> =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r2, c2, c0, 0
>> @@ -543,21 +553,25 @@ usettbr0:
>> =A0 =A0 =A0 and =A0 =A0 r2, r5
>> =A0 =A0 =A0 mov =A0 =A0 r4, pc
>> =A0 =A0 =A0 ldr =A0 =A0 r5, table_index_mask
>> - =A0 =A0 and =A0 =A0 r4, r5 /* r4 =3D 31 to 20 bits of pc */
>> + =A0 =A0 and =A0 =A0 r4, r5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ r4=
 =3D 31 to 20 bits of pc
>> =A0 =A0 =A0 /* Extract the value to be written to table entry */
>> =A0 =A0 =A0 ldr =A0 =A0 r1, table_entry
>> - =A0 =A0 add =A0 =A0 r1, r1, r4 /* r1 has value to be written to ta=
ble entry*/
>> + =A0 =A0 /* r1 has the value to be written to table entry*/
>> + =A0 =A0 add =A0 =A0 r1, r1, r4
>> =A0 =A0 =A0 /* Getting the address of table entry to modify */
>> =A0 =A0 =A0 lsr =A0 =A0 r4, #18
>> - =A0 =A0 add =A0 =A0 r2, r4 /* r2 has the location which needs to b=
e modified
> */
>> + =A0 =A0 /* r2 has the location which needs to be modified */
>> + =A0 =A0 add =A0 =A0 r2, r4
>> =A0 =A0 =A0 /* Storing previous entry of location being modified */
>> =A0 =A0 =A0 ldr =A0 =A0 r5, scratchpad_base
>> =A0 =A0 =A0 ldr =A0 =A0 r4, [r2]
>> =A0 =A0 =A0 str =A0 =A0 r4, [r5, #0xC0]
>> =A0 =A0 =A0 /* Modify the table entry */
>> =A0 =A0 =A0 str =A0 =A0 r1, [r2]
>> - =A0 =A0 /* Storing address of entry being modified
>> - =A0 =A0 =A0* - will be restored after enabling MMU */
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Storing address of entry being modified
>> + =A0 =A0 =A0* - will be restored after enabling MMU
>> + =A0 =A0 =A0*/
>> =A0 =A0 =A0 ldr =A0 =A0 r5, scratchpad_base
>> =A0 =A0 =A0 str =A0 =A0 r2, [r5, #0xC4]
>>
>> @@ -566,7 +580,7 @@ usettbr0:
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c5, 6 =A0 @ Invalidate branc=
h predictor
> array
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c8, c5, 0 =A0 @ Invalidate instr=
uction TLB
>> =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c8, c6, 0 =A0 @ Invalidate data =
TLB
>> - =A0 =A0 /* Restore control register =A0but dont enable caches here=
*/
>> + =A0 =A0 /* Restore control register =A0but dont enable caches here=
 */
> don't.....don't
=46ixed

>> =A0 =A0 =A0 /* Caches will be enabled after restoring MMU table entr=
y */
Rephrased

> Here too you can fix the commenting style
>> =A0 =A0 =A0 ldmia =A0 r3!, {r4}
>> =A0 =A0 =A0 /* Store previous value of control register in scratchpa=
d */
>> @@ -580,7 +594,7 @@ usettbr0:
>> =A0 * =3D=3D Exit point from OFF mode =3D=3D
>> =A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =A0 */
>> - =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ =
restore regs and return
>> + =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore regs and=
 return
>>
>>
>> =A0/*
>> @@ -646,55 +660,56 @@ ENTRY(es3_sdrc_fix_sz)
>> =A0/* Make sure SDRC accesses are ok */
>> =A0wait_sdrc_ok:
>>
>> -/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ens=
ures
>> this. */
>> +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ens=
ures
>> this */
>> =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest_ckgen
>> =A0wait_dpll3_lock:
>> =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> =A0 =A0 =A0 tst =A0 =A0 r5, #1
>> =A0 =A0 =A0 beq =A0 =A0 wait_dpll3_lock
>>
>> - =A0 =A0 =A0 =A0ldr =A0 =A0 r4, cm_idlest1_core
>> + =A0 =A0 ldr =A0 =A0 r4, cm_idlest1_core
>> =A0wait_sdrc_ready:
>> - =A0 =A0 =A0 =A0ldr =A0 =A0 r5, [r4]
>> - =A0 =A0 =A0 =A0tst =A0 =A0 r5, #0x2
>> - =A0 =A0 =A0 =A0bne =A0 =A0 wait_sdrc_ready
>> + =A0 =A0 ldr =A0 =A0 r5, [r4]
>> + =A0 =A0 tst =A0 =A0 r5, #0x2
>> + =A0 =A0 bne =A0 =A0 wait_sdrc_ready
>> =A0 =A0 =A0 /* allow DLL powerdown upon hw idle req */
>> - =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_power
>> - =A0 =A0 =A0 =A0ldr =A0 =A0 r5, [r4]
>> - =A0 =A0 =A0 =A0bic =A0 =A0 r5, r5, #0x40
>> - =A0 =A0 =A0 =A0str =A0 =A0 r5, [r4]
>> -is_dll_in_lock_mode:
>> + =A0 =A0 ldr =A0 =A0 r4, sdrc_power
>> + =A0 =A0 ldr =A0 =A0 r5, [r4]
>> + =A0 =A0 bic =A0 =A0 r5, r5, #0x40
>> + =A0 =A0 str =A0 =A0 r5, [r4]
>>
>> - =A0 =A0 =A0 =A0/* Is dll in lock mode? */
>> - =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_dlla_ctrl
>> - =A0 =A0 =A0 =A0ldr =A0 =A0 r5, [r4]
>> - =A0 =A0 =A0 =A0tst =A0 =A0 r5, #0x4
>> - =A0 =A0 =A0 =A0bxne =A0 =A0lr
>> - =A0 =A0 =A0 =A0/* wait till dll locks */
>> +is_dll_in_lock_mode:
>> + =A0 =A0 /* Is dll in lock mode? */
>> + =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
>> + =A0 =A0 ldr =A0 =A0 r5, [r4]
>> + =A0 =A0 tst =A0 =A0 r5, #0x4
>> + =A0 =A0 bxne =A0 =A0lr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ Return if locked
>> + =A0 =A0 /* wait till dll locks */
>> =A0wait_dll_lock_timed:
>> =A0 =A0 =A0 ldr =A0 =A0 r4, wait_dll_lock_counter
>> =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
>> =A0 =A0 =A0 str =A0 =A0 r4, wait_dll_lock_counter
>> =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_status
>> - =A0 =A0 =A0 =A0mov =A0r6, #8 =A0 =A0 =A0 =A0 =A0/* Wait 20uS for l=
ock */
>> + =A0 =A0 /* Wait 20uS for lock */
>> + =A0 =A0 mov =A0 =A0 r6, #8
>> =A0wait_dll_lock:
>> =A0 =A0 =A0 subs =A0 =A0r6, r6, #0x1
>> =A0 =A0 =A0 beq =A0 =A0 kick_dll
>> - =A0 =A0 =A0 =A0ldr =A0 =A0 r5, [r4]
>> - =A0 =A0 =A0 =A0and =A0 =A0 r5, r5, #0x4
>> - =A0 =A0 =A0 =A0cmp =A0 =A0 r5, #0x4
>> - =A0 =A0 =A0 =A0bne =A0 =A0 wait_dll_lock
>> - =A0 =A0 =A0 =A0bx =A0 =A0 =A0lr
>> + =A0 =A0 ldr =A0 =A0 r5, [r4]
>> + =A0 =A0 and =A0 =A0 r5, r5, #0x4
>> + =A0 =A0 cmp =A0 =A0 r5, #0x4
>> + =A0 =A0 bne =A0 =A0 wait_dll_lock
>> + =A0 =A0 bx =A0 =A0 =A0lr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ Return when locked
>>
>> =A0 =A0 =A0 /* disable/reenable DLL if not locked */
>> =A0kick_dll:
>> =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
>> =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
>> =A0 =A0 =A0 mov =A0 =A0 r6, r5
>> - =A0 =A0 bic =A0 =A0 r6, #(1<<3) =A0 =A0 /* disable dll */
>> + =A0 =A0 bic =A0 =A0 r6, #(1<<3) =A0 =A0 =A0 =A0 =A0 =A0 @ disable =
dll
>> =A0 =A0 =A0 str =A0 =A0 r6, [r4]
>> =A0 =A0 =A0 dsb
>> - =A0 =A0 orr =A0 =A0 r6, r6, #(1<<3) /* enable dll */
>> + =A0 =A0 orr =A0 =A0 r6, r6, #(1<<3) =A0 =A0 =A0 =A0 @ enable dll
>> =A0 =A0 =A0 str =A0 =A0 r6, [r4]
>> =A0 =A0 =A0 dsb
>> =A0 =A0 =A0 ldr =A0 =A0 r4, kick_counter
>> @@ -719,7 +734,7 @@ scratchpad_base:
>> =A0sram_base:
>> =A0 =A0 =A0 .word =A0 SRAM_BASE_P + 0x8000
>> =A0sdrc_power:
>> - =A0 =A0 .word SDRC_POWER_V
>> + =A0 =A0 .word =A0 SDRC_POWER_V
>> =A0ttbrbit_mask:
>> =A0 =A0 =A0 .word =A0 0xFFFFC000
>> =A0table_index_mask:
>> @@ -733,9 +748,9 @@ control_stat:
>> =A0control_mem_rta:
>> =A0 =A0 =A0 .word =A0 CONTROL_MEM_RTA_CTRL
>> =A0kernel_flush:
>> - =A0 =A0 .word v7_flush_dcache_all
>> + =A0 =A0 .word =A0 v7_flush_dcache_all
>> =A0l2dis_3630:
>> - =A0 =A0 .word 0
>> + =A0 =A0 .word =A0 0
>> =A0 =A0 =A0 /* these 2 words need to be at the end !!! */
>> =A0kick_counter:
>> =A0 =A0 =A0 .word =A0 0
>> --
>> 1.7.1
>>
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
