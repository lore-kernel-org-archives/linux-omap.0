From: "Wang Limei-E12499" <E12499@motorola.com>
Subject: RE: [PATCH] OMAP3: PM: Fix freeze when scaling CORE dpll to < 83Mhz
Date: Fri, 10 Jul 2009 07:49:33 +0800
Message-ID: <DF4DCBD3DB270B419320B577AC0C3C8602E2EB04@zmy16exm62.ds.mot.com>
References: <1247134702-12704-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0907091440480.8616@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01CA00EF.F218233F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:31515 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZGIXuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 19:50:16 -0400
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n69NoDk7002334
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2009 16:50:13 -0700 (MST)
Received: from il06vts01.mot.com (il06vts01.mot.com [129.188.137.141])
	by il06exr03.mot.com (8.13.1/Vontu) with SMTP id n69NoCxT009499
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2009 18:50:12 -0500 (CDT)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id n69NoAXq009496
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2009 18:50:11 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.0907091440480.8616@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, "Woodruff, Richard" <r-woodruff2@ti.com>, "Ghongdemath, Girish" <girishsg@ti.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA00EF.F218233F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Paul,

Thank you very much for copying me!  =20

During the investigation, Richard and Girish from TI helped, the mail
is attached.=20

Rajendra,=20

Yesterday night, I sent mail to paul and kevin, I also submmited below
patch along with detailed issue report and analysis.=20

-#define FIXEDDELAY_MASK   (0xff << FIXEDDELAY_SHIFT)
+#define FIXEDDELAY_MASK   0x00FFFFFF


Thanks,
limei

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com]=20
Sent: Thursday, July 09, 2009 3:44 PM
To: Rajendra Nayak
Cc: Wang Limei-E12499; khilman@deeprootsystems.com;
linux-omap@vger.kernel.org
Subject: Re: [PATCH] OMAP3: PM: Fix freeze when scaling CORE dpll to <
83Mhz

Hi Rajendra,

On Thu, 9 Jul 2009, Rajendra Nayak wrote:

> This patch fixes a bug in the CORE dpll scaling sequence which was=20
> errouneously clearing some bits in the SDRC DLLA CTRL register and=20
> hence causing a freeze.
> The issue was observed only on platforms which scale CORE dpll to <=20
> 83Mhz and hence program the DLL in fixed delay mode.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, looks good, I'll queue this up for a fixes series to rmk.

One question: I got an E-mail on this earlier today from Limei Wang
about this same issue.  Looks like we should credit Limei also in this
patch with finding the bug.  Is this acceptable to you?

- Paul

> ---
>  arch/arm/mach-omap2/sram34xx.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/sram34xx.S=20
> b/arch/arm/mach-omap2/sram34xx.S index 481f912..9be09a7 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -113,7 +113,7 @@ return_to_sdram:
>  unlock_dll:
>  	ldr	r11, omap3_sdrc_dlla_ctrl
>  	ldr	r12, [r11]
> -	and	r12, r12, #FIXEDDELAY_MASK
> +	bic	r12, r12, #FIXEDDELAY_MASK
>  	orr	r12, r12, #FIXEDDELAY_DEFAULT
>  	orr	r12, r12, #DLLIDLE_MASK
>  	str	r12, [r11]		@ (no OCP barrier needed)
> --
> 1.5.4.7
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20



------_=_NextPart_001_01CA00EF.F218233F
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit

