From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP3: clean up ASM idle code
Date: Tue, 14 Dec 2010 17:04:04 +0530
Message-ID: <6b2887b2cb33b7eaacb380c2647b6de0@mail.gmail.com>
References: <1291720319-30868-1-git-send-email-jean.pihet@newoldbits.com><877hfdxaav.fsf@deeprootsystems.com>
 <AANLkTinpCM7qOHCjVGb5JwoGPRcYseAcHeHS_xFNoZ66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34293 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757792Ab0LNLeK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 06:34:10 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so597225fxm.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 03:34:08 -0800 (PST)
In-Reply-To: <AANLkTinpCM7qOHCjVGb5JwoGPRcYseAcHeHS_xFNoZ66@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

Jean,

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Tuesday, December 14, 2010 2:53 PM
> To: Kevin Hilman; Vishwanath BS
> Cc: linux-omap@vger.kernel.org; Jean Pihet
> Subject: Re: [PATCH] OMAP3: clean up ASM idle code
>
> Kevin,
>
> On Tue, Dec 14, 2010 at 5:12 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> > jean.pihet@newoldbits.com writes:
> >
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> Clean up of the ASM code:
> >> - reorganized the code in logical sections: defines, API
> >> =E1 =E1functions, internal functions and variables,
> >> - reworked and simplified the execution paths, for better
> >> =E1 =E1readability and to avoid duplication of code,
> >> - added comments on the entry and exit points,
> >> - reworked the existing comments for better readability,
> >> - reworked the code formating, alignment and white spaces,
> >> - added comments for the i443 erratum workarounds,
> >> - changed the hardcoded values in favor of existing macros
> >> =E1 =E1from include files,
> >> - clean up of non used symbols.
> >
> > The 'lock_scratchpad_sem' code is also unused. =E1IIRC, you removed
> that
> > in an earlier version of the series. =E1Are you still planning to r=
emove
> > that? maybe in a subsequent patch?
>
> I asked previously about it and the reply was that this code is
> needed: (quoting Vishwa's reply) "This is indeed used during DVFS whe=
n
> Core DPLL configuration is changed". Note: the DVFS code is not
> upstreamed yet.
>
> Vishwa, can you confirm?
lock_scratchpad_sem is needed when DVFS feature is supported. If you wa=
nt
to add this implementation as part of DVFS feature, then also it's fine=
=2E

Vishwa
>
> > That being said, pure whitespace changes and unused code removal
> should
> > probably be a separate patch. =E1It's a great help to reviewers if
> > functional changes are separated from whitespace changes. =E1It's a=
 bit
> > tricky in this series as there's lots of code moving as well, so I'=
ll
> > leave it up to your judgement on how/if to separate these out.
>
> There is no functional change at all. The code has been reorganized
> for better readability.
> I agree the patch is not easy to read but that is the way diff report=
s
> the changes.
>
> I do not see the point to provide separate patches for code move,
> white space clean-up, alignment fixes etc.
>
> >> Tested on OMAP3EVM and Beagleboard with full RET and OFF modes.
> >
> > In idle? =E1in suspend? =E1both? =E1was CPUidle enabled?
> >
> > FWIW, I tested on 3430-ES3.1/n900 with retention idle & suspend and
> off
> > idle & suspend with CPUidle enabled.
> Tested with cpuidle and suspend. I will update the description.
>
> >
> >> Heavily reworked from Vishwa's original patch.
> >
> > Here, it's more customary to =E1say "Based on original patch from
> Vishwa"
> > and ensure the original author is CC'd (which you've done.)
> >
> > Other than that, this is a great cleanup, and makes this much more
> > readable. =E1Thanks.
> >
> > Some other minor comments below.
>
> OK thanks for the review. I will post a new version asap.
>
> >
> >> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> >> Cc: Vishwanath BS <vishwanath.bs@ti.com>
> >> ---
> >> Applies on top of Nishant's latest idle path errata fixes step 2,
> >> cf. http://marc.info/?l=3Dlinux-omap&m=3D129139584919242&w=3D2
> >>
> >
> > [...]
> >
> >> @@ -208,36 +172,153 @@ api_params:
> >> =E1ENTRY(save_secure_ram_context_sz)
> >> =E1 =E1 =E1 .word =E1 . - save_secure_ram_context
> >>
> >> +
> >> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> + * =3D=3D Idle entry point =3D=3D
> >> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> + */
> >
> > Let's keep C multi-line coding style even for assembly. =E1 Same go=
es
for
> > several other places below.
> Ok
>
> >
> >> =E1/*
> >> =E1 * Forces OMAP into idle state
> >> =E1 *
> >> - * omap34xx_suspend() - This bit of code just executes the WFI
> >> - * for normal idles.
> >> + * omap34xx_suspend() - This bit of code saves the CPU context if
> needed
> >> + * and executes the WFI instruction
> >> + *
> >> + * Note: This code get's copied to internal SRAM at boot.
> >> =E1 *
> >> - * Note: This code get's copied to internal SRAM at boot. When th=
e
> OMAP
> >> - * =E1 =E1wakes up it continues execution at the point it went to=
 sleep.
> >> + * Note: When the OMAP wakes up it continues at different
> execution points,
> >> + * =E1depending on the low power mode (non-OFF vs OFF modes),
> >> + * =E1cf. 'Resume path for xxx mode' comments.
> >> =E1 */
> >> =E1ENTRY(omap34xx_cpu_suspend)
> >> =E1 =E1 =E1 stmfd =E1 sp!, {r0-r12, lr} =E1 =E1 =E1 =E1 =E1 =E1 =E1=
 @ save registers on
