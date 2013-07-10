From: Felipe Balbi <balbi@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 10 Jul 2013 15:25:16 +0300
Message-ID: <20130710122516.GE18966@arwen.pp.htv.fi>
References: <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <51DBA0C2.6030003@ti.com>
 <20130709064212.GB5552@arwen.pp.htv.fi>
 <51DC5D90.1010603@ti.com>
 <20130709194131.GA12523@arwen.pp.htv.fi>
 <51DD50B6.5030604@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44550 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754295Ab3GJMZ6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jul 2013 08:25:58 -0400
Content-Disposition: inline
In-Reply-To: <51DD50B6.5030604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2013 at 03:16:54PM +0300, Grygorii Strashko wrote:
> >>>>>Imagine the device is marked as suspended even though it's fully ena=
bled
> >>>>>(it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> >>>>>your context structure is all zeroes (context has never been saved
> >>>>>before) then when you call pm_runtime_get_sync() on probe() your
> >>>>>->runtime_resume() will get called, which will restore context,
> >>>>>essentially undoing anything which was configured by u-boot.
> >>>>
> >>>>This could be a problem for drivers which do a save context in ->runt=
ime_suspend()
> >>>>but from what I see with omap serial, there is no save context done a=
s part of
> >>>>->runtime_suspend.
> >>>
> >>>right, because context is "saved" in set_termios. probe() will get
> >>>called much before set_termios() has a chance to run, right ?
> >>>
> >>>Same problem will trigger in that case.
> >>>
> >>>I still think patch below is necessary
> >>>
> >>>>>(completely untested, didn't even try to compile, just to illustrate)
> >>>>>
> >>>>>diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
> >>>>>index 7341eff..d8dca68 100644
> >>>>>--- a/arch/arm/mach-omap2/omap_hwmod.c
> >>>>>+++ b/arch/arm/mach-omap2/omap_hwmod.c
> >>>>>@@ -2559,6 +2559,12 @@ static void __init _setup_postsetup(struct om=
ap_hwmod *oh)
> >>>>>  	    (postsetup_state =3D=3D _HWMOD_STATE_IDLE)) {
> >>>>>  		oh->_int_flags |=3D _HWMOD_SKIP_ENABLE;
> >>>>>  		postsetup_state =3D _HWMOD_STATE_ENABLED;
> >>>>>+
> >>>>>+		/* tell pm_runtime this device is already active */
> >>>>>+		pm_runtime_set_active(&oh->od->pdev->dev);
> >>>>>+	} else {
> >>>>>+		/* tell pm_runtime this device is trully suspended */
> >>>>>+		pm_runtime_set_suspended(&oh->od->pdev->dev);
> >>>>>  	}
> >>>>>
> >>>>>  	if (postsetup_state =3D=3D _HWMOD_STATE_IDLE)
> >>>
> >>
> >>This will not work - _setup_postsetup() is called from core_initcall
> >>level and OMAP devices have not been created at this moment yet
> >>(of_platform_populate() is called from
> >>customize_machine->init_machine->omap_generic_init() at arch_initcall t=
ime)
> >
> >fair enough, but something *like* that needs to be done. If pm_runtime
> >doesn't know the state of the device by the time pm_runtime_enable() is
> >called, the wrong assumptions might be made and we will forever have
> >such problems as our ->runtime_resume() callback being called when it
> >shouldn't.
> >
> >>More over, I don't recommend to depend on hwmod->od field - it's been
> >>created to support OPPs and it's obsolete now in case of DT use.
> >
> >that's alright, but still we need something similar.
> >
> >But in any case, if on DT boot that's not used, than *what* uses
> >HWMOD_INIT_NO_IDLE during DT boot ?
> >
> >There's a single place in kernel source which checks if
> >HWMOD_INIT_NO_IDLE is set, and that's the place which I patched.
> >
> >We, certainly, need a way to tell pm_runtime if the device is active or
> >suspended by the time we reach our probe() function. Either we assume
> >*all* devices are active and we blindly call pm_runtime_set_active() for
> >all devices, or we assume *all* devices are suspended as we call
> >pm_runtime_set_suspend() for all devices, or we figure out which ones
> >are active and which are not and call pm_runtime_set_{active,suspend}()
> >conditionally.
> >
> >>Seems, This issue need to be handled in driver for DT boot use case,
> >>possibly cmdline need to be parsed in the same way as it's done in
> >>omap_serial_early_init().
> >
> >so you want *every* single driver to parse their own cmdline ? How big
> >would the cmdline become ? This makes no sense.
> >
>=20
> Agree here. Seems there two similar issues:
> - this one with omap_serial
> - GPIO reset issue http://www.spinics.net/lists/linux-omap/msg84186.html
>   (similar issue is observed on OMAP4460+TPS6236x)
>=20
> And I think, that HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags
> can't be treated as
> SoC (IP) specific parameters any more - they should be board specific.
>=20
> I think, some kind of board_layout {} DT definition need to be
> created to solve these issues (just an idea). For example:
>=20
> Board DTS file:
> board_layout {
>  ti,hwmods-init-no-reset =3D "gpio1", "uart3";
>  ti,hwmods-init-no-idle =3D "uart3";
> }

nah... if we go down the path of passing this info via DT, all you need
to pass is some information if the IP should be reset/idled or not
during initialization.

--=20
balbi

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3VKsAAoJEIaOsuA1yqRELVwP/0zTO/0lF7ewedHhCo4XKzBN
36Y7DE9/HMWDms4tBwF+I+Tp0DsU3q32+ZTGkf1ZnyIEP3MzzFZB1bekBAysDwNU
z9Ykzbhfm30dMKX7HDyTRQJ3LwsKiXtmFek76+qU1TqZoEEizHfZvfC44oFwjUkK
xCByhFlop6hzXCMHmcJnnDHwG7+pE7QzKsUnROYoynEtx93j2fwuasFCJCltJpvY
/57NM7bA/17r/99xUZCifM7g1JLv8ic+tebQA2Bgu+pBwAFVTkDfLIbfMNr8iHU/
3kOm6rxX022ArqRzdKWeTCaZFFJFalaSOeGJQYDWdWkR3M70Rru7eQ8T3B2gVHnd
/bxVyxn8OSqBDqHWbZ6kxTVWsJngeY/XIKiIfCkG+XJKhw9BB789OYS4e2WeMcec
uR2mJ51VGTMZ8l2Uw1zlvJ8cDG6LVzWgbtFePGx3Pwam2q4ELURZPJ7IgcS2wo6T
2Jmy4+uo4/6MqpcGQxpAo0bIP6UxczXW+1ebhwYV/MBLPM+WxyiBij3RYvdEHmz9
5MXF28CKTA7HU6kCkPeP4CkdxtC8+14q1wB5BJRx07ciU9xclit+r6W0v0yyg0Gf
DrOq4h4GJP7dP8FLQ60pepe5aue/IIQXzSXKxlNEGsJYPB0Mh7HmJvcJECBIDJt3
5v9WYhElFgnNTKx6dnSo
=fwgx
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
