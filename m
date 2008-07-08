From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Tue, 08 Jul 2008 09:15:42 +0300
Message-ID: <8763rg3nqp.fsf@trdhcp146196.ntc.nokia.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50392 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYGHGQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 02:16:24 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BCE275B@dlee02.ent.ti.com>
	(ext Woodruff's message of "Mon, 7 Jul 2008 17:25:09 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> I am still trying to find my way thru the codebase in GIT; but here =
is
>> what I can suggest based on similar problem diagnosed (still under
>> test) on the OMAP3EVM:
>>
>> 1) Save/restore the GPIO_IRQENABLE1, GPIO_IRQENABLE2
>> 2) Save/restore the GPIO_IRQSTATUS1, GPIO_IRQSTATUS2
>
> For sure save/restore of IRQENABLE is needed.  Our Labrador board
> which has Ethernet on per-gpio would stop to function after an OFF
> mode transition with out this save and restore (using CDP reference
> code).

I think this is not related to OFF mode, because OFF state is not
used on the boot. This problem seems to disappear when boot is
done and C6 state is started to be used. Currently it seems to me that
this problem exists if using states where mpu is in sleep state and
core is active (C2, C3). This is under investigation. Is there any
known restrictions in GPIO1 module wake-up capability when mpu is in
sleep and core active? Any other known restrictions?

>
> I don't think STATUS is necessary.  It=E2=80=99s a write 1 to clear r=
egister and should re-latch once there is data.
>
> As a side note I was noting that the SMC9211 etherchip actually may n=
eed a dvfs pre-post notifier.  During DVFS spurious interrupt events ca=
use the interface to disable interrupts on its own on some tests.
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