X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from zmy16exm72.ds.mot.com ([10.179.4.45]) by zmy16exm62.ds.mot.com with Microsoft SMTPSVC(6.0.3790.3959); Thu, 9 Jul 2009 06:33:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Received: from il27exr04.cig.mot.com ([10.17.196.73]) by zmy16exm72.ds.mot.com with Microsoft SMTPSVC(6.0.3790.3959); Thu, 9 Jul 2009 06:33:15 +0800
Received: from motgate3.mot.com (motgate3.mot.com [136.182.1.13]) by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n68MXDvc023206; Wed, 8 Jul 2009 17:33:13 -0500 (CDT)
Received: from mail153.messagelabs.com (mail153.messagelabs.com [216.82.253.51]) by motgate3.mot.com (8.14.3/8.14.3) with ESMTP id n68MXClL025547 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK); Wed, 8 Jul 2009 15:33:12 -0700 (MST)
Received: (qmail 12402 invoked from network); 8 Jul 2009 22:33:10 -0000
Received: from arroyo.ext.ti.com (HELO arroyo.ext.ti.com) (192.94.94.40)  by server-5.tower-153.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 8 Jul 2009 22:33:10 -0000
Received: from dlep35.itg.ti.com ([157.170.170.118]) by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n68MWxM6027306; Wed, 8 Jul 2009 17:33:04 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1]) by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n68MWwI3014139; Wed, 8 Jul 2009 17:32:59 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1]) by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n68MWts0019434; Wed, 8 Jul 2009 17:32:55 -0500 (CDT)
Received: from dlee02.ent.ti.com ([157.170.170.17]) by dsbe71.ent.ti.com ([156.117.232.23]) with mapi; Wed, 8 Jul 2009 17:32:55 -0500
Content-class: urn:content-classes:message
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open source PM
Date: Thu, 9 Jul 2009 06:32:54 +0800
Message-ID: <13B9B4C6EF24D648824FF11BE896716203965D2E06@dlee02.ent.ti.com>
In-Reply-To: <DF4DCBD3DB270B419320B577AC0C3C8602E2E872@zmy16exm62.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mem freeze at omap3_sram_configure_core_dpll in K29 open source PM
thread-index: Acn5P5/vo68S3guiQNu285djXVapVgBJHRKcADLzJZAAC3LLHABlZwCAACBoH5AAOsfasAAO8huAAAPXA/AALGXk4AAmldnQAAH84XAABnlZ0A==
References: <DF4DCBD3DB270B419320B577AC0C3C8602DE9531@zmy16exm62.ds.mot.com> <7B4574D56E4ADF438756313E9A172A874D31A344@dlee01.ent.ti.com>,<DF4DCBD3DB270B419320B577AC0C3C8602E2DDF8@zmy16exm62.ds.mot.com> <7B4574D56E4ADF438756313E9A172A874D31A360@dlee01.ent <DF4DCBD3DB270B419320B577AC0C3C8602E2E0E9@zmy16exm62.ds.mot.com> <13B9B4C6EF24D648824FF11BE89671620396444D00@dlee02.ent.ti.com> <DF4DCBD3DB270B419320B577AC0C3C8602E2E340@zmy16exm62.ds.mot.com> <DF4DCBD3DB270B419320B577AC0C3C8602E2E3C1@zmy16exm62.ds.mot.com> <13B9B4C6EF24D648824FF11BE89671620396530D14@dlee02.ent.ti.com> <DF4DCBD3DB270B419320B577AC0C3C8602E2E5F1@zmy16exm62.ds.mot.com> <DF4DCBD3DB270B419320B577AC0C3C8602E2E870@zmy16exm62.ds.mot.com> <DF4DCBD3DB270B419320B577AC0C3C8602E2E872@zmy16exm62.ds.mot.com>
From: "Woodruff, Richard" <r-woodruff2@ti.com>
To: "Wang Limei-E12499" <E12499@motorola.com>,
	"Hunter, Jon" <jon-hunter@ti.com>,
	"Ghongdemath, Girish" <girishsg@ti.com>,
	"Nayak, Rajendra" <rnayak@ti.com>,
	<mikechan@google.com>
Cc: "Sripathi Srinivas-A14759" <sripathi@motorola.com>,
	"Wang Sawsd-A24013" <cqwang@motorola.com>,
	"Falempe Jocelyn-XHP836" <jocelyn.falempe@motorola.com>,
	"De Chanterac Cyril-cdlc01" <Cyril.Dechanterac@motorola.com>,
	"WIDZER NOAH-KFQG76" <NoahWidzer@motorola.com>,
	"Liu Haiyang-DGRW68" <DGRW68@motorola.com>

Good finding.

=20

I=92m not sure what motivated Paul to make this change.  Perhaps we =
should inquire on list.  He is an open source contractor who Nokia has =
under contract to make code =91ready=92 for open source.  I suspect he =
felt it was an optimization.  I am aware he filed some question to TI =
about the fixed delay value but not about the enable/disable sequence.   =
It has been my experience that he is quick to make changes with code =
purity in mind.  He does gladly take back bug fixes for those changes.  =
There are many cases that the TI code has arrived at a working sequence =
which is re-coded in open source =91clean ups=92.  Generally the code =
cleanness does improve but functional regressions are not uncommon.   =
This is part of open source maturity.

