From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 4 Jun 2015 14:05:10 -0500
Message-ID: <20150604190510.GC5710@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43042 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbbFDTIE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2015 15:08:04 -0400
Content-Disposition: inline
In-Reply-To: <55701E93.60303@free.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Felipe Balbi <balbi@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> On 03/06/2015 23:54, Felipe Balbi wrote:
>=20
> > On Wed, Jun 03, 2015 at 02:41:39PM -0700, Stephen Boyd wrote:
> >>>>>> AM43xx, even though it's a single processor A9, it still has TWD a=
nd global
> >>>>>> timer. I was doing some profiling with RT v4.0 and latency is 3.5x=
 lower just
> >>>>>> by switching from gptimer to twd/global.
> >>>>>>
> >>>>>> The only problem is that currently, is_smp() check prevents me fro=
m using twd
> >>>>>> with AM43xx (that's why it's commented below, for testing purposes=
).
> >>>>>>
> >>>>>> In the hopes that we can start a, hopefully, small thread around t=
he subject,
> >>>>>> I'm sending this HACK which I used to get TWD and global timer ena=
bled so I
> >>>>>> could measure latencies with cyclictest.
> >>>>>>
> >>>>>> Is it so that TWD shouldn't be available on UP integrations of ARM=
's Cortex-A
> >>>>>> processors ?
> >>>>>>
> >>>>>>
> >>>>> I wondered about this recently when looking at something unrelated
> >>>>> and noticed that the check had been introduced as part of
> >>>>> 904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_regis=
ter()
> >>>>> no-op for nosmp").
> >>>>>
> >>>>> I suspect this was just the wrong fix at the time, and that the
> >>>>> real culprit is either alloc_percpu() or request_percpu_irq()
> >>>>> getting called too early on a machine without SMP support.
> >>>>>
> >>>>> Possibly the problem is already resolved independently, if you
> >>>>> didn't run into it.
> >>>> no, no splats, nothing at all. See [1]
> >>>>
> >>>> [1] http://hastebin.com/helekubutu
> >>> Adding Shawn
> >>>
> >>
> >> Mason was also interested in doing this. See [2]. From what I could te=
ll
> >> back then, commit 904464b91eca8 was working around the local timer API=
s that
> >> no longer exist.
> >>
> >> [2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=
=3D392348
> >=20
> > A lot of good information on that thread, thanks. Seems like getting
> > twd/global timer working would also have some effect on context
> > switching, perhaps ?
>=20
> Hello,
>=20
> In my case, I need to support two platforms:
>=20
>   single core Cortex A9 MPCore
>     dual core Cortex A9 MPCore
>=20
> However, as the MPCore moniker implies, even the single core platform
> is "SMP capable". (I think this only means an SCU is available?)
>=20
> Thus, I worked around the issue by using the same SMP kernel for both
> platforms; which is why I didn't push any patch.
>=20
> Also, check /proc/timer_list for a "Broadcast device". If you don't
> define one, the TWD timers are set to periodic mode, with hrtimers
> disabled.

Yeah, I have a broadcast device however Linux is picking a gp timer
instead of A9's global timer. Now I think I managed to get Linux to
choose global, but my device won't boot anymore :-p Debugging that. I'm
speculating global timer IRQs aren't firing or aren't wired up properly
on this particular SoC, still to confirm.

--=20
balbi

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVcKFmAAoJEIaOsuA1yqRETNUP/1oBI2ckOzQclQL3cOULLxFY
3pMxH23xHEWh8qCgBcXm7Dj+RGwPSqS2vzz9rsiF50mlp2HRS+bxn4ugksGyOrBc
6vLqItnQw5tSDlHTQB+m1gc0IVVJuCISL/7OlI1Fi5/u39/6Bqea7g0/H0BGzsi/
8kNZK8EZtQCXCtTBNl2rBv2ziiBRqQprsNZ2LFkAbKGMIno+Gol8VErR2AHlf4tJ
K9zGf68gxf3fkPAao2Ru0iKXiLd0RonfRL/MLRUcSBHCj1UNvO+OG3o8w4QE7oM6
yzs5jLr6P5AcC4KaDp+DmA6U81wsU7RivPD+e31MwZWugJ9EMieCkO2lljL9vpbl
jHOXjzGYSkIN6sMn18JRrR0EGwLPIo4JE26AiyckwKQrfe479ALgTHY1T4d7AWS6
fsuWz3wpNcKnmB9ZGYx8crcpUwuKK49oep+2lvP99zAPNqxxjmIVv4r2r4I/SYlS
rsW0K4hvwRsbCzeRYmCnIFsYLVL82lCVKrSIuq8I5/+hz7b0x5usOOZIcWVLK8tu
qF8+UAnz5mHfUw1ujdgaW4nv402eVWhLI5YSv2wDoqV3in3+u09qHh3NKrCK17OX
Jdxi0QV8wd3NXbHzFkAA8Ba+SbwOxqaQSvAMTaLnvUuoYZ0byZDztWetEnqGQIe/
ts6vUhfXgU4D6ANcVdbv
=H7r0
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
