From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Date: Sat, 10 Mar 2018 00:01:24 +0100
Message-ID: <20180309230124.GA17721@amd>
References: <20180309221220.GA15272@amd>
 <20180309222821.GA16973@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309222821.GA16973@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, akinobu.mita@gmail.com, javier@osg.samsung.com, gregor.boirie@parrot.com
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, security@kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hmm. Looks like there's a lot of fun to be had with sysfs.
> >=20
> >=20
> > pavel@n900:~$ uname -a
> > Linux n900 4.16.0-rc4-59690-g7f84626-dirty #543 Thu Mar 8 19:53:30 CET
> > 2018 armv7l GNU/Linux
> >=20
> > [  306.402496] bq2415x: command Timer reset
> > [  312.761322] adp1653 2-0030: Read Addr:03 Val:00 ok
> > [  313.264129] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000
> > 000
> > [  313.272308] pgd =3D 01336620
> > [  313.275146] [00000000] *pgd=3D800af831, *pte=3D00000000, *ppte=3D000=
00000
> > [  313.281463] Internal error: Oops: 80000007 [#1] ARM
> > [  313.286376] Modules linked in:
> > [  313.289459] CPU: 0 PID: 3584 Comm: grep Tainted: G        W
> > 4.16.0-rc4-59690-g
> > 7f84626-dirty #543
> > [  313.298919] Hardware name: Nokia RX-51 board
> > [  313.303222] PC is at   (null)
> > [  313.306213] LR is at iio_ev_state_show+0x38/0x54
> > [  313.310852] pc : [<00000000>]    lr : [<c05d69c0>]    psr: a0000013
> > [  313.317169] sp : c7b47e70  ip : c087bb24  fp : 00000001
> > [  313.322418] r10: cb19e000  r9 : c0857220  r8 : 00001000
> > [  313.327667] r7 : 00000fff  r6 : cb711c80  r5 : cb19e000  r4 :
> > 00000000
> > [  313.334228] r3 : 00000001  r2 : 00000000  r1 : c087b4dc  r0 :
> > ce584800
> > [  313.340789] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> > Segment none
> > [  313.347991] Control: 10c5387d  Table: 87bec019  DAC: 00000051
> > [  313.353759] Process grep (pid: 3584, stack limit =3D 0xc4e45eab)
> > [  313.359619] Stack: (0xc7b47e70 to 0xc7b48000)
> > [  313.364013] 7e60:                                     c05d6988
> > cb711b00 ce585c00 c0450d68
> > [  313.471038] [<c05d69c0>] (iio_ev_state_show) from [<c0450d68>]
> > (dev_attr_show+0x1c/0x4c)
> > [  313.479187] [<c0450d68>] (dev_attr_show) from [<c023f934>]
> > (sysfs_kf_seq_show+0x90/0x108)
> > [  313.487426] [<c023f934>] (sysfs_kf_seq_show) from [<c023e2f8>]
> > (kernfs_seq_show+0x24/0x28)
> > [  313.495758] [<c023e2f8>] (kernfs_seq_show) from [<c01fc954>]
> > (seq_read+0x1dc/0x500)
> > [  313.503479] [<c01fc954>] (seq_read) from [<c01d9f80>]
> > (__vfs_read+0x2c/0x120)
> > [  313.510681] [<c01d9f80>] (__vfs_read) from [<c01da0fc>]
> > (vfs_read+0x88/0x114)
> > [  313.517852] [<c01da0fc>] (vfs_read) from [<c01da584>]
> > (SyS_read+0x40/0x8c)
> > [  313.524780] [<c01da584>] (SyS_read) from [<c0101000>]
> > (ret_fast_syscall+0x0/0x54)
> > [  313.532318] Exception stack(0xc7b47fa8 to 0xc7b47ff0)
> > [  313.537414] 7fa0:                   00035330 00042000 00000003
> > 00042000 00008000 00008000
> >=20
>=20
> What file are you opening to cause this?

Strace says:

openat(7, "in_intensity_both_thresh_rising_en",
> > O_RDONLY|O_LARGEFILE|O_NOFOLLOW) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D4096, ...}) =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) =3D -1 ENOTTY
> > (Inappropriate ioctl for device)
read(3,
Message from syslogd@localhost at Mar  9 23:54:39 ...
 kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM

So that would be:

=2E/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/eve=
nts/in_intensity_both_thresh_rising_en

And indeed, manually cat-ing that file reproduces the problem.

pavel@n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio=
:device1$
cat name
tsl2563

I can not find tsl2563 in MAINTAINERS, file is
=2E/drivers/iio/light/tsl2563.c . I added few people pointed by git log.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqjEkQACgkQMOfwapXb+vKITwCeP1tgBYdQTIHgZKqz9l4ABVAL
WggAoKIGoQ0V3fel/58awEbWBVELQtIa
=dprE
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
