From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 09:50:57 -0700
Message-ID: <20170412165055.GB13484@localhost.localdomain>
References: <f64632d5-c780-e5fe-cff7-8ed1459348a0@ti.com>
 <1491967248.2357.25.camel@intel.com>
 <492e72af-ff33-d193-071e-5bc00df9a8b0@ti.com>
 <20170412040542.GA11305@localhost.localdomain>
 <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
 <1491985580.2357.39.camel@intel.com>
 <db07d448-0fa9-f582-a323-5edcb9a0b509@ti.com>
 <1491986744.2357.42.camel@intel.com>
 <20170412154358.GA12881@localhost.localdomain>
 <3d21afca-2e86-3c66-e36a-2a30ad973194@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3d21afca-2e86-3c66-e36a-2a30ad973194@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey

On Wed, Apr 12, 2017 at 09:46:47PM +0530, Keerthy wrote:
>=20
>=20
> On Wednesday 12 April 2017 09:14 PM, Eduardo Valentin wrote:
> > Hello,
> >=20
> > On Wed, Apr 12, 2017 at 04:45:44PM +0800, Zhang Rui wrote:
> >=20
> > <cut>
> >=20
> >>>>> Zhang/Eduardo,
> >>>>>
> >>>>> OMAP5/DRA7 is one case.
> >>>>>
> >>>>> I believe i this is the root cause of this failure.
> >>>>>
> >>>>> thermal_zone_device_check --> thermal_zone_device_update -->
> >>>>> handle_thermal_trip --> handle_critical_trips -->
> >>>>> orderly_poweroff
> >>>>>
> >>>>> The above sequence happens every 250/500 mS based on the
> >>>>> configuration.
> >>>>> The orderly_poweroff function is getting called every 250/500 mS
> >>>>> and
> >>>>> i
> >>>>> see with a full fledged nfs file system it takes at least 5-10
> >>>>> Seconds
> >>>>> to shutdown and during that time we bombard with orderly_poweroff
> >>>>> calls
> >>>>> multiple times due to the thermal_zone_device_check triggering
> >>>>> periodically.
> >=20
> > I see. A couple of questions here:
> > a. A regular shutdown command on your setup takes 5 to 10 s? What is the
> > PHY underneath your NFS? 56K modem?
>=20
> Its not 56K modem but also i am not running on busybox!

OK. :-)

> Its a full fledged arago file system. Yes i have run a basic poweroff
> and it takes about 5S. I will share the logs with timings the first
> thing tomorrow.
>=20

I see.=20

> > b. Or did you mean it takes 5 to 10 s because you keep calling
> > orderly_poweroff?
>=20
> If we keep calling orderly_poweroff it would never shutdown. Hence the
> issue.

Yeah, if you could share the logs would be great to understand where the
wait sits.

>=20
> >=20
> >>>>>
> >>>>> To confirm that i made sure that handle_critical_trips calls
> >>>>> orderly_poweroff only once and i no longer see the failure on
> >>>>> DRA72-
> >>>>> EVM
> >>>>> board.
> >>>>>
> >=20
> >=20
> >>>> Nice catch!
> >=20
> > Ok. Nice. But how long does it take?
>=20
> About 5-10S as i mentioned.
>=20
> First and foremost there is an issue here where in we keep calling
> orderly_poweroff which needs to be addressed.
>=20

I agree here. Apparently, the expectations of the API were wrong. I
agree on refraining from calling it multiple times before it finishes.

But, I said this before, and I will repeat myself. I believe thermal is
not the only user of this API, maybe the problem is more apparent for
thermal because we call it multiple times, and we want it to finishes,
but even after fixing the serialization on thermal side, we can still
collide with other parts of the kernel and userland.

> >=20
> >>> Thanks.
> >>>
> >>>>
> >>>>
> >>>>>
> >>>>> So IMHO once we get to handle_critical_trips case where we do
> >>>>> orderly_poweroff we need to do the following:
> >>>>>
> >>>>> 1) Make sure that orderly_poweroff is called only once.
> >>>> agreed.
> >>>>
> >>>>>
> >>>>> 2) Cancel all the scheduled work queues to monitor the
> >>>>> temperature as
> >>>>> we have already reached a point of shutting down the system.
> >>>>>
> >>>> agreed.
> >>>>
> >>>> now I think we've found the root cause of the problem.
> >>>> orderly_poweroff() is not reenterable and it does not have to be.
> >=20
> >=20
> > Well, why not? Because we assume that all sources of shutdown within
> > kernel are all gonna happen in different time? What if thermal calls and
> > another subsystem/driver calls it too. Does work if user space also
> > calls shutdown in the middle of a thermal shutdown? I think we need to
> > think this through a bit more..
>=20
> Definitely we need to think a lot more but point agreed. Why is thermal
> framework calling orderly_poweroff multiple times? Say even if you
> manage to shut off in 2 seconds you still end up calling 4 to 8 times
> depending on 500mS or 250mS delay.

