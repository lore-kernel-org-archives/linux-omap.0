From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Fri, 04 Jul 2008 12:55:21 +0300
Message-ID: <87y74ij7na.fsf@trdhcp146196.ntc.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	<20080702131127.GA4404@codecarver.research.nokia.com>
	<000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
	<20080702154253.GC4404@codecarver.research.nokia.com>
	<004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
	<87prpum7nr.fsf@trdhcp146196.ntc.nokia.com>
	<873amqknae.fsf@trdhcp146196.ntc.nokia.com>
	<011601c8ddba$c4031110$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32324 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYGDJz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 05:55:57 -0400
In-Reply-To: <011601c8ddba$c4031110$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Fri, 4 Jul 2008 15:15:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
>> Sent: Friday, July 04, 2008 3:02 PM
>> To: ext Rajendra Nayak
>> Cc: 'Peter 'p2' De Schrijver'; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
>>=20
>> Let's continue this discussion in here to make sure that everybody
>> sees it.
>>=20
>> ext H=C3=B6gander Jouni <jouni.hogander@nokia.com> writes:
>>=20
>> > Hi Rajendra,
>> >
>> > "ext Rajendra Nayak" <rnayak@ti.com> writes:
>> >
>> >>> -----Original Message-----
>> >>> From: Peter 'p2' De Schrijver=20
>> [mailto:peter.de-schrijver@nokia.com]=20
>> >>> Sent: Wednesday, July 02, 2008 9:13 PM
>> >>> To: ext Rajendra Nayak
>> >>> Cc: linux-omap@vger.kernel.org
>> >>> Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
>> >>>=20
>> >>> Hi Rajendra,
>> >>>=20
>> >>> >=20
>> >>> > Not sure, but you can try with my .config while I try=20
>> with yours.=20
>> >>> > I was doing some more testing today, and I saw a hang after=20
>> >>> a while of
>> >>> > idle activity with OFF being attempted multiple times.
>> >>> > Using lauterbach showed me it being stuck up in=20
>> >>> prcm_interrupt_handler trying=20
>> >>> > to clear MPU_IRQSTATUS.
>> >>> > Looks like in the PRCM interrupt handler somehow=20
>> >>> PM_WKST1_CORE is not cleared
>> >>> > (I see it set to 0x2000) and hence MPU_IRQSTATUS fails to clea=
r.
>> >>> >=20
>> >>>=20
>> >>> Ok. I disabled OneNAND support and now I get off mode on=20
>> VDD2 as well.
>> >>> Consumption on VDD1 is 4uA and 32uA on VDD2.=20
>> Unfortunately after the
>> >>> first wakeup, off mode is never reached again.
>> >>
>> >> Do you see a hang? or OFF is never achieved?
>> >> Can you try with the latest fixes that I posted.
>> >
>> > As it seems to be hard to get similiar results with these patches,
>> > could you please send me your uImage?
>>=20
>> So Rajendra sent his uImage and it works quite ok what comes to off
>> mode on my sdp board. I still see problems with serial console (slow=
)
>> and on boot I need to generate manually interrupts to get it to
>> boot. Otherwise board hangs at this point:
>
> Yes, I noticed this as well. It takes quite long to bootup if you don=
't=20
> generate UART interrupts.
> After bootup once RET/OFF is hit, it takes a few hits to come out of =
it
> as IO wakeup is missing.

Can you try to disable C2 state. I noticed that this state is used
all the time at the point on boot where board hangs. I tried to
disable and after this boot worked ok. With my image I couldn't
achieve off state.

>
>>=20
>> eth0: link up
>> Sending DHCP requests ., OK
>> IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.2.101
>> IP-Config: Complete:
>>      device=3Deth0, addr=3D192.168.2.101, mask=3D255.255.255.0,=20
>> gw=3D192.168.2.1,
>>      host=3D192.168.2.101, domain=3Dntc.nokia.com, nis-domain=3D(non=
e),
>>      bootserver=3D0.0.0.0, rootserver=3D172.22.146.197, rootpath=3D
>> Looking up port of RPC 100003/2 on 172.22.146.197
>> Looking up port of RPC 100005/1 on 172.22.146.197
>> VFS: Mounted root (nfs filesystem).
>> Freeing init memory: 108K
>>=20
>> Rajendra, are you still using .config file you sent to me? Are all t=
he
>> changes in your tree available in l-o list.
>
> Yes, all the changes are part of the 11 patch set + 1 rework fixes pa=
tch I sent.
> To debug further, can you put a few prints in omap3_enter_idle and om=
ap3_enter_idle_bm
> to see what states are selected by the menu gov.=20
> We will then know if CORE RET/OFF is attempted but not achieved due t=
o some reason, or=20
> never attempted altogether.

Ok, will send my results soon.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
