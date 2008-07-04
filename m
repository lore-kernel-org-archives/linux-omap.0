From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Fri, 04 Jul 2008 10:26:48 +0300
Message-ID: <87prpum7nr.fsf@trdhcp146196.ntc.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	<20080702131127.GA4404@codecarver.research.nokia.com>
	<000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
	<20080702154253.GC4404@codecarver.research.nokia.com>
	<004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40423 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbYGDH1V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 03:27:21 -0400
In-Reply-To: <004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Thu, 3 Jul 2008 14:09:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

Hi Rajendra,

"ext Rajendra Nayak" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com]=20
>> Sent: Wednesday, July 02, 2008 9:13 PM
>> To: ext Rajendra Nayak
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
>>=20
>> Hi Rajendra,
>>=20
>> >=20
>> > Not sure, but you can try with my .config while I try with yours.=20
>> > I was doing some more testing today, and I saw a hang after=20
>> a while of
>> > idle activity with OFF being attempted multiple times.
>> > Using lauterbach showed me it being stuck up in=20
>> prcm_interrupt_handler trying=20
>> > to clear MPU_IRQSTATUS.
>> > Looks like in the PRCM interrupt handler somehow=20
>> PM_WKST1_CORE is not cleared
>> > (I see it set to 0x2000) and hence MPU_IRQSTATUS fails to clear.
>> >=20
>>=20
>> Ok. I disabled OneNAND support and now I get off mode on VDD2 as wel=
l.
>> Consumption on VDD1 is 4uA and 32uA on VDD2. Unfortunately after the
>> first wakeup, off mode is never reached again.
>
> Do you see a hang? or OFF is never achieved?
> Can you try with the latest fixes that I posted.

As it seems to be hard to get similiar results with these patches,
could you please send me your uImage?

>
>>=20
>> Cheers,
>>=20
>> Peter.
>>=20
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
