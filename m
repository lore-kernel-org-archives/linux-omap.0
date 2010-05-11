From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/2] ARM: VFP: Fixed suspend and added context save
 support
Date: Tue, 11 May 2010 13:04:50 -0700
Message-ID: <20100511200450.GG13931@atomide.com>
References: <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
 <1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
 <AANLkTilyji16JTT1Oe8fOT6Oz5tzopQNc-3AIQ3UprCO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53027 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab0EKUFC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 16:05:02 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilyji16JTT1Oe8fOT6Oz5tzopQNc-3AIQ3UprCO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ye janboe <janboe.ye@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

* ye janboe <janboe.ye@gmail.com> [100510 20:10]:
> hi, Russell, Tony
>=20
> Is this patch ignored by you? I do not see any ack for this patch.

I guess we're still waiting to hear from Russell. AFAIK, this is needed
in addition to the three patches from Imre.

Acked-by: Tony Lindgren <tony@atomide.com>
=20
> Thanks
>=20
> Janboe Ye
>=20
> 2009/12/3 Tero Kristo <tero.kristo@nokia.com>:
> > From: Tero Kristo <tero.kristo@nokia.com>
> >
> > In some ARM architectures, like OMAP3, the VFP context can be lost =
during
> > dynamic sleep cycle. For this purpose, there is now a function
> > vfp_pm_save_context() that should be called before the VFP is assum=
ed to
> > lose context. Next VFP trap will then restore context automatically=
=2E
> >
> > We need to have the last_VFP_context[cpu] cleared after the save in=
 idle,
> > else the restore would fail to restore when it sees that the last_V=
=46P_context
> > is same as the current threads vfp_state. This happens when the sam=
e
> > process/thread traps an exception post idle.
> >
> > This patch also fixes a potential problem with vfp_pm_suspend(), wh=
ere
> > VFP context can be lost if the current process does not have VFP en=
abled.
> > Fixed by calling vfp_pm_save_context().
> >
> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> > Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Richard Woodruff <r-woodruff2@ti.com>
> > Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> > ---
> > =C2=A0arch/arm/vfp/vfpmodule.c | =C2=A0 28 ++++++++++++++++++++----=
----
> > =C2=A01 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > index 2d7423a..920a33b 100644
> > --- a/arch/arm/vfp/vfpmodule.c
> > +++ b/arch/arm/vfp/vfpmodule.c
> > @@ -329,22 +329,34 @@ static void vfp_enable(void *unused)
> > =C2=A0#ifdef CONFIG_PM
> > =C2=A0#include <linux/sysdev.h>
> >
> > -static int vfp_pm_suspend(struct sys_device *dev, pm_message_t sta=
te)
> > +void vfp_pm_save_context(void)
> > =C2=A0{
> > - =C2=A0 =C2=A0 =C2=A0 struct thread_info *ti =3D current_thread_in=
fo();
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 fpexc =3D fmrx(FPEXC);
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int cpu =3D get_cpu();
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /* Save last_VFP_context if needed */
> > + =C2=A0 =C2=A0 =C2=A0 if (last_VFP_context[cpu]) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable vfp to=
 save context */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(fpexc & FP=
EXC_EN)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 vfp_enable(NULL);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fmxr(FPEXC, fpexc | FPEXC_EN);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> >
> > - =C2=A0 =C2=A0 =C2=A0 /* if vfp is on, then save state for resumpt=
ion */
> > - =C2=A0 =C2=A0 =C2=A0 if (fpexc & FPEXC_EN) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_=
DEBUG "%s: saving vfp state\n", __func__);
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vfp_save_state(&=
ti->vfpstate, fpexc);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vfp_save_state(l=
ast_VFP_context[cpu], fpexc);
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* disable, =
just in case */
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fmxr(FPEXC, fmrx=
(FPEXC) & ~FPEXC_EN);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fmxr(FPEXC, fpex=
c & ~FPEXC_EN);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_VFP_context=
[cpu] =3D NULL;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >
> > - =C2=A0 =C2=A0 =C2=A0 /* clear any information we had about last c=
ontext state */
> > - =C2=A0 =C2=A0 =C2=A0 memset(last_VFP_context, 0, sizeof(last_VFP_=
context));
> > + =C2=A0 =C2=A0 =C2=A0 put_cpu();
> > +}
> > +
> > +static int vfp_pm_suspend(struct sys_device *dev, pm_message_t sta=
te)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 vfp_pm_save_context();
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > =C2=A0}
> > --
> > 1.5.4.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
