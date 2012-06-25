From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Mon, 25 Jun 2012 13:37:12 +0530
Message-ID: <CAC83ZvJWz7tCL9VSQXiLNoYDrg6+=Mkx7xS9hQivKfA_L_4ANw@mail.gmail.com>
References: <874nrmtf47.fsf@ti.com>
	<20120614101541.39f50aee@notabene.brown>
	<CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
	<20120621131616.7ac6426f@notabene.brown>
	<CAC83ZvLDObTh2MXABObyGCk5M9qdaJm5GqRUUozFrubH1HfNTg@mail.gmail.com>
	<20120625161845.59d6330b@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53029 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752159Ab2FYIHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 04:07:14 -0400
Received: by qafi31 with SMTP id i31so1847105qaf.1
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 01:07:13 -0700 (PDT)
In-Reply-To: <20120625161845.59d6330b@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 25, 2012 at 11:48 AM, NeilBrown <neilb@suse.de> wrote:
> On Thu, 21 Jun 2012 12:04:26 +0530 "DebBarma, Tarun Kanti"
> <tarun.kanti@ti.com> wrote:
>
>> On Thu, Jun 21, 2012 at 8:46 AM, NeilBrown <neilb@suse.de> wrote:
>> > On Thu, 14 Jun 2012 23:24:10 +0530 "DebBarma, Tarun Kanti"
>> > <tarun.kanti@ti.com> wrote:
>> >
>> >> On Thu, Jun 14, 2012 at 5:45 AM, NeilBrown <neilb@suse.de> wrote:
>> >> > On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com=
> wrote:
>> >> >
>> >> >> Hi Grant,
>> >> >>
>> >> >> Here's the final round of GPIO cleanups for v3.5. =A0This bran=
ch is based
>> >> >> on my for_3.5/fixes/gpio branch you just pulled.
>> >> >>
>> >> >> Kevin
>> >> >
>> >> > Hi.
>> >> >
>> >> > =A0I'm not sure if it was this series or the following cleanups=
 which broke
>> >> > =A0things for me, but I've been trying 3.5-rc2 on my GTA04 and =
the serial
>> >> > =A0console (ttyO2) dies as soon as the omap-gpio driver initial=
ises.
>> >> >
>> >> > =A0After some digging I came up with this patch to gpio-omap.c
>> >> >
>> >> > @@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(stru=
ct platform_device *pdev)
>> >> >
>> >> > =A0 =A0 =A0 =A0platform_set_drvdata(pdev, bank);
>> >> >
>> >> > + =A0 =A0 =A0 if (bank->get_context_loss_count)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context_loss_count =3D
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b=
ank->get_context_loss_count(bank->dev);
>> >> > =A0 =A0 =A0 =A0pm_runtime_enable(bank->dev);
>> >> > =A0 =A0 =A0 =A0pm_runtime_irq_safe(bank->dev);
>> >> > =A0 =A0 =A0 =A0pm_runtime_get_sync(bank->dev);
>> >> >
>> >> > which fixes it.
>> >> >
>> >> > What was happening =A0was that when omap_gpio_probe calls pm_ru=
ntime_get_sync,
>> >> > it calls
>> >> > =A0_od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio=
_runtime_resume
>> >> > =A0-> omap_gpio_restore_context
>> >> >
>> >> > and then the serial port stops.
>> >> > I reasoned that the context probably hadn't been set up yet, so=
 restoring
>> >> > from it broke things.
>> >> > Initialising bank->context_loss_count seems sensible and would =
ensure that
>> >> > we didn't try to restore the context until it has actually been=
 lost.
>> >>
>> >> I thought the following code exactly does that. That is context_l=
ost_cnt_after
>> >> would be zero until there is context loss. The bank->context_loss=
_count is zero
>> >> at the beginning. So, (context_lost_cnt_after !=3D bank->context_=
loss_count) would
>> >> be false and hence context restore should NOT happen? Not sure if=
 I am
