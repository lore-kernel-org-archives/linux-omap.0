From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 10:19:26 +0300
Message-ID: <1340695166.2093.22.camel@lappyti>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	 <1340628094.3395.63.camel@deskari>
	 <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	 <1340632161.3395.100.camel@deskari>
	 <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-F3yYlzm0UiWHKY2bxVxc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:39089 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757100Ab2FZHTc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 03:19:32 -0400
Received: by lbbgk8 with SMTP id gk8so7831821lbb.26
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 00:19:29 -0700 (PDT)
In-Reply-To: <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-F3yYlzm0UiWHKY2bxVxc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 22:36 +0530, Jassi Brar wrote:
> On 25 June 2012 19:19, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2012-06-25 at 19:01 +0530, Jassi Brar wrote:
>=20
> >> > /* this accesses a register, but the HW is disabled? */
> >> > dispc_read_reg(FOO);
> >> >
> >> .... the H/W is already always enabled if CONFIG_PM_RUNTIME is not def=
ined.
> >>
> >> If CONFIG_PM_RUNTIME is indeed defined,  pm_runtime_enabled() will
> >> always return true after pm_runtime_enable()  unless someone disables
> >> it explicitly - omapdss or the RPM stack(during suspend/resume).
> >> OMAPDSS never does so in the lifetime of a driver.  So the only period
> >> in which pm_runtime_enabled() returns false, is when the platform is
> >> suspending, suspended or resuming.
> >
> > Right. So what happens in my example above?
> >
> > Normally if the driver does dispc_runtime_get() and dispc_read_reg(),
> > the first call will enable the HW so the reg read works.
> >
> > But if the pm_runtime is disabled, say, during system suspend, with you=
r
> > patch dispc_runtime_get() will just return 0 without doing anything, an=
d
> > the dispc_read_reg() will crash because the HW is disabled (because
> > nobody enabled it).
> >
> Hmm, I am not sure if new calls would/should be made to dispc.c after
> the system has suspended and before resumed. That is, anything other
> than from runtime_resume/suspend callbacks of DSS, DISPC, HDMI, VENC
> and RFBI, which rightly don't touch any dss reg but only
> enable/disable a clock.

They do touch the registers. For example, dispc's callbacks save and
restore the registers. The HW should be fully functional during the
callbacks. The point of the callbacks is to suspend/resume the HW in
question, which of course requires accessing the HW.

> As we know, a subsystem should make sure any active work is cleared
> out before suspending and set some flag so that nothing runs until it
> has resumed. I don't say we can't crash the system with this patch,
> but then we would be violating rules of suspend-resume.

Let's go back a bit. I feel like I'm missing some pieces of information,
as I still don't quite grasp the problem.

In the patch you said this fixes an issue with HDMI. Can you tell more
about the problem? What code path is being run? Any error messages?

I tried system suspend with omap4-sdp and panda, with 3.5-rc2, but
neither board seems to wake up from the suspend. Does it work for you?

 Tomi


--=-F3yYlzm0UiWHKY2bxVxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6WJ+AAoJEPo9qoy8lh71YZgQAK7lNTovOsiZp7F8hsjzd5RZ
6nNyYFFxWU6/TW+4iRktT4hmyXPhvM4oeAoCOnb+gQyPolnrBMWgZNqTkALk4VS4
vzks4BByprDo42nE8DtyICitmecFXlRwCfAbMjIG9Ub035F3tLn33we75ZXNhmTI
6na8PxoY+qKqXsg4lC3vMcZK7OqqIm6y6aJiGfIv5x25ZEMvwW7RXGZJby99SdqV
oGJQAmfx2TmO8yd9W83s6hqbUOwo8NxPoP1PKmoHGXmkBJ1k3b55Pwy5L8xs4gOw
rCxZjDhm3i5222G6t0Z01ymi0CeLSC61Dvvdm/76qHFGAEN/1UVco0X/Z8cqL+0n
4YfXgcmPW5L9UD2Qm1MoM7JdICfrNtTFigrUucRUVcWlntHwneC2OvB79THjfAya
9gdoCb/lJShvBRWVlImfJciLJqur3WQ5oQj8Ozih04SkBH02XiVAlXs/RYiIcrfO
jwl9gCsc2YdrgHtiS7dE1FgjqP4+xA3jdlvYyLKL/Ii+THeujrUhp7mRHoBjzPbs
W/9fXjdL42+nkVyg9vdFj5KBJTsf8cNmrMSJpd5gHa5W6QKIgbPM1LzSn/Nm+9Ch
FK56aGZTrYTt0X1QXkADhs4lTGwW7P/NQaWriyx/zeVbZ/u3s0qlizxfYSRyKwTA
5eNC+gqJvcQoUqNFky1w
=I7qU
-----END PGP SIGNATURE-----

--=-F3yYlzm0UiWHKY2bxVxc--

