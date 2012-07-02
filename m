From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Mon, 02 Jul 2012 10:37:21 -0700
Message-ID: <87pq8e6p4e.fsf@ti.com>
References: <874nrmtf47.fsf@ti.com> <20120614101541.39f50aee@notabene.brown>
	<CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
	<20120621131616.7ac6426f@notabene.brown>
	<CAC83ZvLDObTh2MXABObyGCk5M9qdaJm5GqRUUozFrubH1HfNTg@mail.gmail.com>
	<20120625161845.59d6330b@notabene.brown>
	<CAC83ZvJWz7tCL9VSQXiLNoYDrg6+=Mkx7xS9hQivKfA_L_4ANw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:36381 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755983Ab2GBRhU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 13:37:20 -0400
Received: by pbcwz7 with SMTP id wz7so13751963pbc.16
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 10:37:17 -0700 (PDT)
In-Reply-To: <CAC83ZvJWz7tCL9VSQXiLNoYDrg6+=Mkx7xS9hQivKfA_L_4ANw@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Mon, 25 Jun 2012 13:37:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: NeilBrown <neilb@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Mon, Jun 25, 2012 at 11:48 AM, NeilBrown <neilb@suse.de> wrote:
>> On Thu, 21 Jun 2012 12:04:26 +0530 "DebBarma, Tarun Kanti"
>> <tarun.kanti@ti.com> wrote:
>>
>>> On Thu, Jun 21, 2012 at 8:46 AM, NeilBrown <neilb@suse.de> wrote:
>>> > On Thu, 14 Jun 2012 23:24:10 +0530 "DebBarma, Tarun Kanti"
>>> > <tarun.kanti@ti.com> wrote:
>>> >
>>> >> On Thu, Jun 14, 2012 at 5:45 AM, NeilBrown <neilb@suse.de> wrote=
:
>>> >> > On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.co=
m> wrote:
>>> >> >
>>> >> >> Hi Grant,
>>> >> >>
>>> >> >> Here's the final round of GPIO cleanups for v3.5. =C2=A0This =
branch is based
>>> >> >> on my for_3.5/fixes/gpio branch you just pulled.
>>> >> >>
>>> >> >> Kevin
>>> >> >
>>> >> > Hi.
>>> >> >
>>> >> > =C2=A0I'm not sure if it was this series or the following clea=
nups which broke
>>> >> > =C2=A0things for me, but I've been trying 3.5-rc2 on my GTA04 =
and the serial
>>> >> > =C2=A0console (ttyO2) dies as soon as the omap-gpio driver ini=
tialises.
>>> >> >
>>> >> > =C2=A0After some digging I came up with this patch to gpio-oma=
p.c
>>> >> >
>>> >> > @@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(str=
uct platform_device *pdev)
>>> >> >
>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, bank);
>>> >> >
>>> >> > + =C2=A0 =C2=A0 =C2=A0 if (bank->get_context_loss_count)
>>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->conte=
xt_loss_count =3D
>>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->get_context_loss_count=
(bank->dev);
>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_enable(bank->dev);
>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_irq_safe(bank->dev);
>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_get_sync(bank->dev);
>>> >> >
>>> >> > which fixes it.
>>> >> >
>>> >> > What was happening =C2=A0was that when omap_gpio_probe calls p=
m_runtime_get_sync,
>>> >> > it calls
>>> >> > =C2=A0_od_runtime_resume -> pm_generic_runtime_resume -> omap_=
gpio_runtime_resume
>>> >> > =C2=A0-> omap_gpio_restore_context
>>> >> >
>>> >> > and then the serial port stops.
>>> >> > I reasoned that the context probably hadn't been set up yet, s=
o restoring
>>> >> > from it broke things.
>>> >> > Initialising bank->context_loss_count seems sensible and would=
 ensure that
>>> >> > we didn't try to restore the context until it has actually bee=
n lost.
>>> >>
>>> >> I thought the following code exactly does that. That is context_=
lost_cnt_after
>>> >> would be zero until there is context loss. The bank->context_los=
s_count is zero
>>> >> at the beginning. So, (context_lost_cnt_after !=3D bank->context=
_loss_count) would
>>> >> be false and hence context restore should NOT happen? Not sure i=
f I am
>>> >> over looking
>>> >> anything here....
>>> >>
>>> >> omap_gpio_runtime_resume(...)
>>> >> {
>>> >> ...
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bank->get_context_loss_count) {
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_=
lost_cnt_after =3D
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bank->get_context_loss_count(bank->dev);
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cont=
ext_lost_cnt_after !=3D bank->context_loss_count) {
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 omap_gpio_restore_context(bank);
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&bank->lock, flags);
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return 0;
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> >> ...
>>> >> }
>>> >
>>> > Hi,
>>> > =C2=A0I've looked more closely at this now.
>>> >
>>> > The problem is that the initial context loss count is *not* zero.=
 =C2=A0Not always.
