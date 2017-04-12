From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 08:44:01 -0700
Message-ID: <20170412154358.GA12881@localhost.localdomain>
References: <1490941820-13511-1-git-send-email-j-keerthy@ti.com>
 <20170411172918.GA5193@localhost.localdomain>
 <f64632d5-c780-e5fe-cff7-8ed1459348a0@ti.com>
 <1491967248.2357.25.camel@intel.com>
 <492e72af-ff33-d193-071e-5bc00df9a8b0@ti.com>
 <20170412040542.GA11305@localhost.localdomain>
 <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
 <1491985580.2357.39.camel@intel.com>
 <db07d448-0fa9-f582-a323-5edcb9a0b509@ti.com>
 <1491986744.2357.42.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491986744.2357.42.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 12, 2017 at 04:45:44PM +0800, Zhang Rui wrote:

<cut>

> > > > Zhang/Eduardo,
> > > >=20
> > > > OMAP5/DRA7 is one case.
> > > >=20
> > > > I believe i this is the root cause of this failure.
> > > >=20
> > > > thermal_zone_device_check --> thermal_zone_device_update -->
> > > > handle_thermal_trip --> handle_critical_trips -->
> > > > orderly_poweroff
> > > >=20
> > > > The above sequence happens every 250/500 mS based on the
> > > > configuration.
> > > > The orderly_poweroff function is getting called every 250/500 mS
> > > > and
> > > > i
> > > > see with a full fledged nfs file system it takes at least 5-10
> > > > Seconds
> > > > to shutdown and during that time we bombard with orderly_poweroff
> > > > calls
> > > > multiple times due to the thermal_zone_device_check triggering
> > > > periodically.

I see. A couple of questions here:
a. A regular shutdown command on your setup takes 5 to 10 s? What is the
PHY underneath your NFS? 56K modem?
b. Or did you mean it takes 5 to 10 s because you keep calling
orderly_poweroff?

> > > >=20
> > > > To confirm that i made sure that handle_critical_trips calls
> > > > orderly_poweroff only once and i no longer see the failure on
> > > > DRA72-
> > > > EVM
> > > > board.
> > > >=20


> > > Nice catch!

Ok. Nice. But how long does it take?

> > Thanks.
> >=20
> > >=20
> > >=20
> > > >=20
> > > > So IMHO once we get to handle_critical_trips case where we do
> > > > orderly_poweroff we need to do the following:
> > > >=20
> > > > 1) Make sure that orderly_poweroff is called only once.
> > > agreed.
> > >=20
> > > >=20
> > > > 2) Cancel all the scheduled work queues to monitor the
> > > > temperature as
> > > > we have already reached a point of shutting down the system.
> > > >=20
> > > agreed.
> > >=20
> > > now I think we've found the root cause of the problem.
> > > orderly_poweroff() is not reenterable and it does not have to be.


Well, why not? Because we assume that all sources of shutdown within
kernel are all gonna happen in different time? What if thermal calls and
another subsystem/driver calls it too. Does work if user space also
calls shutdown in the middle of a thermal shutdown? I think we need to
think this through a bit more..

> > > If we're using orderly_poweroff() for emergency power off, we have
> > > to
> > > use it correctly.
> > >=20

I agree. But there it nothing that says it is not reenterable. If you
saw something in this line, can you please share?

> > > will you generate a patch to do this?
> > Sure. I will generate a patch to take care of 1) To make sure that
> > orderly_poweroff is called only once right away. I have already
> > tested.
> >=20
> > for 2) Cancel all the scheduled work queues to monitor the
> > temperature.
> > I will take some more time to make it and test.
> >=20
> > Is that okay? Or you want me to send both together?
> >=20
> I think you can send patch for step 1 first.

I am happy to see that Keerthy found the problem with his setup and a
possible solution. But I have a few concerns here.

1. If regular shutdown process takes 10seconds, that is a ballpark that
thermal should never wait. orderly_poweroff() calls run_cmd() with wait
flag set. That means, if regular userland shutdown takes 10s, we are
waiting for it. Obviously this not acceptable. Specially if you setup
critical trip to be 125C. Now, if you properly size the critical trip to
fire before hotspot really reach 125C, for 10s (or the time it takes to
shutdown), then fine. But based on what was described in this thread,
his system is waiting 10s on regular shutdown, and his silicon is on
out-of-spec temperature for 10s, which is wrong.

2. The above scenario is not acceptable in a long run, specially from a
reliability perspective. If orderly_poweroff() has a possibility to
simply never return (or take too long), I would say the thermal
subsystem is using the wrong API.


If you are going to implement the above two patches, keep in mind:
i. At least within the thermal subsystem, you need to take care of all
zones that could trigger a shutdown.
ii. serializing the calls to orderly_poweroff() seams to be more
concerning than cancelling all monitoring.


BR,

