From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Wed, 09 Jul 2008 09:48:27 +0300
Message-ID: <87y74bwo1w.fsf@trdhcp146196.ntc.nokia.com>
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
	<87prpoxzm0.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BD66B12@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40524 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYGIGtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 02:49:05 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BD66B12@dlee02.ent.ti.com>
	(ext Woodruff's message of "Tue, 8 Jul 2008 08:52:26 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> >         [x] Has anyone fixed the broken gpio wakeup enable code?
>> >         Right now this might even kill you as it will clear you
>> >         wakeup enable register.  This could stop you from waking
>> >         from a partially idle/clock stop condition on the L3?
>>
>> The problem was actually related to this. There is those
>> gpio_prepare_*
>> and gpio_resume_* functions which were not run. For some reason
>> next_state for powerdomains doesn't update correctly before hw_sup
>> mode is disabled. This caused problem that cpuidle thinks that core =
is
>> entering ON state, while it was actually entering state written in
>> omap3_pm_init. Now as cpuidle was thinking that core is not entering
>> any sleep state it didn't run gpio_prepare_* and gpio_resume_*
>> functions. This caused that interrupt was not generated for that gpi=
o
>> used by eth chip.
>>
>> This was fixed in my patches by disabling hw_sup mode before writing
>> next_state and then re-enable it. Those patches are also writing nex=
t
>> state if CORE next state is ON.
>
> Ok.  As I sent in my mail a couple weeks back.  The clearing of wakeu=
p events at GPIOs when the CORE hits INACTIVE might result in windows o=
f you not waking up, especially with dynamic tick in the system.  I wou=
ld guess the windows would be around boot & suspend resume.
>
> It is not so clear if gpio that hack is even needed on OMAP3.  There =
is some warning about spurious interrupts when going to RET/OFF for OMA=
P2. I don't recall for OMAP3.  didn't those prepare functions dink with=
 wake up masks in fear of spurious interrupts.  So, wasn't the result f=
or you the opposite, it kept you from waking, instead of suppressing ex=
tra wakes?
>
> Did you fix the OMAP2 GPIO wakeup mask in use at least?  The code
> had a hardcoded mask based on OMAP2 wakeup capable gpios which don't
> apply to omap3.

No I haven't modified that code. I have begun to use it before
retention because it is under #if defined(CONFIG_ARCH_OMAP34XX)
statement and used in case of omap2. Maybe we could stop using it in
case of omap3 at least this comment in gpio.c supports this: "See
OMAP2420 Errata item 1.101"? Seems to be just legacy code from omap2.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
