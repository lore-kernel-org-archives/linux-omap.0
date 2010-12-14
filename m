From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: clean up ASM idle code
Date: Tue, 14 Dec 2010 10:22:52 +0100
Message-ID: <AANLkTinpCM7qOHCjVGb5JwoGPRcYseAcHeHS_xFNoZ66@mail.gmail.com>
References: <1291720319-30868-1-git-send-email-jean.pihet@newoldbits.com>
	<877hfdxaav.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50767 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab0LNJWy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 04:22:54 -0500
Received: by qwa26 with SMTP id 26so530488qwa.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 01:22:53 -0800 (PST)
In-Reply-To: <877hfdxaav.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Kevin,

On Tue, Dec 14, 2010 at 5:12 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Clean up of the ASM code:
>> - reorganized the code in logical sections: defines, API
>> =A0 =A0functions, internal functions and variables,
>> - reworked and simplified the execution paths, for better
>> =A0 =A0readability and to avoid duplication of code,
>> - added comments on the entry and exit points,
>> - reworked the existing comments for better readability,
>> - reworked the code formating, alignment and white spaces,
>> - added comments for the i443 erratum workarounds,
>> - changed the hardcoded values in favor of existing macros
>> =A0 =A0from include files,
>> - clean up of non used symbols.
>
> The 'lock_scratchpad_sem' code is also unused. =A0IIRC, you removed t=
hat
> in an earlier version of the series. =A0Are you still planning to rem=
ove
> that? maybe in a subsequent patch?

I asked previously about it and the reply was that this code is
needed: (quoting Vishwa's reply) "This is indeed used during DVFS when
Core DPLL configuration is changed". Note: the DVFS code is not
upstreamed yet.

Vishwa, can you confirm?

> That being said, pure whitespace changes and unused code removal shou=
ld
> probably be a separate patch. =A0It's a great help to reviewers if
> functional changes are separated from whitespace changes. =A0It's a b=
it
> tricky in this series as there's lots of code moving as well, so I'll
> leave it up to your judgement on how/if to separate these out.

There is no functional change at all. The code has been reorganized
for better readability.
I agree the patch is not easy to read but that is the way diff reports
the changes.

I do not see the point to provide separate patches for code move,
white space clean-up, alignment fixes etc.

>> Tested on OMAP3EVM and Beagleboard with full RET and OFF modes.
>
> In idle? =A0in suspend? =A0both? =A0was CPUidle enabled?
>
> FWIW, I tested on 3430-ES3.1/n900 with retention idle & suspend and o=
ff
> idle & suspend with CPUidle enabled.
Tested with cpuidle and suspend. I will update the description.

>
>> Heavily reworked from Vishwa's original patch.
>
> Here, it's more customary to =A0say "Based on original patch from Vis=
hwa"
> and ensure the original author is CC'd (which you've done.)
>
> Other than that, this is a great cleanup, and makes this much more
> readable. =A0Thanks.
>
> Some other minor comments below.

OK thanks for the review. I will post a new version asap.

>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Vishwanath BS <vishwanath.bs@ti.com>
>> ---
>> Applies on top of Nishant's latest idle path errata fixes step 2,
>> cf. http://marc.info/?l=3Dlinux-omap&m=3D129139584919242&w=3D2
>>
>
> [...]
>
>> @@ -208,36 +172,153 @@ api_params:
>> =A0ENTRY(save_secure_ram_context_sz)
>> =A0 =A0 =A0 .word =A0 . - save_secure_ram_context
>>
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Idle entry point =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>
> Let's keep C multi-line coding style even for assembly. =A0 Same goes=
 for
> several other places below.
Ok

>
>> =A0/*
>> =A0 * Forces OMAP into idle state
>> =A0 *
>> - * omap34xx_suspend() - This bit of code just executes the WFI
>> - * for normal idles.
>> + * omap34xx_suspend() - This bit of code saves the CPU context if n=
eeded
>> + * and executes the WFI instruction
>> + *
>> + * Note: This code get's copied to internal SRAM at boot.
>> =A0 *
>> - * Note: This code get's copied to internal SRAM at boot. When the =
OMAP
>> - * =A0 =A0wakes up it continues execution at the point it went to s=
leep.
>> + * Note: When the OMAP wakes up it continues at different execution=
 points,
>> + * =A0depending on the low power mode (non-OFF vs OFF modes),
>> + * =A0cf. 'Resume path for xxx mode' comments.
>> =A0 */
>> =A0ENTRY(omap34xx_cpu_suspend)
>> =A0 =A0 =A0 stmfd =A0 sp!, {r0-r12, lr} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
@ save registers on stack
>> =A0loop:
>> =A0 =A0 =A0 /*b =A0 =A0 loop*/ =A0@Enable to debug by stepping throu=
gh code
>
> While here, let's get rid of these infinite loop hacks for debugging =
as
> anyone debugging this code can add these back as needed. =A0Otherwise=
,
> they clutter the code. =A0 There are a few of theses throughout the
> original code.
Ok. Agree those are not used at all (even when doing heavy debugging).

