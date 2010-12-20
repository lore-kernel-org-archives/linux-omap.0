From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick
	strategy
Date: Mon, 20 Dec 2010 13:33:22 +0200
Message-ID: <20101220113322.GS31404@nokia.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-3-git-send-email-nm@ti.com> <AANLkTi=4DJAnXcTZ37rcmr9Kz2CmXx6uhPqNThnoR2gu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:46563 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757360Ab0LTLgr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 06:36:47 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=4DJAnXcTZ37rcmr9Kz2CmXx6uhPqNThnoR2gu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jean Pihet <jean.pihet@newoldbits.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

On Mon, Dec 20, 2010 at 11:23:27AM +0100, ext Jean Pihet wrote:
> On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> > From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> >
> > Erratum i581 impacts OMAP3 platforms.
> > PRCM DPLL control FSM removes SDRC_IDLEREQ before DPLL3 locks causi=
ng
> > the DPLL not to be locked at times.
> >
> > IMPORTANT:
> > *) This is not a complete workaround implementation as recommended
> > by the silicon erratum. this is a support logic for detecting locku=
ps and
> > attempting to recover where possible and is known to provide stabil=
ity
> > in multiple platforms.
> > *) This code is mostly important for inactive and retention. The RO=
M code
> > waits for the maximum dll lock time when resuming from off mode. So=
 for
> > off mode this code isn't really needed.
> >
> > This should eventually get refactored as part of cleanups to sleep3=
4xx.S
> >
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> >
> > Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.co=
m>
> > ---
> > (no change done, posting for completeness of the series)
> > v2: https://patchwork.kernel.org/patch/365252/
> > =A0 =A0 =A0 =A0typo correction- erratum, support, added comment fro=
m Peter from the
> > =A0 =A0 =A0 =A0thread to commit message
> > v1: http://marc.info/?l=3Dlinux-omap&m=3D129013172525234&w=3D2
> > =A0arch/arm/mach-omap2/sleep34xx.S | =A0 52 +++++++++++++++++++++++=
++++++++++++---
> > =A01 files changed, 47 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/=
sleep34xx.S
> > index 2c20fcf..3fbd1e5 100644
> > --- a/arch/arm/mach-omap2/sleep34xx.S
> > +++ b/arch/arm/mach-omap2/sleep34xx.S
> > @@ -42,6 +42,7 @@
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP=
3430_PM_PREPWSTST)
> > =A0#define PM_PWSTCTRL_MPU_P =A0 =A0 =A0OMAP3430_PRM_BASE + MPU_MOD=
 + OMAP2_PM_PWSTCTRL
> > =A0#define CM_IDLEST1_CORE_V =A0 =A0 =A0OMAP34XX_CM_REGADDR(CORE_MO=
D, CM_IDLEST1)
> > +#define CM_IDLEST_CKGEN_V =A0 =A0 =A0OMAP34XX_CM_REGADDR(PLL_MOD, =
CM_IDLEST)
> > =A0#define SRAM_BASE_P =A0 =A0 =A0 =A0 =A0 =A00x40200000
> > =A0#define CONTROL_STAT =A0 =A0 =A0 =A0 =A0 0x480022F0
> > =A0#define SCRATCHPAD_MEM_OFFS =A0 =A00x310 /* Move this as correct=
 place is
