From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: Problems in cpuidle
Date: Fri, 13 Mar 2009 08:53:16 +0200
Message-ID: <87tz5xj4mb.fsf@trdhcp146196.ntc.nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC0EDF9C@dbde02.ent.ti.com>
	<871vt7ko3z.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC1855E0@dbde02.ent.ti.com>
	<87d4cpv28i.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC1F6BAF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51629 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZCMGxq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 02:53:46 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC1F6BAF@dbde02.ent.ti.com> (ext Premi's message of "Wed\, 11 Mar 2009 14\:23\:39 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
>> Sent: Tuesday, March 10, 2009 8:45 PM
>> To: Premi, Sanjeev
>> Cc: H=C3=B6gander Jouni; linux-omap@vger.kernel.org
>> Subject: Re: Problems in cpuidle
>>=20
>> "Premi, Sanjeev" <premi@ti.com> writes:
>>=20
>> >> -----Original Message-----
>> >> From: H=C3=B6gander Jouni [mailto:jouni.hogander@nokia.com]
>> >> Sent: Monday, March 09, 2009 3:36 PM
>> >> To: Premi, Sanjeev
>> >> Cc: linux-omap@vger.kernel.org
>> >> Subject: Re: Problems in cpuidle
>> >>=20
>> >> "ext Premi, Sanjeev" <premi@ti.com> writes:
>> >>=20
>> >> > While working with cpuidle, I have come across these problems.
>> >> > I am also working on the solutions, but would be good to=20
>> hear more=20
>> >> > thoughts.
>> >> >
>> >> > 1) The flag 'enable_dyn_sleep' is honoured only in
>> >> omap3_idle_bm_check()
>> >> >    but in the C1 state, omap3_enter_idle() is invoked directly.
>> >> >    So, the system can transition to deeper idle state(s)
>> >> >
>> >> >    Same is the case with 'sleep_block'.
>> >> >
>> >> >    Possible Solutions:
>> >> >      a)  Call omap3_can_sleep() in omap3_enter_idle().
>> >> >          This makes omap3_idle_bm_check() redundant; and
>> >> can be removed.
>> >> >
>> >> >      b)  Make single entry point for all idle states
>> >> >          But would be an overkill for C1 state.
>> >> >
>> >> >      c)  Change omap3_can_sleep() to check for=20
>> omap_uart_can_sleep()
>> >> >          and omap3_fclks_active() only.
>> >> >          Move check for 'enable_dyn_sleep' and 'sleep_block' in=
to
>> >> >          omap3_enter_idle()
>> >> >
>> >> >     I believe (c) would be the most optimal.
>> >>=20
>> >> Selecting (c) will break traditional pm_idle. Current plan=20
>> is to add=20
>> >> one more C state (C1) which would prevent mpu/core sleep=20
>> transitions.=20
>> >> Then remove fclk_active check completely.
>> >
>> > [sp] I meant doing the same for pm_idle as well.
>> >      Also, the new cstate will not help with 'sleep' block.
>> >
>> >      The proposed change look like:
>> >
>> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c=20
>> > b/arch/arm/mach-omap2/cpuidle34xx index 7fc3cb3..c25158c 100644
>> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> > @@ -82,6 +82,11 @@ static int omap3_enter_idle(struct=20
>> cpuidle_device *dev,
>> >         /* Used to keep track of the total time in idle */
>> >         getnstimeofday(&ts_preidle);
>> >
>> > +       if (!enable_dyn_sleep)
>> > +               goto return_sleep_time;
>> > +       if (atomic_read(&sleep_block) > 0)
>> > +               goto return_sleep_time;
>> > +
>> >         /*
>> >          * Adjust the idle state (if required).
>> >          * Also, ensure that usage statistics of correct=20
>> state are updated.
>> > diff --git a/arch/arm/mach-omap2/pm34xx.c=20
>> > b/arch/arm/mach-omap2/pm34xx.c index 0716d60..5c7819a 100644
>> > --- a/arch/arm/mach-omap2/pm34xx.c
>> > +++ b/arch/arm/mach-omap2/pm34xx.c
>> > @@ -476,14 +476,10 @@ static int omap3_fclks_active(void)
>> >
>> >  int omap3_can_sleep(void)
>> >  {
>> > -       if (!enable_dyn_sleep)
>> > -               return 0;
>> >         if (!omap_uart_can_sleep())
>> >                 return 0;
>> >         if (omap3_fclks_active())
>> >                 return 0;
>> > -       if (atomic_read(&sleep_block) > 0)
>> > -               return 0;
>> >         return 1;
>> >  }
>> >
>> > @@ -534,6 +530,11 @@ err:
>> >
>> >  static void omap3_pm_idle(void)
>> >  {
>> > +       if (!enable_dyn_sleep)
>> > +               return;
>> > +       if (atomic_read(&sleep_block) > 0)
>> > +               return;
>> > +
>> >         local_irq_disable();
>> >         local_fiq_disable();
>> >
>>=20
>> Sanjeev,
>>=20
>> I think it's cleaner to just make all the states go through=20
>> the 'bm_check', so the standard PM idle and CPUidle use the=20
>> same paths.
>
> [sp] I was trying to avoid duplicate code.
>      When all states go thru bm_check, omap3_enter_idle_bm() and
>      omap3_enter_idle() can be collapsed into single function.
>      Your thoughts?

I'm not sure if you noticed patch for Peter De Schrivjer. In that
patch he is adding one more C state, which is basically only WFI. MPU
and CORE are forced to stay active. He is also removing fclk check. So
that would mean no sleep if (sleep_block =3D=3D 1 || !enable_dyn_sleep =
||
!uart_can_sleep).

If sleep is still wanted in case of uart_can_sleep, maybe we could
just remove the check from omap3_can_sleep?

>
>> Kevin
>>=20
>>=20

--=20
Jouni H=C3=B6gander
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
