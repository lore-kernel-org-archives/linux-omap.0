From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [OMAP 1710] Mainline Broken
Date: Fri, 17 Dec 2010 13:52:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373A9363D@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB037395C74E@dbde02.ent.ti.com>
	<AANLkTi=Shtqm36=_zSa37Fgan9NJYX3oKvoZzN35mi98@mail.gmail.com>
 <87r5dhfxwh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60531 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab0LQIWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 03:22:55 -0500
In-Reply-To: <87r5dhfxwh.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Belisko Marek <marek.belisko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, December 16, 2010 10:39 PM
> To: Belisko Marek
> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org
> Subject: Re: [OMAP 1710] Mainline Broken
>=20
> Belisko Marek <marek.belisko@gmail.com> writes:
>=20
> > Hi,
> >
> > On Thu, Dec 16, 2010 at 4:30 PM, DebBarma, Tarun Kanti
> > <tarun.kanti@ti.com> wrote:
> >> Did anyone observe this? I am using omap_generic_1710_defconfig
> >>
> >> [...]
> >> input: omap-keypad as /devices/platform/omap-keypad/input/input0
> >> TCP cubic registered
> >> NET: Registered protocol family 17
> >> Registering the dns_resolver key type
> >> eth0: link up
> >> IP-Config: Complete:
> >> =A0 =A0 device=3Deth0, addr=3D172.24.191.106, mask=3D255.255.252.0=
,
> gw=3D172.24.188.1,
> >> =A0 =A0 host=3Dmyomap, domain=3D, nis-domain=3D(none),
> >> =A0 =A0 bootserver=3D172.24.191.66, rootserver=3D172.24.191.66, ro=
otpath=3D
> >> VFS: Mounted root (nfs filesystem) on device 0:10.
> >> Freeing init memory: 128K
> >> Kernel panic - not syncing: Attempted to kill init!
> >
> > Seems your userspace is broken. Try add user_debug=3D31 to command =
line
> > to see what exactly happens.
>=20
> Looks like you're mounting an NFS rootfs.  Was it compiled for armv5?
> My hunch would be you're trying to run an armv6/armv7 userspace on th=
e
> 1710 which is armv5.
>=20
> To get more debugging, ensure these are enabled in your defconfig:
>=20
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_USER=3Dy
> CONFIG_DEBUG_ERRORS=3Dy
>=20
> and in addition to cmdline suggested by Marek, add user_debug=3D0xf
>=20
> This will give verbose output for userspace exceptions as well and
> possibly confirm my hunch.
>=20
> Kevin

I checked .config and it shows: CONFIG_CPU_32v5=3Dy

With regard to additional log here they are!!

[...]
[1] init: obsolete system call 00000000.
Code: e08f1001 e1a0c000 e3a0702d ef000000 (e3700a01)
Kernel panic - not syncing: Attempted to kill init!
Backtrace:
[...]

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