=20

I=92m not sure of answer to sequencing issue you raise.  Some research =
is necessary to find the answer.  Maybe Girish or Rajendra know off =
hand.

=20

Regards,

Richard W.

                                                                         =
                                                                         =
                                        =20

________________________________

From: Wang Limei-E12499 [mailto:E12499@motorola.com]=20
Sent: Wednesday, July 08, 2009 3:26 PM
To: Wang Limei-E12499; Woodruff, Richard; Hunter, Jon; Ghongdemath, =
Girish; Nayak, Rajendra; mikechan@google.com
Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe Jocelyn-XHP836; =
De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Liu Haiyang-DGRW68
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source PM

=20

Just talked with Noah, he confirmed DLL should be enabled even when DLL =
is in unlock mode.  DLL is disabled in unlock_dll  is the reason of mem =
corruption.=20

=20

>From the snapshot captured yesterday, SDRC_DLLA_CTRL is changed from =
0x0F000008 to 0x0F000004 after omap3_configure_core_dpll is executed, =
means DLLLOCK is changed from lock mode to unlock mode,this is =
expected,but ENADLL bit is cleared, so DLL is disabled. SDRC_DLLA_CTRL  =
is updated when running unlock_dll code, see 1 and 2 snapshot attached, =
it is masked when setting default FixedDelay.  If enable DLL manually in =
LB, code can be executed correctly till hitting this function again.  =
Since FixedDelay is already set to 0x0F before running these piece of =
code,  pls see snapshot,  if skipping these two instructions in RED,   =
vdd2 dvfs works well.  BTW, in K27 kernel sram-fn_34xx.S, does not =
include these.=20

=20

unlock_dll:
        ldr     r11, omap3_sdrc_dlla_ctrl
        ldr     r12, [r11]
-       and     r12, r12, #FIXEDDELAY_MASK
-       orr     r12, r12, #FIXEDDELAY_DEFAULT
        orr     r12, r12, #DLLIDLE_MASK
        str     r12, [r11]              @ (no OCP barrier needed)
        bx      lr

=20

This change is made orignally in =
http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;a=3D=
commit;h=3D102bfe0bcb4e5985322b5f30b1321f2be1ad1c20 =
<http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;a=3D=
commit;h=3D102bfe0bcb4e5985322b5f30b1321f2be1ad1c20>=20

If it meant to set SDRC_DLLA_CTRL.FIXEDDELAY to 0x0f, need to be changed =
to below way or similar:

=20

diff --git a/arch/arm/mach-omap2/sram34xx.S =
b/arch/arm/mach-omap2/sram34xx.S
index 91e3213..860a252 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -41,8 +41,7 @@
 #define SDRC_UNLOCK_DLL                        0x1

=20

 /* SDRC_DLLA_CTRL bit settings */
-#define FIXEDDELAY_SHIFT               24
-#define FIXEDDELAY_MASK                        (0xff << =
FIXEDDELAY_SHIFT)
+#define FIXEDDELAY_MASK                        0x00FFFFFF
 #define DLLIDLE_MASK                   0x4

=20

Richard and Girish,=20

=20

Do you agree with this? Any comments?

=20

Thanks,

limei

=20

________________________________

From: Wang Limei-E12499=20
Sent: Wednesday, July 08, 2009 1:45 PM
To: Wang Limei-E12499; 'Woodruff, Richard'; 'Hunter, Jon'; 'Ghongdemath, =
Girish'; 'Nayak, Rajendra'; 'mikechan@google.com'
Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe Jocelyn-XHP836; =
De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Liu Haiyang-DGRW68
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source PM

=20

Girish and Ricard,

=20

when unlock dll, clear SDRC_DLLA_CTRL. LOCKDLL , is DLL supposed to be =
disabled(SDRC_DLLA_CTRL.ENADLL) ? if it is disabled, what will happen?

=20

I think when dll is unlocked, DLL should still be enabled, right?

=20

thanks,

limei

=20

________________________________

From: Wang Limei-E12499=20
Sent: Tuesday, July 07, 2009 6:59 PM
To: Woodruff, Richard; Hunter, Jon; Ghongdemath, Girish; Nayak, =
Rajendra; mikechan@google.com
Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe Jocelyn-XHP836; =
De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Liu Haiyang-DGRW68; Wang =
Limei-E12499
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source PM

