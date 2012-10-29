From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Mon, 29 Oct 2012 22:03:28 +0200
Message-ID: <20121029200328.GE30152@arwen.pp.htv.fi>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
 <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
 <508E266C.6090901@ti.com>
 <20121029080523.GC13657@arwen.pp.htv.fi>
 <508E3D09.9090802@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59700 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760745Ab2J2UJX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 16:09:23 -0400
Content-Disposition: inline
In-Reply-To: <508E3D09.9090802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Tim Niemeyer <tim.niemeyer@corscience.de>, Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>

--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 29, 2012 at 01:53:37PM +0530, Santosh Shilimkar wrote:
> >>Just to expand a bit, Out of 6 GPIO banks, GPIO1 bank is in always ON
> >>domain where as remaing 5 are in peripheral domain. Letting individual
> >>banks idle allowed you let the clock domain idle than keeping all the
> >>6 banks and hence respective clock/power domain in ON state.
> >>
> >>So the adding timeout might be reasonable but I am not sure about
> >>the mod_usage change here.
> >
> >IMHO that whole mod_usage is broken. I remember sending a big series of
> >patches getting rid of that long ago. I _did_ break a few things but
> >just because of omap_gpio_prepare_for_idle() /
> >omap_gpio_resume_from_idle() hackery to get GPIO suspended early enough.
> >
> Well so far I haven't seen/come across a patch/proposal which fixes it.

fair point

> >I still think mod_usage needs to go, so does
> >omap_gpio_prepare_for_idle() and omap_gpio_resume_from_idle(). To me, it
> >looks like that needs to be done on ->prepare()/->complete() callbacks
> >of system suspend and the gpio driver needs to learn proper runtime
> >suspend.
> >
> I am not saying it shouldn't go :-)
> The $subject patch isn't fixing it correctly is what I said.
>=20
> Don't get hung up on suspend case because thats the easiest
> way to address it. The issue is with idle where GPIO can prevent
> SOC idle if it isn't taken care. And since its just an IO, its not
> easy to implement something like inactivity timer towards
> autosupend.

I don't see the relation here. Care to expand a bit ?

> Co-processor also makes use of GPIO via syslink proxy and thats
> make things even harder.

that's supposed to be solved with hwspinlock, isn't it ?

cheers

--=20
balbi

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjuEQAAoJEIaOsuA1yqRERj0P/2v+uyt7V2wyd7WZKtJvFsba
ebvRDOESJ5jvsyrogUmMDyius/Z/pb+wA9R//+K/2qlJz1bieyP4bs0XybN/OsbV
2f4nijhf8mBP08BMdwom7a3UwuzwOv6FIXFYxUao3K3mbAFFVrwbg9zTdmEqYcYa
K7IUvizr7lSuDpvgkbHjLjppF25OU8TSALxSXQeAyOh5Zon7atKBVtJVLJuE9gFp
3VZVOG0rCugdc9UxzJKvOBeTQGXkQ5Hr0qtQi+esGIlgF0boR+M7R5X5ebaBF+z6
GlQU01c730zugmBohyjwupCF33v67ToJ1q78NJ58nXAhSulevneg8zCsKJObfv36
C0/ZUJMkFaeQoyZ7Z7CUbsGS7j6DfmfIL7k61pOxjFavoh6yb6OKyH854HWDf4ru
zfrDv4FHzmUrXDVA7SpXlvskkWF9O4BwmyrR2bZ48BCuusuWRKF7IlofHUxv4MDI
a4Fb3ue8YLxaz55bI7i9uaxaaIyB8FzVCBOOd/JC58RcO6syfuTlqn/LkLIJ75ix
AK7H0i3zjlVhLIyp52KyA+PF3sSQXPgfzY8MvwZFkFf/w8/dPLuuvjFetu7Y257U
yzeFBI3UcIQbKVn2EcwLGdz3LA0qsQDiDRZps/UD+WXwXKhFof+uqC6mSyYJVXNY
KalTb2ZVCwzLQoe3jel+
=mlnT
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