>>> > The context loss count is the sum of
>>> >
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D pwrdm->state_counter[PWRDM_P=
OWER_OFF];
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0count +=3D pwrdm->ret_logic_off_counte=
r;
>>> >
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < pwrdm->banks; i++)
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count +=3D=
 pwrdm->ret_mem_off_counter[i];
>>> >
>>> > (from =C2=A0pwrdm_get_context_loss_count()).
>>> >
>>> > These are initlialised in _pwrdm_register
>>> >
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initialize the powerdomain's state =
counter */
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < PWRDM_MAX_PWRSTS; i+=
+)
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm->sta=
te_counter[i] =3D 0;
>>> >
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm->ret_logic_off_counter =3D 0;
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < pwrdm->banks; i++)
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm->ret=
_mem_off_counter[i] =3D 0;
>>> >
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm_wait_transition(pwrdm);
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm->state =3D pwrdm_read_pwrst(pwrd=
m);
>>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm->state_counter[pwrdm->state] =3D=
 1;
>>> >
>>> >
>>> > What I'm seeing is that for wkup_pwrdm and dpll{3,4,5}_pwrdm,
>>> > the state that pwrdm_read_pwrst returns is PWRDM_POWER_OFF.
>>> > So that state_counter gets initialised to '1', and so the initial
>>> > context_loss_count, which includes that counter, is also '1'.
>>> > I think it is the wkup_pwrdm that covers the GPIOs that are causi=
ng problems
>>> > for me.
>>> I just put a log in omap_gpio_probe() to see the value of context_l=
oss_count.
>>> GPIO Bank 0 (WKUP Domain) always shows the count as '1'.
>>>
>>> [ =C2=A0 =C2=A00.169494] omap_gpio omap_gpio.0: context_loss_count=3D=
1
>>> [ =C2=A0 =C2=A00.170227] gpiochip_add: registered GPIOs 0 to 31 on =
device: gpio
>>> [ =C2=A0 =C2=A00.170471] OMAP GPIO hardware version 0.1
>>> [ =C2=A0 =C2=A00.170623] omap_gpio omap_gpio.1: context_loss_count=3D=
0
>>> [ =C2=A0 =C2=A00.170928] gpiochip_add: registered GPIOs 32 to 63 on=
 device: gpio
>>> [ =C2=A0 =C2=A00.171295] omap_gpio omap_gpio.2: context_loss_count=3D=
0
>>> [ =C2=A0 =C2=A00.171600] gpiochip_add: registered GPIOs 64 to 95 on=
 device: gpio
>>> [ =C2=A0 =C2=A00.171936] omap_gpio omap_gpio.3: context_loss_count=3D=
0
>>> [ =C2=A0 =C2=A00.172241] gpiochip_add: registered GPIOs 96 to 127 o=
n device: gpio
>>> [ =C2=A0 =C2=A00.172576] omap_gpio omap_gpio.4: context_loss_count=3D=
0
>>> [ =C2=A0 =C2=A00.172882] gpiochip_add: registered GPIOs 128 to 159 =
on device: gpio
>>> [ =C2=A0 =C2=A00.173217] omap_gpio omap_gpio.5: context_loss_count=3D=
0
>>> [ =C2=A0 =C2=A00.173522] gpiochip_add: registered GPIOs 160 to 191 =
on device: gpio
>>
>> That's consistent with what I see, and confirm that initialising the
>> context_lost_count to zero isn't always correct.
> I am just wondering if the context_lost_count =3D 1 for GPIO in WKUP =
domain
> is expected. In that case we have to add additional logic in runtime =
callbacks
> to skip context restore/save for WKUP domain GPIOs.
> But let's hear what Kevin says.

I think the original patch from Neil looks right.

Note that we would need something like this in the case where we built
the GPIO driver as a module and it was unloaded/reloaded where the
starting point of the context-loss count would not be zero.

Neil, care to send a patch w/changelog?

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
