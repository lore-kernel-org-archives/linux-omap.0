From: ye janboe <janboe.ye@gmail.com>
Subject: Re: [PATCHv2 1/2] ARM: VFP: Fixed suspend and added context save
	support
Date: Tue, 11 May 2010 11:15:13 +0800
Message-ID: <AANLkTilyji16JTT1Oe8fOT6Oz5tzopQNc-3AIQ3UprCO@mail.gmail.com>
References: <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
	 <1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51429 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab0EKDPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 23:15:15 -0400
Received: by gwb19 with SMTP id 19so68603gwb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 20:15:14 -0700 (PDT)
In-Reply-To: <1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

hi, Russell, Tony

Is this patch ignored by you? I do not see any ack for this patch.

Thanks

Janboe Ye

2009/12/3 Tero Kristo <tero.kristo@nokia.com>:
> From: Tero Kristo <tero.kristo@nokia.com>
>
> In some ARM architectures, like OMAP3, the VFP context can be lost du=
ring
> dynamic sleep cycle. For this purpose, there is now a function
> vfp_pm_save_context() that should be called before the VFP is assumed=
 to
> lose context. Next VFP trap will then restore context automatically.
>
> We need to have the last_VFP_context[cpu] cleared after the save in i=
dle,
> else the restore would fail to restore when it sees that the last_VFP=
_context
> is same as the current threads vfp_state. This happens when the same
> process/thread traps an exception post idle.
>
> This patch also fixes a potential problem with vfp_pm_suspend(), wher=
e
> VFP context can be lost if the current process does not have VFP enab=
led.
> Fixed by calling vfp_pm_save_context().
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
> =A0arch/arm/vfp/vfpmodule.c | =A0 28 ++++++++++++++++++++--------
> =A01 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 2d7423a..920a33b 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -329,22 +329,34 @@ static void vfp_enable(void *unused)
> =A0#ifdef CONFIG_PM
> =A0#include <linux/sysdev.h>
>
> -static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state=
)
> +void vfp_pm_save_context(void)
> =A0{
> - =A0 =A0 =A0 struct thread_info *ti =3D current_thread_info();
> =A0 =A0 =A0 =A0u32 fpexc =3D fmrx(FPEXC);
> + =A0 =A0 =A0 unsigned int cpu =3D get_cpu();
> +
> + =A0 =A0 =A0 /* Save last_VFP_context if needed */
> + =A0 =A0 =A0 if (last_VFP_context[cpu]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable vfp to save context */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(fpexc & FPEXC_EN)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfp_enable(NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmxr(FPEXC, fpexc | FPE=
XC_EN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 /* if vfp is on, then save state for resumption */
> - =A0 =A0 =A0 if (fpexc & FPEXC_EN) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_DEBUG "%s: saving vfp stat=
e\n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfp_save_state(&ti->vfpstate, fpexc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfp_save_state(last_VFP_context[cpu], f=
pexc);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* disable, just in case */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmxr(FPEXC, fpexc & ~FPEXC_EN);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_VFP_context[cpu] =3D NULL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* clear any information we had about last context stat=
e */
> - =A0 =A0 =A0 memset(last_VFP_context, 0, sizeof(last_VFP_context));
> + =A0 =A0 =A0 put_cpu();
> +}
> +
> +static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state=
)
> +{
> + =A0 =A0 =A0 vfp_pm_save_context();
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
