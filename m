From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Thu, 14 Jun 2012 23:24:10 +0530
Message-ID: <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
References: <874nrmtf47.fsf@ti.com>
	<20120614101541.39f50aee@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:46724 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754999Ab2FNRyM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 13:54:12 -0400
Received: by qcmv28 with SMTP id v28so1626132qcm.39
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 10:54:10 -0700 (PDT)
In-Reply-To: <20120614101541.39f50aee@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 14, 2012 at 5:45 AM, NeilBrown <neilb@suse.de> wrote:
> On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com> wrot=
e:
>
>> Hi Grant,
>>
>> Here's the final round of GPIO cleanups for v3.5. =A0This branch is =
based
>> on my for_3.5/fixes/gpio branch you just pulled.
>>
>> Kevin
>
> Hi.
>
> =A0I'm not sure if it was this series or the following cleanups which=
 broke
> =A0things for me, but I've been trying 3.5-rc2 on my GTA04 and the se=
rial
> =A0console (ttyO2) dies as soon as the omap-gpio driver initialises.
>
> =A0After some digging I came up with this patch to gpio-omap.c
>
> @@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(struct pla=
tform_device *pdev)
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, bank);
>
> + =A0 =A0 =A0 if (bank->get_context_loss_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context_loss_count =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->g=
et_context_loss_count(bank->dev);
> =A0 =A0 =A0 =A0pm_runtime_enable(bank->dev);
> =A0 =A0 =A0 =A0pm_runtime_irq_safe(bank->dev);
> =A0 =A0 =A0 =A0pm_runtime_get_sync(bank->dev);
>
> which fixes it.
>
> What was happening =A0was that when omap_gpio_probe calls pm_runtime_=
get_sync,
> it calls
> =A0_od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio_runti=
me_resume
> =A0-> omap_gpio_restore_context
>
> and then the serial port stops.
> I reasoned that the context probably hadn't been set up yet, so resto=
ring
> from it broke things.
> Initialising bank->context_loss_count seems sensible and would ensure=
 that
> we didn't try to restore the context until it has actually been lost.

I thought the following code exactly does that. That is context_lost_cn=
t_after
would be zero until there is context loss. The bank->context_loss_count=
 is zero
at the beginning. So, (context_lost_cnt_after !=3D bank->context_loss_c=
ount) would
be false and hence context restore should NOT happen? Not sure if I am
over looking
anything here....

omap_gpio_runtime_resume(...)
{
=2E..
        if (bank->get_context_loss_count) {
                context_lost_cnt_after =3D
                        bank->get_context_loss_count(bank->dev);
                if (context_lost_cnt_after !=3D bank->context_loss_coun=
t) {
                        omap_gpio_restore_context(bank);
                } else {
                        spin_unlock_irqrestore(&bank->lock, flags);
                        return 0;
                }
        }
=2E..
}
--
Tarun
>
> Thanks,
> NeilBrown
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
