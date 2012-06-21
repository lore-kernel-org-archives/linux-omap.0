From: NeilBrown <neilb@suse.de>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Thu, 21 Jun 2012 13:16:16 +1000
Message-ID: <20120621131616.7ac6426f@notabene.brown>
References: <874nrmtf47.fsf@ti.com>
	<20120614101541.39f50aee@notabene.brown>
	<CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Lz=us5iwOEQcG0bl5ZEXsLc"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53291 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758162Ab2FUDQe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 23:16:34 -0400
In-Reply-To: <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

--Sig_/Lz=us5iwOEQcG0bl5ZEXsLc
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

Hi,
 I've looked more closely at this now.

The problem is that the initial context loss count is *not* zero.  Not alwa=
ys.
The context loss count is the sum of=20

	count =3D pwrdm->state_counter[PWRDM_POWER_OFF];
	count +=3D pwrdm->ret_logic_off_counter;

	for (i =3D 0; i < pwrdm->banks; i++)
		count +=3D pwrdm->ret_mem_off_counter[i];

(from  pwrdm_get_context_loss_count()).

These are initlialised in _pwrdm_register

	/* Initialize the powerdomain's state counter */
	for (i =3D 0; i < PWRDM_MAX_PWRSTS; i++)
		pwrdm->state_counter[i] =3D 0;

	pwrdm->ret_logic_off_counter =3D 0;
	for (i =3D 0; i < pwrdm->banks; i++)
		pwrdm->ret_mem_off_counter[i] =3D 0;

	pwrdm_wait_transition(pwrdm);
	pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
	pwrdm->state_counter[pwrdm->state] =3D 1;


What I'm seeing is that for wkup_pwrdm and dpll{3,4,5}_pwrdm,
the state that pwrdm_read_pwrst returns is PWRDM_POWER_OFF.
So that state_counter gets initialised to '1', and so the initial
context_loss_count, which includes that counter, is also '1'.
I think it is the wkup_pwrdm that covers the GPIOs that are causing problems
for me.

So either there is something seriously wrong with pwrdm_read_pwrst and it
shouldn't be reporting that the wkup_pwrdm is off, or we need to initialise
bank->context_loss_count like my patch does.

NeilBrown

--Sig_/Lz=us5iwOEQcG0bl5ZEXsLc
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT+KSADnsnt1WYoG5AQJOWg//UUl3qE3kbuMPVVgp1fchw2/fLyvJ4Anc
LSYpjFBlVlRa+sFlrWHpkamBF7P/2mQ9MlUAc4MPS+xh5vaciOPRuNLZfe0hiaiV
YqfObaUlefDP3jiLnVmTqwp90zpjtrBP7v3foJ5y3gaInUMH1VR8Hc36yTH0Ch5M
Q+1M5glBy1vP+6cK1r2A5w0SujMu2rrqSIrwFDwS5uj8JUaPOZO8I6csmw0iPblA
K67hBtdTYuKalDWMzhEW0jnfyCAdJcbzB3GyTzbOqXn0L4XmCrO8uUH3uo+IbzsA
G0WdV1PNsoLo3N/o/j9VjRplgxT8HwDNi++Jpftx2BHYO9Mqz6L+MtW5xNp3GxE4
KaYNSbKuAM+J+dPNsUeinPEOrXX5daDxe4/FFDWhDj1PncsC+5VwAPuEeyYYbI9l
gg8XuRCfg3bOo1nf7BqP23olI+DcKyKkFTxX4R1BWV7sAMoVRESIiQyMpsroAMWu
P5vsJ6ktTKH6+zA3kcSAztN8ftNevDBr0xiOBKeWC+FVUlskKxEKQIz+xV58It9P
20SmgyqdLmD3cBeF1gYwZ+ic0IDv5Kg5QkTnl/SSFUhz0o/xfjO61M76CFCaVRpZ
Wf22oNjFnVY9MkZygFyaEhPTZFqVFwtUaKo2qeQQlOLqYjs+lLkN/GDOxlH+cxrh
M6ygxwmwb/0=
=VQG2
-----END PGP SIGNATURE-----

--Sig_/Lz=us5iwOEQcG0bl5ZEXsLc--