> [...]
>
>> @@ -250,9 +331,28 @@ loop:
>> =A0 =A0 =A0 nop
>> =A0 =A0 =A0 bl wait_sdrc_ok
>>
>> - =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ =
restore regs and return
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Exit point from non-OFF modes =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>> + =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore regs and=
 return
>> +
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + * =3D=3D Resume path for OFF mode =3D=3D
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>
> I don't think this is quite correct. =A0I don't believe it starts
> immediately here. =A0Doesn't it resume from DDR first, and then =A0ju=
mp
> here. =A0A brief description of that process would help clarify that =
process.
This is the restore point from OFF mode. The ROM code calls this
directly, cf. the get_pointer* functions that are used to get the
resume pointer.
I will update the comment.

>> +/*
>> + * The restore_* functions are executed when back from WFI in OFF m=
ode
>> + *
>> + * =A0restore_es3: applies to 34xx >=3D ES3.0
>> + * =A0restore_3630: applies to 36xx
>> + * =A0restore: common code for 3xxx
>> + */
>> =A0restore_es3:
>> =A0 =A0 =A0 /*b restore_es3*/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ Enable t=
o debug restore code
>> +
>> =A0 =A0 =A0 ldr =A0 =A0 r5, pm_prepwstst_core_p
>> =A0 =A0 =A0 ldr =A0 =A0 r4, [r5]
>> =A0 =A0 =A0 and =A0 =A0 r4, r4, #0x3
>> @@ -282,18 +382,20 @@ restore_3630:
>> =A0 =A0 =A0 ldr =A0 =A0 r1, control_mem_rta
>> =A0 =A0 =A0 mov =A0 =A0 r2, #OMAP36XX_RTA_DISABLE
>> =A0 =A0 =A0 str =A0 =A0 r2, [r1]
>> - =A0 =A0 /* Fall thru for the remaining logic */
>> +
>> + =A0 =A0 /* Fall thru to common code for the remaining logic */
>> +
>> =A0restore:
>> =A0 =A0 =A0 /* b restore*/ =A0@ Enable to debug restore code
>> - =A0 =A0 =A0 =A0/* Check what was the reason for mpu reset and stor=
e the reason in r9*/
>> - =A0 =A0 =A0 =A0/* 1 - Only L1 and logic lost */
>> - =A0 =A0 =A0 =A0/* 2 - Only L2 lost - In this case, we wont be here=
 */
>> - =A0 =A0 =A0 =A0/* 3 - Both L1 and L2 lost */
>> + =A0 =A0 /* Check what was the reason for mpu reset and store the r=
eason in r9*/
>> + =A0 =A0 /* 1 - Only L1 and logic lost */
>> + =A0 =A0 /* 2 - Only L2 lost - In this case, we wont be here */
>> + =A0 =A0 /* 3 - Both L1 and L2 lost */
>> =A0 =A0 =A0 ldr =A0 =A0 r1, pm_pwstctrl_mpu
>> =A0 =A0 =A0 ldr =A0 =A0 r2, [r1]
>> =A0 =A0 =A0 and =A0 =A0 r2, r2, #0x3
>> =A0 =A0 =A0 cmp =A0 =A0 r2, #0x0 =A0 =A0 =A0 =A0@ Check if target po=
wer state was OFF or RET
>> - =A0 =A0 =A0 =A0moveq =A0 r9, #0x3 =A0 =A0 =A0 =A0@ MPU OFF =3D> L1=
 and L2 lost
>> + =A0 =A0 moveq =A0 r9, #0x3 =A0 =A0 =A0 =A0@ MPU OFF =3D> L1 and L2=
 lost
>> =A0 =A0 =A0 movne =A0 r9, #0x1 =A0 =A0 =A0 =A0@ Only L1 and L2 lost =
=3D> avoid L2 invalidation
>> =A0 =A0 =A0 bne =A0 =A0 logic_l1_restore
>>
>> @@ -309,23 +411,23 @@ skipl2dis:
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
>
> This is the type of change that should normally be in a separate patc=
h,
> as it seems to be pure whitespace change.
>
>
> Kevin
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