=20

=20

Ricarhd and Girish,

=20

I think you refer to  fix_dll_freeze, correct ?   It is already in =
sleep34xx.S.  I attached the the sleep34xx.s and sram34xx.s I am using.  =
will you take a close look at them?=20

=20

And I set the breakpoint at the return address of =
omap3_sram_configure_core_dpll 0xC0047FAC, and found that mem content is =
corrupted after returning from it. pls see attached snapshot before and =
after omap3_sram_configure_core_dpll is run.  Seems like unlock DLL lead =
to mem corruption.=20

=20

Again, if does not unlock DLL, no this problem, that ist the only =
difference between good and bad.=20

=20

Thanks,

limei

=20

=20

________________________________

From: Woodruff, Richard [mailto:r-woodruff2@ti.com]=20
Sent: Monday, July 06, 2009 9:33 PM
To: Wang Limei-E12499; Hunter, Jon; Ghongdemath, Girish; Nayak, =
Rajendra; mikechan@google.com
Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe Jocelyn-XHP836; =
De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Liu Haiyang-DGRW68
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source PM

Did you apply my force DLL to lock patch?  I think Mike did.  I didn=92t =
see it in your code.

=20

rkw

=20

________________________________

From: Wang Limei-E12499 [mailto:E12499@motorola.com]=20
Sent: Monday, July 06, 2009 9:23 PM
To: Wang Limei-E12499; Woodruff, Richard; Hunter, Jon; Ghongdemath, =
Girish; Nayak, Rajendra; mikechan@google.com
Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe Jocelyn-XHP836; =
De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Wang Limei-E12499; Liu =
Haiyang-DGRW68
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source PM

=20

More update about this issue:

=20

omap3_sdrc_actim_ctrla,omap3_sdrc_actim_ctrlb,omap3_sdrc_rfr_ctrl  are =
not re-configured when L3 clk is changed from 160.5 to 80.25, the reason =
is in  current sram34xx.c/configure_sdrc, a hack was added to skip ddr =
timing configure, when hit this function, it returns instead of setting =
timing registers.  Mike, will you expain what is the problem with these =
code?

=20

but even after removing the hack, freeze still happen. when it occur, =
attach LB, find that dataabt happened. pls see attached snapshot. sdrc =
iclk is enabled and status is accessed....  Does anybody can check if =
the register setting is correct after freeze happens?  In another two =
instances when occur happened, attached LB, PC stop at FFFFxxxx,seems =
around exception hander/vector, pls check the snapshot. Any idea about =
the data abort and unexpected instructions? =20

=20

BTW, Hacking unlock_dll to zero still works with below patch.

=20

Cyril or Noah,

=20

Will you pls spend sometime with me tomorrow to debug this issue?

=20

Below is the patch I applied.=20

=20

diff --git a/arch/arm/mach-omap2/sram34xx.S =
b/arch/arm/mach-omap2/sram34xx.S
index 91e3213..9831981 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -151,11 +151,15 @@ configure_core_dpll:
        and     r12, r12, r10
        orr     r12, r12, r3, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
        str     r12, [r11]
-       ldr     r12, [r11]              @ posted-write barrier for CM
-       bx      lr
+    ldr r12, clk_stabilize_delay    @ wait for the clock to stabilise
 wait_clk_stable:
        subs    r12, r12, #1
        bne     wait_clk_stable
+    nop
+    nop
+    nop
+    nop
+    nop
        bx      lr
 enable_sdrc:
        ldr     r11, omap3_cm_iclken1_core
@@ -187,7 +191,6 @@ wait_dll_unlock:
        bne     wait_dll_unlock
        bx      lr
 configure_sdrc:
-       bx      lr /* Skip ddr timing configurations, these values are =
bogus */
        ldr     r11, omap3_sdrc_rfr_ctrl
        str     r0, [r11]
        ldr     r11, omap3_sdrc_actim_ctrla
@@ -221,6 +224,8 @@ omap3_sdrc_dlla_ctrl:
        .word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 core_m2_mask_val:
        .word 0x07FFFFFF
+clk_stabilize_delay:
+    .word 0x000000C8

=20

 ENTRY(omap3_sram_configure_core_dpll_sz)
        .word   . - omap3_sram_configure_core_dpll

