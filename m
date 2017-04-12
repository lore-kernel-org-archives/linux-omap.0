From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 09:34:24 -0700
Message-ID: <20170412163422.GA13484@localhost.localdomain>
References: <f64632d5-c780-e5fe-cff7-8ed1459348a0@ti.com>
 <1491967248.2357.25.camel@intel.com>
 <492e72af-ff33-d193-071e-5bc00df9a8b0@ti.com>
 <20170412040542.GA11305@localhost.localdomain>
 <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
 <1491985580.2357.39.camel@intel.com>
 <db07d448-0fa9-f582-a323-5edcb9a0b509@ti.com>
 <1491986744.2357.42.camel@intel.com>
 <20170412154358.GA12881@localhost.localdomain>
 <b565f2c9-fdd7-7525-da91-695f113e631b@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b565f2c9-fdd7-7525-da91-695f113e631b@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Apr 12, 2017 at 11:31:18AM -0500, Grygorii Strashko wrote:
>=20
>=20
> On 04/12/2017 10:44 AM, Eduardo Valentin wrote:
> > Hello,
> >=20
> ...
>=20
> >=20
> > I agree. But there it nothing that says it is not reenterable. If you
> > saw something in this line, can you please share?
> >=20
> >>>> will you generate a patch to do this?
> >>> Sure. I will generate a patch to take care of 1) To make sure that
> >>> orderly_poweroff is called only once right away. I have already
> >>> tested.
> >>>
> >>> for 2) Cancel all the scheduled work queues to monitor the
> >>> temperature.
> >>> I will take some more time to make it and test.
> >>>
> >>> Is that okay? Or you want me to send both together?
> >>>
> >> I think you can send patch for step 1 first.
> >=20
> > I am happy to see that Keerthy found the problem with his setup and a
> > possible solution. But I have a few concerns here.
> >=20
> > 1. If regular shutdown process takes 10seconds, that is a ballpark that
> > thermal should never wait. orderly_poweroff() calls run_cmd() with wait
> > flag set. That means, if regular userland shutdown takes 10s, we are
> > waiting for it. Obviously this not acceptable. Specially if you setup
> > critical trip to be 125C. Now, if you properly size the critical trip to
> > fire before hotspot really reach 125C, for 10s (or the time it takes to
> > shutdown), then fine. But based on what was described in this thread,
> > his system is waiting 10s on regular shutdown, and his silicon is on
> > out-of-spec temperature for 10s, which is wrong.
> >=20
> > 2. The above scenario is not acceptable in a long run, specially from a
> > reliability perspective. If orderly_poweroff() has a possibility to
> > simply never return (or take too long), I would say the thermal
> > subsystem is using the wrong API.
> >=20
>=20
>=20
> Hh, I do not see that orderly_poweroff() will wait for anything now:
> void orderly_poweroff(bool force)
> {
> 	if (force) /* do not override the pending "true" */
> 		poweroff_force =3D true;
> 	schedule_work(&poweroff_work);=20
> ^^^^^^^ async call. even here can be pretty big delay if system is under =
pressure
> }
>=20
>=20
> static int __orderly_poweroff(bool force)
> {
> 	int ret;
>=20
> 	ret =3D run_cmd(poweroff_cmd);
> ^^^^ no wait for the process - only for exec. flags =3D=3D UMH_WAIT_EXEC

Yeah, and that is what I really meant. Sorry for the confusion. The exec
is problematic in his scenario too, given he is running on a very
interesting NFS setup. Yes, the WAIT_EXEC is set:
392 static int run_cmd(const char *cmd)
393 {
394         char **argv;
395         static char *envp[] =3D {
396                 "HOME=3D/",
397                 "PATH=3D/sbin:/bin:/usr/sbin:/usr/bin",
398                 NULL
399         };
400         int ret;
401         argv =3D argv_split(GFP_KERNEL, cmd, NULL);
402         if (argv) {
403                 ret =3D call_usermodehelper(argv[0], argv, envp, UMH_WA=
IT_EXEC);
404                 argv_free(argv);
405         } else {
406                 ret =3D -ENOMEM;
407         }
408=20
409         return ret;
410 }
411=20


>=20
> 	if (ret && force) {
> 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
>=20
> 		/*
> 		 * I guess this should try to kick off some daemon to sync and
> 		 * poweroff asap.  Or not even bother syncing if we're doing an
> 		 * emergency shutdown?
> 		 */
> 		emergency_sync();
> 		kernel_power_off();
> ^^^ force power off, but only if run_cmd() failed - for example /sbin/pow=
eroff doesn't exist
> 	}
>=20
> 	return ret;
> }
>=20
> static bool poweroff_force;
>=20
> static void poweroff_work_func(struct work_struct *work)
> {
> 	__orderly_poweroff(poweroff_force);
> }
>=20
> As result thermal has no control of power off any more after calling orde=
rly_poweroff() and can get the result
> of US poweroff binary execution.
>=20
> >=20
> > If you are going to implement the above two patches, keep in mind:
> > i. At least within the thermal subsystem, you need to take care of all
> > zones that could trigger a shutdown.
> > ii. serializing the calls to orderly_poweroff() seams to be more
> > concerning than cancelling all monitoring.
> >=20
> >=20
>=20
> --=20
> regards,
> -grygorii

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7lcIAAoJEA6VkvSQfF5TE9MP/1hBipgoAgNOaswNNLiv/a/X
JX4dISid9+CtUZuCRKeJjRJjYtpHtAjuU1n3ODS47oZkqbdo3X3HedzoIN0bv1Qe
GzfoNXyIveZarqcZ9P5gPFYvOK8VhxI37JiSitRWJ20TtpZYAmRlp52Q2Kw3/gSO
RaYhJT9IgSrRneyPR/gHnSopNRclLTxb0ERDJG61LHplAKJaxi2l1kvJ/0rboa23
G3Ow37nAYyHGaTUjyCPO9vu8rpdO5ho9gQCvFl62u5/NO4Ag4+6bddfnarFlRUEd
pVcBhywQtTNSmbWJ4Pmszl2HoWzXokzuWRJYtZRu7JebZdsbDVtey7+NzXrMLtOI
rB6DYyWnQsoxXpzl8v/YXFxmkQ9IaABXRJAmnbLwcZGQkIm5r7GER6Q0pi9TGI9U
rTwOEDc+OrmEANkeWQR31IVhXZ38G6yCF1GB4+N0VJBOLfbRb16SeMlXn7GWoyRZ
p/X459T0lfQJ3jW6WRrkxdRSBn/55+Cwl3C4RrjYdyMSN8vJUV+EbeRZVzh/ahDI
TkUAuDth7OJni/GjEUgevir3GlZUk1eMfmD/S1YmKHnj7V7qVKrOZejudoObvco+
aXCGGddTWnjdgW87fxCkMznfjAPT0GnUoAB2EYMCei3BcHwlCYzmGFHcCwYn20yR
OPWeO0RSUzvqHXYQ8vsV
=Xj7S
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
