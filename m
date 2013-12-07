From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sat, 7 Dec 2013 09:18:32 +0100
Message-ID: <201312070918.32471@pali>
References: <20131206213613.GA19648@earth.universe> <20131206222725.GM26766@atomide.com> <20131207000026.GA26921@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1525099.LOsid89dOP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:61056 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab3LGISg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 03:18:36 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so638590bkz.39
        for <linux-omap@vger.kernel.org>; Sat, 07 Dec 2013 00:18:35 -0800 (PST)
In-Reply-To: <20131207000026.GA26921@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>

--nextPart1525099.LOsid89dOP
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 07 December 2013 01:00:27 Sebastian Reichel wrote:
> On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > Nokia N900 DT boot breaks for me using 3.13-rc3. You can
> > > see the relevant kernel output below. Disabling the AES
> > > module in the omap3-n900.dts with status =3D "disabled"
> > > fixed the boot for me.
> >=20
> > OK thanks for letting me know. How about the following patch
> > to fix it?
>=20
> That's basically what I did to fix the problem.
>=20
> I guess the proper fix would be a runtime check if the device
> can be accessed (if that's possible). AFAIK it is possible to
> use the AES module on the N900 if the bootloader is slightly
> patched.
>=20
> Pali, can you elaborate more about this? I've seen, that you
> added a section about this on [0].
>=20
> [0] http://elinux.org/N900#M-Shield
>=20
> -- Sebastian
>=20

Yes, if you want to use M-Shield on Nokia N900, you need to use=20
new version of signed Nokia X-Loader which enable M-Shield usage=20
outside secure world.

Because this updated X-Loader is not official and I think nobody=20
has it in n900, please disable using these M-Shield crypto=20
modules on n900.

Without patched updated X-Loader kernel will crash.

> > Unhandled fault: external abort on non-linefetch (0x1028) at
> > 0xfa0c5048 SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W  =20
> > 3.13.0-rc2+ #446 task: ce057b40 ti: ce058000 task.ti:
> > ce058000
> > PC is at omap_aes_dma_stop+0x24/0x3c
> > LR is at omap_aes_probe+0x1cc/0x584
> >=20
> >    psr: 60000113
> >=20
> > sp : ce059e20  ip : ce0b4ee0  fp : 00000000
> > r10: c0573ae8  r9 : c0749508  r8 : 00000000
> > r7 : ce0b4e00  r6 : 00000000  r5 : ce0b4e10  r4 : ce274890
> > r3 : fa0c5048  r2 : 00000048  r1 : 0000002c  r0 : ce274890
> > Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
> > kernel Control: 10c5387d  Table: 80004019  DAC: 00000015
> > Process swapper/0 (pid: 1, stack limit =3D 0xce058248)
> > Stack: (0xce059e20 to 0xce05a000)
> > 9e20: c0749508 0000a1ff 00000000 c016cd8c c06b5a06 ce2a45f0
> > ce2a4570 ce0b5fb0 9e40: 00000000 480c5000 480c504f c0abe4e4
> > 00000200 00000000 00000000 00000000 9e60: ce0b4e10 ce0b4e10
> > c082da3c c082da3c c02b8c70 c077c610 c0749508 00000000 9e80:
> > 00000000 c02b9e7c c02b9e64 ce0b4e10 00000000 c02b8b20
> > ce0b4e10 ce0b4e44 9ea0: c082da3c c02b8cd8 00000000 ce059eb8
> > c082da3c c02b7408 ce079edc ce0b1a34 9ec0: c082da3c c082da3c
> > ce2a0280 00000000 c08158d8 c02b8358 c0663405 c0663405 9ee0:
> > 00000073 c082da3c c079e4e8 c07ab3bc c0844340 c02b9334
> > 00000000 00000006 9f00: c079e4e8 c0008920 c067f6bf c0ac7c6b
> > 00000000 c0712e28 00000000 00000000 9f20: c0712e38 ce059f38
> > 00000093 c0ac7c82 00000000 c0058994 00000000 c07130e8 9f40:
> > c07127b8 00000093 00000006 00000006 00000001 00000006
> > 00000006 c079e4e8 9f60: c07ab3bc c0844340 00000093 c0749508
> > c079e4f4 c0749c64 00000006 00000006 9f80: c0749508 00000000
> > 00000000 c0517e2c 00000000 00000000 00000000 00000000 9fa0:
> > 00000000 c0517e34 00000000 c000dfb8 00000000 00000000
> > 00000000 00000000 9fc0: 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000 00000000 9fe0: 00000000 00000000
> > 00000000 00000000 00000013 00000000 ffffffff ffffffff
> > (omap_aes_probe+0x1cc/0x584)
> > (platform_drv_probe+0x18/0x48)
> > (driver_probe_device+0xb0/0x200)
> > (__driver_attach+0x68/0x8c)
> > (bus_for_each_dev+0x50/0x88)
> > (bus_add_driver+0xcc/0x1c8)
> > (driver_register+0x9c/0xe0)
> > (do_one_initcall+0x98/0x140)
> > (kernel_init_freeable+0x16c/0x23c)
> > (kernel_init+0x8/0x100)
> > (ret_from_fork+0x14/0x3c)
> > Code: e1811002 e5932020 e590300c e0833002 (e593c000)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1525099.LOsid89dOP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlKi2dgACgkQi/DJPQPkQ1KqpQCfTu63/bIbWzJoCaNdox5Gwcwe
2AAAnjxWnolH9PYGIdsq1VBdHN6xqCXO
=O60B
-----END PGP SIGNATURE-----

--nextPart1525099.LOsid89dOP--
