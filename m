From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [beagleboard] EHCI softirq kernel panic
Date: Thu, 11 Aug 2011 00:12:12 -0500
Message-ID: <CAD=GYpYBL20ybqt3KuJTmPtDA0MDB4VCuqDnopCESw2zm1Fn+Q@mail.gmail.com>
References: <20110809222012.GB4008@legolas.emea.dhcp.ti.com>
	<Pine.LNX.4.44L0.1108101009180.1917-100000@iolanthe.rowland.org>
	<20110810213538.GB26868@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48191 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab1HKFMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 01:12:14 -0400
In-Reply-To: <20110810213538.GB26868@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Jason Kridner <jkridner@beagleboard.org>, "Kridner, Jason" <jdk@ti.com>, "Kooi, Koen" <k-kooi@ti.com>, linux-omap@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>

On Wed, Aug 10, 2011 at 4:35 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Aug 10, 2011 at 10:11:48AM -0400, Alan Stern wrote:
>> On Wed, 10 Aug 2011, Felipe Balbi wrote:
>>
>> > Hi,
>> >
>> > On Tue, Aug 09, 2011 at 02:30:14PM -0400, Jason Kridner wrote:
>> > > On Tue, Aug 9, 2011 at 1:51 PM, Joel A Fernandes <agnel.joel@gma=
il.com> wrote:
>> > > > Anyone seen this before?
>> > >
>> > > A lot of the kernel developers don't frequent the beagleboard li=
st.
>> > > If you think it is a general kernel bug, I suspect you want to c=
opy
>> > > linux-omap.
>> >
>> > and linux-usb, and Alan Stern as he's the EHCI maintainer and myse=
lf for
>> > the OMAP USB part ;-)
>> >
>> > > > Trying to boot 3.0.0 with OE patches from an SD Card, and with=
 a
>> > > > network cable connected results in the following traceback.
>> > > > Not connecting a network cable makes the errors go away.
>>
>> > > > [ ? 99.084899] Unable to handle kernel NULL pointer dereferenc=
e at
>> > > > virtual address 00000000
>> > > > [ ? 99.093383] pgd =3D c0004000
>> > > > [ ? 99.096191] [00000000] *pgd=3D00000000
>> > > > [ ? 99.099945] Internal error: Oops: 17 [#2]
>> > > > [ ? 99.104125] Modules linked in: ipv6
>> > > > [ ? 99.107788] CPU: 0 ? ?Tainted: G ? ? ?D ? ? ?(3.0.0+ #1)
>> > > > [ ? 99.113342] PC is at ehci_quiesce+0xc/0x94
>> > > > [ ? 99.117614] LR is at ehci_stop+0x34/0x8c
>> > > > [ ? 99.121734] pc : [<c0325ce4>] ? ?lr : [<c0328bfc>] ? ?psr: =
200001d3
>> > > > [ ? 99.121734] sp : c064de70 ?ip : 00000108 ?fp : c06b8624
>> > > > [ ? 99.133728] r10: c064dec0 ?r9 : 00000000 ?r8 : dee08504
>> > > > [ ? 99.139190] r7 : c0328b94 ?r6 : 00000100 ?r5 : dee08504 ?r4=
 : dee08608
>> > > > [ ? 99.145996] r3 : 00000000 ?r2 : dee086ec ?r1 : dee086b8 ?r0=
 : dee08608
>> > > > [ ? 99.152832] Flags: nzCv ?IRQs off ?FIQs off ?Mode SVC_32 ?I=
SA ARM
>> > > > Segment kernel
>> > > > [ ? 99.160644] Control: 10c5387d ?Table: 9d804019 ?DAC: 000000=
15
>> > > > [ ? 99.166656] Process swapper (pid: 0, stack limit =3D 0xc064=
c2f0)
>> > > > [ ? 99.172760] Stack: (0xc064de70 to 0xc064e000)
>>
>> > > > [ ? 99.288482] [<c0325ce4>] (ehci_quiesce+0xc/0x94) from [<c03=
28bfc>]
>> > > > (ehci_stop+0x34/0x8c)
>> > > > [ ? 99.296936] [<c0328bfc>] (ehci_stop+0x34/0x8c) from [<c007a=
3d4>]
>> > > > (run_timer_softirq+0x15c/0x1f8)
>> > > > [ ? 99.306121] [<c007a3d4>] (run_timer_softirq+0x15c/0x1f8) fr=
om
>> > > > [<c064dec0>] (0xc064dec0)
>> > > > [ ? 99.314483] Code: c05d7f9a e92d4073 e1a04000 e5903004 (e593=
3000)
>> > > > [ ? 99.320892] ---[ end trace 4ae88755f08e391f ]---
>> > > > [ ? 99.325714] Kernel panic - not syncing: Fatal exception in =
interrupt
>>
>> I'm puzzled. =A0Why is ehci_stop getting called in a softirq context=
?
>> That should never happen. =A0It should get called only when the driv=
er is
>> unbound from the controller.
>
> Maybe some OpenEmbedded patch which changed the behavior and ended up
> breaking the driver ?
>

Hi Felipe,

Thanks for looking into this.

It could be the 1GHz OPP patch in OE, after reverting it [1] I haven't
seen this issue since.

Thanks,
Joel

[1] https://github.com/joelagnel/meta-texasinstruments/commit/95fc251b1=
aeafc1ef774659a8e8654e11b620778
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
