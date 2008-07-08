From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Tue, 08 Jul 2008 16:41:11 +0300
Message-ID: <87prpoxzm0.fsf@trdhcp146196.ntc.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	<20080702131127.GA4404@codecarver.research.nokia.com>
	<000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
	<20080702154253.GC4404@codecarver.research.nokia.com>
	<004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
	<87prpum7nr.fsf@trdhcp146196.ntc.nokia.com>
	<873amqknae.fsf@trdhcp146196.ntc.nokia.com>
	<011601c8ddba$c4031110$68bf18ac@ent.ti.com>
	<1215423520.6048.16.camel@kj-ubuntu>
	<87k5fy2f1r.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930111A74854@dbde02.ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162035BCE275B@dlee02.ent.ti.com>
	<8763rg3nqp.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BCE28A5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33385 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbYGHNly convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 09:41:54 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BCE28A5@dlee02.ent.ti.com>
	(ext Woodruff's message of "Tue, 8 Jul 2008 07:11:27 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> >
>> > For sure save/restore of IRQENABLE is needed.  Our Labrador board
>> > which has Ethernet on per-gpio would stop to function after an OFF
>> > mode transition with out this save and restore (using CDP referenc=
e
>> > code).
>>
>> I think this is not related to OFF mode, because OFF state is not
>> used on the boot. This problem seems to disappear when boot is
>> done and C6 state is started to be used. Currently it seems to me th=
at
>> this problem exists if using states where mpu is in sleep state and
>> core is active (C2, C3). This is under investigation. Is there any
>> known restrictions in GPIO1 module wake-up capability when mpu is in
>> sleep and core active? Any other known restrictions?
>
> If core is ACTIVE and irq is enabled at MPU then everything should wo=
rk on any gpio block.
>
> If the core is INACTIVE (which is possible with hardware auto's on) t=
hen the same holds from above IF you have also enabled all wakeup mecha=
nisms.
>
> If the core is in RET/OFF only selected gpio's will wake the system u=
p.  IIRC not all GPIO1 even are capable to wake you from this level of =
sleep.  I don't recall the list.
>
> You do have the ability to use an IO PAD wake up to wake from those w=
hile in RET/OFF.  However, I don't believe you will get an IO pad when =
you in INACTIVE/ACTIVE.  You do have to program for this event to be ge=
nerated at the pad and in the wakeup domain control registers.
>
> Questions might be:
>         - Has the prcm init happened and is the entire wake up path b=
een setup?
>
>         [x] Has anyone fixed the broken gpio wakeup enable code?
>         Right now this might even kill you as it will clear you
>         wakeup enable register.  This could stop you from waking
>         from a partially idle/clock stop condition on the L3?

The problem was actually related to this. There is those gpio_prepare_*
and gpio_resume_* functions which were not run. For some reason
next_state for powerdomains doesn't update correctly before hw_sup
mode is disabled. This caused problem that cpuidle thinks that core is
entering ON state, while it was actually entering state written in
omap3_pm_init. Now as cpuidle was thinking that core is not entering
any sleep state it didn't run gpio_prepare_* and gpio_resume_*
functions. This caused that interrupt was not generated for that gpio
used by eth chip.

This was fixed in my patches by disabling hw_sup mode before writing
next_state and then re-enable it. Those patches are also writing next
state if CORE next state is ON.

>
> Regards,
> Richard W.
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
