From: eric van tassell <evttxl@gmail.com>
Subject: Re: Question about tracing in _pwrdm_state_switch()
Date: Sun, 29 Jan 2012 10:38:17 -0600
Message-ID: <CAHjCt2-9Edr7G82UukpbavX3d2o1fyN35MXMUMyj_zmOop+Yzw@mail.gmail.com>
References: <alpine.DEB.2.00.1201290302480.27331@utopia.booyaka.com>
	<CAHjCt28mS64GuO+PFTFF+PAkE20n2Up9XJE5Rf8zH2YvKg33vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38525 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab2A2QiT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jan 2012 11:38:19 -0500
Received: by werb13 with SMTP id b13so2792226wer.19
        for <linux-omap@vger.kernel.org>; Sun, 29 Jan 2012 08:38:17 -0800 (PST)
In-Reply-To: <CAHjCt28mS64GuO+PFTFF+PAkE20n2Up9XJE5Rf8zH2YvKg33vg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: jpihet@newoldbits.com, linux-omap@vger.kernel.org, t-kristo@ti.com, khilman@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com

I dont have a Lauterbach but your argument seems valid. If:=C2=A0   +
device was in retention(CSWR) and the next state was supposed to be
OFF   + the device did not hit off   + by the time the code shown runs
the device is still in CSWR(say like the abe or ducati that would be
expected not to go to ON right away)
Then   + there is something you'd like to know about but no event will
be generated

-evt
On Sun, Jan 29, 2012 at 10:10 AM, eric van tassell <evttxl@gmail.com> w=
rote:
>
> I dont have a Lauterbach but your argument seems valid. If:
>
>    + device was in retention(CSWR) and the next state was supposed to=
 be OFF
> + the device did not hit off
> + by the time the code shown runs the device is still in CSWR(say lik=
e the abe or ducati that would be expected not to go to ON right away)
>
> Then
>
> there is something you'd like to know about but no event will be gene=
rated
>
> -evt
>
> On Sun, Jan 29, 2012 at 4:08 AM, Paul Walmsley <paul@pwsan.com> wrote=
:
>>
>>
>> Hi Jean
>>
>> Quick question on the tracing in _pwrdm_state_switch().
>>
>> That section of the code reads:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0state =3D pwrdm_read_pwrst(pwrdm);
>>
>> ...
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0case PWRDM_STATE_PREV:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prev =3D pwrd=
m_read_prev_pwrst(pwrdm);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pwrdm->st=
ate !=3D prev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pwrdm->state_counter[prev]++;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prev =3D=3D=
 PWRDM_POWER_RET)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0_update_logic_membank_counters(pwrdm);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If the pow=
er domain did not hit the desired state,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * generate a=
 trace event with both the desired and hit states
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (state !=3D=
 prev) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0trace_state =3D (PWRDM_TRACE_STATES_FLAG |
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((state=
 & OMAP_POWERSTATE_MASK) << 8) |
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((prev =
& OMAP_POWERSTATE_MASK) << 0));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0trace_power_domain_target(pwrdm->name, trace_state,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smp_processor_id());
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> This code is called after returning from WFI. =C2=A0It appears to co=
mpare the
>> powerdomain's current power state ('state') with the powerdomain's
>> previous power state ('prev'). =C2=A0But it appears to me that it sh=
ould
>> instead compare the powerdomain's intended power state ('pwrdm->stat=
e')
>> with 'prev' ? =C2=A0The rationale is that the PRCM could have brough=
t that
>> powerdomain up to a higher power state than 'pwrdm->state' during th=
e
>> wakeup process.
>>
>> What do you think?
>>
>>
>> - Paul
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
>
>
> --
> - evt
> (Eric van Tassell)
> twitter: evt_texelsoft
> linked-in: linkedin.com/in/evttxl




--
- evt
(Eric van Tassell)
twitter: evt_texelsoft
linked-in: linkedin.com/in/evttxl
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