stack
> >> =E1loop:
> >> =E1 =E1 =E1 /*b =E1 =E1 loop*/ =E1@Enable to debug by stepping thr=
ough code
> >
> > While here, let's get rid of these infinite loop hacks for debuggin=
g
as
> > anyone debugging this code can add these back as needed.
> =E1Otherwise,
> > they clutter the code. =E1 There are a few of theses throughout the
> > original code.
> Ok. Agree those are not used at all (even when doing heavy debugging)=
=2E
>
> > [...]
> >
> >> @@ -250,9 +331,28 @@ loop:
> >> =E1 =E1 =E1 nop
> >> =E1 =E1 =E1 bl wait_sdrc_ok
> >>
> >> - =E1 =E1 ldmfd =E1 sp!, {r0-r12, pc} =E1 =E1 =E1 =E1 =E1 =E1 =E1 =
@ restore regs and
return
> >> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> + * =3D=3D Exit point from non-OFF modes =3D=3D
> >> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> + */
> >> + =E1 =E1 ldmfd =E1 sp!, {r0-r12, pc} =E1 =E1 =E1 @ restore regs a=
nd return
> >> +
> >> +
> >> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> + * =3D=3D Resume path for OFF mode =3D=3D
> >> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> + */
> >
> > I don't think this is quite correct. =E1I don't believe it starts
> > immediately here. =E1Doesn't it resume from DDR first, and then =E1=
jump
> > here. =E1A brief description of that process would help clarify tha=
t
> process.
> This is the restore point from OFF mode. The ROM code calls this
> directly, cf. the get_pointer* functions that are used to get the
> resume pointer.
> I will update the comment.
>
> >> +/*
> >> + * The restore_* functions are executed when back from WFI in
> OFF mode
> >> + *
> >> + * =E1restore_es3: applies to 34xx >=3D ES3.0
> >> + * =E1restore_3630: applies to 36xx
> >> + * =E1restore: common code for 3xxx
> >> + */
> >> =E1restore_es3:
> >> =E1 =E1 =E1 /*b restore_es3*/ =E1 =E1 =E1 =E1 =E1 =E1 =E1 @ Enable=
 to debug restore code
