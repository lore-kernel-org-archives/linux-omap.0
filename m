From: Felipe Balbi <balbi@ti.com>
Subject: Re: [beagleboard] EHCI softirq kernel panic
Date: Thu, 11 Aug 2011 00:35:39 +0300
Message-ID: <20110810213538.GB26868@legolas.emea.dhcp.ti.com>
References: <20110809222012.GB4008@legolas.emea.dhcp.ti.com>
 <Pine.LNX.4.44L0.1108101009180.1917-100000@iolanthe.rowland.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:33072 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755055Ab1HJVfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 17:35:43 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1108101009180.1917-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Jason Kridner <jkridner@beagleboard.org>, beagleboard@googlegroups.com, "Kridner, Jason" <jdk@ti.com>, "Kooi, Koen" <k-kooi@ti.com>, linux-omap@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 10, 2011 at 10:11:48AM -0400, Alan Stern wrote:
> On Wed, 10 Aug 2011, Felipe Balbi wrote:
>=20
> > Hi,
> >=20
> > On Tue, Aug 09, 2011 at 02:30:14PM -0400, Jason Kridner wrote:
> > > On Tue, Aug 9, 2011 at 1:51 PM, Joel A Fernandes <agnel.joel@gmail.co=
m> wrote:
> > > > Anyone seen this before?
> > >=20
> > > A lot of the kernel developers don't frequent the beagleboard list.
> > > If you think it is a general kernel bug, I suspect you want to copy
> > > linux-omap.
> >=20
> > and linux-usb, and Alan Stern as he's the EHCI maintainer and myself for
> > the OMAP USB part ;-)
> >=20
> > > > Trying to boot 3.0.0 with OE patches from an SD Card, and with a
> > > > network cable connected results in the following traceback.
> > > > Not connecting a network cable makes the errors go away.
>=20
> > > > [ ? 99.084899] Unable to handle kernel NULL pointer dereference at
> > > > virtual address 00000000
> > > > [ ? 99.093383] pgd =3D c0004000
> > > > [ ? 99.096191] [00000000] *pgd=3D00000000
> > > > [ ? 99.099945] Internal error: Oops: 17 [#2]
> > > > [ ? 99.104125] Modules linked in: ipv6
> > > > [ ? 99.107788] CPU: 0 ? ?Tainted: G ? ? ?D ? ? ?(3.0.0+ #1)
> > > > [ ? 99.113342] PC is at ehci_quiesce+0xc/0x94
> > > > [ ? 99.117614] LR is at ehci_stop+0x34/0x8c
> > > > [ ? 99.121734] pc : [<c0325ce4>] ? ?lr : [<c0328bfc>] ? ?psr: 20000=
1d3
> > > > [ ? 99.121734] sp : c064de70 ?ip : 00000108 ?fp : c06b8624
> > > > [ ? 99.133728] r10: c064dec0 ?r9 : 00000000 ?r8 : dee08504
> > > > [ ? 99.139190] r7 : c0328b94 ?r6 : 00000100 ?r5 : dee08504 ?r4 : de=
e08608
> > > > [ ? 99.145996] r3 : 00000000 ?r2 : dee086ec ?r1 : dee086b8 ?r0 : de=
e08608
> > > > [ ? 99.152832] Flags: nzCv ?IRQs off ?FIQs off ?Mode SVC_32 ?ISA ARM
> > > > Segment kernel
> > > > [ ? 99.160644] Control: 10c5387d ?Table: 9d804019 ?DAC: 00000015
> > > > [ ? 99.166656] Process swapper (pid: 0, stack limit =3D 0xc064c2f0)
> > > > [ ? 99.172760] Stack: (0xc064de70 to 0xc064e000)
>=20
> > > > [ ? 99.288482] [<c0325ce4>] (ehci_quiesce+0xc/0x94) from [<c0328bfc=
>]
> > > > (ehci_stop+0x34/0x8c)
> > > > [ ? 99.296936] [<c0328bfc>] (ehci_stop+0x34/0x8c) from [<c007a3d4>]
> > > > (run_timer_softirq+0x15c/0x1f8)
> > > > [ ? 99.306121] [<c007a3d4>] (run_timer_softirq+0x15c/0x1f8) from
> > > > [<c064dec0>] (0xc064dec0)
> > > > [ ? 99.314483] Code: c05d7f9a e92d4073 e1a04000 e5903004 (e5933000)
> > > > [ ? 99.320892] ---[ end trace 4ae88755f08e391f ]---
> > > > [ ? 99.325714] Kernel panic - not syncing: Fatal exception in inter=
rupt
>=20
> I'm puzzled.  Why is ehci_stop getting called in a softirq context? =20
> That should never happen.  It should get called only when the driver is=
=20
> unbound from the controller.

Maybe some OpenEmbedded patch which changed the behavior and ended up
breaking the driver ?

--=20
balbi

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQvmqAAoJEAv8Txj19kN1fKoH/jgi9A9jPBtTGniNHeg2v4c9
cx2/o92IzP81tvseP8p9o+4bObzEqxyb8ZJ942FgocsmwtKMJb/O/55Ubxrc8k9T
4OYGcDLz9ZuxzrhUlbblUEJXIrbY+3CZXxhqmRnpT3WvHXRZsJy2aAsOptjRY4Uh
njiabbbfn5dKy5NiD6Z/7Vyx4i1SvezE/tjFtD02wiYAFHsxFsSrP2c6mA2xXDZ+
irGzZ8G4wybWKGFY1ldVdWJzABE7Zv8SchNCFXj8PgGRIukpLj6KqXvTWcpXUA4E
Nr12/htxF/X47dy61/d0bC4U7SaZLcPfNxnx8Sc0cyq07j26HYvGxf3l57rYLPA=
=ZIgR
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
