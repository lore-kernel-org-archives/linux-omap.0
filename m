From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Mon, 25 Jun 2012 16:49:21 +0300
Message-ID: <1340632161.3395.100.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	 <1340628094.3395.63.camel@deskari>
	 <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-gvzmXXNXShF5qugHWXY6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47254 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755767Ab2FYNtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 09:49:15 -0400
Received: by eekd17 with SMTP id d17so1360840eek.8
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 06:49:13 -0700 (PDT)
In-Reply-To: <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-gvzmXXNXShF5qugHWXY6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 19:01 +0530, Jassi Brar wrote:
> On 25 June 2012 18:11, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2012-06-25 at 17:57 +0530, Jassi Brar wrote:
> >> On 25 June 2012 15:00, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> >> > The driver needs to enable the HW and the call to pm_runtime_get() i=
s
> >> > skipped. Won't this lead to crash as the DSS registers are accessed
> >> > without the HW in enabled state?
> >> >
> >> Hmm...  how does the extant code in hdmi driver ensures DSS is up and =
running ?
> >> While it does sound important even to my limited knowledge of OMAPDSS,
> >> I see rpm of HDMI, VENC and RFBI only dependent on DISPC, not DSS.
> >
> > DSS device is parent to all the DSS subdevices. So when a subdevice is
> > enabled, DSS device is enabled first.
> >
> > But anyway, I wasn't referring to the DSS part of OMAPDSS, but to
> > omapdss generally. If we do this:
> >
> > /* this is skipped, if runtime PM is disabled */
> > dispc_runtime_get();
> >
> I hope you do realize that there is difference between "PM is disabled
> on a device"
> and "the device is in some low-power state".   pm_runtime_enabled()
> checks for the former.
> So under this light...
>=20
> > /* this accesses a register, but the HW is disabled? */
> > dispc_read_reg(FOO);
> >
> .... the H/W is already always enabled if CONFIG_PM_RUNTIME is not define=
d.
>=20
> If CONFIG_PM_RUNTIME is indeed defined,  pm_runtime_enabled() will
> always return true after pm_runtime_enable()  unless someone disables
> it explicitly - omapdss or the RPM stack(during suspend/resume).
> OMAPDSS never does so in the lifetime of a driver.  So the only period
> in which pm_runtime_enabled() returns false, is when the platform is
> suspending, suspended or resuming.

Right. So what happens in my example above?

Normally if the driver does dispc_runtime_get() and dispc_read_reg(),
the first call will enable the HW so the reg read works.=20

But if the pm_runtime is disabled, say, during system suspend, with your
patch dispc_runtime_get() will just return 0 without doing anything, and
the dispc_read_reg() will crash because the HW is disabled (because
nobody enabled it).

Perhaps I'm missing something, but I don't quite understand how this
works.

> >> > And what happens if the pm_runtime_get() call is skipped, but pm_run=
time_put() is not?
> >> >
> >> Not sure in what newly introduced scenario by this patch, because
> >> get/put both check for pm_enabled before proceeding. Am I overlooking
> >> something?
> >
> > Currently (for example) dispc_runtime_get/put call
> > pm_runtime_get/put_sync. When somebody uses dispc_runtime_get, the same
> > somebody knows it needs to call dispc_runtime_put later.
> >
> > Now, what happens if dispc_runtime_get is called when runtime PM is
> > disabled (i.e. pm_runtime_get_sync is skipped), but runtime PM is
> > enabled later when that somebody calls dispc_runtime_put (i.e.
> > pm_runtime_put_sync is _not_ skipped)?
> >
> As I said, for omapdss, PM is disabled (not device deactivated) only
> during rpm suspend/resume.
> And it should be no different than any lock protected section
> preempted by suspend-resume before reaching its end.

I'm not sure if I understand... If the driver does dispc_runtime_get()
while the PM is disabled, say, during system resume, dispc_runtime_get()
will do nothing and return 0. The driver thinks it succeeded, and will
call dispc_runtime_put() later.

Calling the dispc_runtime_put() could happen very soon, while runtime PM
is still disabled, in which case everything works fine. But there's no
rule to say dispc_runtime_put() has to be called very soon after
dispc_runtime_get(). The driver might as well call put later, when
runtime PM is enabled.

This would end up with a pm_runtime_put call without a matching
pm_runtime_get call.

 Tomi


--=-gvzmXXNXShF5qugHWXY6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6GxhAAoJEPo9qoy8lh71+DsP/iqClqFdNMqz3ShJBYG6qQ7D
9IxkJvuGMYCWHUYNq7glu8ZGi+xWB6fhqPVFqZBj1Kd9Gr0rJHL60Kbb/VlvVQv/
nwMlKBP4oH1XxgQs6MzmyCCwKvPVW5xudqc9KS3Ze3UBggTtdE6hczIenWoSRg8t
8Z7y7MesPVsORxx3DhuibX/5TGEmuolD3u4gJHZ/gR0csBRxFkbxm5BebGpbvZod
kAh/k6/1cOsn6jiTDn0SbH7ETPtkLZxWpNBkzDadftmpLow5zc5zQc99HfKbaCI8
1J31kMRH2cfm/Vl5taAZPrbeUGIygefvOFTKTX6JvLgiQL7o1YlsjqcQxFcuUxlA
AmW5rVNvuBNy+DmkGzP6nB7DlBgHAEJs6ULXGAXXghhJpA2KSRBIvS5fxdNEfKKV
vAcaGIt2j+Ck9M1kKz0k5KMl0r+qO9MYzVvHq2dO/K60nNEw6y+8fvMLDQUP9QCU
esqDxVISp+D0D/+nBCPFkHM+wEcLdylLJUMNwbGtIF9Vy/6NPmBICExICg2pzEpR
JOoZ/IAWK2IcrsGG0+JyL7OtbYIkB+V/dHIDwksQ9yBsRH5AhuijEs0QMZAtuUdM
5/VoPivev9gBytbI5hCFJM4ipneR3Lr1EN54s7NzGjzqCcUoVts7Uq04hUtn6Mv5
wfl8mHruP6Lw6Kj4Wa5E
=9zom
-----END PGP SIGNATURE-----

--=-gvzmXXNXShF5qugHWXY6--