=20

thanks,

limei

=20

________________________________

From: Wang Limei-E12499=20
Sent: Monday, July 06, 2009 1:09 PM
To: Woodruff, Richard; Hunter, Jon; Ghongdemath, Girish; Nayak, =
Rajendra; mikechan@google.com
Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe Jocelyn-XHP836; =
De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Wang Limei-E12499
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source PM

Richard,

=20

Thanks for the info!

=20

I already applied the patch before, it did not resolve the problem.    =
Remove the posted-write barrier, still does not work.=20

=20

will you pls check the attached sram34xx.S?  what is the delay to =
program for clk stablization?  The clk stable delay is 103 mpu cycles =
when change freq from 160.5 to 80.25M, it is calculated in clock34xx.c.  =
Also tried 200(0xC8), same thing.=20

=20

/*
  * XXX This only needs to be done when the CPU frequency changes
  */
 mpurate =3D arm_fck.rate / CYCLES_PER_MHZ;
 c =3D (mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
 c +=3D 1;  /* for safety */
 c *=3D SDRC_MPURATE_LOOPS;
 c >>=3D SDRC_MPURATE_SCALE;
 if (c =3D=3D 0)
  c =3D 1;

=20

diff --git a/arch/arm/mach-omap2/sram34xx.S =
b/arch/arm/mach-omap2/sram34xx.S
index 91e3213..db7fef5 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -97,6 +97,8 @@ ENTRY(omap3_sram_configure_core_dpll)
        blne    lock_dll
        bl      sdram_in_selfrefresh    @ put SDRAM in self refresh, =
idle SDRC
        bl      configure_core_dpll     @ change the DPLL3 M2 divider
+    mov r12, r5
+    bl  wait_clk_stable     @ wait for SDRC to stabilize
        bl      enable_sdrc             @ take SDRC out of idle
        cmp     r4, #SDRC_UNLOCK_DLL    @ wait for DLL status to change
        bleq    wait_dll_unlock
@@ -104,8 +106,6 @@ ENTRY(omap3_sram_configure_core_dpll)
        cmp     r7, #1                  @ if increasing SDRC clk rate,
        beq     return_to_sdram         @ return to SDRAM code, =
otherwise,
        bl      configure_sdrc          @ reprogram SDRC regs now
-       mov     r12, r5
-       bl      wait_clk_stable         @ wait for SDRC to stabilize
 return_to_sdram:
        isb                             @ prevent speculative exec past =
here
        mov     r0, #0                  @ return value
@@ -151,7 +151,6 @@ configure_core_dpll:
        and     r12, r12, r10
        orr     r12, r12, r3, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
        str     r12, [r11]
-       ldr     r12, [r11]              @ posted-write barrier for CM
        bx      lr
 wait_clk_stable:
        subs    r12, r12, #1
=20

=20

Thanks,

limei

=20

=20

________________________________

From: Woodruff, Richard [mailto:r-woodruff2@ti.com]=20
Sent: Sunday, July 05, 2009 8:56 AM
To: Wang Limei-E12499; Hunter, Jon; Ghongdemath, Girish; Nayak, =
Rajendra; mikechan@google.com
Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe Jocelyn-XHP836; =
De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76
Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source PM

Hello,

=20

Yes, what you reported has been observed in the past.  It is indicative =
of the SDRC hardware state machine being messed up.  You need to wait =
small bit after changing the M2 divider before proceeding. There is a =
small period where the clock has not stabilized.  If you let this =
unstable clock propagate to SDRC bad things a result.

=20

You might try attached patch.  Additionally I=92d remove this read back =
to keep traffic limited to sram post clock change

      ldr   r12, [r11]        @ posted-write barrier for CM  <-- remove

=20

Below is behavior you want:

-        setup for changing M2 divider

-        change M2 divider (in purple)

-        simple delay with minimal outside module paths being touched

=20

configure_core_dpll:

      ldr   r4, cm_clksel1_pll

      ldr   r5, [r4]

      ldr   r6, core_m2_mask_val    @ modify m2 for core dpll

      and   r5, r5, r6

      orr   r5, r5, r3, lsl #0x1B   @ r3 contains the M2 val

      str   r5, [r4]

      mov   r5, r10                 @ get the clk_stab delay count

      cmp   r3, #2

      bne   wait_clk_stable

      bx    lr

wait_clk_stable:

      subs r5, r5, #1

      bne   wait_clk_stable

=20

=20

A side note is your Lauterbach window has the potential to cause issues =
at delicate times.  Any value visible is generating a polling access to =
that source.  This will cause a number of abort which Lauterbach fixes =
up under the scenes.  Sometimes its hard to predict their side effect.  =
You can play with update rules but in this case I=92d just hide =
everything but instructions till after you step through the critical =
section.

=20

Regards,

Richard W.

=20

> -----Original Message-----

> From: Wang Limei-E12499 [mailto:E12499@motorola.com]

> Sent: Saturday, July 04, 2009 6:43 PM

> To: Hunter, Jon; Ghongdemath, Girish; Nayak, Rajendra; Woodruff, =
Richard;

> mikechan@google.com

> Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe =
Jocelyn-XHP836; De

> Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Wang Limei-E12499

> Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open =
source

> PM

>=20

> Girish,Richard and Noah,

>=20

> Last Friday I stepped through =
sram34xx.S/omap3_sram_configure_core_dpll

> again and checked the SDRC and RPCM register setting configured by

> these code using LB.  Did not find issue when running through

> unlock_dll, sdram_in_selfrefresh,configure_core_dll,  the related

> registers are all set correctly. But when running to enable_sdrc, in

> this routine, iclk is re-enabled and sdrc idle status is Accessed in

> cm_idlest1_core, but SDRC register are not accessible.  Pls see the

> snapshot capture by LB.

>=20

> Do you know what might be the reason SDCR can not be accessed even =
after

> iclk is enabled and ST_SDRC say it can be accessed? And what is the

> impact of unlock DLL? Since if don't unlock DLL, seems fine.

>=20

> BTW, In the sram34xx.S attached, I moved wait_clk_stable to be next to

> configure_core_dpll.

>=20

> Thanks,

> limei

>=20

> -----Original Message-----

> From: Hunter, Jon [mailto:jon-hunter@ti.com]

> Sent: Thursday, July 02, 2009 4:40 PM

> To: Wang Limei-E12499; Ghongdemath, Girish; Nayak, Rajendra;

> richardwoodruff2@ti.com; mikechan@google.com

> Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe =
Jocelyn-XHP836;

> De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76

> Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open

> source PM

>=20

> Hi Limei,

>=20

> Thanks for the update. Unfortunately, I am leaving on vacation this

> evening. Please work with Girish on this matter.

>=20

> Cheers

> Jon

> ________________________________________

> From: Wang Limei-E12499 [E12499@motorola.com]

> Sent: Thursday, July 02, 2009 12:26 PM

> To: Hunter, Jon; Ghongdemath, Girish; Nayak, Rajendra;

> richardwoodruff2@ti.com; mikechan@google.com

> Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe =
Jocelyn-XHP836;

> De Chanterac Cyril-cdlc01; WIDZER NOAH-KFQG76; Wang Limei-E12499

> Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in K29 open

> source PM

>=20

> Jon, Girish, Richard,

>=20

> SRAM is already noncachable in K29 Open source PM code. The same piece

> of code you mentioned below are present in

> plat-omap/sram.c/omap-map-sram().

>=20

> And Jocelyn found that if force unlock_dll to zero, no more freeze. =
With

> this hack, testing result seems okay till now. Any idea about this? do

> you already know this issue, any patch?

>=20

> diff --git a/arch/arm/mach-omap2/clock34xx.c

> b/arch/arm/mach-omap2/clock34xx.c index 3cee6b4..82c1e98 100644

> --- a/arch/arm/mach-omap2/clock34xx.c

> +++ b/arch/arm/mach-omap2/clock34xx.c

> @@ -518,9 +518,12 @@ static int omap3_core_dpll_m2_set_rate(struct clk

> *clk, unsigned long rate)

>=20

>     pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n",

> clk->rate,

>          validrate);

