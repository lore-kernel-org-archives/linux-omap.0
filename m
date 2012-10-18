From: Felipe Balbi <balbi@ti.com>
Subject: Re: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
Date: Thu, 18 Oct 2012 08:51:36 +0300
Message-ID: <20121018055136.GF11137@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33737 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab2JRF5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 01:57:40 -0400
Content-Disposition: inline
In-Reply-To: <87txtsitpt.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: balbi@ti.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-i2c@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2012 at 04:06:54PM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > On Wed, Oct 17, 2012 at 05:00:02PM +0300, Felipe Balbi wrote:
> >>=20
> >> On Tue, Oct 16, 2012 at 02:39:50PM -0700, Kevin Hilman wrote:
> >> > + peterz, tglx
> >> >=20
> >> > Felipe Balbi <balbi@ti.com> writes:
> >> >=20
> >> > [...]
> >> >=20
> >> > > The problem I see is that even though we properly return IRQ_WAKE_=
THREAD
> >> > > and wake_up_process() manages to wakeup the IRQ thread (it returns=
 1),
> >> > > the thread is never scheduled. To make things even worse, ouw irq =
thread
> >> > > runs once, but doesn't run on a consecutive call. Here's some (rat=
her
> >> > > nasty) debug prints showing the problem:
> >> >=20
> >> > [...]
> >> >=20
> >> > >> [   88.721923] try_to_wake_up 1411
> >> > >> [   88.725189] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_pro=
cess 0
> >> > >> [   88.731292] [sched_delayed] sched: RT throttling activated
> >> >=20
> >> > This throttling message is the key one.
> >> >=20
> >> > With RT throttling activated, the IRQ thread will not be run (it
> >> > eventually will be allowed much later on, but by then, the I2C xfers
> >> > have timed out.)
> >> >=20
> >> > As a quick hack, the throttling can be disabled by seeting the
> >> > sched_rt_runtime to RUNTIME_INF:
> >> >=20
> >> >         # sysctl -w kernel.sched_rt_runtime_us=3D-1
> >> >=20
> >> > and a quick test shows that things go back to working as expected.  =
But
> >> > we still need to figure out why the throttling is hapenning...
> >> >=20
> >> > So I started digging into why the RT runtime was so high, and noticed
> >> > that time spent in suspend was being counted as RT runtime!
> >> >=20
> >> > So spending time in suspend anywhere near sched_rt_runtime (0.95s) w=
ill
> >> > cause the RT throttling to always be triggered, and thus prevent IRQ
> >> > threads from running in the resume path.  Ouch.
> >> >=20
> >> > I think I'm already in over my head in the RT runtime stuff, but
> >> > counting the time spent in suspend as RT runtime smells like a bug to
> >> > me. no?
> >> >=20
> >> > Peter? Thomas?
> >>=20
> >> it looks like removing console output completely (echo 0 >
> >> /proc/sysrq-trigger) I don't see the issue anymore. Let me just run for
> >> a few more iterations to make sure what I'm saying is correct.
> >
> > Yeah, really looks like removing console output makes the problem go
> > away. Ran a few iterations and it always worked fine. Full logs attached
>=20
> Removing console output during resume is going to significantly change
> the timing of what is happening during suspend/resume, so I suspect that
> combined with all your other debug prints is somehow masking the
> problem.  How log are you letting the system stay in suspend?

about 2 minutes

> That being said, I can still easily reproduce the problem, even with
> console output disabled.
>=20
> With vanilla v3.7-rc1 + the debug patch below[1], with and without
> console output, I see RT throttling kicking in on resume, and the RT
> runtime on resume corresponds to the time spent in suspend.  Here's an
> example of debug output of my patch below after ~3 sec in suspend:
>=20
> [   43.198028] sched_rt_runtime_exceeded: rt_time 2671752930 > runtime 95=
0000000
> [   43.198028] update_curr_rt: RT runtime exceeded: irq/72-omap_i2c
> [   43.198059] update_curr_rt: RT runtime exceeded: irq/72-omap_i2c
> [   43.203704] [sched_delayed] sched: RT throttling activated
>=20
> I see this rather consistently, and the rt_time value is always roughly t=
he
> time I spent in suspend.
>=20
> So the primary question remains: is RT runtime supposed to include the
> time spent suspended?  I suspect not.=20

you might be right there, though we need Thomas or Peter to answer :-s

--=20
balbi

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQf5jnAAoJEIaOsuA1yqREnpgQAJ9cHwZXPswTnZbLmVhWKkF3
ngR1icbr+xtc5ZYiA6vRWWHyCOd1CrHYEG0mUgTtFJSZN0SOnfIQR2PgoJ5CS9vi
wezj1ROC2iweEiMCOqXDCot5mhSR17a2nFLbR42uejV0J7usxgDMrzczOyzr51hF
YA+8y+lQGiY3A/uXuwGFSz52sEdU6Xl2qVYkNwMmp3qbl1U5+2aVMu1LM4ZxwAJG
nd4T6xgrsEGKE5zGOuCIOJE01O6krTn7CDbbN3mlblI3jNGpofM2bK828ps8A219
kqP3UA11ibVrO6M6yBLm2yuCUDQ4ieLZWhR1Dr2rTfJHoMS6drjSRS/bJ/JFkcWQ
evfSiwfGJkz4XzS2ZgKByKUuj5DoCnENFxDs32gp6TO463O2k49SITR7MGYNQDtS
/JNfRJup1hxFVrruW/8nR/zmmohZe9JOhfpe0HOurnRxQ6i/phdTSK+Q/NDbKAbD
R3QKeeP3abHiNA+8UhebBdC8TRDvN8gkNoFtDkARn1/fQQScYyFgNoqLUtaRc81d
xXErP2c4KBswV02PA5Rhr8/pVRY1xG/oJx7tSOPja8Jqjt3nBG22cFOtDBOtmzZe
o4OPwQTu0uNMPxh7uuv4CstLyFrgVBMOFNg1JevGiEasizKQTPy9MZeUNka0hzMS
Usma9jWLA85ED4X1unID
=uwKp
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