>> >> over looking
>> >> anything here....
>> >>
>> >> omap_gpio_runtime_resume(...)
>> >> {
>> >> ...
>> >> =A0 =A0 =A0 =A0 if (bank->get_context_loss_count) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_lost_cnt_after =3D
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->get_context=
_loss_count(bank->dev);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (context_lost_cnt_after !=3D b=
ank->context_loss_count) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_gpio_restore=
_context(bank);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqre=
store(&bank->lock, flags);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 =A0 }
>> >> ...
>> >> }
>> >
>> > Hi,
>> > =A0I've looked more closely at this now.
>> >
>> > The problem is that the initial context loss count is *not* zero. =
=A0Not always.
>> > The context loss count is the sum of
>> >
>> > =A0 =A0 =A0 =A0count =3D pwrdm->state_counter[PWRDM_POWER_OFF];
>> > =A0 =A0 =A0 =A0count +=3D pwrdm->ret_logic_off_counter;
>> >
>> > =A0 =A0 =A0 =A0for (i =3D 0; i < pwrdm->banks; i++)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count +=3D pwrdm->ret_mem_off_count=
er[i];
>> >
>> > (from =A0pwrdm_get_context_loss_count()).
>> >
>> > These are initlialised in _pwrdm_register
>> >
>> > =A0 =A0 =A0 =A0/* Initialize the powerdomain's state counter */
>> > =A0 =A0 =A0 =A0for (i =3D 0; i < PWRDM_MAX_PWRSTS; i++)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->state_counter[i] =3D 0;
>> >
>> > =A0 =A0 =A0 =A0pwrdm->ret_logic_off_counter =3D 0;
>> > =A0 =A0 =A0 =A0for (i =3D 0; i < pwrdm->banks; i++)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->ret_mem_off_counter[i] =3D 0=
;
>> >
>> > =A0 =A0 =A0 =A0pwrdm_wait_transition(pwrdm);
>> > =A0 =A0 =A0 =A0pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
>> > =A0 =A0 =A0 =A0pwrdm->state_counter[pwrdm->state] =3D 1;
>> >
>> >
>> > What I'm seeing is that for wkup_pwrdm and dpll{3,4,5}_pwrdm,
>> > the state that pwrdm_read_pwrst returns is PWRDM_POWER_OFF.
>> > So that state_counter gets initialised to '1', and so the initial
>> > context_loss_count, which includes that counter, is also '1'.
>> > I think it is the wkup_pwrdm that covers the GPIOs that are causin=
g problems
>> > for me.
>> I just put a log in omap_gpio_probe() to see the value of context_lo=
ss_count.
>> GPIO Bank 0 (WKUP Domain) always shows the count as '1'.
>>
>> [ =A0 =A00.169494] omap_gpio omap_gpio.0: context_loss_count=3D1
>> [ =A0 =A00.170227] gpiochip_add: registered GPIOs 0 to 31 on device:=
 gpio
>> [ =A0 =A00.170471] OMAP GPIO hardware version 0.1
>> [ =A0 =A00.170623] omap_gpio omap_gpio.1: context_loss_count=3D0
>> [ =A0 =A00.170928] gpiochip_add: registered GPIOs 32 to 63 on device=
: gpio
>> [ =A0 =A00.171295] omap_gpio omap_gpio.2: context_loss_count=3D0
>> [ =A0 =A00.171600] gpiochip_add: registered GPIOs 64 to 95 on device=
: gpio
>> [ =A0 =A00.171936] omap_gpio omap_gpio.3: context_loss_count=3D0
>> [ =A0 =A00.172241] gpiochip_add: registered GPIOs 96 to 127 on devic=
e: gpio
>> [ =A0 =A00.172576] omap_gpio omap_gpio.4: context_loss_count=3D0
>> [ =A0 =A00.172882] gpiochip_add: registered GPIOs 128 to 159 on devi=
ce: gpio
>> [ =A0 =A00.173217] omap_gpio omap_gpio.5: context_loss_count=3D0
>> [ =A0 =A00.173522] gpiochip_add: registered GPIOs 160 to 191 on devi=
ce: gpio
>
> That's consistent with what I see, and confirm that initialising the
> context_lost_count to zero isn't always correct.
I am just wondering if the context_lost_count =3D 1 for GPIO in WKUP do=
main
is expected. In that case we have to add additional logic in runtime ca=
llbacks
to skip context restore/save for WKUP domain GPIOs.
But let's hear what Kevin says.
--
Tarun

>
> Thanks,
> NeilBrown
>
>
>> --
>> Tarun
>> >
>> > So either there is something seriously wrong with pwrdm_read_pwrst=
 and it
>> > shouldn't be reporting that the wkup_pwrdm is off, or we need to i=
nitialise
>> > bank->context_loss_count like my patch does.
>> >
>> > NeilBrown
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
