From: Felipe Balbi <balbi@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Tue, 9 Jul 2013 22:41:31 +0300
Message-ID: <20130709194131.GA12523@arwen.pp.htv.fi>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <51DBA0C2.6030003@ti.com>
 <20130709064212.GB5552@arwen.pp.htv.fi>
 <51DC5D90.1010603@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58272 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab3GITmM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 15:42:12 -0400
Content-Disposition: inline
In-Reply-To: <51DC5D90.1010603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 09, 2013 at 09:59:28PM +0300, Grygorii Strashko wrote:
> >>>Imagine the device is marked as suspended even though it's fully enabl=
ed
> >>>(it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> >>>your context structure is all zeroes (context has never been saved
> >>>before) then when you call pm_runtime_get_sync() on probe() your
> >>>->runtime_resume() will get called, which will restore context,
> >>>essentially undoing anything which was configured by u-boot.
> >>
> >>This could be a problem for drivers which do a save context in ->runtim=
e_suspend()
> >>but from what I see with omap serial, there is no save context done as =
part of
> >>->runtime_suspend.
> >
> >right, because context is "saved" in set_termios. probe() will get
> >called much before set_termios() has a chance to run, right ?
> >
> >Same problem will trigger in that case.
> >
> >I still think patch below is necessary
> >
> >>>(completely untested, didn't even try to compile, just to illustrate)
> >>>
> >>>diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/om=
ap_hwmod.c
> >>>index 7341eff..d8dca68 100644
> >>>--- a/arch/arm/mach-omap2/omap_hwmod.c
> >>>+++ b/arch/arm/mach-omap2/omap_hwmod.c
> >>>@@ -2559,6 +2559,12 @@ static void __init _setup_postsetup(struct omap=
_hwmod *oh)
> >>>  	    (postsetup_state =3D=3D _HWMOD_STATE_IDLE)) {
> >>>  		oh->_int_flags |=3D _HWMOD_SKIP_ENABLE;
> >>>  		postsetup_state =3D _HWMOD_STATE_ENABLED;
> >>>+
> >>>+		/* tell pm_runtime this device is already active */
> >>>+		pm_runtime_set_active(&oh->od->pdev->dev);
> >>>+	} else {
> >>>+		/* tell pm_runtime this device is trully suspended */
> >>>+		pm_runtime_set_suspended(&oh->od->pdev->dev);
> >>>  	}
> >>>
> >>>  	if (postsetup_state =3D=3D _HWMOD_STATE_IDLE)
> >
>=20
> This will not work - _setup_postsetup() is called from core_initcall
> level and OMAP devices have not been created at this moment yet
> (of_platform_populate() is called from
> customize_machine->init_machine->omap_generic_init() at arch_initcall tim=
e)

fair enough, but something *like* that needs to be done. If pm_runtime
doesn't know the state of the device by the time pm_runtime_enable() is
called, the wrong assumptions might be made and we will forever have
such problems as our ->runtime_resume() callback being called when it
shouldn't.

> More over, I don't recommend to depend on hwmod->od field - it's been
> created to support OPPs and it's obsolete now in case of DT use.

that's alright, but still we need something similar.

But in any case, if on DT boot that's not used, than *what* uses
HWMOD_INIT_NO_IDLE during DT boot ?

There's a single place in kernel source which checks if
HWMOD_INIT_NO_IDLE is set, and that's the place which I patched.

We, certainly, need a way to tell pm_runtime if the device is active or
suspended by the time we reach our probe() function. Either we assume
*all* devices are active and we blindly call pm_runtime_set_active() for
all devices, or we assume *all* devices are suspended as we call
pm_runtime_set_suspend() for all devices, or we figure out which ones
are active and which are not and call pm_runtime_set_{active,suspend}()
conditionally.

> Seems, This issue need to be handled in driver for DT boot use case,
> possibly cmdline need to be parsed in the same way as it's done in
> omap_serial_early_init().

so you want *every* single driver to parse their own cmdline ? How big
would the cmdline become ? This makes no sense.

--=20
balbi

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3GdqAAoJEIaOsuA1yqRE+0gQALSn0ZBEuOChNPWLPfFqeAxG
2hxSGW9IyIxtaRFkP6eeApejNC73UZ4sFgtAuKYVDF95x+29w/fubYYQyxT9WD3j
5B3SJ1rALuWkfNObGd7wJGu15iQbp465Pal5AzOnW3A6lymq7Jg8zIlEXdZl+4vD
9e+k78PPonz5RbaobqNkZCbCDChoE++x1xzFRbPA2zvzwDHMd0XVkA/DEqT8bYs6
WNvVHxDaN7K7S7p6f5/ThoTtuEd5DmTXz5Wlvi1kcxAswCbCiD+/2M2xZrUv1R2O
suiyv4s8c0+OFuGL1dg43dHBDQmk5QyM4WUJptT4UrPXF3aZnRqzHUC10JuT/NUW
rnRTyPztrMiDahFZPZ2Ltcb0JfjqPv2K0L23949vhCnjywQdyzcQZZIOH+qnOlIX
e074qberj7THVryRMg7+kZkXYZJRhs/zuCEjVqYL2SJKQLgRGl+6L/K1VJCYVLHl
RMDJcgi374WJeoewKbRz96PeOQTZ9yC4SwYkSXRMzStUIR2HQEPaRAtSKWhmtm3U
+X/5nrBF2DVTyqxpAuwL1eWxnidP0YNf1axf3ljlE69ocfvaYPKak95qmecEPd/o
s7VMiSkXsMYD+YTajBfD9FOInwAyj1pej25IT0WzmE/xLs1Hzv+PNb6oqAzwJf24
N+l7sns1Zr1uuIZlHGWo
=SOuN
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
