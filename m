From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Tue, 15 Jul 2008 16:51:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9641@dbde02.ent.ti.com>
References: <486BDD2A.5070500@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com>
 <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
 <486F21F6.7020208@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com>
 <87vdzi2ln0.fsf@trdhcp146196.ntc.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9263@dbde02.ent.ti.com>
 <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:57245 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbYGOLVe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2008 07:21:34 -0400
In-Reply-To: <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: H?gander Jouni <jouni.hogander@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> >> diff --git a/arch/arm/mach-omap2/pm34xx.c
> >> b/arch/arm/mach-omap2/pm34xx.c
> >> index 202c269..308835b 100644
> >> --- a/arch/arm/mach-omap2/pm34xx.c
> >> +++ b/arch/arm/mach-omap2/pm34xx.c
> >> @@ -380,11 +380,11 @@ int __init omap3_pm_init(void)
> >>                goto err1;
> >>        }
> >>
> >> -       ret = pwrdm_for_each(pwrdms_setup);
> >> -       if (ret) {
> >> -               printk(KERN_ERR "Failed to setup powerdomains\n");
> >> -               goto err2;
> >> -       }
> >> +/*     ret = pwrdm_for_each(pwrdms_setup); */
> >> +/*     if (ret) { */
> >> +/*             printk(KERN_ERR "Failed to setup powerdomains\n"); */
> >> +/*             goto err2; */
> >> +/*     } */
> >>
> >>        mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
> >>        if (mpu_pwrdm == NULL) {
> >
> > With this change, the hang does not happene. Applied this patch on
> > the current linux-omap tree.
> >
> > Thanks for the patch. It fixes the hang for now. I'm not sure why the hang
> > happens, but could it be because the SDP uses ttyS0 by default as the
> > console while the Beagle is on ttyS2?
>
> With that patch I still get the same behaviour:
>
> serial console freezes, but responds to sysrq
>
> I don't know if its related, but after the serial console freezes
> animated backgrounds in X stop animating, but will refresh if you
> press a key on the keyboard. The same effect can be seen with running
> 'top' on the screen.
> I'm using the CPUidle patches posted to the list a few weeks back +
> the timer suppression patch.
>
> regards,
>
> Koen

Okay. Guess I should have waited longer after applying the patch.

- Anand
