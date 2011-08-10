From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [beagleboard] EHCI softirq kernel panic
Date: Wed, 10 Aug 2011 10:11:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108101009180.1917-100000@iolanthe.rowland.org>
References: <20110809222012.GB4008@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110809222012.GB4008-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "Kridner, Jason" <jdk-l0cyMroinI0@public.gmane.org>, "Kooi, Koen" <k-kooi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 10 Aug 2011, Felipe Balbi wrote:

> Hi,
>=20
> On Tue, Aug 09, 2011 at 02:30:14PM -0400, Jason Kridner wrote:
> > On Tue, Aug 9, 2011 at 1:51 PM, Joel A Fernandes <agnel.joel@gmail.=
com> wrote:
> > > Anyone seen this before?
> >=20
> > A lot of the kernel developers don't frequent the beagleboard list.
> > If you think it is a general kernel bug, I suspect you want to copy
> > linux-omap.
>=20
> and linux-usb, and Alan Stern as he's the EHCI maintainer and myself =
for
> the OMAP USB part ;-)
>=20
> > > Trying to boot 3.0.0 with OE patches from an SD Card, and with a
> > > network cable connected results in the following traceback.
> > > Not connecting a network cable makes the errors go away.

> > > [ =A0 99.084899] Unable to handle kernel NULL pointer dereference=
 at
> > > virtual address 00000000
> > > [ =A0 99.093383] pgd =3D c0004000
> > > [ =A0 99.096191] [00000000] *pgd=3D00000000
> > > [ =A0 99.099945] Internal error: Oops: 17 [#2]
> > > [ =A0 99.104125] Modules linked in: ipv6
> > > [ =A0 99.107788] CPU: 0 =A0 =A0Tainted: G =A0 =A0 =A0D =A0 =A0 =A0=
(3.0.0+ #1)
> > > [ =A0 99.113342] PC is at ehci_quiesce+0xc/0x94
> > > [ =A0 99.117614] LR is at ehci_stop+0x34/0x8c
> > > [ =A0 99.121734] pc : [<c0325ce4>] =A0 =A0lr : [<c0328bfc>] =A0 =A0=
psr: 200001d3
> > > [ =A0 99.121734] sp : c064de70 =A0ip : 00000108 =A0fp : c06b8624
> > > [ =A0 99.133728] r10: c064dec0 =A0r9 : 00000000 =A0r8 : dee08504
> > > [ =A0 99.139190] r7 : c0328b94 =A0r6 : 00000100 =A0r5 : dee08504 =
=A0r4 : dee08608
> > > [ =A0 99.145996] r3 : 00000000 =A0r2 : dee086ec =A0r1 : dee086b8 =
=A0r0 : dee08608
> > > [ =A0 99.152832] Flags: nzCv =A0IRQs off =A0FIQs off =A0Mode SVC_=
32 =A0ISA ARM
> > > Segment kernel
> > > [ =A0 99.160644] Control: 10c5387d =A0Table: 9d804019 =A0DAC: 000=
00015
> > > [ =A0 99.166656] Process swapper (pid: 0, stack limit =3D 0xc064c=
2f0)
> > > [ =A0 99.172760] Stack: (0xc064de70 to 0xc064e000)

> > > [ =A0 99.288482] [<c0325ce4>] (ehci_quiesce+0xc/0x94) from [<c032=
8bfc>]
> > > (ehci_stop+0x34/0x8c)
> > > [ =A0 99.296936] [<c0328bfc>] (ehci_stop+0x34/0x8c) from [<c007a3=
d4>]
> > > (run_timer_softirq+0x15c/0x1f8)
> > > [ =A0 99.306121] [<c007a3d4>] (run_timer_softirq+0x15c/0x1f8) fro=
m
> > > [<c064dec0>] (0xc064dec0)
> > > [ =A0 99.314483] Code: c05d7f9a e92d4073 e1a04000 e5903004 (e5933=
000)
> > > [ =A0 99.320892] ---[ end trace 4ae88755f08e391f ]---
> > > [ =A0 99.325714] Kernel panic - not syncing: Fatal exception in i=
nterrupt

I'm puzzled.  Why is ehci_stop getting called in a softirq context? =20
That should never happen.  It should get called only when the driver is=
=20
unbound from the controller.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