> +

> +    /*Force it to 0 to hack freeze at wait_dll_unlock*/

> +    unlock_dll =3D 0;

>     omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,

>                   sp->actim_ctrlb, new_div, unlock_dll, c,

>                   sp->mr, rate > clk->rate);

> --

>=20

> Girish,

>=20

> For your question, yes, I only see freeze,  the system is still =
running

> and no crash. I can attach LB, but the instructions of PC stoppped  at

> is abnormal, Attached aretwo isntances,   it was not stuck at

> omap3_sram_configure_core_dpll,cpu is keeping on running, can stop and

> run multiple times by LB, but the instructions are all strange...

>=20

>=20

> thanks,

> limei

> ________________________________

> From: Hunter, Jon [mailto:jon-hunter@ti.com]

> Sent: Wednesday, July 01, 2009 10:53 AM

> To: Wang Limei-E12499; Ghongdemath, Girish; Nayak, Rajendra

> Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe =
Jocelyn-XHP836

> Subject: RE: Mem freeze at omap3_sram_configure_core_dpll in open =
source

> PM

>=20

> Hi Limei,

>=20

> Sorry for the delay. The last time we had a problem with dvfs it =
turned

> out to be that the SRAM was being configured as cacheable. Can you =
make

> sure that the SRAM is being as noncacheable in the function

