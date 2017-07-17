From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: Droid 4 boot failure due to 422580c3cea7 (mm/oom_kill.c: add
 tracepoints for oom reaper-related events)
Date: Mon, 17 Jul 2017 13:17:13 +0200
Message-ID: <20170717111713.2lzgplta7mx7xfy3@earth>
References: <20170714134330.bsdoopceecuk5yem@earth>
 <B9634541-43B8-45FD-8DD2-38FB4F0FAD14@fb.com>
 <20170714172343.szrjbeob5alpgzpe@earth>
 <20170716125354.GA20017@castle>
 <20170717055942.GA10026@atomide.com>
 <20170717095139.gv3dmh7mhyzmh7bn@earth>
 <20170717101927.GJ10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ps4g5fgjcwvkinsd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717101927.GJ10026@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--ps4g5fgjcwvkinsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[dropping people from Cc]

Hi,

On Mon, Jul 17, 2017 at 03:19:28AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170717 02:52]:
> > On Sun, Jul 16, 2017 at 10:59:42PM -0700, Tony Lindgren wrote:
> > > Sebastian, for me droid 4 boots just fine with v4.13-rc1 +
> > > 19d39a3810e if that helps. So that's with commit 422580c3cea7.
> >=20
> > v4.13-rc1 + 19d39a3810e was also broken for me. I just disabled
> > some unused bits in my .config and now the kernel boots with
> > (with 422580c3cea7 that is). Maybe I hit some maximum image size
> > limit for Droid 4?
> >=20
> > Anyways it looks like 422580c3cea7 is not the actual problem
> > and merely reveals some other problem.
>=20
> OK. Maybe check kexec --image-size configuration if you have
> a huge static kernel?

I still use the IMGSIZE=3D26214400 from your kexec wrapper for
Droid 4, which should be 25MB. With the updated .config my
image looks like this:

$ ls -lh arch/arm/boot/*Image
-rwxr-xr-x 1 sre sre  17M Jul 17 12:44 arch/arm/boot/Image
-rwxr-xr-x 1 sre sre 7.2M Jul 17 12:44 arch/arm/boot/zImage

Unfortunately I did not check size before I dropped the config
options. I don't think I removed 8M of config options, but who
knows.

-- Sebastian

--ps4g5fgjcwvkinsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsnLYACgkQ2O7X88g7
+pqNCA//fF8G/LiS3YiMFYyi79eqGF+CkOK8jDa1YR4FjAZxL0LWXirSHQRsyNBN
JMPzBy7GnOYTKWWsqL/nWuabCGgmllFw0jU6lSiCJch2qIYZA7DLCoDDWfc+tVzX
kYUYjQQxnHftkPBs6SbKO+iXsgpl5i8UKoE1Gh+D7qM1al2FflaxagytdmAiQUSx
Nl8DWfz8uQO9fxhbdxPAUu40ldu3CQseLRKwaB/fVDK8N6f5PoeWysbqfENhfhu5
oAJ8LHgLJcO87nEv/zItCDsMo/40JT1EA9Vm0FgIiZ6uxDtrITTyzwiyDo0IZkQD
AGCAakEksMnhg4kW+3NS0AyyEYqtq4WTk9ZJMz2vLkqCjsDj+NKl0HjnytYuTIT8
DTqUKmL2oNjZQ+W5nbg4MYWPD4zQFjfKlJM8cdnVF8Csqf7aVYsenFSgar1AV+Je
I/hHgDVI2Lch54L6oJQjJvNhxM1gaGU8plWWv1pMXRzBStLcygTjLkbbh0mt+yLL
7UfU8FVu3UPPZlez8HACq+DHgZUx0OxzojaLpQtUNjS621V44rcND033H1FjGn+f
oldXoGEFHpfnUtZCLh/4Y+arG+E0eguVKulffn6QWjMeKoWN90I7g9BPt+MlubTv
8ZgQ9r9wjLRDPBOS3dA2vmQQQz2R951SP3z6dM2TzT9hL8kTTO8=
=lBuV
-----END PGP SIGNATURE-----

--ps4g5fgjcwvkinsd--
