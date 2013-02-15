From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 08:44:29 +0200
Message-ID: <20130215064429.GA30038@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47398 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161111Ab3BOGok (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 01:44:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 14, 2013 at 08:47:53PM +0000, Paul Walmsley wrote:
> Hi,
>=20
> On Thu, 14 Feb 2013, Tony Lindgren wrote:
>=20
> > I don't think so as hwmod should only touch the sysconfig space
> > when no driver has claimed it.
>=20
> hwmod does need to touch the SYSCONFIG register during pm_runtime suspend=
=20
> and resume operations, and during device enable and disable operations. =
=20
> Here's the relevant code:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob;f=
=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a30a6c204d6=
d2282;hb=3DHEAD#l2157
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob;f=
=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a30a6c204d6=
d2282;hb=3DHEAD#l2195
>=20
> Drivers shouldn't touch their IP block's SYSCONFIG registers.  They don't=
=20

why not ? It's part of the driver's address space anyway. It's not part
of the IP in question (usb, ethernet, etc) but it's part of the TI
wrapper which usually involves a bridge (ocp2scp, ocp2axi, etc) plus the
TI-specific integration registers (revision, sysc, syss...).

So they're not part of the licensed IP, but they're part of the TI
wrapper around those.

> have anything specifically to do with the underlying device IP block, but=
=20

of course they do, soft reset touches the underlying IP, so does force
idle, no idle, etc. But I agree that part is more changing the the
asynchronous idle request handshake.

> with the SoC integration, even though they live in the device's=20
> memory-mapped address range.  It's unfortunate that TI didn't allocate a=
=20
> separate, small address space for these registers, translated by the bus,=
=20
> similar to the PCI-E Enhanced Configuration Access Mechanism:
>=20
> http://wiki.osdev.org/PCI_Express#Extended_Configuration_Space
>=20
> ... but that's unfortunately the reality of the OMAP hardware.

right.

> Regarding ioremap(), it seems reasonable for drivers to call ioremap(), a=
s=20
> long as the implementation of ioremap() can be overridden by the device's=
=20
> bus.  PCI device drivers already do this -- albeit in a PCI-specific way=
=20
> -- with pci_ioremap_bar():
>=20
> http://git.kernel.org/?p=3Dlinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&a=
=3Dsearch&h=3DHEAD&st=3Dgrep&s=3Dpci_ioremap_bar
>=20
> So instead of something bus-specific like that, a better way would be to=
=20
> use something like:
>=20
> va =3D dev->bus->ioremap( ... );
> va =3D dev->bus->iounmap( ... );
>=20
> Any driver using such a mechanism would be intrinsically generic.=20
> platform_bus could simply set its bus->ioremap to the existing ioremap()=
=20
> function, while buses like a omap_hwmod_bus could use a function that=20
> returned the address range that omap_hwmod_bus has already ioremap()ped.

although I'm not sure I like the idea exposed here, ioremap() is the
least of our problems :-) The biggest problem is having functioning PM
for all drivers on a DT boot with CPUIDLE enabled.

--=20
balbi

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHdlNAAoJEIaOsuA1yqREmf8P/jI+gu6xbrFAnnMyflIKCJm6
16dycJvwUNVaJTgPC2LtJSVXcYoeDdqBDdyHkr7Axu5SPvTAbwYdao1mCDF8a8cy
XDaoCP+SEQrRi5UMte2817PHFQ9oV+wJLnJIPzzKOZrdtTCh5kvp1wKJlkRIPntu
I5IgTz28DLtGJ45HG28vxzIy51dABuY8IRY7tbywnLwSwIz2I4XfIJhpmRVPp58u
Vvuo0kF6S4/CxL3/QITw6RtHMTxjvvQAW86QwyEC8DNgVEimDDblkSyW/u5oeM6v
m6WOUZrorUsYYnprnspQ5rrxJ+BUZ1BRX/Ts5j+iwadGlon60uYTuQfkxs8vEha1
9okuKgnQZGweSY+iUUOtK+CcweNB2oQ04UKrzNQ6q7rIHrJqjPaskYkxISrCl2JT
hJOA2wuPyop5a9vPuCbEcdXTP6tsWpjD6dGsF2aKHRP7XOnENrjsSbIkfjQFdqXU
fHyaiF9q1RvsUal3pke0WzWdxkpVdyn846KPqSKWNqsTx01EW3y0UL20Xgmt5fn3
3GeKD/8ZChe9VRTaKRj7qpEtsvXLlrsqCFCSlI3MbNRsdpLD0OnLtDvvXp2C3OGt
++xoDJufQTNvHf13YRF8gjcU3rBjOwRLfwiV8cd9bagFxq8JpS+XW+KYIXvmW6zA
ag4voHTjkkKHOHQuvLjg
=zeee
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
