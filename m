From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Tue, 30 Oct 2012 09:09:04 +0200
Message-ID: <20121030070904.GB1978@arwen.pp.htv.fi>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
 <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
 <508E266C.6090901@ti.com>
 <20121029080523.GC13657@arwen.pp.htv.fi>
 <508E3D09.9090802@ti.com>
 <20121029200328.GE30152@arwen.pp.htv.fi>
 <508F7471.8060402@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57391 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab2J3HO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 03:14:59 -0400
Content-Disposition: inline
In-Reply-To: <508F7471.8060402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Tim Niemeyer <tim.niemeyer@corscience.de>, Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 30, 2012 at 12:02:17PM +0530, Santosh Shilimkar wrote:
> >>>I still think mod_usage needs to go, so does
> >>>omap_gpio_prepare_for_idle() and omap_gpio_resume_from_idle(). To me, =
it
> >>>looks like that needs to be done on ->prepare()/->complete() callbacks
> >>>of system suspend and the gpio driver needs to learn proper runtime
> >>>suspend.
> >>>
> >>I am not saying it shouldn't go :-)
> >>The $subject patch isn't fixing it correctly is what I said.
> >>
> >>Don't get hung up on suspend case because thats the easiest
> >>way to address it. The issue is with idle where GPIO can prevent
> >>SOC idle if it isn't taken care. And since its just an IO, its not
> >>easy to implement something like inactivity timer towards
> >>autosupend.
> >
> >I don't see the relation here. Care to expand a bit ?
> >
> Let me try again...
>=20
> Before I answer you, a closer look at code, the multiple bank should
> not be a problem since we create PIO device per bank so the runtime
> PM layer can indeed manage the use-counting. The issue is with SOC
> idle.
>=20
> System wide suspend, we suspend all the devices and hence all the
> GPIO devices(banks) will be suspended letting the SOC to hit suspend
> state. Hence suspend case is no problem as such.
>=20
> Devices like UART/USB can implement inactivity timers since they
> do have state machine and after the timeout, those devices can be
> suspended. GPIO doesn't fall exactly in that category and hence

idling the device has nothing to do with their internal state machines,
though :-)

We just assume that if device hasn't been used for X ms, it's unlikely
it will continue to be used. Likewise, If device has been used Y ms ago,
it's likely it will continue to be used.

> its bit of an issue to take care. How do you ensure that GPIO
> does idle on SOC idle C-state attempts in such cases. Today that
> job is done by omap_gpio_[prepare/resume]_for_idle.

that's only there because we pm_runtime_get_sync() on gpio_request() and
pm_runtime_put_sync() only on gpio_free().

That's the problem IMHO. And that's easy enough to 'fix':

call pm_runtime_mark_last_busy(); pm_runtime_put_sync_autosuspend();
also on gpio_request() and pm_runtime_get_sync() on gpio_free().

> Idle if we had generic idle notifiers, that would been easy
> but it doesn't exist today.
>=20
> In case we get rid of "mod_usage" which is doable, we need to
> see how to handle the idle since the runtime callback will be
> in that case controlled by runtime PM layer which is unaware
> of idle. You can do put on all banks to trigger callback but

I think we might have a clash of concepts here. What are you calling
idle ? We _do_ have ->runtime_idle() callback, are we not using that ?

I can see omap_device.c implements it properly and I can see that
->runtime_idle() will be called whenever pm_usage counter is decremented
but is not zero. Looks like we can turn that into something useful.

> that will highly UN-optimal. See summary in the end.
>=20
> >>Co-processor also makes use of GPIO via syslink proxy and thats
> >>make things even harder.
> >
> >that's supposed to be solved with hwspinlock, isn't it ?
> >
> Spin locks are needed when same devices are shared across. That
> is not the main concern. The PM is centralized on Linux side for
> GPIO where as the users are outside Linux SW. They may use of
> syslink proxy to request/free GPIO.

fair enough, that's even better.

> Just to summaries, there are 3 things we are talking here.
>=20
> 1. Delaying the idle with a timeout which $subject patch is
> trying to do to reduce latency for interrupts. That itself
> is reasonable.
>=20
> 2. Removal of the bank "mod_usage" which is also clubbed
> in $subject path. Ofcourse that break the current driver
> for idle. So that change needs to be made with better thought
> and in a separate patch. This is doable.
>=20
> 3. Removing omap_gpio_[prepare/resume]_for_idle() with soome
> thing better. For this one though, so far I have not come
> across a good solution. Ideas/Solution is welcome !!

make pm_runtime a bit more aggressive. You don't need to keep GPIO
bank's clocks on just because a GPIO in that bank is requested. If
context save & restore isn't buggy, you can disable clocks no problem.

The difficult part, IMHO, is to figure out what's a good autosuspend
timeout to use. Some GPIO lines are used as IRQ lines on some devices,
that means that the GPIO will be periodically triggered and, depending
on our timeout, we will either loose IRQs or prevent power domain from
idling. We could figure out a way to let board code to choose what it
wants on a per-bank basis (maybe some extra DT attribute).

--=20
balbi

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQj30QAAoJEIaOsuA1yqREtBgQALF+SvujF1S9DIzWvBePiWXZ
iPeLYk94E2hckCuBcBtuVvbTxXFKYdrR+tATwMXZcMqPN1uZiu8qnwscJgOdHxLw
TEbqr+Evnk7x1vOLXrnbNEwAB8DlnVZMQGe5PG/vPM6OXFchHHx8Prtr29fy3qPj
QcuA8ASruKR05d4LYmkcyWIJkgwEg3EYs4MfofjaKPwrX/tjt6+HiRH1944giJEb
2N0rjePVk4lGtzXEu2CKVZMMXYgf2w/JugLet1TJOM85JHFiHSaciYLVQaxd+0mR
QBiz2gNB/L4ZMkpHCVEpIQrx4uaXIzF/RPPrFiCy3MDp3fsixCDdXnDGqCXjZwtO
Pwg5KXwDhoBYIkHelJ5veVX8Xwlz9tVzzSpTqSykKmiO3xHXbhYjU6yOYccsUL08
ngT6yVoH+dxPEQvWaObWnTygE8b8XIKqsnxmApwjbnIML4tDO/7vMAk8utxVX0lC
en/azMDahxLqN2nrm2AbCO/v1xc/4RH53G6bU4u0KFscndYlufy1qp2Cnv+vtQdb
rqmoix8Op8qD1aXzVtnD2nSRGcg6cb4zSehK9ghA+R24zzqA6LM9XV393r6HCirk
2pLg/zaEp13KrvG4OeCQZMuKVgxIh99JjgNJollxeFUpAboqsdN0hLQYNBfNcnKz
/IULi2IVSe4NSK+fe1tt
=4ePv
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