> omap_map_sram() in the file arch/arm/plat-omap/sram.c?

>=20

> You should see something like:

>=20

>  205        if (cpu_is_omap34xx()) {

>  206                 omap_sram_io_desc[0].virtual =3D OMAP3_SRAM_VA;

>  207                 base =3D OMAP3_SRAM_PA;

>  208                 base =3D ROUND_DOWN(base, PAGE_SIZE);

>  209                 omap_sram_io_desc[0].pfn =3D __phys_to_pfn(base);

>  210

>  211                 /*

>  212                  * SRAM must be marked as non-cached on OMAP3 =
since

> the

>  213                  * CORE DPLL M2 divider change code (in SRAM) =
runs

> with the

>  214                  * SDRAM controller disabled, and if it is marked

> cached,

>  215                  * the ARM may attempt to write cache lines back =
to

> SDRAM

>  216                  * which will cause the system to hang.

>  217                  */

>  218                 omap_sram_io_desc[0].type =3D =
MT_MEMORY_NONCACHED;

>  219         }

>=20

> Please make sure that the above code is getting executed correctly. =
You

> can view the code here:

>=20

> =
http://android.git.kernel.org/?p=3Dkernel/omap.git;a=3Dblob;f=3Darch/arm/=
plat-

> =
omap/sram.c;h=3Da2e60e7e3c7c851cdb3896ac26b5ddb3a282194d;hb=3Drefs/heads/=
and

> roid-omap-2.6.29

>=20

> Cheers

> Jon

>=20

> ________________________________

> From: Wang Limei-E12499 [E12499@motorola.com]

> Sent: Tuesday, June 30, 2009 12:15 AM

> To: Ghongdemath, Girish; Hunter, Jon; Nayak, Rajendra

> Cc: Sripathi Srinivas-A14759; Wang Sawsd-A24013; Falempe =
Jocelyn-XHP836;

> Wang Limei-E12499

> Subject: Mem freeze at omap3_sram_configure_core_dpll in open source =
PM

>=20

>=20

> Hi Girish and Hon,

>=20

> I am working on open source PM and trying to enable vdd2 dvfs on =
Sholes

> HW, but phone freeze when running to

> clock34xx.c/omap3_core_dpll_m2_set_rate(), I have applied the patch =
from

> Rajendra Nayak, but seems does not resolve my problem. I also checked

> the SDRC settings on both K27 (functional one) and K29 nonfunctional

> one, the SDRC setting and mem parameters passed to

> omap3_configure_core_dpll() are same, do you have any idea about this?

>=20

> when freeze, below is the log:

>=20

> DVFS: sdrc_ick.rate=3D160500000,sdrcrate=3D80250000

>=20

> clock: changing CORE DPLL rate from 321000000 to 160500000

>=20

> clock: SDRC timing params used: 00023f01 61512283 0001120c

> 00000032,new_div=3D2,unlock_dll=3D1,c=3D103

>=20

> Attached LB right after that, the mem content is abnormal.  If attach =
LB

> first and set breakpoint at clock34xx.c/omap3_core_dpll_m2_set_rate()

> and then step through sram34xx.S/omap3_sram_configure_core_dpll(), =
when

> hit wait_dll_unlock instructions, LB status bar show "Emuation =
running",

> can not step any more.

>=20

> Thanks,

>=20

> limei

=20


------_=_NextPart_001_01CA00EF.F218233F--