I agree here. Also, a graceful thermal shutdown may also mean displaying
a message, etc. In this case, you have to size properly the trip,
accounting shutdown down time, and your reliability expectation.


>=20
> >=20
> >>>> If we're using orderly_poweroff() for emergency power off, we have
> >>>> to
> >>>> use it correctly.
> >>>>
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
>=20
> 2 approaches can be taken here:
>=20
> 1) Reduce the critical temperature to something lesser than the hardware
> critical point.
>=20
> Or
>=20
> 2) Call kernel_power_off directly as you are in a pretty critical
> situation! That only takes less than a second and powers off the PMIC at
> least on OMAP5/DRA7.


I think the code needs to allow doing both, actually. Considering both,
the silicon and system reliability, and userland (and end user)
interaction, the thermal shutdown typically needs to:
1. Make sure it avoids reliability problems, i.e., one shall not allow
device to run on out-of-spec temperature.
2. Give the opportunity for the system to gracefully shutdown, so you
have the time to keep system state sane (save your data, notify user,
etc), even if you are on a 56K modem :-)

>=20
> >=20
> > 2. The above scenario is not acceptable in a long run, specially from a
> > reliability perspective. If orderly_poweroff() has a possibility to
> > simply never return (or take too long), I would say the thermal
> > subsystem is using the wrong API.
>=20
> As mentioned above kernel_power_off?
>=20
> >=20
> >=20
> > If you are going to implement the above two patches, keep in mind:
> > i. At least within the thermal subsystem, you need to take care of all
> > zones that could trigger a shutdown.
>=20
> Do you think it makes sense for all the 'n' sensors to trigger
> orderly_poweroff one by one? Or we should worry about the first source
> and ensure that it shuts off the system?
>=20
> Is it not enough to catch the first critical alert and poweroff

I think it is enough if we make sure the first one goes through
properly. For accountability purposes, some people would like to also
know if other sensors are too hot too, and could be also firing the
shutdown.

Only making sure that the first shutdown goes all the way through,
and block any other thermal shutdowns, it is enough. Then again, I do
not think you need to cancel all the monitoring in the system.

Given the above points, my suggestion is to:
1. still call orderly_poweroff(), therefore, you still give the
opportunity for userland to gracefully power off.
2. but still make sure, once one of the zones hits critical, no other
will call orderly_poweroff()
3. Also, when in the critical path, make sure there is no way back, or
long delays, allowing system engineer to size the shutdown wait.
Shutdown wait is a system property, not a zone property. That is, we
eventually call kernel_power_off().

All in all, 1. and 2. above are part of what you found and what has been
proposed to make sure we call orderly_poweroff() only once, system wide
(or at least thermal subsystem wide). And 3. is pretty much the proposed
patch in this series, I think this still needs to go, and I am convinced
that thermal core is best place to write the backup mechanism, given the
expected variability of orderly_poweroff().

BR,

Eduardo Valentin

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7lrpAAoJEA6VkvSQfF5TYAYP/jyYmU9HlC1MtGbXS8kLGXIR
dzNHO3xG/rvg5hnmz5Xtx7joW3yCWvQhv4bxUa8FU7gzWex4yKpScytdPQPTUKsI
HM3TX1Q5BmtShzDwSEpJYuTPIRX+rsCEV7Jj3xW7OCWX3GfD/tbbCOcqdUHkR87Y
MqtIaG7nMvdpEcrqKWS+kDIHv/ZkWPg6kzu1JUX19DMlTdCVMbyf7yCooUfuIq44
wqnZE6EeKaKi9tmH4BF9F0OSouxDrqjGcZ0ltYSPLoN0+Wwlpf1gbVXM9w0QaETr
F0Kv74z2Iyw+P6suZnxCnZY8TykjRh0Zm75Dh+AJ/eKKCugOzzx0vl9zk+pVw2Jh
r3DJsECo7Fc79QbCgEGk+/ODE++rPbeRMAcBLiDXtO/QNORDHq2R46pP9SdPAKpz
rmvK2JUF0rc1veG44FPcM8aZ6jC8JrGs98nYMnmRLDE75YkFTLYg2a5Zpp3Etkvw
WmyLoMmnsMtXBAKBtjdI43lvKk4TQCeZY6F36JQ6keNPQZ+bQKQyX+XdAkWvDf3s
3rOO4TGgs63hGsBWZ3Fcyp5U4LtTtDIdDlZru/h2BBKDG3T/yqD3SSHSKyPM9/uB
8O9F7cneS5BCw/WATKwurNzsaWOPH1+R70kvpzNB6TGYLHYojvq93SVF/J11d7pi
TKvhqnmY9PWHX+7mYyxN
=fP6b
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
