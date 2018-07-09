From: Pavel Machek <pavel@ucw.cz>
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Date: Mon, 9 Jul 2018 12:49:43 +0200
Message-ID: <20180709104943.GA5212@amd>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
 <20180709102852.GA20580@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709102852.GA20580@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>, andriy.shevchenko@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > grep in /sys produces a nasty oops:
> > >=20
> > > I guess next step is trying to find out which file that is..
> >=20
> > Let me see...
> >=20
> > openat(6, "suspend",
> > O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) =3D 4
> > fstat64(4, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
> > read(4, 0x4d2000, 32768)                =3D -1 EINVAL (Invalid argument)
> > write(2, "grep: ", 6grep: )                   =3D 6
> > write(2, "/sys/kernel/debug/pm_debug/cefus"...,
> > 47/sys/kernel/debug/pm_debug/cefuse_pwrdm/suspend) =3D 47
> > write(2, ": Invalid argument", 18: Invalid argument)      =3D 18
> > write(2, "\n", 1
> > )                       =3D 1
> > close(4)                                =3D 0
> > close(6)                                =3D 0
> > openat(5, "time", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW)
> > =3D 4
> > fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
> > read(4, "cefuse_pwrdm (OFF),OFF:641441757"..., 32768) =3D 849
> > read(4, "", 28672)                      =3D 0
> > close(4)                                =3D 0
> > openat(5, "count",
> > O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) =3D 4
> > Connection to usb closed by remote host.
> > Connection to usb closed.
> > pavel@half:~$
> >=20
> > Ok, so it seems to be:
> >=20
> > user@devuan:~$ cat /sys/kernel/debug/pm_debug/count
> > (oops).
> >=20
> > The file seems to be world-readable.
> >=20
> > user@devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> > -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
> >=20
> > But on PC, that file does not exist.
>=20
> Ok, it is easier to reproduce like this:
>=20
> sudo mount /dev/zero -t debugfs /sys/kernel/debug/
> sudo cat /sys/kernel/debug/pm_debug/count
>=20
> I tried adding debugging like this:

Confused.


>  	seq_printf(s, "%s->%s (%d)\n", clkdm->name, clkdm->pwrdm.ptr->name,
>  		   clkdm->usecount);

I replaced seq_prinf with printk, and it still crashes, after
producing reasonable output.

[   74.852508] cmp...
[   74.855773] printf...
[   74.859313] l4_cfg_clkdm->core_pwrdm (0)
[   74.864532] done...
[   74.867889] cmp...
[   74.871154] printf...
[   74.874694] l4_cefuse_clkdm->cefuse_pwrdm (0)
[   74.880340] done...
[   74.883728] ------------[ cut here ]------------
[   74.889709] WARNING: CPU: 0 PID: 2127 at
drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x23c/0x380
[   74.900695] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2
(Read): Data Access in User mode during Functional access
[   74.915222] Modules linked in:
[   74.919982] CPU: 0 PID: 2127 Comm: cat Not tainted
4.18.0-rc4-88970-gf075a2c-dirty #763
[   74.929870] Hardware name: Generic OMAP4 (Flattened Device Tree)
[   74.937805] [<c010f6cc>] (unwind_backtrace) from [<c010ba50>]
(show_stack+0x10/0x14)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltDPccACgkQMOfwapXb+vKmrwCguXjgku8wwvq+DVk9leEHhywg
6cEAoLKtXHwePIxHIImCTPOc0leey4N6
=SErq
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
