From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: Droid 4 boot failure due to 422580c3cea7 (mm/oom_kill.c: add
 tracepoints for oom reaper-related events)
Date: Mon, 17 Jul 2017 13:51:28 +0200
Message-ID: <20170717115128.u3caqnyiqcnuytz5@earth>
References: <20170714134330.bsdoopceecuk5yem@earth>
 <B9634541-43B8-45FD-8DD2-38FB4F0FAD14@fb.com>
 <20170714172343.szrjbeob5alpgzpe@earth>
 <20170716125354.GA20017@castle>
 <20170717055942.GA10026@atomide.com>
 <20170717095139.gv3dmh7mhyzmh7bn@earth>
 <20170717101927.GJ10026@atomide.com>
 <20170717111713.2lzgplta7mx7xfy3@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dp2y7lrlz4dw77v5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717111713.2lzgplta7mx7xfy3@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--dp2y7lrlz4dw77v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 01:17:13PM +0200, Sebastian Reichel wrote:
> [dropping people from Cc]
>=20
> Hi,
>=20
> On Mon, Jul 17, 2017 at 03:19:28AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170717 02:52]:
> > > On Sun, Jul 16, 2017 at 10:59:42PM -0700, Tony Lindgren wrote:
> > > > Sebastian, for me droid 4 boots just fine with v4.13-rc1 +
> > > > 19d39a3810e if that helps. So that's with commit 422580c3cea7.
> > >=20
> > > v4.13-rc1 + 19d39a3810e was also broken for me. I just disabled
> > > some unused bits in my .config and now the kernel boots with
> > > (with 422580c3cea7 that is). Maybe I hit some maximum image size
> > > limit for Droid 4?
> > >=20
> > > Anyways it looks like 422580c3cea7 is not the actual problem
> > > and merely reveals some other problem.
> >=20
> > OK. Maybe check kexec --image-size configuration if you have
> > a huge static kernel?
>=20
> I still use the IMGSIZE=3D26214400 from your kexec wrapper for
> Droid 4, which should be 25MB. With the updated .config my
> image looks like this:
>=20
> $ ls -lh arch/arm/boot/*Image
> -rwxr-xr-x 1 sre sre  17M Jul 17 12:44 arch/arm/boot/Image
> -rwxr-xr-x 1 sre sre 7.2M Jul 17 12:44 arch/arm/boot/zImage
>=20
> Unfortunately I did not check size before I dropped the config
> options. I don't think I removed 8M of config options, but who
> knows.

I just enabled CONFIG_DEBUG_LOCKDEP=3Dy and CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
and it did not boot again. Sizes are much smaller than kexec's
image-size parameter (26214400 - 25MB):

$ ls -l arch/arm/boot/Image
-rwxr-xr-x 1 sre sre 17768448 Jul 12 00:38 arch/arm/boot/Image

Then I increased image-size parameter to 33554432 (32MB) and it
boots again. So looks like it is a size problem. I wonder what
size this is about, though.

-- Sebastian

--dp2y7lrlz4dw77v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllspL0ACgkQ2O7X88g7
+przQA/+LMAItoaR9SU+6bi7NV/yOJ7ZHYTLng87iw6FB+MM0t0EvKrq4/40I1Qa
okUuskBbXJOmwZXD4Xf9QwpxWUUhjHSHurJ2Y1Zh9VORIbrNTF6jmVYg1yLBeUbN
QRBh2T0QjJZYIj2sBvur6hDDjM4WUZVOcSHTN6yhpuB7JOhzG734Jh1hDLXg/+Ta
nTFvwCuUbLhBajuqWFO30ImLs6DewNRs/uanoiBCbCr3nZGEEalcwqy8sXM2sWY3
sVIBTMTUusCQfHlTLw31fOMApeHB3cNgiUC/gc/FuyVloS31MX+p3oKk5YBkATyF
tpbux4npttZGsJqFtZj7ltCUUHQiO7RN7hLjIPrapbtOAZvP2bv7RzhpgR5IrGRE
4NrnZjIF4KJHSs0MQ/mTuhRyqqyUisRYVzihImpsm8t3zhKLaTct7vdkVA7jajyR
8wlgEujjpwl4e3SKqebqKoKJTvnms3PFDAC/YM4XqYaxx4mwbGABnDoPivKdFXpP
zXWo1vrZWlUQa+wVjDBLJNGJLXX0Zt1cqk4za4z1ipsbTzWsAoe6PAiJSuASYWpK
P9RC2Uo2IOxvmDTjTJBCgS1lpU0UFoNuFtTyCpxoUZH/wlE9HIMsx0T4phIpOi7k
ne7DrHaS8hqb5oPREdC/XizSvzfOj4+RIRND119TRC04B94UYek=
=fixW
-----END PGP SIGNATURE-----

--dp2y7lrlz4dw77v5--