> > @@ -554,31 +555,67 @@ skip_l2_inval:
> >
> > =A0/* Make sure SDRC accesses are ok */
> > =A0wait_sdrc_ok:
> > +
> > +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW en=
sures this. */
> > + =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest_ckgen
> > +wait_dpll3_lock:
> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> > + =A0 =A0 =A0 tst =A0 =A0 r5, #1
> > + =A0 =A0 =A0 beq =A0 =A0 wait_dpll3_lock
> > +
> > =A0 =A0 =A0 =A0 ldr =A0 =A0 r4, cm_idlest1_core
> > +wait_sdrc_ready:
> > =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> > - =A0 =A0 =A0 =A0and =A0 =A0 r5, r5, #0x2
> > - =A0 =A0 =A0 =A0cmp =A0 =A0 r5, #0
> > - =A0 =A0 =A0 =A0bne =A0 =A0 wait_sdrc_ok
> > + =A0 =A0 =A0 =A0tst =A0 =A0 r5, #0x2
> > + =A0 =A0 =A0 =A0bne =A0 =A0 wait_sdrc_ready
> > + =A0 =A0 =A0 /* allow DLL powerdown upon hw idle req */
> > =A0 =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_power
> > =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> > =A0 =A0 =A0 =A0 bic =A0 =A0 r5, r5, #0x40
> > =A0 =A0 =A0 =A0 str =A0 =A0 r5, [r4]
> > -wait_dll_lock:
> > +is_dll_in_lock_mode:
> > +
> > =A0 =A0 =A0 =A0 /* Is dll in lock mode? */
> > =A0 =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
> > =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> > =A0 =A0 =A0 =A0 tst =A0 =A0 r5, #0x4
> > =A0 =A0 =A0 =A0 bxne =A0 =A0lr
> > =A0 =A0 =A0 =A0 /* wait till dll locks */
> > - =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_dlla_status
> > +wait_dll_lock_timed:
> > + =A0 =A0 =A0 ldr =A0 =A0 r4, wait_dll_lock_counter
> > + =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
> > + =A0 =A0 =A0 str =A0 =A0 r4, wait_dll_lock_counter
> > + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_status
> > + =A0 =A0 =A0 =A0mov =A0 =A0r6, #8 =A0 =A0 =A0 =A0 =A0/* Wait 20uS =
for lock */
> > +wait_dll_lock:
> > + =A0 =A0 =A0 subs =A0 =A0r6, r6, #0x1
> > + =A0 =A0 =A0 beq =A0 =A0 kick_dll
>=20
> It would be good to have more comments on the code flow here:
> - what are wait_dll_lock_counter and kick_counter used for?

=46or debugging and statistics. So you can find out how many times a
'kick' was needed.

> - what is the timing based on? Why 20uS for the wait time?

This is the maximum lock time of the dll according to TI for OMAP3430.

> - jumping back and forth to kick_dll and wait_dll_lock_timed is confu=
sing.
>=20
> > =A0 =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> > =A0 =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x4
> > =A0 =A0 =A0 =A0 cmp =A0 =A0 r5, #0x4
> > =A0 =A0 =A0 =A0 bne =A0 =A0 wait_dll_lock
> > =A0 =A0 =A0 =A0 bx =A0 =A0 =A0lr
> >
> > + =A0 =A0 =A0 /* disable/reenable DLL if not locked */
> > +kick_dll:
> > + =A0 =A0 =A0 ldr =A0 =A0 r4, sdrc_dlla_ctrl
> > + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4]
> > + =A0 =A0 =A0 mov =A0 =A0 r6, r5
> > + =A0 =A0 =A0 bic =A0 =A0 r6, #(1<<3) =A0 =A0 /* disable dll */
> > + =A0 =A0 =A0 str =A0 =A0 r6, [r4]
> > + =A0 =A0 =A0 dsb
> > + =A0 =A0 =A0 orr =A0 =A0 r6, r6, #(1<<3) /* enable dll */
> > + =A0 =A0 =A0 str =A0 =A0 r6, [r4]
> > + =A0 =A0 =A0 dsb
> > + =A0 =A0 =A0 ldr =A0 =A0 r4, kick_counter
> > + =A0 =A0 =A0 add =A0 =A0 r4, r4, #1
> > + =A0 =A0 =A0 str =A0 =A0 r4, kick_counter
> > + =A0 =A0 =A0 b =A0 =A0 =A0 wait_dll_lock_timed
> > +
> > =A0cm_idlest1_core:
> > =A0 =A0 =A0 =A0.word =A0 CM_IDLEST1_CORE_V
> > +cm_idlest_ckgen:
> > + =A0 =A0 =A0 .word =A0 CM_IDLEST_CKGEN_V
> > =A0sdrc_dlla_status:
> > =A0 =A0 =A0 =A0.word =A0 SDRC_DLLA_STATUS_V
> > =A0sdrc_dlla_ctrl:
> > @@ -615,5 +652,10 @@ control_stat:
> > =A0 =A0 =A0 =A0.word =A0 CONTROL_STAT
> > =A0kernel_flush:
> > =A0 =A0 =A0 =A0.word v7_flush_dcache_all
> > + =A0 =A0 =A0 /* these 2 words need to be at the end !!! */
> > +kick_counter:
> > + =A0 =A0 =A0 .word =A0 0
> > +wait_dll_lock_counter:
> > + =A0 =A0 =A0 .word =A0 0
> Why do they need to be at the end? Also, at the end of what do they n=
eed to be?
>=20

At the end of omap34xx_cpu_suspend. As we don't know where in SRAM the
counters will be, the code accessing those counters addresses them
relative from (_omap_sram_idle + omap34xx_cpu_suspend_sz). Not sure if
this part of the code made it to linux-omap though.

Cheers,

Peter.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
