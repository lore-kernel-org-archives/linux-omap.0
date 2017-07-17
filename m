From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: Droid 4 boot failure due to 422580c3cea7 (mm/oom_kill.c: add
 tracepoints for oom reaper-related events)
Date: Mon, 17 Jul 2017 11:51:39 +0200
Message-ID: <20170717095139.gv3dmh7mhyzmh7bn@earth>
References: <20170714134330.bsdoopceecuk5yem@earth>
 <B9634541-43B8-45FD-8DD2-38FB4F0FAD14@fb.com>
 <20170714172343.szrjbeob5alpgzpe@earth>
 <20170716125354.GA20017@castle>
 <20170717055942.GA10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5ebqwxsxom4775d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717055942.GA10026@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--q5ebqwxsxom4775d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 16, 2017 at 10:59:42PM -0700, Tony Lindgren wrote:
> * Roman Gushchin <guro@fb.com> [170716 05:55]:
> > On Fri, Jul 14, 2017 at 07:23:43PM +0200, Sebastian Reichel wrote:
> > > On Fri, Jul 14, 2017 at 02:12:21PM +0000, Roman Gushchin wrote:
> > > > > On 14 Jul 2017, at 14:43, Sebastian Reichel <sebastian.reichel@co=
llabora.co.uk> wrote:
> > > > > I just bisected another issue breaking boot on Droid 4. My
> > > > > bisect points to 422580c3cea7 (mm/oom_kill.c: add tracepoints
> > > > > for oom reaper-related events). It do not see any message
> > > > > printed to UART (with earlyprintk) once that commit is part
> > > > > of my image. Kernel config is below.
> > >=20
> > > > This is really interesting, because this patch adds few
> > > > tracepoints and all of them are called from the oom code, which is
> > > > hopefully not a part of the boot process.
> > > >=20
> > > > Can you, please, confirm, that it can be reproduced with some
> > > > confidence? If so, can you, please, eliminate the tracepoints
> > > > calls and try to reproduce the boot failure?
> > >=20
> > > I can boot 9967468c0a10 ("Merge branch 'akpm' (patches from
> > > Andrew)") after adding
> > >=20
> > >  - http://git.kernel.org/tip/19d39a3810e7032f311ef83effdac40339b9d022
> > >    (another issue, that breaks Droid 4 boot)
> > >  - a git revert of 422580c3cea7
> > >=20
> > > OTOH there are strange problems. Using da16dd9785f8 + above
> > > two commits also works. Using b5e16170f59b + above commits
> > > does not work and bisection ended up in the merge commit.
> >=20
> > Hi, Sebastian!
> >=20
> > As commit 422580c3cea7 hasn't added any code, which is executed
> > during the boot process, I could imagine only two options:
> > 1) Added code/data occasionally broke some alignment/size contraints.
> > 2) There is another instable bug, which compromised bisect results.
> >=20
> > Unfortunately, I can't help you with reproducing, because I haven't
> > necessary hardware.
> >=20
> > Can you, please, try some older known to be good revision with
> > the 422580c3cea7 patch applied?
>=20
> Sebastian, for me droid 4 boots just fine with v4.13-rc1 +
> 19d39a3810e if that helps. So that's with commit 422580c3cea7.

v4.13-rc1 + 19d39a3810e was also broken for me. I just disabled
some unused bits in my .config and now the kernel boots with
(with 422580c3cea7 that is). Maybe I hit some maximum image size
limit for Droid 4?

Anyways it looks like 422580c3cea7 is not the actual problem
and merely reveals some other problem.

-- Sebastian

--q5ebqwxsxom4775d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsiKgACgkQ2O7X88g7
+prnShAAkFnsOMcXdqkxv1DpAjmCHC59xHbGxwye4aOo1ypkiJWS7uCGTfnXiH4h
RN0W87kPuTJW+PGtvbMwFcitL1kfE7E3xACEMP6IiwZAF712XyhLgLH6iVAlU5Xt
KJ3vodY8/br81wZu6a1GwS/zVWr82FJE68zrVjO7+gPNP87o+SCypbCvRGcKIAqh
cPVObYhGj7qg/MCNwDUyYKAnmT1irLeMLoXAPNwmmCeZ3Rz0kqrRD2DwLp4ZTY1r
MKJR2ev+qiUyTomHSbaVGqstLqHHPSR/v7VuAJeXFpLozkPzm14s/xBZp7M3FgSA
lYuaEhXDYTMtsiYH6dWatr+HWtjph+OVG8wfersMAEA5IYNt9irFDoduPaYcZ/Do
e3WE2E63BZrtiipT76d0FtAED0VKSVUJxPZupWB1yMKQvg6kzUSUhxfSEJPmFZIQ
2XfzW1o0fGQgg204Qvr+yp8+RVFIYyLmjh58Ih1gi9kjiT1zq99Ousb8ADFF32PA
O4bY+w3bAPo6NsR1UX2uhRKGSoAunEvdwz+XxJ/mra7OEDi05lIr9JveV9iZdR/2
756SOC1O7N275CK8tY6bI223EWEbjBuGs04y/0DItGO4Lpe24dBHQDkp3vYldpcW
vwBalsKQdah3Ve2WQU+oahOfHsEQGoRVCdBNP+tJ4wrkpp+MrZY=
=CFDc
-----END PGP SIGNATURE-----

--q5ebqwxsxom4775d--
