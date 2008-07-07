From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches
Date: Mon, 07 Jul 2008 12:38:40 +0300
Message-ID: <1215423520.6048.16.camel@kj-ubuntu>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	 <20080702131127.GA4404@codecarver.research.nokia.com>
	 <000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
	 <20080702154253.GC4404@codecarver.research.nokia.com>
	 <004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
	 <87prpum7nr.fsf@trdhcp146196.ntc.nokia.com>
	 <873amqknae.fsf@trdhcp146196.ntc.nokia.com>
	 <011601c8ddba$c4031110$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40612 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYGGJgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 05:36:47 -0400
In-Reply-To: <011601c8ddba$c4031110$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: =?ISO-8859-1?Q?=27=22H=F6gander=22?= Jouni' <jouni.hogander@nokia.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

On pe, 2008-07-04 at 15:15 +0530, ext Rajendra Nayak wrote:
=2E..
> > ext H=C3=B6gander Jouni <jouni.hogander@nokia.com> writes:

=2E..

> >=20
> > So Rajendra sent his uImage and it works quite ok what comes to off
> > mode on my sdp board. I still see problems with serial console (slo=
w)
> > and on boot I need to generate manually interrupts to get it to
> > boot. Otherwise board hangs at this point:
>=20
> Yes, I noticed this as well. It takes quite long to bootup if you don=
't=20
> generate UART interrupts.
> After bootup once RET/OFF is hit, it takes a few hits to come out of =
it
> as IO wakeup is missing.

Jouni had a theory that the ethernet device could cause this slowness
trouble in the startup, so I investigated the matter a little further.
By enabling the debug prints in the ethernet chip driver,

diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 776c81d..7d1eead 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -62,7 +62,7 @@ static const char version[] =3D
=20
 /* Debugging level */
 #ifndef SMC_DEBUG
-#define SMC_DEBUG              0
+#define SMC_DEBUG              1
 #endif


I was able to see, that we get lots of RX overrun interrupts with
cpu_idle, meaning that incoming stuff is not getting processed. By
generating UART interrupts, I we probably can also catch more network R=
X
interrupts and this helps the bootup go faster. =EF=BB=BFWith cpu_idle =
disabled,
there were no RX overruns.

I'll try to see if this can be fixed somehow.

>=20
> >=20
> > eth0: link up
> > Sending DHCP requests ., OK
> > IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.2.10=
1
> > IP-Config: Complete:
> >      device=3Deth0, addr=3D192.168.2.101, mask=3D255.255.255.0,=20
> > gw=3D192.168.2.1,
> >      host=3D192.168.2.101, domain=3Dntc.nokia.com, nis-domain=3D(no=
ne),
> >      bootserver=3D0.0.0.0, rootserver=3D172.22.146.197, rootpath=3D
> > Looking up port of RPC 100003/2 on 172.22.146.197
> > Looking up port of RPC 100005/1 on 172.22.146.197
> > VFS: Mounted root (nfs filesystem).
> > Freeing init memory: 108K
> >=20
> > Rajendra, are you still using .config file you sent to me? Are all =
the
> > changes in your tree available in l-o list.
>=20
> Yes, all the changes are part of the 11 patch set + 1 rework fixes pa=
tch I sent.
> To debug further, can you put a few prints in omap3_enter_idle and om=
ap3_enter_idle_bm
> to see what states are selected by the menu gov.=20
> We will then know if CORE RET/OFF is attempted but not achieved due t=
o some reason, or=20
> never attempted altogether.

My setup does not seem to go beyond C2 state, btw. So I'll need to debu=
g
that also a bit. The above-mentioned patches are applied.

Br, Kalle


=2E..

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
