From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Wed, 31 Oct 2012 12:15:23 +0200
Message-ID: <20121031101523.GD10094@arwen.pp.htv.fi>
References: <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
 <508E266C.6090901@ti.com>
 <20121029080523.GC13657@arwen.pp.htv.fi>
 <508E3D09.9090802@ti.com>
 <20121029200328.GE30152@arwen.pp.htv.fi>
 <508F7471.8060402@ti.com>
 <20121030070904.GB1978@arwen.pp.htv.fi>
 <508FE142.2020408@ti.com>
 <20121030151029.GD29159@arwen.pp.htv.fi>
 <5090FA26.5090808@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49771 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934308Ab2JaKVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 06:21:19 -0400
Content-Disposition: inline
In-Reply-To: <5090FA26.5090808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: balbi@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Linux OMAP List <linux-omap@vger.kernel.org>

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 05:15:02AM -0500, Jon Hunter wrote:
> >>>> its bit of an issue to take care. How do you ensure that GPIO
> >>>> does idle on SOC idle C-state attempts in such cases. Today that
> >>>> job is done by omap_gpio_[prepare/resume]_for_idle.
> >>>
> >>> that's only there because we pm_runtime_get_sync() on gpio_request() =
and
> >>> pm_runtime_put_sync() only on gpio_free().
> >>>
> >>> That's the problem IMHO. And that's easy enough to 'fix':
> >>>
> >>> call pm_runtime_mark_last_busy(); pm_runtime_put_sync_autosuspend();
> >>> also on gpio_request() and pm_runtime_get_sync() on gpio_free().
> >>
> >> Sounds like a good approach. I have been discussing with Kevin and I
> >> need to look more at the resume handler as we are working around some
> >> old issues in there and with this approach the resume following idle
> >> will be delayed and we were not sure if there could be any implications
> >> for omap2. I am hoping not, but we need to look into this.
> >>
> >> So I am wondering if we should just take Tim's original proposal for n=
ow
> >> and then I will look into improving this long term. I really need to
> >> clean-up the suspend/resume stuff for gpio and so may be we can make
> >> that a separate change. What do you think?
> >=20
> > that'll cause a regression right ?
>=20
> Sorry, not sure I follow.

$SUBJECT will prevent core idle.

> >>> The difficult part, IMHO, is to figure out what's a good autosuspend
> >>> timeout to use. Some GPIO lines are used as IRQ lines on some devices,
> >>> that means that the GPIO will be periodically triggered and, depending
> >>> on our timeout, we will either loose IRQs or prevent power domain from
> >>> idling. We could figure out a way to let board code to choose what it
> >>> wants on a per-bank basis (maybe some extra DT attribute).
> >>
> >> I have also been bending Kevin's ear on this, this week and we were
> >> wondering if we should make the default 0 for now as this will have the
> >=20
> > I believe you mean -1 here ;-)
>=20
> I did mean 0, so that it will autosuspend right away. Basically, it will
> behave like today, however, will allow people to change the timeout. I

yeah, that's the -1 timeout, it disables pm timer and all
pm_runtime_*_autosuspend() will act as pm_runtime_*().

> did not wish to make it -1 as then suspend/resume would not be exercised
> and so people would need to change it via the sysfs to exercise deep
> power states on the device.

why won't be exercised ?

> >> same behaviour that we have today but would allow Tim to customise via
> >> the sysfs for his specific app.
> >=20
> > sysfs might be too late for his platform. What if he needs NFS root
> > (just wondering, not sure about his use case) ?
>=20
> His use case was for SPI (see the original changelog). That's a good
> point, but I am wondering if we can live with that for now.

fair enough, but it's possible we will cause regressions. At least with
current version of $SUBJECT, I guess.

--=20
balbi

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkPo7AAoJEIaOsuA1yqRErtoQAK53rXsoWBIEVQuzhZGfLIJ6
54Vk/rni+KUjHeVMPEDeqnutqY4XlB2JZ3A/PRNNk3c/gbUb+Ph9QK9cnhgqEPtD
6DERSu45Ey/GnLQd4PBejNWYbXlQhBQZ4FeOFAe808/ndSULvCaTPd2eOVOyXr0P
7HQbXD+u+kwjOlaEsXqjpZvBIT9mhsFb+C+E3n1D0huGWYXvOI5tYFMBKwwYkkCP
+WL3VLsqS16RUXIerIxpuE04VIui4THqlBKe0s/KX25vJRS5xWNc2nrcg70Za0/e
+BgKmdbcfmHIf4TcrprVzZpbNymqB8wxGUN1J0OJkBUZFX173P7GsL1ArdpDqJh2
V21RBiceZctJXZ96let5jNZP9kIeps77i19PnmqnovM+NWpmqFJJGd+t26ztkIXI
ONsiarn9XxgLl7uxo/HKRmrucqt3rnkjf7lwmBu6vZFfxeeuUGSmhDsWwjIYwR4D
DlPv4pKm3H2oFKJVf/FnM8JTL4dMvqLCuneO26F+7mI1YLJipFX2d30PPETsglG3
bQDu8eUi37eGxHz0fGqMSUw4IemzRkditx6ySI7B1NnyK7yVJGijxp0gCBENajGK
IBWRrH+Kx8qOgp9x7efoFE2t1cFOWsZeCJ/hN3GzlP9Hkd1+0zeAC7yoo80x2O1B
iE2PH3qsdpRW1te2+SWY
=wdr0
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