Eduardo Valentin
>=20
> thanks,
> rui
> > Regards,
> > Keerthy
> >=20
> > >=20
> > >=20
> > > thanks,
> > > rui
> > >=20
> > > >=20
> > > > Let me know your thoughts on this.
> > > >=20
> > > > Best Regards,
> > > > Keerthy
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > However, there is no clean way of detecting such
> > > > > > > > > > failure
> > > > > > > > > > of
> > > > > > > > > > userspace
> > > > > > > > > > powering off the system. In such scenarios, it is
> > > > > > > > > > necessary for a
> > > > > > > > > > backup
> > > > > > > > > > workqueue to be able to force a shutdown of the
> > > > > > > > > > system
> > > > > > > > > > when
> > > > > > > > > > orderly
> > > > > > > > > > shutdown is not successful after a configurable time
> > > > > > > > > > period.
> > > > > > > > > >=20
> > > > > > > > > Given that system running hot is a thermal issue, I
> > > > > > > > > guess
> > > > > > > > > we care
> > > > > > > > > more
> > > > > > > > > on this matter then..
> > > > > > > > Yes!
> > > > > > > >=20
> > > > > > > I just read this thread again https://patchwork.kernel.org/
> > > > > > > patc
> > > > > > > h/802458
> > > > > > > 1/ to recall the previous discussion.
> > > > > > >=20
> > > > > > > https://patchwork.kernel.org/patch/8149891/
> > > > > > > https://patchwork.kernel.org/patch/8149861/
> > > > > > > should be the solution made based on Ingo' suggestion,
> > > > > > > right?
> > > > > > >=20
> > > > > > > And to me, this sounds like the right direction to go,
> > > > > > > thermal
> > > > > > > does not
> > > > > > > need a back up shutdown solution, it just needs a kernel
> > > > > > > function call
> > > > > > > which guarantees the system can be shutdown/reboot
> > > > > > > immediately.
> > > > > > >=20
> > > > > > > is there any reason that patch 1/2 is not accepted?
> > > > > > Zhang,
> > > > > >=20
> > > > > > http://www.serverphorums.com/read.php?12,1400964
> > > > > >=20
> > > > > > I got a NAK from Alan and was given this direction on a
> > > > > > thermal_poweroff
> > > > > > which is more or less what is done in this patch.
> > > > > >=20
> > > > > Actually, Alan's suggestion is more for you to define a
> > > > > thermal_poweroff() that can be defined per architecture.
> > > > >=20
> > > > > Also, please, keep track of your patch versions and also do
> > > > > copy
> > > > > everybody who has stated their opinion on previous discussions.
> > > > > These
> > > > > patches must have Ingo, Alan, and RMK copied too. In this way
> > > > > we
> > > > > avoid
> > > > > loosing track of what has been suggested and we also converge
> > > > > faster to
> > > > > something everybody (or most of us) agree. Next version,
> > > > > please,
> > > > > fix
> > > > > that.
> > > > >=20
> > > > >=20
> > > > > To me, thermal core needs a function that simply powers off the
> > > > > system.
> > > > > No timeouts, delayed works, backups, etc. Simple and straight.
> > > > >=20
> > > > > The idea of having a per architecture implementation, as per
> > > > > Alan's
> > > > > suggestion, makes sense to me too. Having something different
> > > > > from
> > > > > pm_power_off(), specific to thermal, might also give the
> > > > > opportunity to
> > > > > save the power off reason.
> > > > >=20
> > > > > BR,
> > > > >=20
> > > > > Eduardo Valentin
> > > > >=20

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7ks2AAoJEA6VkvSQfF5TAgMP/iz6EsRttJhuHzvQ1ixM6nrI
EGAbyiv+VNMLakUqPzdKuZN1eGbGSBnk0/tLwZXRk2hIuqMMT1URgekbTxeVGzyv
+Oq5BOsrdracrtOyDv1sGDKRD6EXIWg6Eza23RMaTT0Idr2NHklVn8yIoKvlIhAp
ADG9K758mt3QwvixqirI1A2WJ/b1c9cmZU6Gwe3uZzenMnEKho2G//URofydI4KC
84atYfuH68g/bz348hlKDSWfLBRPFxg4fjXzvNNtgirkpj1WzrkhJAjuvX8zGZKL
DEwSSFEf6G4/dpgGFeEPeOo3ORqRYJHComRGRbkVGn/E2O9vvRWz/Eu89ekxUp4+
MrHM6vlgxDGD9/gGO/oYMpt330q9nOb+FCF90UR1VrexpgRtXUHYGB8DXeyN4LvC
H1a5DeuEVkLPKQfR3iSuP1RWzvMDioPU32M3H55qoQ1uiQ3rq6ONzqMo8ip392Nk
cqZGDTxc+jUInmvjcbuk5JAsalYlLPY9abvhcPovIsTuon0zNNODJY1xO69IX944
HfbhtgJeqmX9ivv1QjD3e3OyBJc0xiKrQ6+ldWwWCL99NW1o3NkpkuZwvrIVb/Hw
r8wlXvCguiLct10Ie+qf8XYX4j+9yUe0MAjI7mPHqjtPvGIBnX7K+yvSehcXNXiX
zk6sz35rNKp2N6nms3ta
=9B+U
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
