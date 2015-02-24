From: Felipe Balbi <balbi@ti.com>
Subject: Re: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
Date: Mon, 23 Feb 2015 21:15:47 -0600
Message-ID: <20150224031547.GB15941@saruman.tx.rr.com>
References: <20150223235947.GC25954@atomide.com>
 <20150224015903.GP32521@atomide.com>
 <20150224022433.GB5198@saruman.tx.rr.com>
 <20150224023505.GQ32521@atomide.com>
 <20150224030141.GR32521@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbbBXDQk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 22:16:40 -0500
Content-Disposition: inline
In-Reply-To: <20150224030141.GR32521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 23, 2015 at 07:01:42PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150223 18:43]:
> > * Felipe Balbi <balbi@ti.com> [150223 18:28]:
> > > Hi,
> > >=20
> > > On Mon, Feb 23, 2015 at 05:59:04PM -0800, Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [150223 16:09]:
> > > > > Hi Nishanth,
> > > > >=20
> > > > > Olof told me about a new L3 error happening on omap5-uevm with
> > > > > v4.0-rc1:
> > > > >=20
> > > > > WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_interr=
upt_handler+0x214/0x340()
> > > > > 4000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle): Dat=
a Access in Supervisor mode during Functional access
> > > > > ...
> > > > >=20
> > > > > I tried bisecting this with no luck, but narrowed it down to
> > > > > having CONFIG_CPUFREQ_DT=3Dy causing it, while =3Dm wont' trigger
> > > > > it. This got changed by commit 40d1746d2eee ("ARM:
> > > > > omap2plus_defconfig: use CONFIG_CPUFREQ_DT").
> > > > >=20
> > > > > Any ideas?
> > > >=20
> > > > Hmm so setting CONFIG_CPUFREQ_DT=3Dm in arch/arm/configs/omap2plus_=
defconfig
> > > > produces the same output with make omap2plus_defconfig as with =3Dy=
=2E. So
> > > > CPUFREQ_DT can't be the real cause of the problem.
> > > >=20
> > > > It's now looking like the l3-noc warning does not get triggered on
> > > > every boot.
> > > >=20
> > > > It also seems the zImage triggering the error does not trigger the
> > > > error on every boot. To trigger the error, it seems the device need=
s to
> > > > be powered down for at least 10 or so seconds between the boots.
> > > > So far no luck reproducing the error on v3.19.
> > > >=20
> > > > The easy way to reproduce is to power down omap5 for at least 10 se=
conds,
> > > > make omap2lus_defconfig on v4.0-rc1 and boot it.
> > > >=20
> > > > And so far it looks like next-20150204 works and next-20150209
> > > > failed at once so far. But of course I would not trust anything
> > > > at this point :)
> > >=20
> > > got a log of the failure ? Is it pointing to a device or one of the L=
4s?
> >=20
> > Well mostly the MASTER MPU TARGET L4PER2, the following stack dump is
> > really the stack dump of the l3_interrupt_handler.
> > =20
> > > Might be worth to boot with just the bare minimum (UART & timers) and
> > > disable everything else. You might need to build busybox and append t=
hat
> > > to the kernel so you don't need to rely on MMC/USB/etc for rootfs.
> > >=20
> > > After that, you could start enabling modules one by one (as modules, =
not
> > > built-in) and loading them one by one to see which one causes the
> > > failure. Big PITA, I know, but I can't think of any other way to go
> > > about this.
> >=20
> > It seems the best way to deal with this is to make the l3_handle_target
> > actually show the address where the error happened to limit it down
> > to a single device..
>=20
> Looks like the address is 0 for "Custom Error". Anyways, reverting

yeah, that's because the error comes from l4per2, not l3 :-)

> a fix for similar issue found on omap3 so far seems to help, that's
> 3d009c8c61f9 ("gpio: omap: Fix bad device access with setup_irq()").

if we revert that, we regress omap3, right ?

--=20
balbi

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU6+zjAAoJEIaOsuA1yqREGhMQAK6YsBgPfuKYAUbTf5zyXBhG
BVK8MNksMlLt/cs19nHMBwG3oNtrIzWfMZEj2MyxRhiT6TSM2QThCPeoZof3rslg
nKYyhZ4A15SawYGcJvi5ZFxN7AgDueDECN6EUfu5q4aY04tOHepZzgEbKloY2Asb
hyeuYktDiQMQHgy++PUW6Z9kAEbngnqy9/LxaCC3X/h9nXO2DND58HOXfumKx7Oq
xXIfXLZy2tO0RYj/nD49N/71oG5sL1iae3jKjokCkj0Fn5qNvJ5eq+UXc/Ktruot
FnNHdH4qJCm7i1NVcDFyNIlUa76cgnMt9TgCOEKQpGGAFbGmRyCxhEIksYTMVqCK
sdVxGE+0lSz10PiUt5BNICjDaEAxCXM479n53F9EdSWXWiNDyVxp6xBlNwhgNq9g
MKOwJGCYvvqvDSPfi9Gz3eSxFtRzcA31wQqOZSI/qEc94LjzAlr0dRM7HpcgYRWt
pNPheQ2NqLoxg9eIRYoRY6Ghhh6Qwta7STJJG4nXMCIW/GVhdQftqXc7k4qWbbfZ
DUuxL3EqYrWiLgqaacbuuyF4bxyPDLzbW6PI/VxLgTEUStQ+YwfkJUI75o1uXzA3
i0pvdNtdNl2mRTHo1kW9lRWVqsrCBwfYbYae+aN15Ftzqz1pLQHO/HLczdvaNXIv
qsrpUklEPsLOkmPscFVN
=Dls7
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
