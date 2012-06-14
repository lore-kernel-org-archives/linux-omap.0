From: NeilBrown <neilb@suse.de>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Fri, 15 Jun 2012 07:06:11 +1000
Message-ID: <20120615070611.0fa559ed@notabene.brown>
References: <874nrmtf47.fsf@ti.com>
	<20120614101541.39f50aee@notabene.brown>
	<CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/xYN=dShzA4+PKrA9aCG1JTx"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44367 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220Ab2FNVGc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 17:06:32 -0400
In-Reply-To: <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

--Sig_/xYN=dShzA4+PKrA9aCG1JTx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Jun 2012 23:24:10 +0530 "DebBarma, Tarun Kanti"
<tarun.kanti@ti.com> wrote:

> On Thu, Jun 14, 2012 at 5:45 AM, NeilBrown <neilb@suse.de> wrote:
> > On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com> wrote:
> >
> >> Hi Grant,
> >>
> >> Here's the final round of GPIO cleanups for v3.5. =A0This branch is ba=
sed
> >> on my for_3.5/fixes/gpio branch you just pulled.
> >>
> >> Kevin
> >
> > Hi.
> >
> > =A0I'm not sure if it was this series or the following cleanups which b=
roke
> > =A0things for me, but I've been trying 3.5-rc2 on my GTA04 and the seri=
al
> > =A0console (ttyO2) dies as soon as the omap-gpio driver initialises.
> >
> > =A0After some digging I came up with this patch to gpio-omap.c
> >
> > @@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(struct platf=
orm_device *pdev)
> >
> > =A0 =A0 =A0 =A0platform_set_drvdata(pdev, bank);
> >
> > + =A0 =A0 =A0 if (bank->get_context_loss_count)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context_loss_count =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->get=
_context_loss_count(bank->dev);
> > =A0 =A0 =A0 =A0pm_runtime_enable(bank->dev);
> > =A0 =A0 =A0 =A0pm_runtime_irq_safe(bank->dev);
> > =A0 =A0 =A0 =A0pm_runtime_get_sync(bank->dev);
> >
> > which fixes it.
> >
> > What was happening =A0was that when omap_gpio_probe calls pm_runtime_ge=
t_sync,
> > it calls
> > =A0_od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio_runtime=
_resume
> > =A0-> omap_gpio_restore_context
> >
> > and then the serial port stops.
> > I reasoned that the context probably hadn't been set up yet, so restori=
ng
> > from it broke things.
> > Initialising bank->context_loss_count seems sensible and would ensure t=
hat
> > we didn't try to restore the context until it has actually been lost.
>=20
> I thought the following code exactly does that. That is context_lost_cnt_=
after
> would be zero until there is context loss. The bank->context_loss_count i=
s zero
> at the beginning. So, (context_lost_cnt_after !=3D bank->context_loss_cou=
nt) would
> be false and hence context restore should NOT happen? Not sure if I am
> over looking
> anything here....

Ahhh... I think I know what might be happening.

I found a while ago that if I actually enable off_mode some things
didn't work properly, but if I just set mpu_deepest_state to PWRDM_POWER_OFF
in next_valid_state, it all does work and I use less power.  So I did that.
It has now come back to bite me I expect.

I'll revert that, enable off mode properly, and see what happens.

Thanks,

NeilBrown


>=20
> omap_gpio_runtime_resume(...)
> {
> ...
>         if (bank->get_context_loss_count) {
>                 context_lost_cnt_after =3D
>                         bank->get_context_loss_count(bank->dev);
>                 if (context_lost_cnt_after !=3D bank->context_loss_count)=
 {
>                         omap_gpio_restore_context(bank);
>                 } else {
>                         spin_unlock_irqrestore(&bank->lock, flags);
>                         return 0;
>                 }
>         }
> ...
> }
> --
> Tarun
> >
> > Thanks,
> > NeilBrown
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Sig_/xYN=dShzA4+PKrA9aCG1JTx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT9pSQznsnt1WYoG5AQIJ4Q/8DblBkLBn6r6V3UkQTB1j0IMLngQcaQ4K
7c6tRIexcTuGE3TS15cN26yPQ70AVvYAKHIV4faxgWVJZTmO4iZ/JcRerwuu62N/
oAhg5q+gJL60dOKIWPOPzNy9J3Qtd0xKj67ekUH5K2byyJvRguKa/yrwppj0b/XC
e6IsIg1BfhWOzs46URaL701wjMfK2HOCALjymnNzvGrA5bLqOGoJnQfNkHTStM52
C1QEE4pK/pgtQ/+8DI7oxOcg5kUR6BtGPxJimQQJmoXa8si8LeYEuw7Xt9pokyZG
G8EZ/t63vCaskWxjGSojnhQHcCjzqEHE5Qg6tZkV5A0dlzD09eTI6y4ydgUgtzyR
TH33Pi6zqZYzTjiEdClgKbVZoeikXgflLziTfhIrBxuNvA3ByqXQA9aXExtwFDeD
INapYdVwIKfuUCx12vh82+M37Nd3jM7j38y6Mih3N4m7dF38f4F4vUti8FrtF05k
iFbAsGwioROS0bBWY9PHnb5hUQUcHSa+WL7mQzsK/GzTtfAp7mYz2La5rmwJDfn0
e4nCMYAVigJXXoYSzHwM1aZghudZeSBbP9C9MfNTyLH2RRf/G7rR3M3puLzgRIdD
XrzKXtGnzzA3jbayvHteQ/xCXiHNiWTSBclvWh1iQa4xXCUeIQry1sBzZZCgCDzq
RGPv1VrJSfE=
=s76j
-----END PGP SIGNATURE-----

--Sig_/xYN=dShzA4+PKrA9aCG1JTx--
