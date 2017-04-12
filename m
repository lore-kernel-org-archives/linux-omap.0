From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 09:54:46 -0700
Message-ID: <20170412165444.GC13484@localhost.localdomain>
References: <1491967248.2357.25.camel@intel.com>
 <492e72af-ff33-d193-071e-5bc00df9a8b0@ti.com>
 <20170412040542.GA11305@localhost.localdomain>
 <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
 <1491985580.2357.39.camel@intel.com>
 <db07d448-0fa9-f582-a323-5edcb9a0b509@ti.com>
 <1491986744.2357.42.camel@intel.com>
 <20170412154358.GA12881@localhost.localdomain>
 <b565f2c9-fdd7-7525-da91-695f113e631b@ti.com>
 <b0830fa9-9a3b-6862-6cab-274c17810227@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b0830fa9-9a3b-6862-6cab-274c17810227@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Keerthy,

On Wed, Apr 12, 2017 at 10:14:36PM +0530, Keerthy wrote:
>=20
>=20
> On Wednesday 12 April 2017 10:01 PM, Grygorii Strashko wrote:
> >=20
> >=20
> > On 04/12/2017 10:44 AM, Eduardo Valentin wrote:
> >> Hello,
> >>
> > ...
> >=20
> >>
> >> I agree. But there it nothing that says it is not reenterable. If you
> >> saw something in this line, can you please share?
> >>
> >>>>> will you generate a patch to do this?
> >>>> Sure. I will generate a patch to take care of 1) To make sure that
> >>>> orderly_poweroff is called only once right away. I have already
> >>>> tested.
> >>>>
> >>>> for 2) Cancel all the scheduled work queues to monitor the
> >>>> temperature.
> >>>> I will take some more time to make it and test.
> >>>>
> >>>> Is that okay? Or you want me to send both together?
> >>>>
> >>> I think you can send patch for step 1 first.
> >>
> >> I am happy to see that Keerthy found the problem with his setup and a
> >> possible solution. But I have a few concerns here.
> >>
> >> 1. If regular shutdown process takes 10seconds, that is a ballpark that
> >> thermal should never wait. orderly_poweroff() calls run_cmd() with wait
> >> flag set. That means, if regular userland shutdown takes 10s, we are
> >> waiting for it. Obviously this not acceptable. Specially if you setup
> >> critical trip to be 125C. Now, if you properly size the critical trip =
to
> >> fire before hotspot really reach 125C, for 10s (or the time it takes to
> >> shutdown), then fine. But based on what was described in this thread,
> >> his system is waiting 10s on regular shutdown, and his silicon is on
> >> out-of-spec temperature for 10s, which is wrong.
> >>
> >> 2. The above scenario is not acceptable in a long run, specially from a
> >> reliability perspective. If orderly_poweroff() has a possibility to
> >> simply never return (or take too long), I would say the thermal
> >> subsystem is using the wrong API.
> >>
> >=20
> >=20
> > Hh, I do not see that orderly_poweroff() will wait for anything now:
> > void orderly_poweroff(bool force)
> > {
> > 	if (force) /* do not override the pending "true" */
> > 		poweroff_force =3D true;
> > 	schedule_work(&poweroff_work);=20
> > ^^^^^^^ async call. even here can be pretty big delay if system is unde=
r pressure
> > }
> >=20
> >=20
> > static int __orderly_poweroff(bool force)
> > {
> > 	int ret;
> >=20
> > 	ret =3D run_cmd(poweroff_cmd);
>=20
> When i tried with multiple orderly_poweroff calls ret was always 0.
> So every 250mS i see this ret =3D 0.
>=20
> > ^^^^ no wait for the process - only for exec. flags =3D=3D UMH_WAIT_EXEC
> >=20
> > 	if (ret && force) {
>=20
> So it never entered this path. ret =3D 0 so if is not executed.

I think your setup has two major problems then:
1. when kernel runs userspace power off, it execs properly, in fact, it
is not triggered.
2. when you finally exec it, it takes 5s to finish.

If this is correct, I think my suggestions on the other email
still holds.

BR,

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7lvOAAoJEA6VkvSQfF5T6r8P/iG/8iAfqZhmKWcwd5dhW5w0
8bHV1eEmkGiNhn16BDPf/QkoNft2VMZcdK5Ac/m+PyHPdyHQTKdVN51byaYOnCVq
3TG4SLU8uJu4FZt+jeMKbhd61NrOwN8dgB2z/MmlLt68QA7X1macUcmkmP8wZmGq
osiArzse2di6TH+CWrI65tedVMZ36KppEBSnzWYJhQNbd+HMmZ4Fm58E01z/meEk
AIj9Tk/vgcj3+979m3w9bBtQ8Mw00Fmeb3jsOz4lSmM3Sxh+HIQIEO042oUdsITO
QNr9W6jrAEcBkrg6apt4RmJlxq7sHDamzmDCz3PmX5FLuJ1Gtf6GgDi+rn9sSDHR
zvlwq6mjFhpx4VTDhVbcjZRZpQbzVQ7St5m4nBECuto/9QfJuvrvzxaJLeTWWA9i
5ewEoyeHo2o/AI2uEifv6FiwRFVftRjze0CdT0ZUZdrL050GKxWaR/qC/G4s4rYo
7Ix++NE48DocExpep5GR8Dn9qf73WZdwEFkhTd5VAqxFYWdgNDcpYnWU14j0vVvY
q9HNGCRbON1R45b69N8YeCFYo/baCOiU/z1fGroCNIKiv653MB0Vb6tX/XY4p8bD
D1DGS9fDtu7GuDlD72HsxOzRP/xf9la7nDfurpnG/NjdRlA4D77rdKa+nglsd23K
DcJGExCWVAPqaXVEllu2
=aJwv
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
