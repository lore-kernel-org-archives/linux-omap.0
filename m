From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Mon, 07 Jul 2008 12:56:32 +0300
Message-ID: <87k5fy2f1r.fsf@trdhcp146196.ntc.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	<20080702131127.GA4404@codecarver.research.nokia.com>
	<000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
	<20080702154253.GC4404@codecarver.research.nokia.com>
	<004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
	<87prpum7nr.fsf@trdhcp146196.ntc.nokia.com>
	<873amqknae.fsf@trdhcp146196.ntc.nokia.com>
	<011601c8ddba$c4031110$68bf18ac@ent.ti.com>
	<1215423520.6048.16.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43031 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbYGGJ5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 05:57:08 -0400
In-Reply-To: <1215423520.6048.16.camel@kj-ubuntu> (Kalle Jokiniemi's message
	of "Mon, 07 Jul 2008 12:38:40 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: ext Rajendra Nayak <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> writes:

> On pe, 2008-07-04 at 15:15 +0530, ext Rajendra Nayak wrote:
> ...
>> > ext H=C3=B6gander Jouni <jouni.hogander@nokia.com> writes:
>
> ...
>
>> >=20
>> > So Rajendra sent his uImage and it works quite ok what comes to of=
f
>> > mode on my sdp board. I still see problems with serial console (sl=
ow)
>> > and on boot I need to generate manually interrupts to get it to
>> > boot. Otherwise board hangs at this point:
>>=20
>> Yes, I noticed this as well. It takes quite long to bootup if you do=
n't=20
>> generate UART interrupts.
>> After bootup once RET/OFF is hit, it takes a few hits to come out of=
 it
>> as IO wakeup is missing.
>
> Jouni had a theory that the ethernet device could cause this slowness
> trouble in the startup, so I investigated the matter a little further=
=2E
> By enabling the debug prints in the ethernet chip driver,
>
> diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
> index 776c81d..7d1eead 100644
> --- a/drivers/net/smc91x.c
> +++ b/drivers/net/smc91x.c
> @@ -62,7 +62,7 @@ static const char version[] =3D
> =20
>  /* Debugging level */
>  #ifndef SMC_DEBUG
> -#define SMC_DEBUG              0
> +#define SMC_DEBUG              1
>  #endif
>
>
> I was able to see, that we get lots of RX overrun interrupts with
> cpu_idle, meaning that incoming stuff is not getting processed. By
> generating UART interrupts, I we probably can also catch more network=
 RX
> interrupts and this helps the bootup go faster. =EF=BB=BFWith cpu_idl=
e disabled,
> there were no RX overruns.

Your investigation supports this theory. Interrupt line from eth chip
doesn't wake up mpu. I assume it is gpio line. Those are added to mpu
wake-up events group, gpio wake-ups are enabled and mpu peripherals
group wake-up event interrupt is enabled.

I'm suspecting that this problem happens if state where mpu is in
sleep state and core+per are awake is used.

Any comments from TI people what might be wrong?

>
> I'll try to see if this can be fixed somehow.
>
>>=20
>> >=20
>> > eth0: link up
>> > Sending DHCP requests ., OK
>> > IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.2.1=
01
>> > IP-Config: Complete:
>> >      device=3Deth0, addr=3D192.168.2.101, mask=3D255.255.255.0,=20
>> > gw=3D192.168.2.1,
>> >      host=3D192.168.2.101, domain=3Dntc.nokia.com, nis-domain=3D(n=
one),
>> >      bootserver=3D0.0.0.0, rootserver=3D172.22.146.197, rootpath=3D
>> > Looking up port of RPC 100003/2 on 172.22.146.197
>> > Looking up port of RPC 100005/1 on 172.22.146.197
>> > VFS: Mounted root (nfs filesystem).
>> > Freeing init memory: 108K
>> >=20
>> > Rajendra, are you still using .config file you sent to me? Are all=
 the
>> > changes in your tree available in l-o list.
>>=20
>> Yes, all the changes are part of the 11 patch set + 1 rework fixes p=
atch I sent.
>> To debug further, can you put a few prints in omap3_enter_idle and o=
map3_enter_idle_bm
>> to see what states are selected by the menu gov.=20
>> We will then know if CORE RET/OFF is attempted but not achieved due =
to some reason, or=20
>> never attempted altogether.
>
> My setup does not seem to go beyond C2 state, btw. So I'll need to de=
bug
> that also a bit. The above-mentioned patches are applied.
>
> Br, Kalle
>
>
> ...
>
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
