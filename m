From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Sun, 26 Oct 2014 22:22:39 +0100
Message-ID: <201410262222.39892@pali>
References: <20141019090107.GA19132@amd> <201410261212.46582@pali> <20141026211721.GA7351@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1981530.ZjnzfcZRCA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141026211721.GA7351@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1981530.ZjnzfcZRCA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 26 October 2014 22:17:21 Pavel Machek wrote:
> On Sun 2014-10-26 12:12:46, Pali Roh=C3=A1r wrote:
> > On Sunday 26 October 2014 12:08:25 Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > On Sun, Oct 19, 2014 at 09:19:37PM +0200, Pavel Machek=20
wrote:
> > > > > I am trying to use nfsroot, so I can't use modules.
> > > >=20
> > > > Why not?
> > > >=20
> > > > > (I am attaching full config, in case I missed
> > > > > something important).
> > > >=20
> > > > I'm using the below config with 3.17 and g_ether works
> > > > OK.
> > > >=20
> > > > (My initramfs modprobes g_ether, runs busybox ifconfig
> > > > for usb0 and launches sshd.)
> > >=20
> > > I am trying to get 3.14 kernel to work, first. There, usb
> > > gadget works when compiled into kernel. But with modules,
> > > I get
> > >=20
> > > # root@(none):/tmp# insmod libcomposite.ko
> > > # root@(none):/tmp# insmod u_ether.ko
> > > # root@(none):/tmp# insmod usb_f_rndis.ko
> > > # root@(none):/tmp# insmod g_ether.ko
> > >=20
> > > [  169.061218] udc musb-hdrc.0.auto: registering UDC
> > > driver [g_ether] [  169.078918] g_ether musb-hdrc.0.auto:
> > > failed to start g_ether: -2
> > >=20
> > > -2 is ENOENT...
> >=20
> > Can you try g_nokia.ko? I used this module for usb
> > networking.
>=20
> I have root prepared on /dev/mmcblk0p6. I tried 3.17 with
> rx51_defconfig, but no, it refuses to mount it.
>=20
> VFS: Cannot open root device "mmcblk0p6" or ....: error -19.
>=20
> And then it proceeds to list mmcblk0p6 as one of available
> options
>=20
> :-(.
>=20
> Ideas welcome.
> 									Pavel

Try to add rootdelay=3D30 or rootwait to kernel cmdline.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1981530.ZjnzfcZRCA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRNZh8ACgkQi/DJPQPkQ1KNDQCfTuOmuZsGbRLu40u1jCvDKXs/
IlgAn0Rl80fnZKjcBCMaIwTj7RBqAFhf
=1d8T
-----END PGP SIGNATURE-----

--nextPart1981530.ZjnzfcZRCA--
