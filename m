From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: Regression in next with filesystem context concept
Date: Fri, 7 Sep 2018 19:35:57 +0200
Message-ID: <20180907193522.1a98d410@aktux>
References: <20180906164358.GI5659@atomide.com>
        <9053.1536310046@warthog.procyon.org.uk>
        <20180907161023.GF5662@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JwFDSM5zShD/p=h26a5lGM7"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907161023.GF5662@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

--Sig_/JwFDSM5zShD/p=h26a5lGM7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 7 Sep 2018 09:10:23 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * David Howells <dhowells@redhat.com> [180907 08:51]:
> > Tony Lindgren <tony@atomide.com> wrote:
> >  =20
> > > Looks like next-20180906 now has a regression where mounting
> > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > filesystem superblock creation/configuration context"). =20
> >=20
> > Am I right in thinking you're not using any of the LSMs? =20
>=20
> Assuming LSM as in Documentation/lsm.txt, right not using any.
>=20
> BTW, I don't think this issue shows up with ramdisk either,
> so that's probably why for example kernelci.org does not
> show errors.
>=20

I have also similar experience with my automated tests (automated
alarming does not work yet ;-)), I am still in the beginning.
I do there a ramdisk boot to create an overlay mount with the fresh
modules on top of an ordinary rootfs. initramfs mount is
ok, but the microsd card fails.

Testing from a ramdisk I get:
/ # ls -l /dev/mmcblk0p2=20
brw-------    1 0        0         179,   2 Jan  1  1970 /dev/mmcblk0p2
/ # mount /dev/mmcblk0p2 /mnt/
[  682.819061] Filesystem requires source device
[  682.825103] Filesystem requires source device
[  682.830810] Filesystem requires source device
[  682.836303] Filesystem requires source device
[  682.843078] Filesystem requires source device
[  682.847991] Filesystem requires source device
[  682.853149] Filesystem requires source device
mount: mounting /dev/mmcblk0p2 on /mnt/ failed: No such file or directory

64GB microsd at omap_hsmmc correcly recognized.=20
Last known successful boot: next-20180830

so you are not alone with such problems.
will investigate further

Regards,
Andreas

--Sig_/JwFDSM5zShD/p=h26a5lGM7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluStv0ACgkQfb1qx03i
kySW4xAAhKea/3ncoKAloypGwknJoJjnLjX2eeUxdMhY6iQ9RQwJpRvv9Dp5soIt
v+g2uSt4jHnGZ7coADGAk2VDJDqZ09/kmxOUJRTo8Ndqn2X2fAz/SMJ9mJYv6gp/
5FvBh7RBeDifNZh2FBfN+08w869NcGCZ7hQeTnv1LregpAfVdGzn5rZuGbwflMLK
ErFiyxatzzRlDvG1PBxuqmbu4xYf15OWDdCiEPMgfdjDUgv5wNEMO0t7RHYfW3Po
HlMlmDY4soCAIYdhJEPc1WQANafFdjauKPhfTNpmgiiKLmnuSa0Slgv+Lh12S/nA
T3e/JH3ikFmlB25RaHrHWKlAT04Hp9SGiJ3f2eFX9voOtHZEdd9p6KSkDVEc2DaO
JZhrg44xOrXvdzKe6u8KOfkSSqXKt6QMbCCuwPLxSEUWBzUHQXlO1Cs/+2X3aWf2
XocgxtzaMajzIrwC4HNRosY3prejyvg6mcP9mPQZjW6+NOTOKktWJrIb9lw1eWND
EEz01x0oQJjzJz1dLfG0veH4p/nt6FYdrFeyoSwJd4oPXmUP8qkvENshjbS4Fx+3
hN8BF2WhL9+XLjKMFolNIiVumNrP1WuLZZcknRZfd15VBAp05Htd6kUdHHC9areT
6Gi786e0bnEpgG/Od/CsohMXjYVaao6tCLzzwyyLAtqoD3nEfuU=
=nwXd
-----END PGP SIGNATURE-----

--Sig_/JwFDSM5zShD/p=h26a5lGM7--