> >> +
> >> =E1 =E1 =E1 ldr =E1 =E1 r5, pm_prepwstst_core_p
> >> =E1 =E1 =E1 ldr =E1 =E1 r4, [r5]
> >> =E1 =E1 =E1 and =E1 =E1 r4, r4, #0x3
> >> @@ -282,18 +382,20 @@ restore_3630:
> >> =E1 =E1 =E1 ldr =E1 =E1 r1, control_mem_rta
> >> =E1 =E1 =E1 mov =E1 =E1 r2, #OMAP36XX_RTA_DISABLE
> >> =E1 =E1 =E1 str =E1 =E1 r2, [r1]
> >> - =E1 =E1 /* Fall thru for the remaining logic */
> >> +
> >> + =E1 =E1 /* Fall thru to common code for the remaining logic */
> >> +
> >> =E1restore:
> >> =E1 =E1 =E1 /* b restore*/ =E1@ Enable to debug restore code
> >> - =E1 =E1 =E1 =E1/* Check what was the reason for mpu reset and st=
ore the
> reason in r9*/
> >> - =E1 =E1 =E1 =E1/* 1 - Only L1 and logic lost */
> >> - =E1 =E1 =E1 =E1/* 2 - Only L2 lost - In this case, we wont be he=
re */
> >> - =E1 =E1 =E1 =E1/* 3 - Both L1 and L2 lost */
> >> + =E1 =E1 /* Check what was the reason for mpu reset and store the
> reason in r9*/
> >> + =E1 =E1 /* 1 - Only L1 and logic lost */
> >> + =E1 =E1 /* 2 - Only L2 lost - In this case, we wont be here */
> >> + =E1 =E1 /* 3 - Both L1 and L2 lost */
> >> =E1 =E1 =E1 ldr =E1 =E1 r1, pm_pwstctrl_mpu
> >> =E1 =E1 =E1 ldr =E1 =E1 r2, [r1]
> >> =E1 =E1 =E1 and =E1 =E1 r2, r2, #0x3
> >> =E1 =E1 =E1 cmp =E1 =E1 r2, #0x0 =E1 =E1 =E1 =E1@ Check if target =
power state was OFF
or
> RET
> >> - =E1 =E1 =E1 =E1moveq =E1 r9, #0x3 =E1 =E1 =E1 =E1@ MPU OFF =3D> =
L1 and L2 lost
> >> + =E1 =E1 moveq =E1 r9, #0x3 =E1 =E1 =E1 =E1@ MPU OFF =3D> L1 and =
L2 lost
> >> =E1 =E1 =E1 movne =E1 r9, #0x1 =E1 =E1 =E1 =E1@ Only L1 and L2 los=
t =3D> avoid L2
> invalidation
> >> =E1 =E1 =E1 bne =E1 =E1 logic_l1_restore
> >>
> >> @@ -309,23 +411,23 @@ skipl2dis:
> >> =E1 =E1 =E1 and =E1 =E1 r1, #0x700
> >> =E1 =E1 =E1 cmp =E1 =E1 r1, #0x300
> >> =E1 =E1 =E1 beq =E1 =E1 l2_inv_gp
> >> - =E1 =E1 mov =E1 =E1 r0, #40 =E1 =E1 =E1 =E1 @ set service ID for=
 PPA
> >> - =E1 =E1 mov =E1 =E1 r12, r0 =E1 =E1 =E1 =E1 @ copy secure Servic=
e ID in r12
> >> - =E1 =E1 mov =E1 =E1 r1, #0 =E1 =E1 =E1 =E1 =E1@ set task id for =
ROM code in r1
> >> - =E1 =E1 mov =E1 =E1 r2, #4 =E1 =E1 =E1 =E1 =E1@ set some flags i=
n r2, r6
> >> + =E1 =E1 mov =E1 =E1 r0, #40 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 @ se=
t service ID for PPA
> >> + =E1 =E1 mov =E1 =E1 r12, r0 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 @ co=
py secure Service ID in r12
> >> + =E1 =E1 mov =E1 =E1 r1, #0 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1@ =
set task id for ROM code in
r1
> >> + =E1 =E1 mov =E1 =E1 r2, #4 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1@ =
set some flags in r2, r6
> >
> > This is the type of change that should normally be in a separate
patch,
> > as it seems to be pure whitespace change.
> >
> >
> > Kevin
> >
>
> Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
