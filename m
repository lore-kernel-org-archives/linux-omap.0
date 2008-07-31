From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Thu, 31 Jul 2008 18:38:57 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208A6A03F@dbde02.ent.ti.com>
References: <486BDD2A.5070500@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com>
 <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
 <486F21F6.7020208@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com>
 <87vdzi2ln0.fsf@trdhcp146196.ntc.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9263@dbde02.ent.ti.com>
 <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl>
 <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9641@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:60561 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbYGaNLW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2008 09:11:22 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9641@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, H?gander Jouni <jouni.hogander@nokia.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>
> > >> diff --git a/arch/arm/mach-omap2/pm34xx.c
> > >> b/arch/arm/mach-omap2/pm34xx.c
> > >> index 202c269..308835b 100644
> > >> --- a/arch/arm/mach-omap2/pm34xx.c
> > >> +++ b/arch/arm/mach-omap2/pm34xx.c
> > >> @@ -380,11 +380,11 @@ int __init omap3_pm_init(void)
> > >>                goto err1;
> > >>        }
> > >>
> > >> -       ret = pwrdm_for_each(pwrdms_setup);
> > >> -       if (ret) {
> > >> -               printk(KERN_ERR "Failed to setup powerdomains\n");
> > >> -               goto err2;
> > >> -       }
> > >> +/*     ret = pwrdm_for_each(pwrdms_setup); */
> > >> +/*     if (ret) { */
> > >> +/*             printk(KERN_ERR "Failed to setup powerdomains\n"); */
> > >> +/*             goto err2; */
> > >> +/*     } */
> > >>
> > >>        mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
> > >>        if (mpu_pwrdm == NULL) {
> > >

Hi Jouni,

Commenting the lines did fix my UART 3 issue, but I am not clear as to what is happening by having it enabled. Before I dig in further can you give your thoughts as to why these lines could result in UART3 hang?

Thanks.

Regards,
Khasim

